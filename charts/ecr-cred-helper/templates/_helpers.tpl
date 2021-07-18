{{/*
Expand the name of the chart.
*/}}
{{- define "ecr-cred-helper.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ecr-cred-helper.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ecr-cred-helper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ecr-cred-helper.labels" -}}
helm.sh/chart: {{ include "ecr-cred-helper.chart" . }}
{{ include "ecr-cred-helper.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ecr-cred-helper.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ecr-cred-helper.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ecr-cred-helper.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ecr-cred-helper.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account namespace
*/}}
{{- define "ecr-cred-helper.serviceAccountNamespace" -}}
{{ default "default" .Release.Namespace }}
{{- end }}

{{/*
Create the name of the cluster role to use
*/}}
{{- define "ecr-cred-helper.clusterRoleName" -}}
{{- if .Values.clusterRole.create }}
{{- default (include "ecr-cred-helper.fullname" .) .Values.clusterRole.name }}
{{- else }}
{{- default "default" .Values.clusterRole.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role binding to use
*/}}
{{- define "ecr-cred-helper.clusterRoleBindingName" -}}
{{- if .Values.clusterRoleBinding.create }}
{{- default (printf "%s-binding" (include "ecr-cred-helper.fullname" .)) .Values.clusterRoleBinding.name }}
{{- else }}
{{- default "default" .Values.clusterRoleBinding.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "ecr-cred-helper.secretName" -}}
{{- if .Values.aws.createSecret }}
{{- default (printf "%s-aws" (include "ecr-cred-helper.fullname" .)) .Values.aws.secretName }}
{{- else }}
{{- default "aws" .Values.aws.secretName }}
{{- end }}
{{- end }}

{{/*
Get the encoded AWS access key ID
*/}}
{{- define "ecr-cred-helper.accessKeyId" -}}
{{- printf "%s" (.Values.aws.accessKeyId | b64enc) }}
{{- end}}

{{/*
Get the encoded AWS secret access key
*/}}
{{- define "ecr-cred-helper.secretAccessKey" -}}
{{- printf "%s" (.Values.aws.secretAccessKey | b64enc) }}
{{- end}}

{{/*
Get the ECR registry hostname
*/}}
{{- define "ecr-cred-helper.registryHostname" -}}
{{- default (printf "%s.dkr.ecr.%s.amazonaws.com" .Values.aws.accountId .Values.aws.region) .Values.aws.registryHostname }}
{{- end }}