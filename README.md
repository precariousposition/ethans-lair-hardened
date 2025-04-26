# My Hardened + Privacy-Focused Home Environment (Apple-Based + VMs, DIY Networking, SBCs, etc)

# Author: Ethan Ross

Developing home environment from borrowed NBN to an digital fortress that not even the AFP can f#%k with!
Operating Systems: MacOS, iOS, Ubuntu, Windows
Containers/VMs: Docker, Proxmox
Hardware: SBCs, Apple, Misc
Network Services: DNS, VPN, VLANs and Routing, Firewalls, Intrusion Detection, Private Domain, etc!

Purpose:
- I spent the past year incarcerated. 
- Prior to that, I worked in cybersecurity, with a strong background in security, networking, DevOps, and automation. 
- During my time away, the industry has likely evolved significantly. 
- This project serves as a skills refresher to:
	- Identify gaps in my knowledge (e.g., new technologies, shifted fundamentals).
	- Rebuild confidence in my technical abilities.
	- Prepare for roles securing enterprise systems/infrastructure within 90 days.
- I’m approaching this as a semi-formal project:
	- Using GitHub repositories for version control.
	- Adhering to code as if other techies were reviewing this.
	- Readjusting to technologies: MacOS (Unix), Linux, VMs, containers, Infrastructure-as-Code, security, and networking.

Environment:
- Location: Family residence, using a neighbor’s Wi-Fi (two doors away).
	- Connectivity Issues:
		- MacBook Pro M3: 1–2 signal bars.
		- iPhone 12: Limited coverage in the unit.
	- Other Users: Two non-technical individuals sharing the network.

Goals:
1. Secure, Private, Portable Network:
	- Design a remote-work-ready setup emphasising privacy and security (DD-Wrt, VPN, DNS filtering, VLAN segmentation).
	- Ensure portability for future relocation.
2. Secure and Private Apple devices:
	- MacBook Pro M3 (Sonoma 14.6.1).
	- iPhone 12 (iOS 18.3.1).
3. Isolate a "Repair/Imaging" Lab:
	- Create Windows 11 + Ubuntu 22.04 base images with:
		- Forensic toolkits (Autopsy, FTK Imager).
		- Data Recovery Tools.
		- Android Payloads.
		- PXE Server(s).
	- Convert Images to VM snapshots.
4. **Self-hosted Infrastructure** (Budget):
	- SBCs (Odroid, Banana, Raspberry, or Orange Pi):
		- Host VPN, DNS, Incident Response (Eg. Pi-hole, WireGuard, Grafana).
		- Host Router, Firewall.
    - **Proxmox**: To run security tools, and VMs for lab/testing environments.

Weak Spots to Address:
- Address New Threats (Post-2023):
	- AI-powered attacks (e.g., WormGPT, FraudGPT).
	- Zero-day exploits in M-series Macs.
- Skill Degradation.
- Tools may have new best practices.
- Learn Container orchestration.

Note:
- Security updating is important, I must mitigate risks from shared, unstable Wi-Fi (e.g., rogue DHCP servers, ARP spoofing).

Citing GitHub Repositories:
	https://github.com/drduh/macOS-Security-and-Privacy-Guide
	https://github.com/usnistgov/macos_security
	https://github.com/iCHAIT/awesome-macOS
	

High-Level Process (In order):
1. Configure iCloud+, iCloud, Apple
2. Configure MacOS.
3. Configure iOS.

Roadblocks:
- I don't yet have the hardware required to configure any Network services.
- I need to investigate Self-hosted Infrastructure, and choose each technology.
