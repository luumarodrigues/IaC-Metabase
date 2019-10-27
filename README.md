
## Terraform-Metabase
[![Build Status](https://travis-ci.org/luumarodrigues/Terraform-metabase.svg?branch=master)](https://travis-ci.org/luumarodrigues/Terraform-metabase)

- Create and configure aws instance - ubuntu
- Install JDK >= 8
- download and run metabase

## Dependencies

- AWS CLI - [Install](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-chap-install.html) and [Configure](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-chap-configure.html)

- Terraform - [Install](https://www.terraform.io/downloads.html)


## Variables.tf

| Variable                       | Default         | Comments              |
| :---                           | :---            | :---                  |
| `private_key` | '~/.ssh/key.pem' | Path to the SSH private key to be used for authentication |
| `public_key` | '~/.ssh/key.pub' | Path to the SSH public key to be used for authentication |
| `region` | 'us-east-1'  | AWS region to launch servers |
| `instance_type`| 't2.micro'  | The type of instance to start |
| `monitoring` | true | If true, the launched EC2 instance will have detailed monitoring enabled |
| `tags` | "Name"= "Ubuntu", "Ambiente"= "Desenvolvimento", "Projeto" = "DevOps-metabase" | A mapping of tags to assign to the resource |


## Clone Repository

```
$ git clone https://github.com/luumarodrigues/Terraform-metabase.git
```

## Run Script

```
$ chmod +x ./start.sh
```

```
$ ./start.sh
```

## if you want to remove created resources

```
$ Terraform destroy
```
