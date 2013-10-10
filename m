Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:46543 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab3JJNnc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 09:43:32 -0400
From: Marek Vasut <marex@denx.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Thu, 10 Oct 2013 15:43:28 +0200
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
Message-Id: <201310101543.29145.marex@denx.de>
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

Ah, thanks for this information, this is very helpful! I implemented mx6 PCIe 
driver for U-Boot and this is my topology (detected by U-Boot)

  00:01.0     - 16c3:abcd - Bridge device
   01:00.0    - 12d8:2303 - Bridge device
    02:01.0   - 12d8:2303 - Bridge device
     03:00.0  - 8086:1531 - Network controller
    02:02.0   - 12d8:2303 - Bridge device

(The mnenomic is BUS:DEV.FN)

So I shouldn't even touch 0000:00:00.0 in Linux, but use 0000:00:01.0 as that's 
the root hub (16c3:abcd), no?

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

Will check this, thank you!

> > pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> > pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
> > pci 0000:00:00.0: PCI bridge to [bus 01]
> > pci 0000:00:00.0: PCI bridge to [bus 01]
> > 
> > Is this line normal/expected? Is this related to the PCIe switch I have
> > there? pcieport: probe of 0000:00:00.0 failed with error -22
> > 
> > Thank you for your help!
> > 
> > Best regards,
> > Marek Vasut

Best regards,
Marek Vasut
