docker build -t sbhasale/multi-client:latest -t sbhasale/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sbhasale/multi-server:latest -t sbhasale/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sbhasale/multi-worker:latest -t sbhasale/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sbhasale/multi-client:latest
docker push sbhasale/multi-client:$SHA
docker push sbhasale/multi-worker:latest
docker push sbhasale/multi-worker:$SHA
docker push sbhasale/multi-server:latest
docker push sbhasale/multi-server:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sbhasale/multi-server:$SHA
kubectl set image deployments/client-deployment client=sbhasale/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sbhasale/multi-worker:$SHA