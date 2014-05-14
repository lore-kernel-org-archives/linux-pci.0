Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:65200 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbaENJ0b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 May 2014 05:26:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: [Q] Synopsys PCIe interrupts
Date: Wed, 14 May 2014 11:26:11 +0200
Message-ID: <5605248.nZXVxazLBk@wuerfel>
In-Reply-To: <4335be621d0e47b38580c54658b1702b@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <fd5f29f175b2499e9d972629f1ccd74a@HKXPR06MB168.apcprd06.prod.outlook.com> <1400056898.4837.11.camel@weser.hi.pengutronix.de> <4335be621d0e47b38580c54658b1702b@HKXPR06MB168.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 14 May 2014 09:13:45 Phil Edworthy wrote:
> > Because of those differences I've pushed the irq properties of the
> > binding into the SoC specific part.
> > If we can enumerate all irq signals from the DW core we could maybe push
> > this stuff back into common doc/code, but I'm not sure about how to
> > handle this without breaking the Exynos binding. i.MX won't care as the
> > only irq it uses besides the legacy irqs, which are mapped through DT,
> > is now a named irq.
> I don’t have a lot of experience with DT bindings, though it appears as
> though it would be good if we could specify interrupts by their name,
> rather than the order in which they are listed. Of course, that would add
> some overhead to DT parsing.

In general, it's preferred to specify a particular order and use that
as the primary identification, with the names being an additional way
to identify them. This is done for historic reasons: traditional OF
does not have an interrupt-names property, and requires the order to
be fixed. The names are a Linux extension originally added to allow
platform drivers to keep working when they already used named interrupts.

> I can imagine this sort of problem happening with lots of other IP blocks.

It's usually not as bad, but there are other IP blocks that are confused
e.g. about the number of clocks that get routed into them, based on
which documentation (or vendor sourcecode) you read.

The other problem with IntA/IntB/IntC/IntD on PCI is you can wire
parallel PCI devices to have their interrupts connected directly to
the GIC. With PCIe devices this does not happen (the interrupts are
messages sent to the host bridge), but nothing prevents a board
design from adding a PCIe-to-PCI bridge chip with hardwired PCI
devices or actual slots. This means we have to describe them in
the interrupt-map property that can actually handle them.

	Arnd
