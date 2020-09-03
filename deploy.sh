docker build -t hkityan/k8s-client:latest -t hkityan/k8s-client:$SHA -f ./client/Dockerfile ./client
docker build -t hkityan/k8s-server:latest -t hkityan/k8s-server:$SHA -f ./server/Dockerfile ./server
docker build -t hkityan/k8s-worker:latest -t hkityan/k8s-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hkityan/k8s-client:latest
docker push hkityan/k8s-server:latest
docker push hkityan/k8s-worker:latest

docker push hkityan/k8s-client:$SHA
docker push hkityan/k8s-server:$SHA
docker push hkityan/k8s-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hkityan/k8s-server:$SHA
kubectl set image deployments/client-deployment client=hkityan/k8s-client:$SHA
kubectl set image deployments/worker-deployment worker=hkityan/k8s-worker:$SHA