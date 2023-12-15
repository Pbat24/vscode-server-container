FROM ubuntu:22.04

# defined in .env or based through a environmental variable
ARG WORKING_DIR

# The following lines are needed for creating an existing user within the image
ARG UID
ARG GID
ARG ID
RUN useradd --create-home --no-log-init -u "${UID}" -g "${GID}" "${ID}"

# Installs and sets up the required binaries for the VS Code Server to work
COPY scripts/setup_vscode.sh /setup/
RUN /setup/setup_vscode.sh

# Optional packages that are helpful
COPY scripts/install_additional_packages.sh /setup/
RUN /setup/install_additional_packages.sh

# Helper scripts for starting the VS Code Server
COPY .env /opt/vscode-server/
COPY scripts/start_code_server.sh /opt/vscode-server/
RUN echo "export PATH=\$PATH:/opt/vscode-server" >> /root/.bashrc

# The working directory points to the mounted source used for development
WORKDIR $WORKING_DIR

USER "${ID}"
COPY --chown=${UID}:${GID} scripts/config /home/${ID}/.ssh/
RUN echo "export PATH=\$PATH:/opt/vscode-server" >> /home/${ID}/.bashrc


ENTRYPOINT ["/bin/bash"]
CMD [ "/opt/vscode-server/start_code_server.sh" ]
