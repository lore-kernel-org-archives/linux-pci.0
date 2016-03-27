Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:38827 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbcC0OD4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 27 Mar 2016 10:03:56 -0400
Date: Sun, 27 Mar 2016 16:03:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
Message-ID: <20160327140348.GA19498@lunn.ch>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> +static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
> +	void __iomem *base = pcie->base;
> +	u32 val;
> +
> +	val = readl(base + PCIE_GLOBAL_INT_CAUSE1_REG);
> +	writel(val, base + PCIE_GLOBAL_INT_CAUSE1_REG);
> +
> +	return IRQ_HANDLED;

Hi Thomas

Maybe a comment as to why you are just throwing them away.

> +}
> +
> +static struct pcie_host_ops armada8k_pcie_host_ops = {
> +	.link_up = armada8k_pcie_link_up,
> +	.host_init = armada8k_pcie_host_init,
> +};
> +
> +static int armada8k_pcie_probe(struct platform_device *pdev)
> +{
> +	struct armada8k_pcie *pcie;
> +	struct pcie_port *pp;
> +	struct device *dev = &pdev->dev;
> +	struct resource *base;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->main_clk = devm_clk_get(dev, "main");
> +	if (!IS_ERR(pcie->main_clk))
> +		clk_prepare_enable(pcie->main_clk);
> +
> +	pcie->lane_clk = devm_clk_get(dev, "port");
> +	if (!IS_ERR(pcie->lane_clk))
> +		clk_prepare_enable(pcie->lane_clk);

Any need to handle -EPRODE_DEFERED here?

    Andrew
