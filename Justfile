set shell := ["bash", "-c"]

# List available recipes
default:
    @just --list

# Lint the Helm chart
lint:
    helm lint .

# Render templates to verify syntax (dry-run)
template:
    helm template . --debug > /dev/null

# Run comprehensive CI tests against test values
test:
    @echo "Running KEDA scenario..."
    helm template . -f ci/test-values-keda.yaml > /dev/null
    @echo "Running Gateway scenario..."
    helm template . -f ci/test-values-gateway.yaml > /dev/null
    @echo "Running StatefulSet scenario..."
    helm template . -f ci/test-values-sts.yaml > /dev/null
    @echo "Running Observability scenario..."
    helm template . -f ci/test-values-observability.yaml > /dev/null
    @echo "✅ All CI scenarios passed!"

# Package the chart for distribution
package:
    helm package .

# Create or update index.yaml. Usage: just index [url]
index url="":
    helm repo index . {{ if url != "" { "--url " + url } else { "" } }}

# Generate README.md from values.yaml (requires helm-docs)
docs:
    helm-docs

# Install pre-commit hooks
install-hooks:
    pre-commit install
