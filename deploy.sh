docker build -t ickyatcity/multi-client:latest -t ickyatcity/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ickyatcity/multi-server:latest -t ickyatcity/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ickyatcity/multi-worker:latest -t ickyatcity/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ickyatcity/multi-client:latest
docker push ickyatcity/multi-server:latest
docker push ickyatcity/multi-worker:latest

docker push ickyatcity/multi-client:$SHA 
docker push ickyatcity/multi-server:$SHA 
docker push ickyatcity/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ickyatcity/multi-server:$SHA
kubectl set image deployments/client-deployment client=ickyatcity/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ickyatcity/multi-worker:$SHA
