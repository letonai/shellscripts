#Small Shell Scripts collection

```
./cinema.sh <dd-mm-yyyy>
```

Scraps from Villa-lobos theater site all movies times for a specific date (5 days ahead by theater site) plus youtube trailers

```
./meuip.sh
``` 

Scraps your current external ipaddress from meuip.com.br

```
./reddit_top.sh <reddit thread>
```

Scraps first entry on TOP of a specific Reddit thread

```
source message.sh
```

Small logger shell script library from log and better formating from scripts outputs.
Logs all messages on a formatted log file with date and time
Enable print messages on the screen with different colours or diret to log file
Once script is imported it's will grap main script name to create a log file "script name".log unless LOG var is set

```
message ok "OK"
message info "Information"
message alert "Alert"
message error "Error"
message answer "Answer"
message info "Info"
message log "Just log"
message <any> "Test #STR#"  "Highlited message"
```

Setups a server from scrach:
installs:
  - VIM
  - Setup sudo NOPASSWD for the current user
  - install docker
```
wget  -qO- https://raw.githubusercontent.com/letonai/shellscripts/master/setup.sh | sudo bash
```
