# Using Conda in a Spark Cluster

I was trying to use Python in a Spark cluster, which required packing my Python code, dependencies, and the Python interpreter. The Spark documentation suggests using Conda for this task:
- https://spark.apache.org/docs/3.5.1/api/python/user_guide/python_packaging.html?highlight=conda#using-conda

I encountered some issues getting it running, so I tried to reproduce the error seperately in a Docker container here. This README documents the process and the solution.

## TLDR;

Whenever using conda in a script (non interactive), watch out for:  `conda activate -n <env>` and replace it with `conda run -n <env>`.

## Docker Images

The official Docker containers from Continuum Analytics (Anaconda) are used:

https://github.com/ContinuumIO/docker-images

## Usage

To run the example, use the following commands:

```bash
alias dc='docker compose'

dc up -d
for service in `dc config --services`; do
    dc exec $service ./report.sh
done
dc down
```

If everything is set up and executed successfully, you should not see any 🚫 error messages. Look for ✅ success messages!

## Troubleshooting

I initially encountered the following error message:

```
CondaError: Run 'conda init' before 'conda activate'

🚫 An error occurred in: ./report.sh at line: 19. Exiting...
```

After some investigation, I realized that `conda activate/init` modifies the shell environment, which does not work directly in a script. Adjustments to handle this are visible in the `report.sh` script.