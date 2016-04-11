Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42574 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932200AbcDKP5E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 11:57:04 -0400
Date: Mon, 11 Apr 2016 17:56:51 +0200
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
Message-ID: <20160411175651.5f32a990@free-electrons.com>
In-Reply-To: <20160327140348.GA19498@lunn.ch>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160327140348.GA19498@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Sun, 27 Mar 2016 16:03:48 +0200, Andrew Lunn wrote:
> > +static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
> > +{
> > +	struct pcie_port *pp = arg;
> > +	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
> > +	void __iomem *base = pcie->base;
> > +	u32 val;
> > +
> > +	val = readl(base + PCIE_GLOBAL_INT_CAUSE1_REG);
> > +	writel(val, base + PCIE_GLOBAL_INT_CAUSE1_REG);
> > +
> > +	return IRQ_HANDLED;
> 
> Maybe a comment as to why you are just throwing them away.

I'll have a look into this.

> > +static int armada8k_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct armada8k_pcie *pcie;
> > +	struct pcie_port *pp;
> > +	struct device *dev = &pdev->dev;
> > +	struct resource *base;
> > +	int ret;
> > +
> > +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	pcie->main_clk = devm_clk_get(dev, "main");
> > +	if (!IS_ERR(pcie->main_clk))
> > +		clk_prepare_enable(pcie->main_clk);
> > +
> > +	pcie->lane_clk = devm_clk_get(dev, "port");
> > +	if (!IS_ERR(pcie->lane_clk))
> > +		clk_prepare_enable(pcie->lane_clk);
> 
> Any need to handle -EPRODE_DEFERED here?

Is this needed? The clocks are registered in of_clk_init(), i.e at
time_init() time. This is way before the device drivers get probed, no?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
