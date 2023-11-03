# 🚀 AWS ECS Cluster and Container Interaction Script

This Bash script is designed to simplify the interaction with Amazon Web Services (AWS) Elastic Container Service (ECS). It allows you to list ECS clusters, select a specific cluster, list tasks within the selected cluster, and connect to a container interactively.

## 🧰 Prerequisites

Before using this script, make sure you have the following prerequisites in place:

1. [AWS CLI](https://aws.amazon.com/cli/) :electric_plug: : Ensure you have the AWS Command Line Interface installed and configured with the necessary AWS credentials and permissions.

2. [jq](https://stedolan.github.io/jq/) :hammer_and_wrench: : You will need the `jq` command-line tool for parsing JSON data. Make sure it is installed on your system.

## 🚴 Usage

1. Clone this repository to your local machine.
2. Make the script executable by running the following command:
```bash
chmod +x ecs-connect.sh
```
3. Run the script
```bash
./ecs-connect.sh
```
4. The script will guide you through the following steps:
- List available ECS clusters and allow you to select one.
- List tasks within the selected cluster.
- If multiple tasks are available, you can choose one.
- Finally, it will connect to a container within the selected task interactively using /bin/sh.

## 🔎 Script Details

- The script uses the AWS CLI to interact with AWS ECS services.
- It leverages the `jq`` tool to parse and manipulate JSON data.
- It provides a user-friendly interface for selecting ECS clusters and tasks.
- It enables you to connect to a container within a selected task for debugging or other purposes.

## ⚠️ Disclaimer

This script is provided as-is and does not come with any warranties or support. Use it at your own risk, and make sure you have the necessary AWS credentials and permissions to access your AWS resources.

## 📜 License

This script is © 2023 by Arnaud Coral. It's licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/). Please refer to the license for permissions and restrictions.
