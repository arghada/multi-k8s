docker build -t arghada/multi-client:latest -t arghada/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arghada/multi-server:latest -t arghada/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arghada/multi-worker:latest -t arghada/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arghada/multi-client:latest
docker push arghada/multi-server:latest
docker push arghada/multi-worker:latest

docker push arghada/multi-client:$SHA
docker push arghada/multi-server:$SHA
docker push arghada/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arghada/multi-server:$SHA
kubectl set image deployments/client-deployment client=arghada/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arghada/multi-worker:$SHA