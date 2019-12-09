docker build -t dmoshal/multi-client:latest -t dmoshal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dmoshal/multi-server:latest -t dmoshal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dmoshal/multi-worker:latest -t dmoshal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dmoshal/multi-client:latest
docker push dmoshal/multi-server:latest
docker push dmoshal/multi-worker:latest

docker push dmoshal/multi-client:$SHA
docker push dmoshal/multi-server:$SHA
docker push dmoshal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dmoshal/multi-server:$SHA
kubectl set image deployments/client-deployment client=dmoshal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dmoshal/multi-worker:$SHA
