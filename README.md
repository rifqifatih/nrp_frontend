This repository consist of 2 main parts (file):
- Dockerfile
- nrp-frontend.yml

The `Dockerfile` defines the modification applied to the base image of NRP backend from `hbpneurorobotics/nrp_frontend:dev` tuned for deployment on Kubernetes cluster inside Google Cloud Platform environment.

Any commit to the `master` branch will automatically trigger a build to the respected [Docker Hub](https://hub.docker.com/repository/docker/rifqifatih/nrp_frontend) repository.

Pull the image from repository:
```
docker pull rifqifatih/nrp_frontend:latest
```

The `nrp-frontend.yml` defines the Service and Deployment Kubernetes configuration. The proxy uses Kubernetes API to discover backend services, so make sure that the pod running the frontend had the permission by applying:
```
kubectl apply -f fabric8-rbac.yaml
```

To nrp frontend in your Kubernetes cluster run:
```
kubectl apply -f nrp-frontend.yml
```
