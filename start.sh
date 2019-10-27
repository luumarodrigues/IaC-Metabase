ssh-keygen -t rsa -b 2048 -f ~/.ssh/Key.pem -q -P ''
chmod 400 ~/.ssh/Key.pem
ssh-keygen -y -f ~/.ssh/Key.pem > ~/.ssh/Key.pub

terraform init

terraform plan

terraform apply
