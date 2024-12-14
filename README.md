# Spring Tool Suite (STS) Linux Installation Script

This script automates the installation of Spring Tool Suite (STS) on Linux, including creating a desktop shortcut for easy access. Follow the instructions below to install and run Spring Tool Suite.

## Prerequisites

1. **Spring Tool Suite Installation**: The script assumes that you have installed Spring Tool Suite in the `/opt` directory (e.g., `/opt/sts-4.x.x.RELEASE`). If you haven't already installed STS, please follow the installation steps on the official [Spring Tool Suite website](https://spring.io/tools).

2. **Linux Environment**: The script is designed to work on most Linux distributions (Ubuntu, Fedora, etc.).

## Installation Steps

### 1. Download the Script

You can download the `sts-linux-install.sh` script directly from the repository, or you can copy it from here:

```bash
wget https://example.com/path/to/sts-linux-install.sh
```
###2. Change to the Repository Directory

After cloning the repository, navigate into the directory where it was cloned:

cd yourrepository

###3. Make the Script Executable

Ensure that the script is executable by running the following command to give it execute permissions:
```bash
chmod +x sts-linux-install.sh
```
###4. Run the Script

Once the script is executable, run it to automatically generate the .desktop entry for Spring Tool Suite:
```bash
./sts-linux-install.sh
```
This will create a desktop entry for Spring Tool Suite, allowing you to launch it directly from your application menu.

## CREDITS: JEJO.J
### WITH LOVE FOR BUBUCHI ! 
