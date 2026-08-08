# Домашнее задание к занятию «Сетевое взаимодействие в Kubernetes» - Муравский Артем


## Задание 1

1. Создаем *deployment* из манифеста [deployment-multi-container.yaml](manifests/deployment-multi-container.yaml) командой `kubectl apply -f deployment-multi-container.yaml`

2. Создаем *service* из манифеста [service-clusterip.yaml](manifests/service-clusterip.yaml) командой `kubectl apply -f service-clusterip.yaml`

3. Проверяем доступность приложений изнутри кластера
  
  Создаем тестовый под и подключаемся к нему, выполнив команду `kubectl run test-pod --image=wbitt/network-multitool --rm -it -- sh`

  Тестируем возможность подключения к приложению *nginx* помощью команды `curl my-service:9001`
  
  Скриншот результата выполнения команды
  
  ![test_nginx_clusterip](img/screen1.png)

  Тестируем возможность подключения к приложению *multitool* помощью команды `curl my-service:9002`
  
  Скриншот результата выполнения команды
  
  ![test_multitool_clusterip](img/screen2.png)

4. Создаем *service* из манифеста [service-nodeport.yaml](manifests/service-nodeport.yaml) командой `kubectl apply -f service-nodeport.yaml`

5. Проверяем доступность приложений снаружи кластера

  Тестируем возможность подключения к приложению *nginx* помощью команды `curl 127.0.0.1:30080`
  
  Скриншот результата выполнения команды
  
  ![test_nginx_nodeport](img/screen3.png)

  Тестируем возможность подключения к приложению *multitool* помощью команды `curl 127.0.0.1:30880`
  
  Скриншот результата выполнения команды
  
  ![test_multitool_nodeport](img/screen4.png)

---

## Задание 2

1. Создаем *deployment* из манифеста [deployment-frontend.yaml](manifests/deployment-frontend.yaml) командой `kubectl apply -f deployment-frontend.yaml`
  
  Создаем *deployment* из манифеста [deployment-backend.yaml](manifests/deployment-backend.yaml) командой `kubectl apply -f deployment-backend.yaml`

2. Создаем *service* из манифеста [service-frontend.yaml](manifests/service-frontend.yaml) командой `kubectl apply -f service-frontend.yaml`

  Создаем *service* из манифеста [service-backend.yaml](manifests/service-backend.yaml) командой `kubectl apply -f service-backend.yaml`

3. Ingress-контроллер установлен командой `kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.1/deploy/static/provider/cloud/deploy.yaml`

4. Создаем *ingress* из манифеста [ingress.yaml](manifests/ingress.yaml) командой `kubectl apply -f ingress.yaml`

5. Проверяем доступность приложений снаружи кластера

  Тестируем возможность подключения к приложению *frontend* помощью команды `curl http://127.0.0.1`
  
  Скриншот результата выполнения команды
  
  ![test_frontend](img/screen5.png)

  Тестируем возможность подключения к приложению *backend* помощью команды `curl http://127.0.0.1/api`
  
  Скриншот результата выполнения команды
  
  ![test_backend](img/screen6.png)
