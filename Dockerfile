FROM python:3.8-slim

#  arguments
ARG DEV_MODE
ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN echo $USERNAME

# environment
ENV PYTHONFAULTHANDLER=1 \
	PYTHONUNBUFFERED=1 \
	PYTHONHASHSEED=random \
	PIP_NO_CACHE_DIR=off \
	PIP_DISABLE_PIP_VERSION_CHECK=on \
	PIP_DEFAULT_TIMEOUT=100 \
	POETRY_VERSION=1.1.13

# create a non root user and install sudo
RUN groupadd --gid $USER_GID $USERNAME \
	&& useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
	&& apt-get update \
	&& apt-get install -y sudo \
	&& echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
	&& chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

# system deps
RUN pip install "poetry==$POETRY_VERSION"
ENV PATH="${PATH}:/home/${USERNAME}/.local/bin"

# copy only requirements to cache them in docker layer
WORKDIR /app
COPY src/poetry.lock src/pyproject.toml /app/

# project initialization
RUN poetry config virtualenvs.create false \
	&& poetry install $(test "${DEV_MODE}" != prototype && echo "--no-dev") --no-interaction --no-ansi

# creating folders, and files for a project
COPY src/ /app/src/

ENV PYTHONPATH "${PYTHONPATH}:/app/src"

# run
WORKDIR /app/src/
CMD ["python", "main.py"]
