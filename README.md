# Overview

This Docker Compose solution is specifically designed to execute Visual Studio Code Server. It simplifies the set-up and management of your development environment, enabling you to focus on coding. This solution allows you to run Visual Studio Code Server quickly and easily, fostering efficient software development processes.

## Quick Start

You will need to specify you USER creds and the location of your github ssh key. **IT'S HIGHLY RECOMMENDED THAT YOU USE AN SSH KEY THAT HAS THE PASSPHRASE.**

```bash
# Verified for MAC OS

# The simplest command will initiate the VSCode Server on localhost:8000?tkn=[TOKEN]
# UID, GID, and ID are needed so your not running in VS Code as root and allows you to keep your existing file permissions
# SSH_KEY location is needed in order to have the ability of managing your code with git from within VS Code
# It uses the current directory as the working directory
UID=${UID} GID=${GID} ID=${USER} SSH_KEY=/home/user/.ssh/id_github docker compose -d

# Add the --build option if you always want to start with a rebuilt image
UID=${UID} GID=${GID} ID=${USER} SSH_KEY=/home/user/.ssh/id_github docker compose -d --build
```

Once the Visual Studio Code Server is operational, you can connect to it using any modern web browser. Enter the local address followed by the port number in your browser's address bar: `http://localhost:port_number?tkn=[TOKEN]`.

You can now start coding in your preferred language, with all the features and convenience of Visual Studio Code in your browser. This includes IntelliSense, debugging, Git commands, extensions, and more.

To stop the server, use the command `docker compose down` in the terminal. This will cease all processes related to the Visual Studio Code Server, freeing up system resources.

Remember, this Docker Compose solution's main advantage is that it provides a consistent and reliable development environment, eliminating the need to manually set up your IDE each time. This makes software development much smoother and more efficient.

## Configurable Environmental Variables

- OPTIONS - This variable passes options used to configure the VS Code Server start-up.
    - d allows the server to accept connections without tokens
    - h displays the usage printout
- WDIR - Overrides the default working directory. Using a directory that doesnât exist will cause the container to fail when starting
- PORT - Overrides the default web port of 8000

```bash
# disable connection token, specifies a different working directory,
# and changes the web port which will kick off the VSCode Server on localhost:8888
WDIR=/home/user/dev OPTIONS="-d" UID=${UID} GID=${GID} ID=${USER} SSH_KEY=/home/user/.ssh/id_github PORT=8888 docker compose -d
```

## Recommendations

By default, the VS Code server doesn't use HTTPS. On an unsecured network, make sure to use the connection token for server access. For remote server access, create an SSH secure tunnel to ensure your connection is secured through port forwarding.

To establish an SSH tunnel with port forwarding for port 8000, enter the following command in your terminal:

```bash
ssh -L 8000:localhost:8000 your_username@your_remote_server

```

In this command, `your_username` is your user account on the remote server, and `your_remote_server` is the server's address. The `-L` option specifies the port forwarding configuration. This command forwards the local port 8000 to the remote server's port 8000, allowing you to access the server by navigating to `localhost:8000?tkn=[TOKEN]` in your browser.