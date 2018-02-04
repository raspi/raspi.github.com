---
title: "WinLLDPService"
description: "WinLLDPService is free, open source and tiny Windows service. It sends Windows' machine network information via LLDP so that network administrators can find computers with ease."
date: 2017-10-27T01:25:42+03:00
draft: false
categories: [projects]
tags: [projects]
---

WinLLDPService is free, open source and tiny Windows service. It sends Windows' machine network information via [LLDP](https://en.wikipedia.org/wiki/Link_Layer_Discovery_Protocol) so that network administrators can find computers with ease. See also [SNMP](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol) as it's often used to gather more detailed information from network devices.

WinLLDPService acts only as an announcer to the switch (sends packets to the switch). **It will not query switches' internal LLDP data**.

Possible errors are logged to Windows Event Log.

Report possible bugs and feature requests to [issues page](https://github.com/raspi/WinLLDPService/issues).

# Requirements:

 * Capture library supported by Sharppcap for example:
   * [Npcap](https://nmap.org/npcap/)
   * [WinPcap](https://www.winpcap.org/)
   * or other
 * Microsoft PowerShell

# Download from GitHub
[![Github All Releases](https://img.shields.io/github/downloads/raspi/WinLLDPService/total.svg)](https://github.com/raspi/WinLLDPService)

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

# Configuring

WinLLDPService uses [PowerShell](https://docs.microsoft.com/en-us/powershell/) for it's configuration. You must set execution policy accordingly. See [About Execution Policies @ Microsoft](https:/go.microsoft.com/fwlink/?LinkID=135170).

Search paths are:

* `$Env:APPDATA\WinLLDPService\`
* `$Env:LOCALAPPDATA\WinLLDPService\`
* Registry: `HKLM:Software\WinLLDPService` `InstallPath` value.
* Current directory of WinLLDPService.exe

These are translated to:

* `C:\WINDOWS\system32\config\systemprofile\AppData\Local\WinLLDPService\`
* `C:\WINDOWS\system32\config\systemprofile\AppData\Roaming\WinLLDPService\`
* `C:\Program Files\WinLLDPService\` (default install path x64)
* `C:\Program Files (x86)\WinLLDPService\` (default install path x86)

Filenames that are searched:

* `Configuration.ps1`
* `Configuration.default.ps1`

If `Configuration.ps1` is not found then `Configuration.default.ps1` is used.

The search is run once after service starts. To rescan paths simply restart the service.

The configuration file is run each time before packet is sent.

## Example configuration file

To make your own custom configuration simply copy the `Configuration.default.ps1` to one of the directories mentioned above. **Do not modify the installed** `Configuration.default.ps1` **as it may change when new version is released**.

`C:\WINDOWS\system32\config\systemprofile\AppData\Roaming\WinLLDPService\Configuration.ps1`:

    # initialize object
    $config = New-Object WinLLDPService.Configuration

    $config.PortDescription.Add("port descr..")
    $config.SystemDescription.Add("sys descr..")
    $config.SystemName = "my machine"
    $config.Separator = "|"

    # Must always return WinLLDPService.Configuration object
    Return $config

For information how to get details about machine see [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/) 

## Example deployment

There are 10 machines. Every machine has `$Env:LOCALAPPDATA\WinLLDPService\Configuration.default.ps1`. Let's say 3 are virtual machines. For those machines you could create `$Env:LOCALAPPDATA\WinLLDPService\Configuration.ps1` which reports additional information.   

{{< pswp-init >}}
