# Google traffic polling

## Installation

Get repo:
```
git clone https://github.com/ijl20/google_traffic
```

Install Google Chrome:
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb
```

Create directory to hold traffic map images:
```
su tfc_prod

mkdir /mnt/sdb1/tfc/google_traffic_map

ln -s /mnt/sdb1/tfc/google_traffic_map /media/tfc/google_traffic_map
```

## Test

```
google_traffic/run.sh
```

Image files should appear in `/media/tfc/google_traffic_map`

## Crontab

As `tfc_prod` user:

```
crontab -e

*/5 * * * * /home/tfc_prod/google_traffic/run.sh
```

