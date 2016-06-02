Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52881 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbcFBJqE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2016 05:46:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Hanna Hawa <hannah@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/3] PCI: host: new PCI host controller driver for Marvell Armada 3700
Date: Thu, 02 Jun 2016 11:46:04 +0200
Message-ID: <3112077.0RPfokLCAs@wuerfel>
In-Reply-To: <1464858585-10963-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com> <1464858585-10963-3-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 2, 2016 11:09:44 AM CEST Thomas Petazzoni wrote:

> +static bool advk_pcie_link_up(struct advk_pcie *pcie)
> +{
> +	int timeout;
> +	u32 ltssm_state;
> +	u32 val;
> +
> +	timeout = PCIE_LINKUP_TIMEOUT;
> +	do {
> +		val = advk_readl(pcie, CFG_REG);
> +		ltssm_state = (val >> LTSSM_SHIFT) & LTSSM_MASK;
> +		timeout--;
> +	/* Use ltssm < LTSSM_L0 instead of ltssm != LTSSM_L0 */
> +	} while (ltssm_state < LTSSM_L0 && timeout > 0);
> +
> +	return (timeout > 0);
> +}

Maybe wait for some amount of time to have passed here (using 
time_before(jiffies, end)) rather than a number of retries,
for robustness and determinism.

> +	/* Point PCIe unit MBUS decode windows to DRAM space. */
> +	for (i = 0; i < 8; i++)
> +		advk_pcie_set_ob_win(pcie, i, 0, 0, 0, 0, 0, 0, 0);

Is this actually mbus based, or is the comment copied from some
other Marvell driver?

> +static int advk_pcie_setup_msi_irq(struct msi_controller *chip,
> +				   struct pci_dev *pdev,
> +				   struct msi_desc *desc)
> +{
> +	struct advk_pcie *pcie = pdev->bus->sysdata;
> +	struct msi_msg msg;
> +	int virq, hwirq;
> +	phys_addr_t msi_msg_phys;
> +
> +	/* We support MSI, but not MSI-X */
> +	if (desc->msi_attrib.is_msix)
> +		return -EINVAL;
> +
> +	hwirq = advk_pcie_alloc_msi(pcie);
> +	if (hwirq < 0)
> +		return hwirq;
> +
> +	virq = irq_create_mapping(pcie->msi_domain, hwirq);
> +	if (!virq) {
> +		advk_pcie_free_msi(pcie, hwirq);
> +		return -EINVAL;
> +	}

What is the version of the GIC in the Armada 3700? If you have GICv3
or GICv2m, could you use that instead of the built-in MSI logic?

We typically handle this using the msi-map or msi-parent properties
pointing to either the gic or the PCI host, depending on which one
you want to use, but either of them should work, and the GIC should
be more efficient because you can distribute the interrupts of the
PCI devices over all CPUs by workload, rather than having to
multiplex all MSI through a single GIC interrupt.

	Arnd

