#!/bin/bash

# List all ECS clusters alphabetically
echo "Listing ECS clusters..."
clusters_json=$(aws ecs list-clusters --output json)
clusters_tmp=($(echo "$clusters_json" | jq -r '.clusterArns | map(.[32:]) | sort[]'))

if [ ${#clusters_tmp[@]} -eq 0 ]; then
  echo "No ECS clusters found."
  exit 1
fi

# Create an empty array to store the trimmed values
clusters=()

# Loop through the original array and trim the leading "44:cluster/"
for element in "${clusters_tmp[@]}"; do
  trimmed_element="${element#44:cluster/}"
  clusters+=("$trimmed_element")
done

# Prompt the user to select a cluster
echo "Available ECS clusters:"
for i in "${!clusters[@]}"; do
  echo "$i. ${clusters[$i]}"
done

read -p "Select a cluster (enter the corresponding number): " cluster_selection

if [[ ! $cluster_selection =~ ^[0-9]+$ ]] || [[ $cluster_selection -lt 0 ]] || [[ $cluster_selection -ge ${#clusters[@]} ]]; then
  echo "Invalid selection. Please enter a valid number."
  exit 1
fi

selected_cluster="${clusters[$cluster_selection]}"
echo "Selected cluster: $selected_cluster"

# List all tasks for the selected cluster
echo "Listing tasks for cluster $selected_cluster..."
tasks_json=$(aws ecs list-tasks --cluster "$selected_cluster" --output json)
tasks=($(echo "$tasks_json" | jq -r '.taskArns | sort[]'))

if [ ${#tasks[@]} -eq 0 ]; then
  echo "No tasks found for cluster $selected_cluster."
  exit 1
fi

# Check if there is only one task available
if [ ${#tasks[@]} -eq 1 ]; then
  echo "Only one task available. Selecting it automatically."
  selected_task="${tasks[0]}"
else
  # Prompt the user to select a task
  echo "Available tasks for cluster $selected_cluster:"
  for i in "${!tasks[@]}"; do
    echo "$i. ${tasks[$i]}"
  done

  read -p "Select a task (enter the corresponding number): " task_selection

  if [[ ! $task_selection =~ ^[0-9]+$ ]] || [[ $task_selection -lt 0 ]] || [[ $task_selection -ge ${#tasks[@]} ]]; then
    echo "Invalid selection. Please enter a valid number."
    exit 1
  fi

  selected_task="${tasks[$task_selection]}"
fi

echo "Selected task: $selected_task"

# Execute the command to connect to the container
echo "Connecting to the container in task $selected_task..."
aws ecs execute-command \
  --cluster "$selected_cluster" \
  --task "$selected_task" \
  --container "$selected_cluster" \
  --interactive \
  --command "/bin/sh"
  