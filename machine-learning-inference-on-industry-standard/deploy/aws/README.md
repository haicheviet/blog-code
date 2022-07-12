# Step

- Enable enviroment value first before run all these step. Ex: `set -a && source .env && set +a`
- Start VPC and Client

```bash
# Start VPC and Client-JG
$ bash aws-init-vpc.sh

# Start bastion host to enable to feature store
$ bash aws-init-bastion.sh

# Start redis store
$ bash aws-init-feature-store.sh
```

- Connect bastion host to test redis available

```bash

$ ssh -i /your/path/id_rsa -L 6379:cache-dns-name:6379 ec2-user@ip-bastion-host -f -N

$ redis-cli -p 6379
127.0.0.1:6379> ping
PONG
```

- Start cluster and task

```bash
# Start Cluster
$ bash aws-init-cluster.sh

# Run task
$ bash aws-init-task.sh
```

- Go to your ALB to test service `$your-alb-dns/docs`
