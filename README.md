# Terraform files for creating grafana server, onedata clients and running a benchmark

## Prerequisits
A running Ceph cluster and oneprovider built with ceph-tf is required. The relative path access ceph-ft directiry should be ../ceph-tf.

## Configuring
In order to build your grafana server and onedata clients machines you need to:
* run ssh-agent and add your key. It will further be used to login into the created VMs.
* provide your openstack credentials by editting parameter.tvars. The username should be the same as shown in the OTC console. You can not use the email or mobile number, which can also be used to login to the OTC web console. 
* eventually change values in varaibles.tf according to the comments in this file.
* you should provide the same project name as used when creating the Ceph cluster and oneprovider. The tf scripts use it to obtain the subnet and network ids, which are needed to create VMs in the same subnet.
* eventually change benchmark parameters in bench/start.sh.tpl. You should only change the namber of files created and the time limit for running the benchmark. 


## Running
Create your machines issuing:
```
terraform init
terraform apply -var-file parameter.tvars -var project=<project> -var access_token=<access_token>
```

After successful built the benchmark will be running on each client and performance counters will be reported to the graphite server. You can visualize them by pointing to the grafana public ip in your browser. Login with admin:admin.

## Accessing your Grafana server and clients
After a successful built the public IP of the Grafana server and the private IPs of the clients are displayed. Use it to login:
```
ssh -A ubuntu@THE_GRAFANA_PUBLIC_IP
```
Then you can jump into the clients:
```
ssh -A ubuntu@CLIENT_PRIVATE_IP
```



