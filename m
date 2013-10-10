Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:51652 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab3JJRRx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 13:17:53 -0400
Received: by mail-ie0-f175.google.com with SMTP id aq17so4607509iec.34
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2013 10:17:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201310101758.35085.marex@denx.de>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
 <201310101225.10455.marex@denx.de> <CAErSpo7oHK1tyndKdgk_6f3F7O0pMCSUV+RLUy0V75OKKFniow@mail.gmail.com>
 <201310101758.35085.marex@denx.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 10 Oct 2013 11:17:31 -0600
Message-ID: <CAErSpo64NbDhA0LX95s1T=DvuBhWi7qeqS2maNJn15zbG8GCUA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
To: Marek Vasut <marex@denx.de>
Cc: Zhu Richard-R65037 <r65037@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Thu, Oct 10, 2013 at 9:58 AM, Marek Vasut <marex@denx.de> wrote:
>> On Thu, Oct 10, 2013 at 4:25 AM, Marek Vasut <marex@denx.de> wrote:
> I tried you suggestion, this is what I got now (and with V7 of the patches):
>
> Note that my topology is: rootport->2_port_switch->ethernet_chip , the other
> port of the switch is not used .
>
> imx6q-pcie 1ffc000.pcie: phy link never came up
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
> pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> pci_bus 0000:00: scanning bus
> pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]

This is probably your Root Port, and it looks like its BARs haven't
been programmed.

> pci 0000:00:00.0: calling pci_fixup_ide_bases+0x0/0x5c
> pci 0000:00:00.0: supports D1
> pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> pci 0000:00:00.0: PME# disabled
> pci_bus 0000:00: fixups for bus
> PCI: bus0: Fast back to back transfers disabled
> pci 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
> pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0000:01: scanning bus
> pci_bus 0000:01: fixups for bus
> PCI: bus1: Fast back to back transfers enabled
> pci_bus 0000:01: bus scan returning with max=01
> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> pci_bus 0000:00: bus scan returning with max=01
> pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01

We should have found the switch (an Upstream Port and two Downstream
Ports) and the ethernet device here.  Have you ever seen this work,
i.e., have we ever found those devices, with any kernel?

It's possible that your host bridge is configured to only generate
config cycles for bus 00, i.e., the host bridge resource is actually
"[bus 00]".  If that were the case, we'd never see anything on bus 01.
 This would be i.MX6q-specific configuration, so I can't help here.

I suppose it's conceivable this is related to 928bea96 "PCI: Delay
enabling bridges until they're needed".  Per spec (PCI-to-PCI Bridge
Spec, r1.2, sec 3.2.4.3), I don't think the bridge enable bits affect
config transaction forwarding, but if your Root Port were defective
and only forwarded config transactions when enabled, you'd also see
this.  You could try forcibly setting the enable bits in
pci_scan_bridge() just as an experiment.

> PCI: Device 0000:00:00.0 not available because of resource collisions
> pcieport: probe of 0000:00:00.0 failed with error -22
> pci 0000:00:00.0: fixup irq: got 155
> pci 0000:00:00.0: assigning IRQ 155
> pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> pci 0000:00:00.0: BAR 0: set to [mem 0x01000000-0x010fffff] (PCI address
> [0x1000000-0x10
> fffff])
> pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]

You *are* assigning resources here; I'm not sure why we're trying to
bind the pcieport driver before resource assignment.  That seems out
of order.

> pci 0000:00:00.0: PCI bridge to [bus 01]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> pci_bus 0000:00: resource 4 [io  0x1000-0x10000]
> pci_bus 0000:00: resource 5 [mem 0x01000000-0x01efffff]
>
> What is this conflicting device 0000:00:01 I observe here? Does it have to do
> with the switch ?

I don't see a 0000:00:01.  That's not a complete PCI ID anyway; it
means domain 0000, bus 00, device 01, but there's no function number.

Bjorn
