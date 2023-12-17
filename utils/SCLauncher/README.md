# Star Citizen Launcher

![Logo][FS]

This script is made to prevent EAC service from starting when you launch Star Citizen. EAC Service is not necessary to play Star Citizen and won't prevent the game to use the anti-cheat system. This is only to prevent EPIC to collect unnecessary data from your computer.

## Installation

### Clone the repository to your home directory

```bash
git clone https://github.com/FrogSwarm/StarCitizen.git $HOME/Documents/StarCitizen
```

### Create a symbolic link in powershell to your desktop

```ps1
New-Item -ItemType SymbolicLink -Path $HOME\Desktop\SCLauncher.ps1 -Target $HOME/Documents/StarCitizen\utils\SCLauncher\SCLauncher.ps1
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

## Update

```bash
cd $HOME/Documents/StarCitizen
git pull
```

## Authors

- [@Silmerias](https://www.github.com/Silmerias)

[FS]: https://frogswarm.fr/data/imgs/logo-devops-github.png
