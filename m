Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:63181 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbaI3JSs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Sep 2014 05:18:48 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] PCI: Layerscape: Add Layerscape PCIe driver
Date: Tue, 30 Sep 2014 11:18:30 +0200
Message-ID: <8584310.bgN0fYJaqP@wuerfel>
In-Reply-To: <1411888107-27640-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1411888107-27640-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday 28 September 2014 15:08:27 Minghuan Lian wrote:
> Add support for Freescale Layerscape PCIe controller. This driver
> re-uses the designware core code.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>

I'm still not too happy about the MSI handling here. I think you
really need to have a separate driver for the msi controller.

> +/* SCFG MSI register */
> +#define SCFG_SPIMSICR		0x40
> +#define SCFG_SPIMSICLRCR	0x90
> +
> +#define MSI_LS1021A_ADDR		0x1570040
> +#define MSI_LS1021A_DATA(pex_idx)	(0xb3 + pex_idx)

>From what I can tell, the 'scfg' registers are mostly for MSI, and
the MSI_LS1021A_ADDR that you have hardcoded here is actually part of
the scfg area itself. You should never hardwire that in a PCI host
driver.

Please make a separate MSI driver instead and use the 'msi-parent'
property.

> +static u32 ls_pcie_get_msi_addr(struct pcie_port *pp)
> +{
> +	return MSI_LS1021A_ADDR;
> +}
> +
> +static u32 ls_pcie_get_msi_data(struct pcie_port *pp, int pos)
> +{
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +
> +	return MSI_LS1021A_DATA(pcie->index);
> +}

Does this mean you can have only one device on this PCI host that
uses MSI?

> +static irqreturn_t ls_pcie_msi_irq_handler(int irq, void *data)
> +{
> +	struct pcie_port *pp = data;
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +	unsigned int msi_irq;
> +
> +	/* clear the interrupt */
> +	regmap_write(pcie->scfg, SCFG_SPIMSICLRCR,
> +		     MSI_LS1021A_DATA(pcie->index));
> +
> +	msi_irq = irq_find_mapping(pp->irq_domain, 0);
> +	if (!msi_irq) {
> +		/*
> +		 * that's weird who triggered this?
> +		 * just clear it
> +		 */
> +		dev_err(pcie->dev, "unexpected MSI\n");
> +		return IRQ_NONE;
> +	}
> +
> +	generic_handle_irq(msi_irq);
> +	return IRQ_HANDLED;
> +}

Since you have only one addr/data value per host controller, does that mean
that you can have only one device on this host that uses one interrupt?

How do you ensure that the second user that tries to call pci_enable_msi
gets an error? Is there only one internal device attached to the host?

> +	if (of_device_is_compatible(pcie->dev->of_node, "fsl,ls1021a-pcie")) {
> +		/*
> +		 * LS1021A Workaround for internal TKT228622
> +		 * to fix the INTx hang issue
> +		 */
> +		val = ioread32(pcie->dbi + PCIE_STRFMR1);
> +		val &= 0xffff;
> +		iowrite32(val, pcie->dbi + PCIE_STRFMR1);
> +
> +		ls1021a_pcie_msi_fixup(pp);
> +	}
> +}

"fsl,ls1021a-pcie" is the only one supported by this driver, so the
check is useless.

	Arnd
