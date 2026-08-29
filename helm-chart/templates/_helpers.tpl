{{/*
Полное имя ресурса. Использует .Release.Name, чтобы несколько релизов
в одном namespace не конфликтовали между собой.
*/}}
{{- define "web-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Лейблы для ресурсов чарта
*/}}
{{- define "web-app.labels" -}}
app.kubernetes.io/name: {{ include "web-app.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
