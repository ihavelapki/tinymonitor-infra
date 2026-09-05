# Настройка AWS






## Что сделать в AWS Console

### Зайди в IAM

- В AWS Console открой: `IAM` -> `Users` -> `Create user`
- Имя пользователя: `terraform-bootstrap`
- **НЕ** включать `Console access`
    - AWS предложит: `Provide user access to the AWS Management Console`
    - Для Terraform это **не нужно**. Оставь выключенным. Почему: Terraform будет работать через CLI/API, а не через браузер.
- Создай пользователя без группы
    - На шаге permissions можно выбрать (Но лучше сначала создать свою policy): `Attach policies directly`

---

### Создай custom IAM policy

- Открой: `IAM -> Policies -> Create policy -> JSON`

Вставь policy.

Замени bucket/table имена на свои:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "TerraformBootstrapS3BucketManagement",
      "Effect": "Allow",
      "Action": [
        "s3:CreateBucket",
        "s3:DeleteBucket",
        "s3:GetBucketLocation",
        "s3:GetBucketVersioning",
        "s3:PutBucketVersioning",
        "s3:GetBucketEncryption",
        "s3:PutBucketEncryption",
        "s3:GetBucketPublicAccessBlock",
        "s3:PutBucketPublicAccessBlock",
        "s3:GetBucketTagging",
        "s3:PutBucketTagging",
        "s3:GetBucketPolicy",
        "s3:PutBucketPolicy",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::tinymonitor-tfstate-prod-CHANGE-ME"
      ]
    },
    {
      "Sid": "TerraformBootstrapS3ObjectManagement",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::tinymonitor-tfstate-prod-CHANGE-ME/*"
      ]
    },
    {
      "Sid": "TerraformBootstrapDynamoDBManagement",
      "Effect": "Allow",
      "Action": [
        "dynamodb:CreateTable",
        "dynamodb:DeleteTable",
        "dynamodb:DescribeTable",
        "dynamodb:UpdateTable",
        "dynamodb:TagResource",
        "dynamodb:UntagResource",
        "dynamodb:ListTagsOfResource",
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": [
        "arn:aws:dynamodb:eu-central-1:*:table/tinymonitor-terraform-locks"
      ]
    },
    {
      "Sid": "TerraformBootstrapReadAccountInfo",
      "Effect": "Allow",
      "Action": [
        "sts:GetCallerIdentity"
      ],
      "Resource": "*"
    }
  ]
}
```

- Policy name: `TerraformBootstrapPolicy`
- Потом вернись к user `terraform-bootstrap` и прикрепи эту policy.

---

### Создать access key

- Открыть: `IAM -> Users -> terraform-bootstrap -> Security credentials -> Create access key`
- Выбрать: `Command Line Interface (CLI)`
    - [ссылка на документацию по пользованию AWSCLI v2](https://docs.aws.amazon.com/signin/latest/userguide/command-line-sign-in.html)
- после создания сохранить себе:
    - Access key ID
    - Secret access key



## Установить AWS CLI на ноуте

- Установи AWS CLI: 
    ```bash
    brew install awscli
    ```
- Проверим версию
    ```sh
    % aws --version
    aws-cli/2.36.40 Python/3.14.7 Darwin/25.6.0 source/arm64
    ```
- затем настроить профиль:
    ```bash
    aws configure --profile tinymonitor-bootstrap
    ```
- Ввести:
    - `AWS Access Key ID`: <твой access key>
    - `AWS Secret Access Key`: <твой secret>
    - `Default region name`: eu-central-1
    - `Default output format`: json
- Проверить: 
    ```bash
    aws sts get-caller-identity --profile tinymonitor-bootstrap
    ```
    Если видишь `Account`, `UserId`, `Arn` — доступ работает.
    ```
    {
        "UserId": "<твой access key>",
        "Account": "<твой account>",
        "Arn": "arn:aws:iam::<account>:user/terraform-bootstrap"
    }
    ```


