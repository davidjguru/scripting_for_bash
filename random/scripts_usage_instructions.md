# Script Usage Instructions
In this folder, you’ll find a collection of scripts designed to simplify your workflow in a local development environment (LDE). Learn what each script does and review the steps required to run them.

## Available scripts

1. **Install Docker Engine and DDEV**: `install_docker_engine_ddev.sh` - Use it to install basic resources on a freshly installed system. This will install Git, cURL, Docker, DDEV, and many other essential tools. This is for new environments only.  
2. **Create new Drupal project**: `create_drupal_project.sh` - Use it to create new Drupal projects on the fly, in environments where all required tools (Git, cURL, Docker, DDEV, etc.) are already installed.    
3. **Delete Drupal projects**: `delete_drupal_project.sh` - Use it to delete DDEV-based Drupal projects: this will remove both the DDEV configuration and the Docker containers used by the project, and even the project’s source code from your local environment. Use with caution.

## Steps

1. Move scripts to your workspace or projects folder.
2. Give execution permissions to scripts: `chmod +x install_docker_engine_ddev.sh`
3. Execute scripts: `./install_docker_engine_ddev.sh`