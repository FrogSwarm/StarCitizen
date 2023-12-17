# Star Citizen Launcher

![Logo][FS]

This script is made to prevent EAC service from starting when you launch Star Citizen. EAC Service is not necessary to play Star Citizen and won't prevent the game to use the anti-cheat system. This is only to prevent EPIC to collect unnecessary data from your computer.

## Installation

### Clone the repository

```bash
  git clone git@github.com:FrogSwarm/StarCitizen.git
```

### Prerequisites

Execute the following command in a powershell terminal to allow the script to run.

```ps1
  Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```

Edit SClauncher.ini to set the correct path to your Star Citizen Launcher.

```ini
[StarCitizen]
Launcher=C:\Program Files\Cloud Imperium Games\RSI Launcher\RSI Launcher.exe
```

## Usage

```ps1
  ./SCLauncher.ps1
```

## Authors

- [@Silmerias](https://www.github.com/Silmerias)

[FS]: https://frogswarm.fr/data/imgs/logo-devops-github.png
