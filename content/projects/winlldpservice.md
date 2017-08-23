---
title: "WinLLDPService"
description: "WinLLDPService is free, open source and tiny Windows service. It sends Windows' machine network information via LLDP so that network administrators can find computers with ease."
date: 2017-08-23T20:05:48+03:00
draft: false
categories: [projects]
tags: [projects]
---

WinLLDPService is free, open source and tiny Windows service. It sends Windows' machine network information via [LLDP](https://en.wikipedia.org/wiki/Link_Layer_Discovery_Protocol) so that network administrators can find computers with ease. See also [SNMP](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol) as it's often used to gather more detailed information from network devices.

WinLLDPService acts only as an announcer to the switch (sends packets to the switch). **It will not query switches' internal LLDP data**.

Possible errors are logged to Windows Event Log.

Report possible bugs and feature requests to [issues page](https://github.com/raspi/WinLLDPService/issues).

# Requirements:

 * [WinPcap](https://www.winpcap.org/)

# Download from GitHub

<div id="githubrelease"></div>

{{< ghrelease >}}

Sources can be found at [GitHub](https://github.com/raspi/WinLLDPService).

See [GitHub Releases page](https://github.com/raspi/WinLLDPService/releases) for downloads if list above failed to load.


# Install with Chocolatey

<code>choco install winlldpservice</code>

See [chocolatey site](https://chocolatey.org/packages/winlldpservice) for additional information.

# Screenshots

{{< gallery title="Screenshots" >}}

{{< figure src="screenshot.png" caption="Windows Services" width="100" >}}
{{< figure src="screenshot2.png" caption="View from HP switch" width="100" >}}

{{< /gallery >}}

# Tested with

* Windows Server 2012 R2
* Windows 10 Professional edition 64 bit 
* Windows 7 Ultimate edition 64 bit with Service Pack 1
* Windows 7 Professional edition 64 bit with Service Pack 1

{{< pswp-init >}}
