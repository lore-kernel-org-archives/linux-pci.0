Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:37823 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921Ab3JJP6l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 11:58:41 -0400
From: Marek Vasut <marex@denx.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Thu, 10 Oct 2013 17:58:34 +0200
Cc: "Zhu Richard-R65037" <r65037@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org> <201310101225.10455.marex@denx.de> <CAErSpo7oHK1tyndKdgk_6f3F7O0pMCSUV+RLUy0V75OKKFniow@mail.gmail.com>
In-Reply-To: <CAErSpo7oHK1tyndKdgk_6f3F7O0pMCSUV+RLUy0V75OKKFniow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310101758.35085.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

> On Thu, Oct 10, 2013 at 4:25 AM, Marek Vasut <marex@denx.de> wrote:
> > In the meantime, this is what I see upon probe with V6 of the patches:
> > 
> > Linux version 3.12.0-rc2-next-20130927+
> > [...]
> > imx6q-pcie 1ffc000.pcie: phy link never came up
> > PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
> > pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> > pci_bus 0000:00: No busn resource found for root bus, will use [bus
> > 00-ff]
> 
> This indicates a bug in your host bridge driver.  You must supply the
> bus number range claimed by the host bridge.  There's no way the PCI
> core can figure that out itself.  We do assume [bus 00-ff], but that's
> only a fallback and will prevent multi-host bridge configurations from
> working.
> 
> > PCI: bus0: Fast back to back transfers disabled
> > PCI: bus1: Fast back to back transfers enabled
> > PCI: Device 0000:00:00.0 not available because of resource collisions
> > pcieport: probe of 0000:00:00.0 failed with error -22
> 
> If you boot with "ignore_loglevel", you should see more details about
> this device, including the BAR values we read from it.  Based on
> pcibios_enable_device() in arch/arm/kernel/bios32.c, my guess is that
> 00:00.0 has an uninitialized BAR (maybe it is in power-on state), and
> you didn't do anything to assign the BAR before trying to bind the
> pcieport driver to it.  You might be missing a call to
> pci_bus_assign_resources() or pci_assign_unassigned_resources().

I tried you suggestion, this is what I got now (and with V7 of the patches):

Note that my topology is: rootport->2_port_switch->ethernet_chip , the other 
port of the switch is not used .

imx6q-pcie 1ffc000.pcie: phy link never came up
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x5c
pci 0000:00:00.0: supports D1
pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:01: scanning bus
pci_bus 0000:01: fixups for bus
PCI: bus1: Fast back to back transfers enabled
pci_bus 0000:01: bus scan returning with max=01
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci_bus 0000:00: bus scan returning with max=01
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
PCI: Device 0000:00:00.0 not available because of resource collisions
pcieport: probe of 0000:00:00.0 failed with error -22
pci 0000:00:00.0: fixup irq: got 155
pci 0000:00:00.0: assigning IRQ 155                                                                                                                                         
pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]                                                                                                               
pci 0000:00:00.0: BAR 0: set to [mem 0x01000000-0x010fffff] (PCI address 
[0x1000000-0x10                                                                                    
fffff])                                                                                                                                                                     
pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]                                                                                                          
pci 0000:00:00.0: PCI bridge to [bus 01]                                                                                                                                    
pci 0000:00:00.0: PCI bridge to [bus 01]                                                                                                                                    
pci_bus 0000:00: resource 4 [io  0x1000-0x10000]                                                                                                                            
pci_bus 0000:00: resource 5 [mem 0x01000000-0x01efffff]

What is this conflicting device 0000:00:01 I observe here? Does it have to do 
with the switch ?

Best regards,
Marek Vasut
