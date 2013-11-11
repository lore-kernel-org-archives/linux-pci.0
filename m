Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:54817 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab3KKNsp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2013 08:48:45 -0500
From: Marek Vasut <marex@denx.de>
To: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
Subject: Re: [PATCH 0/6] PCI: imx6: Random fixes
Date: Mon, 11 Nov 2013 14:48:40 +0100
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <1381853200-5534-1-git-send-email-marex@denx.de> <201311111432.59318.jbe@pengutronix.de>
In-Reply-To: <201311111432.59318.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201311111448.40922.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jürgen Beisert,

> Hi,
> 
> I'm also trying to get the PCIe to work on an i.MX6. But the attached
> device cannot be enabled. The external device is an FPGA directly
> connected to the i.MX6. I'm using the changes from linux-next to get the
> machine working up to this point. But it seems I still miss something.
> 
> What I see is:
> 
> [...]
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
> pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> pci_bus 0000:00: scanning bus
> pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x5c
> pci 0000:00:00.0: supports D1
> pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> pci 0000:00:00.0: PME# disabled
> pci_bus 0000:00: fixups for bus
> PCI: bus0: Fast back to back transfers disabled
> pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
> pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0000:01: scanning bus
> pci 0000:01:00.0: [1172:0004] type 00 class 0x000000
> pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0000ffff]
> pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x5c
> pci_bus 0000:01: fixups for bus
> PCI: bus1: Fast back to back transfers disabled
> pci_bus 0000:01: bus scan returning with max=01
> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> pci_bus 0000:00: bus scan returning with max=01
> pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
> pci 0000:00:00.0: fixup irq: got 155
> pci 0000:00:00.0: assigning IRQ 155
> pci 0000:01:00.0: fixup irq: got 155
> pci 0000:01:00.0: assigning IRQ 155
> pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> pci 0000:00:00.0: BAR 0: set to [mem 0x01000000-0x010fffff] (PCI address
> [0x1000000-0x10fffff]) pci 0000:00:00.0: BAR 8: assigned [mem
> 0x01100000-0x011fffff]
> pci 0000:00:00.0: BAR 6: assigned [mem 0x01200000-0x0120ffff pref]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
> pci_bus 0000:00: max bus depth: 1 pci_try_num: 2
> pci 0000:00:00.0: PCI bridge to [bus 01]
> pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
> pci_bus 0000:00: resource 4 [io  0x1000-0x10000]
> pci_bus 0000:00: resource 5 [mem 0x01000000-0x01efffff]
> pci_bus 0000:01: resource 1 [mem 0x01100000-0x011fffff]
> [...]
> pcieport 0000:00:00.0: Resource 0: from 1000000 to 10FFFFF <- my message
> from pcibios_enable_device()/arch/arm/kernel/bios32.c [...]
> FPGA 0000:01:00.0: Dummy FPGA driver starts probing
> FPGA 0000:01:00.0: Resource 0: from 0 to FFFF <- my message from
> pcibios_enable_device()/arch/arm/kernel/bios32.c PCI: Device 0000:01:00.0
> not available because of resource collisions FPGA 000:01:00.0: Cannot
> enable PCIe device, aborting
> FPGA: probe of 0000:01:00.0 failed with error -5
> 
> pcibios_enable_device() fails due to the start address of this device is
> still 0.

Looks like your device isn't assigned it's memory windows for some reason. There 
is a discussion going on about DWC PCIe and how the iATU configuration is wrong 
and how to fix it in the PCI ML. I'd check that.

btw. do you need to switch the bus to Gen1 to get it to probe your device?
