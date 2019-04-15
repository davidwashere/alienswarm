# Create a GCP VM
- Create Firewall Rule
  - **Name:** `alienswarm`
  - **Targets:** `specified target tags`
  - **Target tags:** `alienswarm`
  - **Source IP ranges:** `0.0.0.0/0`
  - **Protocols and ports:**
    - **tcp:** `27070`
    - **udp:** `27070`
- Create a VM
  - **Name:** `alienswarm`
  - **Region:** `us-central1`
  - **Machine Type:** `2vCPU, 7.5 GB memory [n1-standard-2]`
  - **Boot Disk:** `Windows Server 2019 Datacenter`
  - **Network tags:** `alienswarm`
- RDP Into VM
  - `Connect > RDP > Set Windows Password`
    - Save a copy of the password somewhere
  - `Connect > RDP > Download RDP File`
    - Use password from above when prompted

# Installation Instructions
1. Download [setup.ps1](https://davidwashere.github.io/alienswarm/setup.ps1)
1. Launch PowerShell as administrator
1. Execute `.\setup.ps1`

# Running Game
1. Open cmd.exe and execute `C:\srcds\alienswarmrd1\start.bat`

# Managing Bans
Reference: https://support.steampowered.com/kb_article.php?ref=7612-KIMZ-9654
- **Kick and Ban**
  - `users`
  - `banid 0 7 kick` <- will ban and kick userid 7 permanently
