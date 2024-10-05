# base-chart

Helm chart for deploying a stateless application on Kubernetes, with support for both **Deployments** and **StatefulSets**.

## Overview

This Helm chart provides a flexible framework for deploying stateless applications on Kubernetes. You can choose between using a **Deployment** (for typical stateless applications) or a **StatefulSet** (for applications requiring stable network identities or persistent storage). Both options can be configured in the `values.yaml` file.

## Prerequisites

- Helm 3.x
- Kubernetes 1.18+ cluster

## Installation

To install the chart with the release name `my-release`, run the following command:

```bash
helm install my-release ./base-chart
```

You can override the default configurations by specifying your own `values.yaml`:

```bash
helm install my-release ./base-chart -f custom-values.yaml
```

## Configuration

### Deployment or StatefulSet

You can configure whether to use a **Deployment** or a **StatefulSet** by setting the `statefulset.enabled` value in the `values.yaml` file:

- To use a **Deployment** (default behavior):

```yaml
statefulset:
  enabled: false
```

- To use a **StatefulSet**:

```yaml
statefulset:
  enabled: true
  volumeClaimTemplates:
    enabled: true
    templates:
      - name: sts-data
        accessModes:
          - ReadWriteOnce
        storageClassName: "standard"
        storage: 10Gi
        mountPath: /mnt/data
```

### Application Settings

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `replicaCount`                      | Number of replicas of the application                              | `1`                    |
| `recreatePods`                      | Force pods to be recreated by setting a random annotation           | `false`                |

### StatefulSet Configuration

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `statefulset.enabled`               | Enable StatefulSet instead of Deployment                           | `false`                |
| `statefulset.podManagementPolicy`   | Management policy for pods in the StatefulSet (`Parallel`, `OrderedReady`) | `Parallel`             |
| `statefulset.updateStrategy.type`   | Update strategy for StatefulSet (`RollingUpdate`, `OnDelete`)       | `RollingUpdate`        |
| `statefulset.volumeClaimTemplates`  | Volume claim templates for the StatefulSet                         | Disabled               |

### Image Settings

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `image.repository`                  | Docker image repository                                             | `nginx`                |
| `image.tag`                         | Docker image tag                                                    | `latest`               |
| `image.pullPolicy`                  | Image pull policy (`Always`, `IfNotPresent`, `Never`)               | `IfNotPresent`         |

### Environment Variables

You can define environment variables to be injected into the application container:

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `env`                               | Environment variables as key-value pairs                           | `{}`                   |
| `envFrom`                           | Import environment variables from ConfigMaps or Secrets            | `[]`                   |
| `JAVA_OPTS`                         | Java options to pass to the container                              | `[]`                   |
| `JMX_OPTS`                          | JMX options to pass to the container                               | `[]`                   |

#### Example: Using `env` and `envFrom`

You can pass environment variables directly via the `env` section, or load them from a ConfigMap or Secret using `envFrom`. Here's how to define both in the `values.yaml`:

```yaml
env:
  - name: APP_ENV
    value: "production"
  - name: DEBUG
    value: "false"

envFrom:
  - configMapRef:
      name: app-config
  - secretRef:
      name: app-secret
```

#### Example: Using `environment` with `valueFrom`

You can also define environment variables dynamically using Kubernetes field references, ConfigMaps, and Secrets. Here's an example:

```yaml
environment:
  - name: MY_NODE_NAME
    valueFrom:
      fieldRef:
        fieldPath: spec.nodeName
  - name: PROPERTIES_FILE_NAME
    valueFrom:
      configMapKeyRef:
        name: some-cm-name
        key: properties_file_name
  - name: SECRET_PASSWORD
    valueFrom:
      secretKeyRef:
        name: mysecret
        key: password
        optional: false # "mysecret" must exist and include a key named "password"
```

### Resource Management

You can define CPU and memory resource limits and requests:

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `resources.limits.cpu`              | CPU resource limit                                                  | Not set                |
| `resources.limits.memory`           | Memory resource limit                                               | Not set                |
| `resources.requests.cpu`            | CPU resource request                                                | Not set                |
| `resources.requests.memory`         | Memory resource request                                             | Not set                |

### Horizontal Pod Autoscaling

Enable autoscaling for the application based on CPU utilization:

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `autoscaling.enabled`               | Enable horizontal pod autoscaler                                   | `false`                |
| `autoscaling.minReplicas`           | Minimum number of replicas                                         | `1`                    |
| `autoscaling.maxReplicas`           | Maximum number of replicas                                         | `100`                  |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage                                | `80`                   |

### Service Configuration

You can configure the Kubernetes service for your application:

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `service.type`                      | Kubernetes service type (`ClusterIP`, `NodePort`, `LoadBalancer`)  | `ClusterIP`            |
| `service.services`                  | List of services to expose, including port and target port          | HTTP, port 80          |

### Ingress Configuration

To expose your application using Ingress, configure the following options:

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `ingress.enabled`                   | Enable Ingress for the application                                 | `false`                |
| `ingress.className`                 | Ingress class name (if required by the cluster)                    | Not set                |
| `ingress.annotations`               | Annotations for the Ingress resource                               | `{}`                   |
| `ingress.hosts`                     | List of hosts for the Ingress                                      | `chart-example01.local`, `chart-example02.local` |
| `ingress.tls`                       | TLS configuration for Ingress                                      | `[]`                   |

### Pod Probes

You can define startup, liveness, and readiness probes for the pod:

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `startupProbe`                      | Probe to check if the application is started                       | Not set                |
| `livenessProbe`                     | Probe to check if the application is healthy                       | Not set                |
| `readinessProbe`                    | Probe to check if the application is ready to accept traffic        | Not set                |

### Service Account

You can configure the service account associated with the application:

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `serviceAccount.create`             | Whether to create a service account                                | `true`                 |
| `serviceAccount.name`               | The name of the service account to use                             | Empty, auto-generated  |
| `serviceAccount.annotations`        | Annotations to add to the service account                          | `{}`                   |

### Persistent Volumes

You can configure persistent volume claims for the application:

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `volumeMounts`                      | Volume mounts for the container                                    | `[]`                   |

### Monitoring and Prometheus

Prometheus monitoring options can be enabled to export metrics from the application:

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `servicemonitor.enabled`            | Enable ServiceMonitor for Prometheus                               | `false`                |
| `prometheusrule.enabled`            | Enable Prometheus alerting rules                                   | `false`                |

### Init Containers and Sidecars

You can define custom init containers and sidecars for the application:

| Parameter                          | Description                                                        | Default                |
|-------------------------------------|--------------------------------------------------------------------|------------------------|
| `initContainers`                    | List of init containers to run before the main container            | `[]`                   |
| `sidecars`                          | List of sidecars to run alongside the main container                | `[]`                   |

## Uninstalling the Chart

To uninstall the Helm release, run:

```bash
helm uninstall my-release
```

This command removes all the Kubernetes components associated with the release.

## License

This project is licensed under the MIT License.

---

Let me know if you need any further updates!
