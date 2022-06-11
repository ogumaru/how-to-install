#!/bin/bash
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
rm -rf ./aws
rm awscliv2.zip

