Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbdAQOld (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jan 2017 09:41:33 -0500
Date: Tue, 17 Jan 2017 08:41:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Richard, Joseph" <Joseph.Richard@windriver.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Hotplugging PCI device with large BAR
Message-ID: <20170117144128.GB22776@bhelgaas-glaptop.roam.corp.google.com>
References: <7B6A2AE64F40F245AE81F245059F0C3651381A56@ALA-MBA.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <7B6A2AE64F40F245AE81F245059F0C3651381A56@ALA-MBA.corp.ad.wrs.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 16, 2017 at 11:29:26PM +0000, Richard, Joseph wrote:
> Hello,
> I am trying to hotplug a device with a large BAR to a KVM guest, but it is failing to map the memory for the BAR.
> 
> From dmesg, here is the output when hotplugging the device, with the failure on BAR 2:
> [  891.614017] ACPI: \_SB_.PCI0.S60_: ACPI_NOTIFY_DEVICE_CHECK event
> [  891.614036] ACPI: \_SB_.PCI0.S60_: Device check in hotplug_event()
> [  891.614100] pci 0000:00:0c.0: [1af4:1110] type 00 class 0x050000
> [  891.614277] pci 0000:00:0c.0: reg 0x10: [mem 0x00000000-0x00000fff]
> [  891.614391] pci 0000:00:0c.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [  891.614557] pci 0000:00:0c.0: reg 0x18: [mem 0x00000000-0x7fffffff 64bit pref]
> [  891.614670] pci 0000:00:0c.0: reg 0x20: [mem 0x00000000-0x000fffff pref]
> [  891.614780] pci 0000:00:0c.0: reg 0x24: [mem 0x00000000-0x000fffff pref]
> [  891.615277] pci 0000:00:0c.0: BAR 2: no space for [mem size 0x80000000 64bit pref]
> [  891.615279] pci 0000:00:0c.0: BAR 2: failed to assign [mem size 0x80000000 64bit pref]
> [  891.615281] pci 0000:00:0c.0: BAR 4: assigned [mem 0xc0300000-0xc03fffff pref]
> [  891.617759] pci 0000:00:0c.0: BAR 5: assigned [mem 0xc0400000-0xc04fffff pref]
> [  891.620473] pci 0000:00:0c.0: BAR 0: assigned [mem 0xc0202000-0xc0202fff]
> [  891.623148] pci 0000:00:0c.0: BAR 1: assigned [mem 0xc0203000-0xc0203fff]
> 
> When the node is rebooted, the allocation gets fixed.
> Also, when a similar device has previously been removed, it can allocate the memory that has previously been used for that device to this device, so allocation will succeed
> Note, this is on a guest that has 9.8GB of RAM.  The same result was also observed on guests with lower amounts of RAM.

This is a weakness of the PCI core -- we don't deal well with resource
allocation issues.

To really see what's going on we would need to see more of the dmesg
(preferably the entire log), which would show the available address
space.

In this case, the device (00:0c.0) is on a root bus, so it's a
question of what the host bridge windows are and how space is
assigned to the other devices on the root bus.

Since it works after a reboot, I suspect the BIOS is assigning things
differently when the device is present at boot-time.  The BIOS may
also be able to increase the host bridge window sizes.  The dmesg logs
showing the hotplug and a subsequent reboot would show what's
happening.

Linux could theoretically do something similar at hotplug-time, but it
is complicated by the fact that other devices may already be operating
(and thus difficult to move), and the fact that we don't currently
have support for changing host bridge windows (and any such support
would rely on firmware support, i.e., a host bridge _SRS method).

Bjorn
