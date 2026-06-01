<h1 align=center>DotFiles</h1>
<h3 align=center>PS1 Prompt</h3>
<br>

A clean, informative, slightly resource intensive, prompt for your shell(s).

<details>
<summary>Show Examples</summary>

#### Bash

<div><img src='/../assets/ps1-bash-example.jpg' /></div>

#### Zsh

<div><img src='/../assets/ps1-zsh-example.jpg' /></div>
</details>

#### Features

- Detects shell and displays shell-specific prompt line
- Detects and displays git repo and branch
- Uses shorthand for directory paths
- First column displays last-command exit status
- Last column displays user level
- Configurable colors and icons (See [Configuration](#configuration))
- Visual indicators for compatible shells

#### Dependencies

- Bash4
- Git

#### Compatible Shells

- Bash
- Zsh

## Installation

### Via Install Script

```sh
sudo src/install
```

### Manual Install

> [!IMPORTANT]
> Ensure `/usr/local/bin` is present in the `PATH` of each user `get-ps1` is configured for, including _root_.

1. #### Create Directories

    ```sh
    sudo mkdir -p /usr/local/bin /usr/local/libexec/ps1
    ```

2. #### Copy PS1 Scripts to `libexec`

    ```sh
    sudo cp -r src/scripts/* /usr/local/libexec/ps1
    ```

3. #### Create Symbolic Link for `get-ps1`

    ```sh
    sudo ln -s /usr/local/libexec/ps1/get-ps1 /usr/local/bin/get-ps1
    ```

4. #### Update Shell Runtime Configs

    - #### Bash

        ```sh
        echo 'source <(get-ps1 bash)' |\
            tee -a ~/.bashrc | sudo tee -a /root/.bashrc >/dev/null
        ```

    - #### Zsh

        ```sh
        echo 'source <(get-ps1 zsh)' |\
            tee -a ~/.zshrc | sudo tee -a /root/.zshrc >/dev/null
        ```

## Configuration

You can configure prompt colors and icons by declaring any of the following variables above `source <(get-ps1 ...)` in your shell's runtime config.

> [!NOTE]
> All colors are defined using [ASCII color codes](https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit) in range 0-255.

| Variable | Default | Definition
| -------- | ------- | ----------
| PS1__ICON_SHELL_ANY |  | Fallback prompt icon if shell-specific icons are not applied.
| PS1__ICON_SHELL_BASH |  | Prompt icon used for _bash_ shells.
| PS1__COLOR_OK | 2 | Color used for command status indicator on success.
| PS1__COLOR_FAIL | 1 | Color used for command status indicator on fail.
| PS1__COLOR_DIR | 3 | Color used for standard directory path.
| PS1__COLOR_USER_ROOT | 1 | Color used on prompt indicator for _root_ user.
| PS1__COLOR_USER_SUDO | 2 | Color used on prompt indicator for privileged users (sudo group).
| PS1__COLOR_USER_USER | 4 | Color used on prompt indicator for unprivileged users.
| PS1__COLOR_GIT_BRANCH | 1 | Color used for the current git branch name.
| PS1__COLOR_GIT_REPO | 6 | Color used for the current git repository name.
| PS1__COLOR_GIT_PATH | 3 | Color used for git project directory path.
| PS1__COLOR_GIT_DELIM | 8 | Color used for delimiter characters that separate git components.
