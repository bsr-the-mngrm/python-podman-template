# python-podman-template
📦 Python project template with Podman support — easily containerize and run your Python apps using a minimal, ready-to-use Podman setup.

## ✅ Prerequisites
Before you begin, make sure the following tools are installed and properly configured on your system:
- Operating System: Windows 10 or 11 (with WSL2 enabled)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Podman](https://podman.io/)
- [Podman Desktop](https://podman.io/podman-desktop)
- [Remote - Containers extension for VS Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

⚠️ This template assumes you are using Podman as a Docker replacement under WSL2 and running VS Code on Windows.

## 🚀 Getting Started with Podman in VS Code
To run this project in a Podman container using Visual Studio Code, follow these initial setup steps:

1. **Open User Settings (JSON)**
    1. Open **Visual Studio Code**.
    1. Press `Ctrl + Shift + P` to open the Command Palette.
    1. Search for "**Preferences: Open User Settings (JSON)**" and select it.

1. **Add the following settings**
    - Insert the following key-value pairs into your `settings.json` file:
    - This tells VS Code to use Podman instead of Docker when working with Dev Containers 
    - And disable GUI-related socket mounting in Dev Containers (not to attempt to mount the wayland-0 socket, which avoids the UNC mount error).
    ```json
    "containers.containerClient": "com.microsoft.visualstudio.containers.podman",
    "dev.containers.dockerPath": "podman",
    "dev.containers.mountWaylandSocket": false,
    ``` 

1. **Copy Template Files**

    To set up your development environment, copy the provided template files to their active locations:
    ```bash
    cp .devcontainer/devcontainer.json.template .devcontainer/devcontainer.json
    cp .vscode/settings.json.template .vscode/settings.json
    ```
    💡 These files define your development container and workspace settings. You can modify them to suit your project needs.

1. **Launch Dev Container**
    
    Run: `Ctrl + Shift + P` → "**Dev Containers: Reopen in Container**"

    VS Code will:
    - Build your container using `Containerfile`
    - Mount your code inside `/home/dev/app`
    - Install extensions and run poetry install
    - Open VS Code inside the container as the `dev` user

1. **Awesome**, you're ready to build the next thing! 🎉🎉🎉

## 🔧 Local Development Workflow

The diagram below illustrates how this template works during local development with Podman:
```
+-------------------+        triggers build          +---------------------+
|      VS Code      | ---------------------------->  | Python Container    |
|  (devcontainer)   |                                | Image (Podman)      |
+-------------------+                                +---------------------+
        |                                                        |
        |    podman run (auto)                                   |
        |  + source mount / port                                 |
        v                                                        v
+-------------------+                                 +-------------------+
| VS Code Terminal  | <------- localhost:PORT --------| Running Container |
| or UI Extensions  |                                 | (Python app)      |
+-------------------+                                 +-------------------+


```