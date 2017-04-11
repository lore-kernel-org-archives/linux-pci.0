Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752119AbdDKBno (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Apr 2017 21:43:44 -0400
Date: Mon, 10 Apr 2017 20:43:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: 4.11-rc*: PCI IRQ allocation broken
Message-ID: <20170411014338.GA9311@bhelgaas-glaptop.roam.corp.google.com>
References: <alpine.LRH.2.20.1704102317110.14071@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.20.1704102317110.14071@math.ut.ee>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 10, 2017 at 11:21:22PM +0300, Meelis Roos wrote:
> This happens on my HP Compaq 8100 Elite SFF PC. While 4.10 works fine, 
> 4.11.-rc5 and at least back to 4.10.0-10770-g2d6be4abf514 fail to assign 
> PCI IRQ to multiple devices (no GSI messages in the dmesg). This results 
> in mouse in one USB port working and keyboard in another USB port not 
> working, reproducibly.
> 
> Will bisect.

Thanks a lot for the report, Meelis, and I apologize for the inconvenience.
I opened https://bugzilla.kernel.org/show_bug.cgi?id=195319 to track this,
marked it as a regression, and attached your v4.11-rc5 dmesg to it.

Something seems broken in ACPI.  There are a bunch of warnings, and I
think the PCI IRQ problem is a consequence of the fact that the
PNP0A08 _CRS evaluation failed, and we probably don't bother looking
for a _PRT under that bridge.

> Linux version 4.11.0-rc5-00033-g308ac7563944 (mroos@prometheus) (gcc version 6.3.0 20170321 (Debian 6.3.0-11) ) #64 SMP Wed Apr 5 12:29:53 EEST 2017
> Command line: BOOT_IMAGE=/boot/vmlinuz-4.11.0-rc5-00033-g308ac7563944 root=/dev/sda1 ro
> ...
> ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Address but zero Length: 0x0000000000000050/0x0 (20170119/tbfadt-658)
> ACPI BIOS Warning (bug): Invalid length for FADT/Pm2ControlBlock: 0, using default 8 (20170119/tbfadt-708)
> ...
> acpi LNXCPU:00: Invalid PBLK length [7]
> acpi LNXCPU:01: Invalid PBLK length [7]
> acpi LNXCPU:02: Invalid PBLK length [7]
> acpi LNXCPU:03: Invalid PBLK length [7]
> acpi PNP0A08:00: [Firmware Bug]: no secondary bus range in _CRS
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
> ACPI BIOS Error (bug): \_SB.PCI0._OSC: Excess arguments - ASL declared 5, ACPI requires 4 (20170119/nsarguments-189)
> ACPI Error: [CAPD] Namespace lookup failure, AE_ALREADY_EXISTS (20170119/dsfield-211)
> ACPI Error: Method parse/execution failed [\_SB.PCI0._OSC] (Node ffff880113031668), AE_ALREADY_EXISTS (20170119/psparse-543)
> acpi PNP0A08:00: _OSC failed (AE_ALREADY_EXISTS); disabling ASPM
> acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
> acpi PNP0A08:00: failed to parse _CRS method, error code -5
> acpi PNP0A08:00: Bus 0000:00 not present in PCI namespace
> ...
> PCI: Discovered peer bus 00
> PCI: root bus 00: using default resources
> PCI: Probing PCI hardware (bus 00)
> ...
> ACPI: \: failed to evaluate _DSM (0x1001)
> ...
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> pci_bus 0000:00: root bus resource [mem 0x00000000-0xfffffffff]
> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> ...
> PCI: Discovered peer bus 3f
> PCI: root bus 3f: using default resources
> PCI: Probing PCI hardware (bus 3f)
> ACPI: \: failed to evaluate _DSM (0x1001)
> ...
> pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
> pnp 00:01: can't evaluate _CRS: 12316
> ...
> [drm] ACPI BIOS requests an excessive sleep of 4294705151 ms, using 1500 ms instead
