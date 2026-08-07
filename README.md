# Домашнее задание к занятию «Запуск приложений в K8S» - Муравский Артем


## Задание 1

1. Создаем *deployment* из манифеста [deployment1.yaml](manifests/deployment1.yaml) командой
  `kubectl apply -f deployment1.yaml`

  Проверяем наличие подов командой
  `kubectl get pods`

  Скриншот результата выполнения команды
  ![pods_of_deployment1](img/screen1.png)


2. Увеличиваем количество реплик приложения до двух путем изменения значения параметра *replicas* в манифесте [deployment1.yaml](manifests/deployment1.yaml)


3. Проверяем наличие и количество подов командой
  `kubectl get pods`

  Скриншот результата выполнения команды
  ![pods_of_deployment1_scale](img/screen2.png)


4. Создаем *service* из манифеста [service1.yaml](manifests/service1.yaml) командой
  `kubectl apply -f service1.yaml`


5. Создаем отдельный *pod* из манифеста [pod1.yaml](manifests/pod1.yaml) командой
  `kubectl apply -f pod1.yaml`

  Проверяем наличие и количество подов командой
  `kubectl get pods`

  Скриншот результата выполнения команды
  ![pods_multitool](img/screen3.png)


  Осуществляем подключение к созданному поду с помощью команды
  `kubectl exec -i -t pods/multitool -- bash`

  Тестируем возможность подключения к приложению *nginx* помощью команды
  `curl my-service:80`

  Скриншот результата выполнения команды
  ![curl1](img/screen4.png)

  Тестируем возможность подключения к приложению *multitool* помощью команды
  `curl my-service:8080`

  Скриншот результата выполнения команды
  ![curl2](img/screen5.png)

---

## Задание 2

1. Создаем *deployment* из манифеста [deployment2.yaml](manifests/deployment2.yaml) командой
  `kubectl apply -f deployment2.yaml`

  Проверяем наличие подов командой
  `kubectl get pods`

  Скриншот результата выполнения команды
  ![pods_of_deployment2](img/screen6.png)

2. Убеждаемся, что *nginx* не стартовал, так как у подов *READY* имеет значение `0`, а *STATUS* `Init:0/1`, что можно интерпретировать как отсутсвие старта контейнера *nginx* по причине невозможности запуска init-контейнера

3. Создаем *service* из манифеста [service2.yaml](manifests/service2.yaml) командой
  `kubectl apply -f service2.yaml`

4. Проверяем наличие подов командой
  `kubectl get pods`

  Скриншот результата выполнения команд
  ![pods_of_deployment2_init](img/screen7.png)
