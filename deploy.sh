docker build -t balajivenkatasubramanian/multi-client:latest -t balajivenkatasubramanian/multi-clinet:$SHA -f ./client/Dockerfile ./client
docker build -t balajivenkatasubramanian/multi-server:latest -t balajivenkatasubramanian/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t balajivenkatasubramanian/multi-worker:latest -t balajivenkatasubramanian/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push balajivenkatasubaramanian/multi-client
docker push balajivenkatasubramanian/multi-server
docker push balajivenkatasubramanian/multi-worker

docker push balajivenkatasubramanian/multi-client:$SHA
docker push balajivenkatasubramanian/multi-server:$SHA
docker push balajivenkatasubramanian/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=balajivenkatasubramanian/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=balajivenkatasubramanian/multi-worker:$SHA
kubectl set image deployment/client-deployment client=balajivenkatasubramanian/multi-client:$SHA