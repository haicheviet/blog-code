PROJECT_NAME=${PROJECT_NAME?Variable not set}
APP_ENV=${APP_ENV?Variable not set}

aws cloudformation deploy \
    --template-file cloudformation/elasticcache-redis.yml \
    --stack-name redis-$APP_ENV-$PROJECT_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides ParentVPCStack=vpc-$APP_ENV-$PROJECT_NAME \
        ParentClusterStack=cluster-fargate-$APP_ENV-$PROJECT_NAME \
        ParentClientStack=client-$APP_ENV-$PROJECT_NAME \
        ParentSSHBastionStack=ssh-bastion-$APP_ENV-$PROJECT_NAME \
    --tags $PROJECT_NAME-$APP_ENV-cluster=feature-store
