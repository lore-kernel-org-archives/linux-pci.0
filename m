Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62698 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbaIDMPY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 08:15:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>,
	linux-pci@vger.kernel.org,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver
Date: Thu, 04 Sep 2014 14:14:48 +0200
Message-ID: <2799937.bNtU9KXR6t@wuerfel>
In-Reply-To: <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com> <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 04 September 2014 18:45:38 Minghuan Lian wrote:

> +
> +#define PCIE_LS1021A_BASE	0x3400000
> +#define PCIE_LS1021A_REG_SIZE	0x0100000

This does not belong here. All addresses must come from DT,
and you should not do the calculation below based on the address.

> +struct ls_pcie {
> +	struct list_head node;
> +	struct device *dev;
> +	struct pci_bus *bus;
> +	void __iomem *dbi;
> +	void __iomem *scfg;
> +	struct pcie_port pp;
> +	int id;
> +	int index;
> +	int irq;
> +	int msi_irq;
> +	int pme_irq;
> +};

irq and pme_irq seem to be completely unused, so better
not add them until they are actually used.

The scfg registers seem to belong to another device that
is responsible for multiple instances. Unfortunately,
this "fsl,ls1021a-scfg" device is not documented anywhere
that I can see.

Is this some sort of syscon node, or is it specific to the
pcie controller(s)?

> +static LIST_HEAD(ls_pcie_list);

Don't maintain your own lists please.

> +static int ls_pcie_link_up(struct pcie_port *pp)
> +{
> +	u32 rc, tmp;
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +
> +	tmp = ioread32(pcie->scfg + SCFG_SCFGREVCR_OFF);
> +	iowrite32(SCFG_NO_BIT_REVERSE, pcie->scfg + SCFG_SCFGREVCR_OFF);
> +
> +	rc = (ioread32(pcie->scfg + PEXMSCPORTSR(pcie->index)) >>
> +	     LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
> +
> +	iowrite32(tmp, pcie->scfg + SCFG_SCFGREVCR_OFF);
> +
> +	if (rc < LTSSM_PCIE_L0)
> +		return 0;
> +
> +	return 1;
> +}

This looks like it is really a phy driver, although a pretty minimal
one.

> +static u32 ls_pcie_get_msi_addr(struct pcie_port *pp)
> +{
> +	return SCFG_SPIMSICR_ADDR;
> +}
> +
> +static u32 ls_pcie_get_msi_data(struct pcie_port *pp, int pos)
> +{
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +
> +	if (pcie->id == PCI_DEVICE_ID_LS1021A)
> +		return MSI_LS1021A_DATA(pcie->index);
> +
> +	return pos;
> +}

My impression is that you have two distinct MSI controller
implementations, one for LS1021A and the other one for everything
else. How about using separate pcie_host_ops for them, possibly
also moving them into separate files?

A good way to deal with this is to put the pointers to the two
pcie_host_ops into the data fields of the ls_pcie_of_match table.

> +/* Freescale PCIe driver does not allow module unload */
> +static int __init ls_pcie_init(void)
> +{
> +	return platform_driver_probe(&ls_pcie_driver, ls_pcie_probe);
> +}
> +subsys_initcall(ls_pcie_init);

Better change to platform_driver_register, so you can use deferred probing.

	Arnd

