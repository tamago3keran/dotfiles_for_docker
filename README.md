# dotfiles_for_docker
Welcome to my world! Here are configuration files for neovim plugins based on dark powered made by [Shougo](https://github.com/Shougo). I hope you find something useful in these dotfiles. So take a look around and feel free to borrow, modify, or fork to get the dark power.

<img src="https://raw.githubusercontent.com/tamago3keran/images/main/dotfiles_for_docker/image_01.png">

## Screenshots

|splash screen|editing code|filer UI|
|:--:|:--:|:--:|
|<img src="https://raw.githubusercontent.com/tamago3keran/images/main/dotfiles_for_docker/image_02.png">|<img src="https://raw.githubusercontent.com/tamago3keran/images/main/dotfiles_for_docker/image_03.png">|<img src="https://raw.githubusercontent.com/tamago3keran/images/main/dotfiles_for_docker/image_04.png">|

## About
There are some branches in this repository. Each branch has dotfiles, with different functionality.

|Branch|Function|
|:--:|:--|
|base|neovim plugins|
|dotfiles|neovim plugins + LSP ( Vim script )|
|python|neovim plugins + LSP ( Python )|
|react|neovim plugins + LSP ( ESLint, TypeScript Language Server )|
|ruby|neovim plugins + LSP ( Ruby )|

## Setup
I usually use a MacBook. And I use Docker for development. So the following setup assumes that you are using Docker on a MacBook.

### WezTerm
The dotfiles are not displayed properly with Terminal.app which is installed by default on Mac. So I recommend using WezTerm. Please download WezTerm on [the Website](https://wezfurlong.org/wezterm/index.html).

### Docker
First, please install [Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/).

I have created [the Docker image](https://hub.docker.com/repository/docker/tamago3keran/dotfiles/tags?name=base) that incorporates these dotfiles. This Docker image is based on [the Dockerfile](https://github.com/tamago3keran/Dockerfiles/blob/master/base/Dockerfile).

So after installing Docker, run the following command to pull the Docker image.

```bash
> docker pull --platform linux/amd64 tamago3keran/dotfiles:base
```

Finally, run command of `docker run` based on the pulled the Docker image.

```bash
> docker run --name base -it tamago3keran/dotfiles:base
```
