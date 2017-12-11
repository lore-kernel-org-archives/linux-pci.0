Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbdLKP4O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Dec 2017 10:56:14 -0500
Date: Mon, 11 Dec 2017 15:56:51 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mingkai.hu@nxp.com,
        peter.newton@nxp.com, minghuan.lian@nxp.com, rajesh.raina@nxp.com,
        rajan.kapoor@nxp.com, prabhjot.singh@nxp.com
Subject: Re: [PATCH v4 2/2] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
 driver
Message-ID: <20171211155651.GA6822@red-moon>
References: <1511878688-8234-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <20171208182634.GA1885@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171208182634.GA1885@e107981-ln.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 08, 2017 at 06:26:34PM +0000, Lorenzo Pieralisi wrote:

[...]

> > +static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
> > +{
> > +	struct device *dev = &pcie->pdev->dev;
> > +	struct device_node *node = dev->of_node;
> > +
> > +	/* setup INTx */
> > +	pcie->intx_domain =
> > +		irq_domain_add_linear(node, PCI_NUM_INTX + 1, &intx_domain_ops,
> > +				  pcie);
> > +
> > +	if (!pcie->intx_domain) {
> > +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> > +		return -ENODEV;
> > +	}
> > +	/* setup MSI */
> > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +		pcie->msi_domain =
> > +			irq_domain_add_linear(node,
> > +						PCI_NUM_MSI,
> > +						&msi_domain_ops,
> > +						&pcie->msi_chip);
> > +		if (!pcie->msi_domain) {
> > +			dev_err(dev, "Failed to get a MSI IRQ domain\n");
> > +			return -ENODEV;
> > +		}
> > +
> > +		mobiveil_pcie_enable_msi(pcie);
> 
> You need to rewrite the MSI support - I will review it then, see above.

Actually it would be good to split MSI support in a separate patch,
to simplify the review.

Thanks,
Lorenzo
