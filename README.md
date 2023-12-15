# Overview

This Docker Compose solution is specifically designed to execute Visual Studio Code Server. It simplifies the set-up and management of your development environment, enabling you to focus on coding. This solution allows you to run Visual Studio Code Server quickly and easily, fostering efficient software development processes.

## Quick Start

```bash
# Verified for MAC OS

# The simplest command will initiate the VSCode Server on localhost:8000?tkn=[TOKEN]
# It uses the current directory as the working directory
UID=${UID} GID=${GID} ID=${USER} docker compose -d

# Add the --build option if you always want to start with a rebuilt image
UID=${UID} GID=${GID} ID=${USER} docker compose -d --build
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
WDIR=/home/user/dev OPTIONS="-d" UID=${UID} GID=${GID} ID=${USER} PORT=8888 docker compose -d
```