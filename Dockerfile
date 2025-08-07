# base image
FROM ubuntu:22.04

# environment variables
ENV PATH=/home/vscode/.local/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV DEBCONF_NONINTERACTIVE_SEEN=true

# install packages
RUN apt update \
    && apt -y upgrade \
    && apt -y install --no-install-recommends build-essential \
    && apt -y install --no-install-recommends manpages-dev \
    && apt -y install --no-install-recommends software-properties-common \
    && apt -y install --no-install-recommends gcc-12 \
    && apt -y install --no-install-recommends g++-12 \
    && apt -y install --no-install-recommends python3.10 \
    && apt -y install --no-install-recommends python3-pip \
    && apt -y install --no-install-recommends gdb \
    && apt -y install --no-install-recommends libboost-all-dev \
    && apt -y install --no-install-recommends git \
    && apt -y install --no-install-recommends parallel \
    && apt -y install --no-install-recommends zsh \
    && apt -y install --no-install-recommends curl \
    && apt -y install --no-install-recommends wget \
    && apt -y install --no-install-recommends ca-certificates \
    && update-ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt -y install --no-install-recommends nodejs \
    && npm install -g @anthropic-ai/claude-code \
    && apt autoremove -y \
    && apt clean -y

# zsh settings
RUN chsh -s /bin/zsh
RUN echo 'alias ll="ls -la"' >> /etc/zsh/zshrc \
    && echo 'alias gcc="gcc-12"' >> /etc/zsh/zshrc \
    && echo 'alias g++="g++-12"' >> /etc/zsh/zshrc \
    && echo 'PROMPT="%U%F{45}%~%f%u > "' >> /etc/zsh/zshrc \
    && echo 'bindkey "^[[1;5C" forward-word' >> /etc/zsh/zshrc \
    && echo 'bindkey "^[[1;5D" backward-word' >> /etc/zsh/zshrc \
    && echo 'bindkey "^[[3;5~" kill-word' >> /etc/zsh/zshrc \
    && echo 'bindkey "^H" backward-kill-word' >> /etc/zsh/zshrc

# install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
