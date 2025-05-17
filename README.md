# PPA

PPA (Personal Package Archives) Repository for Ubuntu.

## Usage

### Install

```sh
wget -qO - https://ppa.parker.dev/ppa.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ppa.gpg 1> /dev/null
sudo wget -P /etc/apt/sources.list.d/ https://ppa.parker.dev/ppa.list
sudo apt update
```

### Uninstall

```sh
sudo rm -rf /etc/apt/sources.list.d/ppa.list /etc/apt/trusted.gpg.d/ppa.gpg /var/lib/apt/lists/
sudo apt update
```

## Test

### Run with CLI

```sh
gh extension install https://github.com/nektos/gh-act
gh act push
```

### Run with VS Code Extension

1. Install `act` and `sanjulaganepola.github-local-actions`.

```sh
gh extension install https://github.com/nektos/gh-act
code --install-extension sanjulaganepola.github-local-actions
```

2. Click `Run Event` in the `Workflows` view of the `Github Local Actions` extension in VS Code.

## References

- [Hosting your own PPA repository on GitHub](https://assafmo.github.io/2019/05/02/ppa-repo-hosted-on-github.html)
