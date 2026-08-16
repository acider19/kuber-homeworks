# Домашнее задание к занятию «Настройка приложений и управление доступом в Kubernetes» - Муравский Артем

---

## Задание 1: Работа с ConfigMaps

Создаем *ConfigMap* с веб-страницей из манифеста [configmap-web.yaml](manifests/configmap-web.yaml):

```bash
kubectl apply -f manifests/configmap-web.yaml
```

Создаем *deployment* (nginx + multitool) из манифеста [deployment.yaml](manifests/deployment.yaml) и *service* из [service.yaml](manifests/service.yaml):

```bash
kubectl apply -f manifests/deployment.yaml
kubectl apply -f manifests/service.yaml
```

ConfigMap монтируется в контейнер *nginx* в директорию `/usr/share/nginx/html`, где nginx по умолчанию отдаёт статические страницы.

Проверяем доступность веб-страницы из контейнера *multitool* (контейнеры пода делят network namespace, поэтому обращение идёт на `localhost`):

```bash
kubectl exec -it <pod> -c multitool -- curl http://localhost
```

Скриншот результата выполнения команды

![check_curl](img/screen1.png)

---

## Задание 2: Настройка HTTPS с Secrets

Генерируем самоподписанный SSL-сертификат:

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout tls.key -out tls.crt -subj "/CN=myapp.example.com"
```

Создаем *Secret* типа `kubernetes.io/tls` из манифеста [secret-tls.yaml](manifests/secret-tls.yaml):

```bash
kubectl create secret tls tls-secret --key=tls.key --cert=tls.crt
# или
kubectl apply -f manifests/secret-tls.yaml
```

Создаем *Ingress* с TLS из манифеста [ingress-tls.yaml](manifests/ingress-tls.yaml):

```bash
kubectl apply -f manifests/ingress-tls.yaml
```

Проверяем HTTPS-доступ (так как сертификат самоподписанный, используем `-k`, а имя `myapp.example.com` резолвим через `--resolve` на адрес ingress-контроллера):

```bash
curl -k --resolve myapp.example.com:443:127.0.0.1 https://myapp.example.com/
```

Скриншот результата выполнения команды

![check_https](img/screen2.png)

---

## Задание 3: Настройка RBAC

Генерируем сертификат пользователя `student`:

```bash
openssl genrsa -out developer.key 2048
openssl req -new -key developer.key -out developer.csr -subj "/CN=student"
openssl x509 -req -in developer.csr \
  -CA client-ca.crt -CAkey client-ca.key \
  -CAcreateserial -out developer.crt -days 365
```

Создаем *Role* (только просмотр логов и описание подов) из манифеста [role-pod-reader.yaml](manifests/role-pod-reader.yaml) и *RoleBinding* для пользователя `student` из [rolebinding-developer.yaml](manifests/rolebinding-developer.yaml):

```bash
kubectl apply -f manifests/role-pod-reader.yaml
kubectl apply -f manifests/rolebinding-developer.yaml
```

Проверяем права пользователя: список подов доступен, а доступ к секретам запрещён:

```bash
kubectl get pods --as=student
kubectl get secrets --as=student
```

Скриншот результата выполнения команды

![check_rbac](img/screen3.png)
