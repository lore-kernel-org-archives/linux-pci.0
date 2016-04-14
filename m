Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51025 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755040AbcDNOZl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2016 10:25:41 -0400
Date: Thu, 14 Apr 2016 16:25:28 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Yehuda Yitschak <yehuday@marvell.com>
Subject: Re: [PATCH 2/2] pci: host: new driver for Marvell Armada 7K/8K PCIe
 controller
Message-ID: <20160414162528.678be5b7@free-electrons.com>
In-Reply-To: <20160411175651.5f32a990@free-electrons.com>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160327140348.GA19498@lunn.ch>
	<20160411175651.5f32a990@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Mon, 11 Apr 2016 17:56:51 +0200, Thomas Petazzoni wrote:

> > > +	struct pcie_port *pp = arg;
> > > +	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
> > > +	void __iomem *base = pcie->base;
> > > +	u32 val;
> > > +
> > > +	val = readl(base + PCIE_GLOBAL_INT_CAUSE1_REG);
> > > +	writel(val, base + PCIE_GLOBAL_INT_CAUSE1_REG);
> > > +
> > > +	return IRQ_HANDLED;
> > 
> > Maybe a comment as to why you are just throwing them away.
> 
> I'll have a look into this.

Enabling the INT A-D interrupts is needed for the PCI device drivers to
receive interrupts from their respective PCI devices. But then, once
you enable the INT A-D interrupts, they are also latched into the PCIe
controller, so if you don't acknowledge them in the PCIe controller
level, at the first interrupt coming from a PCI device, the system
hangs. I've added a comment in the driver about this.

> Is this needed? The clocks are registered in of_clk_init(), i.e at
> time_init() time. This is way before the device drivers get probed, no?

The clock drivers are now regular platform drivers, so I'll add the
EPROBE_DEFER handling logic.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
