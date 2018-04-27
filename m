Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758725AbeD0TxP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 15:53:15 -0400
Date: Fri, 27 Apr 2018 14:53:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vidya Sagar <vidyas@nvidia.com>,
        Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug? pcie_aspm=off cause less power consumption as default
Message-ID: <20180427195313.GH8199@bhelgaas-glaptop.roam.corp.google.com>
References: <20180422171647.7v65zrlwhya5mq7v@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180422171647.7v65zrlwhya5mq7v@pali>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Pali,

On Sun, Apr 22, 2018 at 07:16:47PM +0200, Pali Rohár wrote:
> Hi!
> 
> To increase runtime on battery of my Dell Latitude E6440 laptop I tried
> different tweaks and settings. And I come up to the conclusion that
> adding pcie_aspm=off to the kernel command line decrease power
> consumption by approx. 2 Watts as opposite to adding pcie_aspm=force or
> nothing (letting ASPM in default state).
> 
> I suspect that this is a clear kernel bug as I cannot understand how
> turning off powersave feature ASPM could lead to decrease of power
> consumption. Turning powersave off should either not impact or increase
> power consumption.
> 
> Moreover one I put laptop into ACPI S3 sleep and resume it, then power
> consumption increase. The only way to decrease it is to power it off and
> power on again. Very impractical, specially as ACPI sleep is there to
> prevent power off and on.
> 
> Tests:
> 
> Laptop on battery with pcie_aspm=off has average 8.50 Watts in idle.
> After suspend+resume it has 11.20 Watts (power off + on is needed to get
> back for 8.50 Watts).
> 
> Laptop on battery with pcie_aspm=force and with powersave aspm policy
> it has average 11.20 Watts in idle. After suspend+resume it is 11.30
> Watts in idle. With default policy it has 11.15 Watts and with
> performance policy it has 11.70 Watts.
> 
> When pcie_aspm is not specified at all, then average power consumption
> in idle is 8.90 Watts. And after suspend+resume it is 9.30 Watts.
> 
> So what is happening there? Such results are really strange and
> apparently I'm not alone, see discussion in kernel bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=62181#c23
> 
> I'm using Debian Stretch with its default kernel. But I remember that
> power consumption with defaults or with pcie_aspm=force was around 10-11
> Watts even with older kernel versions.
> 
> Debian Stretch has currently this kernel:
> 4.9.0-6-amd64 #1 SMP Debian 4.9.82-1+deb9u3 (2018-03-02) x86_64 GNU/Linux
> 
> with this configuration:
> 
> $ grep ASPM /boot/config-4.9.0-6-amd64
> CONFIG_PCIEASPM=y
> # CONFIG_PCIEASPM_DEBUG is not set
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> 
> In dmesg are these ASPM strings:
> 
> $ dmesg | grep ASPM
> 
> pcie_aspm=off
> [    0.000000] PCIe ASPM is disabled
> [    0.119127] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.163351] acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> 
> pcie_aspm=force
> [    0.000000] PCIe ASPM is forcibly enabled
> [    0.118985] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.162322] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.162621] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> 
> (none)
> [    0.120064] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.163424] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> [    0.163724] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    3.294357] iwlwifi 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
> 
> In attachments I'm sending output from lspci -vv -nn, maybe it could
> contain some useful information.
> 
> Another strange thing which I spotted in lspci output is that Root Host
> bridge at 00:00.0 pci address totally disappeared after suspend+resume.
> I hope such thing is not normal.
> 
> So I see there at 3 bugs:
> 
> 1) Power consumption increase after suspend+resume when pcie_aspm=off or
> default
> 
> 2) Power consumption is higher in pcie_aspm=force or default mode as in
> pcie_aspm=off
> 
> 3) PCI host bridge disappear after suspend+resume.
> 
> Do you have any idea what is happening here?

No, but I agree it looks totally nonsensical.  I tried to pull out the
hardware ASPM settings from all your lspci info (thanks very much for
collecting all that).  Here's what I got.  The same/disabled comments
are relative to the "default" baseline:

                                default,      force       force             force     default      pcie_aspm=off  force pwrsave
                              pcie_aspm=off   default   performance        powersave  after resume  after resume  after resume
  notes                                                                               [1,2,3]       [1,2,3,5]     [1,2,3,4,5]
  power usage                8.90W, 8.50(off) 11.15W    11.70W             11.20W     9.30W         11.20W        11.30W
  00:01.0 RP [bus 01] GPU    L0s L1 ClockPM-  same      disabled           same       same          same          same
  00:1c.0 RP [bus 02] empty  L0s L1 ClockPM-  same      same               same       same          same          same
  00:1c.2 RP [bus 03] NIC    L1     ClockPM-  disabled  disabled           disabled   same          same          disabled
  00:1c.4 RP [bus 04] empty  L0s L1 ClockPM-  same      same               same       same          same          same
  00:1c.5 RP [bus 05] empty  L0s L1 ClockPM-  same      same               same       same          same          same
  00:1c.7 RP [bus 06] SD/MMC L1     ClockPM-  same      disabled           same       same          same          L0s L1
  01:00.0 Radeon GPU         ? [6]            ?         ?                  ?          ?             ?             ?
  03:00.0 Centrino NIC       L1     ClockPM-  disabled  disabled           disabled   same          same          disabled
  06:00.0 SD/MMC card        L1     ClockPM+  same      disabled ClockPM-  L0s L1     same          same          L0s L1

  [1] 00:00.0 device absent
  [2] 00:01.0 LnkCtl AutWidDis+, SltSta PresDet+
  [3] 00:1c.2 SecStatus <MAbort-, SltSta LinkState+
      00:1c.7 SecStatus <MAbort-, SltSta LinkState+
      03:00.0 DevSta CorrErr-, UnsuppReq-
  [4] 00:1c.2 LnkCtl ASPM Disabled
      00:1c.7 LnkCtl L0s L1 Enabled
      03:00.0 LnkCtl ASPM Disabled
      06:00.0 LnkCtl ASPM L0s L1 Enabled
  [5] 06:00.0 LTR max snoop 71680ns -> 566ns
  [6] 01:00.0 seems completely powered off, probably because you're
      using integrated video

I haven't made sense out of any of this yet, except that the "force
performance" column seems plausible: if we want performance, we should
disable ASPM across the board.

I don't really know where to start here.  Maybe we can focus on
understanding one tiny piece.  Can you apply the following patch and
try just the "force powersave" situation?  Please collect the entire
dmesg log and "lspci -vv" output.

Bjorn
