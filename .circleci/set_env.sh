#!/bin/sh
set -e

# pushしたブランチ名によって設定を変更する
case "${CIRCLE_BRANCH}" in
  develop)
    echo 'export IMAGE_TAG=stage01' | tee -a ${BASH_ENV}
    ;;
  stage[0-9][0-9])
    echo 'export IMAGE_TAG=${CIRCLE_BRANCH}' | tee -a ${BASH_ENV}
    ;;
  master)
    echo 'export IMAGE_TAG=prod' | tee -a ${BASH_ENV}
    ;;
  *)
    exit 0
    ;;
esac

# echo 'export IMAGE_TAG=testing' | tee -a ${BASH_ENV}
echo 'export ECR_REPO_NAME=wordpress-test' | tee -a ${BASH_ENV}
echo 'export ECR_IMAGE_NAME=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}' | tee -a ${BASH_ENV}
