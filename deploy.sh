docker build -t tux1980/multi-client:latest -t tux1980/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tux1980/multi-server:latest -t tux1980/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tux1980/multi-worker:latest -t tux1980/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tux1980/multi-client:latest
docker push tux1980/multi-server:latest
docker push tux1980/multi-worker:latest
docker push tux1980/multi-client:$SHA
docker push tux1980/multi-server:$SHA
docker push tux1980/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tux1980/multi-server:$SHA
kubectl set image deployments/client-deployment sclient=tux1980/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tux1980/multi-worker:$SHA