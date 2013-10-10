Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41231 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab3JJN1Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 09:27:24 -0400
Received: by mail-ie0-f173.google.com with SMTP id ar20so5119117iec.32
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2013 06:27:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201310101225.10455.marex@denx.de>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
 <201310082256.28474.marex@denx.de> <0E83723C55F66F43A6041464FE31119D401869@039-SN2MPN1-011.039d.mgd.msft.net>
 <201310101225.10455.marex@denx.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 10 Oct 2013 07:27:03 -0600
Message-ID: <CAErSpo7oHK1tyndKdgk_6f3F7O0pMCSUV+RLUy0V75OKKFniow@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
To: Marek Vasut <marex@denx.de>
Cc: Zhu Richard-R65037 <r65037@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 10, 2013 at 4:25 AM, Marek Vasut <marex@denx.de> wrote:

> In the meantime, this is what I see upon probe with V6 of the patches:
>
> Linux version 3.12.0-rc2-next-20130927+
> [...]
> imx6q-pcie 1ffc000.pcie: phy link never came up
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x1000-0x10000]
> pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]

This indicates a bug in your host bridge driver.  You must supply the
bus number range claimed by the host bridge.  There's no way the PCI
core can figure that out itself.  We do assume [bus 00-ff], but that's
only a fallback and will prevent multi-host bridge configurations from
working.

> PCI: bus0: Fast back to back transfers disabled
> PCI: bus1: Fast back to back transfers enabled
> PCI: Device 0000:00:00.0 not available because of resource collisions
> pcieport: probe of 0000:00:00.0 failed with error -22

If you boot with "ignore_loglevel", you should see more details about
this device, including the BAR values we read from it.  Based on
pcibios_enable_device() in arch/arm/kernel/bios32.c, my guess is that
00:00.0 has an uninitialized BAR (maybe it is in power-on state), and
you didn't do anything to assign the BAR before trying to bind the
pcieport driver to it.  You might be missing a call to
pci_bus_assign_resources() or pci_assign_unassigned_resources().

> pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> pci 0000:00:00.0: PCI bridge to [bus 01]
>
> Is this line normal/expected? Is this related to the PCIe switch I have there?
> pcieport: probe of 0000:00:00.0 failed with error -22
>
> Thank you for your help!
>
> Best regards,
> Marek Vasut
