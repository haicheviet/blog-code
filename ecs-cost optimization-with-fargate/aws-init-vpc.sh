PROJECT_NAME=${PROJECT_NAME?Variable not set}
APP_ENV=${APP_ENV?Variable not set}

echo ">>>>>>>>>>>VPC for $PROJECT_NAME - $APP_ENV<<<<<<<<<<<<"
sleep 1

aws cloudformation deploy \
    --template-file aws/vpc-2azs.yml \
    --stack-name vpc-$APP_ENV-$PROJECT_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --tags $PROJECT_NAME-$APP_ENV-cluster=vpc

echo ">>>>>>>>>>>Client for $PROJECT_NAME - $APP_ENV<<<<<<<<<<<<"
sleep 1

aws cloudformation deploy \
    --template-file aws/client-sg.yml \
    --stack-name client-$APP_ENV-$PROJECT_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides ParentVPCStack=vpc-$APP_ENV-$PROJECT_NAME \
    --tags $PROJECT_NAME-$APP_ENV-cluster=client