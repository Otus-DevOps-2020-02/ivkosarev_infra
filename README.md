# ivkosarev_infra

ivkosarev Infra repository

testapp_IP = 34.91.219.128
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
