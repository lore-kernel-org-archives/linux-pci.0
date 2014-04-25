Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45162 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbaDYKWN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 06:22:13 -0400
Message-ID: <1398421265.4657.25.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH 0/8] i.MX6 PCIe binding change and MSI support
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <r65037@freescale.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Sean Cross <xobs@kosagi.com>, Marek Vasut <marex@denx.de>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de
Date: Fri, 25 Apr 2014 12:21:05 +0200
In-Reply-To: <20140424175844.GD29593@google.com>
References: <1396025579-14344-1-git-send-email-l.stach@pengutronix.de>
	 <20140424175844.GD29593@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 24.04.2014, 11:58 -0600 schrieb Bjorn Helgaas:
> On Fri, Mar 28, 2014 at 05:52:51PM +0100, Lucas Stach wrote:
> > While working on MSI support for the i.MX6 PCIe host driver
> > it has been discovered that the binding for this host controller
> > is broken in many ways (refer to the patch descriptions for more
> > info) and was introduced without proper discussion about what
> > should/should not be in the binding.
> > 
> > This series fixes this and minimizes the difference of the
> > i.MX6 binding to the common designware PCIe binding. I'm aware
> > that this is a quite radical change, but I think it's justified
> > to do this as long as there aren't many user of the old binding
> > (most of the optional properties in the binding aren't even
> > implemented).
> > 
> > Looking forward to your feedback.
> > 
> > Lucas Stach (8):
> >   ARM: imx6q-clk: parent lvds_gate from lvds_sel
This one is already applied.

> >   PCI: designware: split Exynos and i.MX bindings
> >   ARM: dts: imx6: update pcie to bring in line with new binding
> >   PCI: imx6: use new clock names
> >   PCI: imx6: drop old irq mapping
> >   PCI: imx6: rip out optional (and unused) irqs
> >   PCI: designware: make MSI isr shared irq aware
> >   PCI: imx6: add support for MSI
> 
> What's the status of all these?  I would normally apply patches 4-8 of this
> series through my tree, given the appropriate acks, but I haven't seen
> those yet.  And I'm not sure what dependencies there are between the
> non-PCI patches and the PCI ones.
> 
It's a complete binding change, so applying one part without the other
is going to horribly break things.

So I would at least want to see an ack for the binding change on the
i.MX side from Shawn and Richard. This will need some follow on patches,
as some boards adding PCIe using the old binding have cropped up in
linux-next, but I can do the patches on short notice if everyone agrees
to merge this patchset.

The designware part is pretty simple and doesn't change anything for
other users than i.MX. Though I would like to see an ack from Jingoo for
those.

I have some more stuff in the pipes regarding multiple MSI irqs, that
depend on this series and also the Keystone people are waiting for this
to be applied in order to consolidate the clock handling of the
designware core driver, so it would be nice to get this moving again.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

