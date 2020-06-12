Nvidia fan and PL control service to keep the temperature in the specified range.

Suitable only for:
- Nvidia GPUs;
- Sonm OS.

# Installation

`sudo bash -c "$(curl -s https://raw.githubusercontent.com/sonm-io/fan-control/master/install.sh)"`

## Adjusting temperature range

By default:
- MIN fan speed = 40% (when GPU temp is below MIN temp),
- MIN temp=50˚C, 
- MAX temp=70˚C (fan speed will be set to 100 if temperature rises above this value),
- Between MIN and MAX fan speed adjust graguatelly,
- CRITICAL GPU temp = 85˚C (when GPU temp exceed this value, script initiates force reboot).

## Flexible power limit

Flexible PL is enabled by default. You may disable it in the config.

On service start, GPU power limit adjust to MAX_PL (% from default PL for particular GPU based on driver settings).
Once GPU temp encreases [MAX_TEMP + 5˚C] , PL will be decreased, step by step, to force GPU temp down below this value, until MIN_PL (% from default PL for particular GPU, based on driver settings).
When GPU temp drops below MAX temp, PL will be increased, step by step, until MAX_PL.

Default settings:
- MANAGE_PL=1 (on)
- MAX_PL=85 (%)
- MIN_PL=60 (%)
- PL_CHANGE_STEP=5 (watt)

## Configuration file

You may change all settings mentioned above, in `/etc/sonm/fan-control.cfg`

Service will handle config change, and apply new settings.
