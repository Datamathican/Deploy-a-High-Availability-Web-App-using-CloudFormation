#!/bin/bash
# Usage: ./delete.sh <stack-name>
aws cloudformation delete-stack \
--stack-name $1 \
--region=us-east-1
