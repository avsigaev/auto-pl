Nvidia power limit control service to keep the temperature in the specified range.

# Installation

`sudo bash -c "$(curl -s https://raw.githubusercontent.com/avsigaev/auto-pl/master/install.sh)"`

## Flexible power limit

Flexible PL is enabled by default. You may disable it in the config.

On service start, GPU power limit adjust to MAX_PL (% from default PL for particular GPU based on driver settings).
Once GPU temp encreases MAX_TEMP, PL will be decreased, step by step, to force GPU temp down below this value, until MIN_PL (% from default PL for particular GPU, based on driver settings).
When GPU temp drops below MAX temp, PL will be increased, step by step, until MAX_PL.
Please note that PL adjustment works on every 3rd check. For checks 1-2 you can see only warning in the logs. Therefore, choose time interval between checks carefully: for instance, by default (delay 5 sec), PL adjustment will work every 15 seconds.

Default settings:
- MAX_TEMP=70˚C (PL will be decreased if temperature rises above this value),
- MANAGE_PL=1 (on)
- MAX_PL=85 (%)
- MIN_PL=60 (%)
- PL_CHANGE_STEP=5 (watt)
- DELAY=5 (seconds between checks)

## Configuration file

You may change all settings mentioned above, in `/etc/sonm/auto-pl.cfg`

Service will handle config change, and apply new settings on-the-fly (no need to restart the service).
