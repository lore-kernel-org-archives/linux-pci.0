Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33063 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbcEIUel (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 May 2016 16:34:41 -0400
Date: Mon, 9 May 2016 15:34:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: PCIe issue with NIC card that has 64bit BARs
Message-ID: <20160509203436.GC18166@localhost>
References: <5730E5DA.4020906@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5730E5DA.4020906@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Murali,

On Mon, May 09, 2016 at 03:32:42PM -0400, Murali Karicheri wrote:
> Bjorn,
> 
> I am running into an issue with using a rtk8168 GiB NIC card with Keystone PCIe.
> It works for 32bit BARs such as the Marvel SATA controller on K2E. On another
> recent SoC (K2G) that re-uses the same driver and hardware, I have issues
> bringing up PCIe.
> 
> The rtk8168 NIC gets detected, but all read values are zeros. Based on the boot
> log, it appears to be getting assigned 64bit BARs. See the log on K2E with Marvell
> controller and that on K2G with rtk8168. Is there way we can get it assigned
> 32Bit BAR and get it functional? Keystone is a 32bit ARM A15 SoC.
> 
> Here are the logs.
> 
> K2E log with Marvel controller (Good working case).
> ===================================================
> [    0.236353] pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600fffff]
> [    0.236364] pci 0000:00:00.0: BAR 9: assigned [mem 0x60100000-0x601fffff pref]
> [    0.236373] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> [    0.236385] pci 0000:01:00.0: BAR 6: assigned [mem 0x60100000-0x6010ffff pref]
> [    0.236394] pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
> [    0.236406] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x100f]
> [    0.236418] pci 0000:01:00.0: BAR 0: assigned [io  0x1010-0x1017]
> [    0.236429] pci 0000:01:00.0: BAR 2: assigned [io  0x1018-0x101f]
> [    0.236441] pci 0000:01:00.0: BAR 1: assigned [io  0x1020-0x1023]
> [    0.236452] pci 0000:01:00.0: BAR 3: assigned [io  0x1024-0x1027]
> [    0.236464] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.236472] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    0.236481] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
> [    0.236490] pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff pref]
> 
> K2G log with Tealtek NIC card
> =============================
> [    2.311572] keystone-pcie 21801000.pcie: PCI host bridge to bus 0000:00
> [    2.318188] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    2.323844] pci_bus 0000:00: root bus resource [io  0x0000-0x3fff]
> [    2.330023] pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]

There's no "(bus address ...)" annotation here, which means these
windows map CPU addresses to identical bus addresses.  The
"[mem 0x50000000-0x5fffffff]" window is a 32-bit window.

> [    2.337567] PCI: bus0: Fast back to back transfers disabled
> [    2.361159] PCI: bus1: Fast back to back transfers disabled
> [    2.366889] pci 0000:00:00.0: BAR 8: assigned [mem 0x50000000-0x500fffff]
> [    2.373841] pci 0000:00:00.0: BAR 9: assigned [mem 0x50100000-0x501fffff pref]
> [    2.381061] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
> [    2.387225] pci 0000:01:00.0: BAR 6: assigned [mem 0x50100000-0x5011ffff pref]
> [    2.394505] pci 0000:01:00.0: BAR 4: assigned [mem 0x50120000-0x5012ffff 64bit pref]
> [    2.402288] pci 0000:01:00.0: BAR 2: assigned [mem 0x50000000-0x50000fff 64bit]

I assume these BARs (2 and 4) are the ones in question.  They are
64-bit BARs, but the addresses currently assigned to them fit in 32
bits, so the space is already all below 4GB.

The BAR type (32-bit or 64-bit) is built into the device; Linux
doesn't have any influence on that.  The type is encoded in the
low-order four bits of the BAR, which are read-only.

> [    2.409610] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> [    2.415729] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    2.420693] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    2.426806] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x500fffff]
> [    2.433610] pci 0000:00:00.0:   bridge window [mem 0x50100000-0x501fffff pref]
> [    2.441365] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
> [    2.448323] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> [    2.455567] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    2.461332] r8169 0000:01:00.0: enabling device (0140 -> 0143)
> [    2.468789] r8169 0000:01:00.0 eth0: RTL8169 at 0xf0d6a000, 00:00:00:00:00:00, XID 00000000 IRQ 286

Looks like this is printed by rtl_init_one().  I see that we read
zeroes from MAC0 and TxConfig, but I don't see any PCI problem here.
Could it be that some EEPROM on the card hasn't been programmed yet?
Does the card work if you put it in a different machine?

> [    2.478169] r8169 0000:01:00.0 eth0: jumbo features [frames: 7152 bytes, tx checksumming: ok]
