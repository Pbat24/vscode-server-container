FROM ubuntu:22.04

# defined in .env or based through a environmental variable
ARG WORKING_DIR

# The following lines are needed for creating an existing user within the image
ARG USER_ID
ARG GRP_ID
ARG USER_NAME
RUN groupadd -fg "${GRP_ID}" default
RUN useradd --create-home --no-log-init -u "${USER_ID}" -g "${GRP_ID}" "${USER_NAME}"

# Installs and sets up the required binaries for the VS Code Server to work
COPY scripts/setup_vscode.sh /setup/
COPY *.deb /setup/
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

USER "${USER_NAME}"
COPY --chown=${USER_ID}:${GRP_ID} scripts/config /home/${USER_NAME}/.ssh/
RUN echo "export PATH=\$PATH:/opt/vscode-server" >> /home/${USER_NAME}/.bashrc


ENTRYPOINT ["/bin/bash"]
CMD [ "/opt/vscode-server/start_code_server.sh" ]
