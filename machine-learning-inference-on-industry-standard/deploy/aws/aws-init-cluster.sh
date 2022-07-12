PROJECT_NAME=${PROJECT_NAME?Variable not set}
APP_ENV=${APP_ENV?Variable not set}

echo ">>>>>>>>>>>Cluster for $PROJECT_NAME - $APP_ENV<<<<<<<<<<<<"
sleep 1

aws cloudformation deploy \
    --template-file cloudformation/cluster-fargate.yml \
    --stack-name cluster-fargate-$APP_ENV-$PROJECT_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides ParentVPCStack=vpc-$APP_ENV-$PROJECT_NAME \
    --tags $PROJECT_NAME-$APP_ENV-cluster=ecs-cluster