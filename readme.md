# Local Ollama in Docker

This is Frank's personal local Ollama set up in Docker. This runs on a Ubuntu Linux LTS 24.04.

Wrote about the big picture at https://rietta.com/blog/ollama-with-nvidia-gpu-in-docker-compose/.

## GPU Information

Frank's system is running a NVIDIA GeForce RTX 4070 GPU. Running the nvidia-smi command gives details:

```
$ nvidia-smi 
Wed Apr  8 17:39:22 2026       
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 580.126.09             Driver Version: 580.126.09     CUDA Version: 13.0     |
+-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 4070 ...    Off |   00000000:01:00.0  On |                  N/A |
|  0%   42C    P2             34W /  220W |    2310MiB /  12282MiB |      1%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI              PID   Type   Process name                        GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A            5241      G   /usr/lib/xorg/Xorg                      242MiB |
|    0   N/A  N/A            5573      G   /usr/bin/gnome-shell                     64MiB |
|    0   N/A  N/A            6057      G   ...exec/xdg-desktop-portal-gnome          3MiB |
|    0   N/A  N/A          214413      G   ...slack/216/usr/lib/slack/slack         50MiB |
|    0   N/A  N/A          220068    C+G   ...rack-uuid=3190709233690919630         71MiB |
|    0   N/A  N/A          245265      G   /usr/share/code/code                     60MiB |
|    0   N/A  N/A          249301      C   /usr/bin/ollama                        1656MiB |
+-----------------------------------------------------------------------------------------+
```

**Pro-tip**: If you want to monitor continuously, you can run:

```bash
watch -n 1 nvidia-smi 
```

Ctrl+C to exit when you are done.

## The Interactive Ruby Console

```bash
docker compose run console
```

## Bring up Server

```bash
docker compose up webui
```

It will automatically download and start the OpenWeb UI.

You can access the web interface at http://localhost:8080/.

Read more about Open WebUI at https://github.com/open-webui/open-webui

## Stop Server

```bash
docker compose down --remove-orphans
```

## Running Services

This docker-compose.yml brings up two servers. One is the OpenWeb UI and the other is the Ollama server itself. You can see this by running:

```bash
$ docker ps
CONTAINER ID   IMAGE                                  COMMAND               CREATED         STATUS                   PORTS                                             NAMES
ca1c3602ba25   ghcr.io/open-webui/open-webui:latest   "bash start.sh"       5 minutes ago   Up 5 minutes (healthy)   0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp       ollama-webui-1
cf364379003c   ollama/ollama:latest                   "/bin/ollama serve"   5 minutes ago   Up 5 minutes             0.0.0.0:11434->11434/tcp, [::]:11434->11434/tcp   ollama-ollama-1
```
This shows that the following ports are being listened to on your system:

- 8080 -> Web UI for managing and "chatting" with models.
- 11434 -> OLLAMA server for inference and direct connections.

## List Volumes

```bash
$ docker volume ls | grep 'ollama'
```

Results like:
```
local     ollama_ollama
local     ollama_open-webui
```
