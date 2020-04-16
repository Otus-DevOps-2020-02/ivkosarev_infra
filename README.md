# ivkosarev_infra

ivkosarev Infra repository

testapp_IP = 34.77.129.82
testapp_port = 9292

bastion_IP = 35.205.201.59
someinternalhost_IP = 10.132.0.3

#Команда для создания инстанса и передачи startup-script из локального файла

gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup-script.sh

#Команда для создания правила в фаерволе
gcloud compute firewall-rules create default-puma-server\
  --direction=INGRESS \
  --priority=1000 \
  --network=default \
  --action=ALLOW \
  --rules=tcp:9292 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=puma-server
  
  
Сборка образов при помощи Packer
Был собран базовый образ с помощью Packer, с установленным Ruby и MongoDB
Из образа был запущен инстанс ВМ и вручную установлено приложение
Изучен механизм параметризации шаблонов Packer, для примера приложен файл variables.json.example
