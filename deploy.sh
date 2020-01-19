docker build -t tayo96/multi-client:latest -t tayo96/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t tayo96/multi-server:latest -t tayo96/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tayo96/multi-worker:latest -t tayo96/multi-worker:$SHA-f ./worker/Dockerfile ./worker

docker push tayo96/multi-client:latest
docker push tayo96/multi-server:latest
docker push tayo96/multi-worker:latest

docker push tayo96/multi-client:$SHA
docker push tayo96/multi-server:$SHA
docker push tayo96/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=tayo96/multi-server:$SHA
kubectl set image deployments/client-deployment client=tayo96/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tayo96/multi-worker:$SHA