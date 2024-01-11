# Overview

This Docker Compose solution is specifically designed to execute Visual Studio Code Server. It simplifies the set-up and management of your development environment, enabling you to focus on coding. This solution allows you to run Visual Studio Code Server quickly and easily, fostering efficient software development processes.

## Quick Start

```bash
# Verified for MAC and Ubuntu OS

# Configures the environmental variables needed to keep your permissions in tact
./setenv.sh

# The simplest command will initiate the VSCode Server on localhost:8000?tkn=[TOKEN]
# It uses the current directory as the working directory
# [OPTIONAL] Add the `-d` option if you want the container to run in the background
# [OPTIONAL] Add the `--build` option if you always want to start with a rebuilt image
docker compose --env-file .env.ids --env-file .env -d --build 
```

If you need git support, use this `docker compose` command in place of the previous command.
You will need to specify the location of your git repo ssh key. **IT'S HIGHLY RECOMMENDED THAT YOU USE AN SSH KEY THAT HAS THE PASSPHRASE.**

```bash
# Share the SSH_KEY location is needed if you need the ability of managing your code with git from within VS Code
SSH_KEY=/home/user/.ssh/id_git docker compose --env-file .env.ids --env-file .env -d
```

Once the Visual Studio Code Server is operational, you can connect to it using any modern web browser. Enter the local address followed by the port number in your browser's address bar: `http://localhost:port_number?tkn=[TOKEN]`.

You can now start coding in your preferred language, with all the features and convenience of Visual Studio Code in your browser. This includes IntelliSense, debugging, Git commands, extensions, and more.

To stop the server, use `ctrl-c`. If you kicked off the container with `-d`, use the command `docker compose down` in the terminal. This will cease all processes related to the Visual Studio Code Server, freeing up system resources.

Remember, this Docker Compose solution's main advantage is that it provides a consistent and reliable development environment, eliminating the need to manually set up your IDE each time. This makes software development much smoother and more efficient.

## Configurable Environmental Variables

- OPTIONS - This variable passes options used to configure the VS Code Server start-up.
    - d allows the server to accept connections without tokens
    - h displays the usage printout
- WDIR - Overrides the default working directory. Using a directory that doesn't exist will cause the container to fail when starting
- PORT - Overrides the default web port of 8000

```bash
# disable connection token, specifies a different working directory,
# and changes the web port which will kick off the VSCode Server on localhost:8888
WDIR=/home/user/dev OPTIONS="-d" SSH_KEY=/home/user/.ssh/id_git PORT=8888 docker compose --env-file .env.ids --env-file .env -d
```

## Recommendations

By default, the VS Code server doesn't use HTTPS. On an unsecured network, make sure to use the connection token for server access. For remote server access, create an SSH secure tunnel to ensure your connection is secured through port forwarding.

To establish an SSH tunnel with port forwarding for port 8000, enter the following command in your terminal:

```bash
ssh -L 8000:localhost:8000 your_username@your_remote_server

```

In this command, `your_username` is your user account on the remote server, and `your_remote_server` is the server's address. The `-L` option specifies the port forwarding configuration. This command forwards the local port 8000 to the remote server's port 8000, allowing you to access the server by navigating to `localhost:8000?tkn=[TOKEN]` in your browser.