# ECR Credential Helper

This is a utility that periodically updates a Docker registry secret for AWS
ECR repositories in namespaces with a matching label. It also watches for
namespaces with the matching label and creates the secret at that time.

By default the label name is `credentialType` and the value is `ecr`. So you
would create your namespace like:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: my-namespace
  labels:
    credentialType: ecr
```

Then, a Docker registry secret will be created in the namespace (named
`ecr-creds` by default) and you can use that as the image pull secret for the
pods in the namespace.

## Options

| Option                    | Default Value    | Required                             | Description                                                            |
| ------------------------- | ---------------- | ------------------------------------ | ---------------------------------------------------------------------- |
| `aws.accessKeyId`         | _None_           | true                                 | The AWS IAM access key ID                                              |
| `aws.secretAccessKey`     | _None_           | true                                 | The AWS IAM secret access key                                          |
| `aws.region`              | `us-east-1`      | true                                 | The AWS region in which the ECR repositories are hosted                |
| `aws.accountId`           | _None_           | If `aws.registryHostname` is not set | The AWS account ID                                                     |
| `aws.registryHostname`    | _None_           | If `aws.accountId` is not set        | The host name for the ECR repositories                                 |
| `aws.generatedSecretName` | `ecr-creds`      | true                                 | The name of the secret created in the labeled namespaces               |
| `aws.labelName`           | `credentialType` | true                                 | The name of the label that identifies the namespaces                   |
| `aws.labelValue`          | `ecr`            | true                                 | The value of the lable that identifies the namespaces                  |
| `aws.cronSchedule`        | `0 */6 * * *`    | true                                 | The cronjob expression that specifies when the credentials are updated |
