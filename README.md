# Grafana via Docker

Metrics from Coiled clusters are collected and stored in Prometheus. Some of these metrics are exposed in the Coiled web app, but for access to your cluster metrics, you'll want to use Grafana.

There are many ways to run Grafana. You can use a hosted Grafana service (Grafana Cloud, Amazon Managed Grafana). You can run Grafana on a VM—we do this for internal Coiled users.

But for an individual user, it's easiest to just run Grafana locally using Docker. That's what we'll do here.

The included config will start Grafana, add your datasource and the basic Coiled dashboard, so it's very easy to get started looking at Coiled cluster metrics.

# Get started running Grafana

1. Edit `datasource.yaml` with the config to access your Prometheus workspace (`endpoint`, `region`, `key` and `secret`)
2. `chmod +x run.sh delete.sh`
3. `./run.sh`
4. On macOS, this will open a web browser automatically, but if that doesn't work, go to the [Grafana dashboard](http://localhost:3000/d/GvbFsqKVk/coiled-cluster-metrics-basic)

The initial username and password are both 'admin', you can then change the password if you want.

If you want to stop and start Grafana, just run `docker stop grafana` / `docker start grafana`.

If you want to get rid of Grafana entirely, run `./delete.sh`.

# How this works

For persistent storage, we create a docker volume so that Prometheus settings will be persisted.

The Docker run command mounts the datasource and dashboard so that they are "provisioned" when Grafana starts.

We also need to set an ENV var so that SigV4 authentication is enabled; this is needed for accessing Amazon Managed Prometheus.
