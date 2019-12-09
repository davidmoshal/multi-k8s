docker build -t davidmoshal/multi-client:latest -t davidmoshal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t davidmoshal/multi-server:latest -t davidmoshal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t davidmoshal/multi-worker:latest -t davidmoshal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push davidmoshal/multi-client:latest
docker push davidmoshal/multi-server:latest
docker push davidmoshal/multi-worker:latest

docker push davidmoshal/multi-client:$SHA
docker push davidmoshal/multi-server:$SHA
docker push davidmoshal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=davidmoshal/multi-server:$SHA
kubectl set image deployments/client-deployment client=davidmoshal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=davidmoshal/multi-worker:$SHA
