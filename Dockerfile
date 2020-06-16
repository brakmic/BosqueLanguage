FROM ubuntu:20.04

# Prepare development environment
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl
RUN curl --silent --location https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential
RUN apt-get install -y clang-10
RUN apt-get update && apt-get upgrade -y && apt-get install git -y
RUN ln -s /usr/bin/clang-10 /usr/bin/clang
RUN ln -s /usr/bin/clang++-10 /usr/bin/clang++

# Clone Bosque's sources
RUN git clone https://github.com/microsoft/BosqueLanguage.git bosque
# Copy language tools for VSCode integration (syntax highlighting)
RUN mkdir -p /root/.vscode-server/extensions && mv ./bosque/bosque-language-tools /root/.vscode-server/extensions
WORKDIR /bosque/impl
# Install Node packages
RUN npm install --global --silent typescript
RUN npm install --silent
# Make Bosque's exegen globally available
RUN npm run make-exe
# Install nano & vim editors
RUN apt-get install nano -y && apt-get install vim -y

WORKDIR /src

CMD ["/bin/bash"]
