# Google traffic polling

## Installation

```
git clone https://github.com/ijl20/google_traffic

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb

mkdir /mnt/sdb1/tfc/google_traffic

ln -s /mnt/sdb1/tfc/google_traffic /media/tfc/google_traffic
```

## Test

```
google_traffic/run.sh
```

Image files should appear in `/media/tfc/google_traffic`

## Crontab

As `tfc_prod` user:

```
crontab -e

*/5 * * * * /home/tfc_prod/google_traffic/run.sh
```
