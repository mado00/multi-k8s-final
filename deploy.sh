docker build -t menomonies/multi-client:latest -t menomonies/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t menomonies/multi-server:latest -t menomonies/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t menomonies/multi-worker:latest -t menomonies/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push menomonies/multi-client:latest
docker push menomonies/multi-server:latest
docker push menomonies/multi-worker:latest

docker push menomonies/multi-client:$SHA
docker push menomonies/multi-server:$SHA
docker push menomonies/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=menomonies/multi-server:$SHA
kubectl set image deployments/client-deployment client=menomonies/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=menomonies/multi-worker:$SHA

