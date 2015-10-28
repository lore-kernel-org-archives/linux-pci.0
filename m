Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0053.outbound.protection.outlook.com ([157.56.110.53]:42080
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755657AbbJ1KR3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2015 06:17:29 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v5] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Wed, 28 Oct 2015 10:17:22 +0000
Message-ID: <8520D5D51A55D047800579B0941471980169316D@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1445871386-2377-1-git-send-email-bharatku@xilinx.com>
 <20151027234032.GA7238@localhost>
In-Reply-To: <20151027234032.GA7238@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Mon, Oct 26, 2015 at 08:26:26PM +0530, Bharat Kumar Gogada wrote:
> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.

> > +
> > +	while ((status = nwl_bridge_readl(pcie, MSGF_MSI_STATUS_LO)) !=
> 0) {
> > +		for_each_set_bit(bit, &status, 32) {
> > +			nwl_bridge_writel(pcie, 1 << bit,
> MSGF_MSI_STATUS_LO);
> > +			virq = irq_find_mapping(msi->dev_domain, bit);
> > +			if (virq)
> > +				generic_handle_irq(virq);
> > +		}
> > +	}
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> 
> These are basically identical.  Can you factor them out somehow to avoid
> repeating the code?

Is it okay if irq_set_chained_handler_and_data being invoked with two different interrupt numbers, but pointing to 
same interrupt handler?

> > +
> > +	pcie->legacy_irq_domain =
> irq_domain_add_linear(legacy_intc_node, 4,
> > +
> 	&legacy_domain_ops,
> > +							pcie);
> > +
> > +	if (!pcie->legacy_irq_domain) {
> > +		dev_err(pcie->dev, "failed to create IRQ domain\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +#ifdef CONFIG_PCI_MSI
> > +	msi->dev_domain = irq_domain_add_linear(NULL,
> INT_PCI_MSI_NR,
> > +					&dev_msi_domain_ops, pcie);
> > +	if (!msi->dev_domain) {
> > +		dev_err(pcie->dev, "failed to create dev IRQ domain\n");
> > +		return -ENOMEM;
> > +	}
> > +	msi->msi_chip.domain = pci_msi_create_irq_domain(node,
> > +
> 	&nwl_msi_domain_info,
> > +							msi->dev_domain);
> > +	if (!msi->msi_chip.domain) {
> > +		dev_err(pcie->dev, "failed to create msi IRQ domain\n");
> > +		irq_domain_remove(msi->dev_domain);
> > +		return -ENOMEM;
> > +	}
> > +#endif
> > +	return 0;
> > +}
> > +
> > +static int nwl_pcie_enable_msi(struct nwl_pcie *pcie, struct pci_bus
> > +*bus) {
> 
> It looks strange to have all the "#ifdef CONFIG_PCI_MSI" above, and here
> we have this long MSI-related function without any ifdefs around it.  Seems
> like this should be ifdef'ed also?  What about nwl_pcie_msi_handler_high(),
> nwl_pcie_msi_handler_low(), nwl_compose_msi_msg(),
> nwl_msi_set_affinity(), etc.?
> 
In probe I'm invoking "nwl_pcie_enable_msi" using "if (IS_ENABLED(CONFIG_PCI_MSI)) " check, since this is at run time 
I haven't kept above mentioned functions under #ifdef CONFIG_PCI_MSI.
The above MSI domain allocation was under ifdef, since if driver was compiled for legacy some of the MSI hierarchy API's and structures aren't available.

> > +	struct platform_device *pdev = to_platform_device(pcie->dev);
> > +	struct nwl_msi *msi = &pcie->msi;

Regards,
Bharat
