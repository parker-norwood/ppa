# PPA

PPA (Personal Package Archives) Repository for Ubuntu.

## Usage

### Install

```sh
sudo wget -O /etc/apt/sources.list.d/ppa.sources https://ppa.parker.dev/ppa.sources
sudo apt update
```

### Uninstall

```sh
sudo rm -f /etc/apt/sources.list.d/ppa.sources
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
