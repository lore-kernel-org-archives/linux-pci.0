Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45424 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbeAEOAI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jan 2018 09:00:08 -0500
Date: Fri, 5 Jan 2018 14:01:02 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        marc.zyngier@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        mingkai.hu@nxp.com, peter.newton@nxp.com, minghuan.lian@nxp.com,
        rajesh.raina@nxp.com, rajan.kapoor@nxp.com, prabhjot.singh@nxp.com
Subject: Re: [PATCH v5 2/3] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
 driver
Message-ID: <20180105140102.GA24933@red-moon>
References: <1513181317-19914-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <20171220170307.GC1709@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171220170307.GC1709@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 20, 2017 at 05:03:07PM +0000, Lorenzo Pieralisi wrote:

[...]

> > +static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
> > +{
> > +	struct device *dev = &pcie->pdev->dev;
> > +	struct device_node *node = dev->of_node;
> > +	int ret;
> 
> ret is unused
> 
> > +	/* setup INTx */
> > +	pcie->intx_domain = irq_domain_add_linear(node,
> > +				PCI_NUM_INTX + 1, &intx_domain_ops, pcie);
> 
> You should use PCI_NUM_INTX and add pci_irqd_intx_xlate() as the
> domain ops .xlate.

Actually that's not quite correct - so scrap this. The point here is,
the PCI host controller interrupt domain has to have 4 hwirqs (this
is a pseudo interrupt controller - a multiplexer) and it
is through DT interrupt-map that INTx pins (1-4) can be mapped to the
"PCI interrupt controller hwirq inputs" that we consider numbered
from 0 to 3.

It is not that clean-cut but IMO it is the DT interrupt mapping that
should carry out the translation.

See for instance:

arch/arm64/boot/dts/marvell/armada-37xx.dtsi

This requires DT/irqchip maintainers acknowledgement before proceeding.

Lorenzo
