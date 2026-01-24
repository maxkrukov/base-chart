# base-chart

![Version: 1.1.0](https://img.shields.io/badge/Version-1.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A Helm base chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| JAVA_OPTS | list | `[]` | Java options (JAVA_OPTS) |
| JMX_OPTS | list | `[]` | JMX options (JMX_OPTS) |
| affinity | object | `{}` | Affinity |
| args | list | `[]` | Container arguments |
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler |
| autoscaling.maxReplicas | int | `10` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| binaryFiles | list | `[]` | Mount binary files from values (base64) |
| command | list | `[]` | Container command |
| env | object | `{}` | Environment variables (key-value) |
| envFrom | list | `[]` | Load environment variables from Secrets or ConfigMaps |
| environment | list | `[]` | Advanced environment variables (valueFrom) |
| fileLoad | object | `{"enabled":false,"mountPath":"/app/config"}` | Load files from 'config/' directory of the chart |
| files | list | `[]` | Mount files from values |
| fullnameOverride | string | `""` | Override the full chart name |
| gateway.className | string | `"cilium"` | GatewayClass name |
| gateway.create | bool | `false` | Create a Gateway resource |
| gateway.enabled | bool | `false` | Enable Gateway API support |
| gateway.hostnames | list | `[]` | Hostnames for HTTPRoute |
| gateway.parentRefs | list | `[]` | Parent references for HTTPRoute |
| gateway.rules | list | `[]` | Rules for HTTPRoute |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"nginx"` | Image repository |
| image.tag | string | `"latest"` | Image tag (defaults to chart appVersion) |
| imagePullSecrets | list | `[]` | Secrets for pulling images from a private registry |
| ingress.annotations | object | `{}` | Ingress annotations |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable Ingress |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific","servicePort":80}]}]` | Ingress hosts |
| ingress.tls | list | `[]` | Ingress TLS configuration |
| initContainers | string | `""` | Init containers (template string) |
| keda.cooldownPeriod | int | `300` |  |
| keda.enabled | bool | `false` | Enable KEDA Autoscaling |
| keda.maxReplicaCount | int | `10` |  |
| keda.minReplicaCount | int | `1` |  |
| keda.pollingInterval | int | `30` |  |
| keda.triggers | list | `[]` | KEDA triggers |
| lifecycle | object | `{}` | Container lifecycle hooks |
| livenessProbe | object | `{}` | Liveness probe configuration |
| nameOverride | string | `""` | Override the chart name |
| nodeSelector | object | `{}` | Node selector |
| podAnnotations | object | `{}` | Pod annotations |
| podSecurityContext | object | `{}` | Pod security context |
| prometheusrule.enabled | bool | `false` | Enable PrometheusRule |
| prometheusrule.groups | list | `[]` | Alerting rules groups |
| readinessProbe | object | `{}` | Readiness probe configuration |
| recreatePods | bool | `false` | Force pods to be recreated by setting a random annotation |
| replicaCount | int | `1` | Number of replicas (ignored if autoscaling is enabled) |
| resources | object | `{}` | Container resource requests and limits |
| securityContext | object | `{}` | Container security context |
| service.services | list | `[{"name":"http","port":80,"protocol":"TCP","targetPort":80}]` | List of service ports |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount.annotations | object | `{}` | Annotations for the service account |
| serviceAccount.create | bool | `true` | Create a service account |
| serviceAccount.name | string | `""` | The name of the service account to use |
| servicemonitor.enabled | bool | `false` | Enable Prometheus ServiceMonitor |
| servicemonitor.interval | string | `"10s"` | Scrape interval |
| servicemonitor.path | string | `"/metrics"` | Metrics path |
| servicemonitor.port | string | `"http"` | Service port to scrape |
| servicemonitor.scrapeTimeout | string | `"10s"` | Scrape timeout |
| sidecars | string | `""` | Sidecar containers (template string) |
| startupProbe | object | `{}` | Startup probe configuration |
| statefulset.enabled | bool | `false` | Enable StatefulSet instead of Deployment |
| statefulset.podManagementPolicy | string | `"Parallel"` | Pod management policy |
| statefulset.updateStrategy | object | `{"rollingUpdate":{"partition":0},"type":"RollingUpdate"}` | Update strategy |
| statefulset.volumeClaimTemplates.enabled | bool | `false` | Enable volume claim templates for StatefulSet |
| statefulset.volumeClaimTemplates.templates | list | `[{"accessModes":["ReadWriteOnce"],"mountPath":"/mnt/data","name":"sts-data","storage":"1Gi","storageClassName":""}]` | List of volume claim templates |
| terminationGracePeriodSeconds | int | `30` | Pod termination grace period in seconds |
| tolerations | list | `[]` | Tolerations |
| volumeMounts | list | `[]` | Additional volume mounts |
| wrapped_env | object | `{"data":{},"enabled":false,"type":"Secret"}` | Helper for wrapping sensitive values in a Secret/ConfigMap |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
