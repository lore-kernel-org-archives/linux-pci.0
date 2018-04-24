Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeDXTwN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Apr 2018 15:52:13 -0400
Date: Tue, 24 Apr 2018 14:52:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marc.zyngier@arm.com,
        mingkai.hu@nxp.com, peter.newton@nxp.com, minghuan.lian@nxp.com,
        rajesh.raina@nxp.com, rajan.kapoor@nxp.com, prabhjot.singh@nxp.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/3] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
 driver
Message-ID: <20180424195210.GA72698@bhelgaas-glaptop.roam.corp.google.com>
References: <1524580195-4680-1-git-send-email-l.subrahmanya@mobiveil.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524580195-4680-1-git-send-email-l.subrahmanya@mobiveil.co.in>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:29:55AM -0400, Subrahmanya Lingappa wrote:
> Adds driver for Mobiveil AXI PCIe Host Bridge Soft IP
>  - GPEX 4.0, a PCIe gen4 IP. This IP has upto 8 outbound and inbound windows
>  for the address translation.
> 
> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-pci@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  drivers/pci/host/pcie-mobiveil.c | 692 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 692 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-mobiveil.c
> 
> diff --git a/drivers/pci/host/pcie-mobiveil.c b/drivers/pci/host/pcie-mobiveil.c
> new file mode 100644
> index 0000000..28f488b
> --- /dev/null
> +++ b/drivers/pci/host/pcie-mobiveil.c
> @@ -0,0 +1,692 @@
> +/*
> + * PCIe host controller driver for Mobiveil PCIe Host controller
> + *
> + * SPDX-License-Identifier: GPL-2.0

Incorrect usage of SPDX tag, see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst

(Must be first line of file, should use "//" comment in C source)

> + * Copyright (c) 2017 Mobiveil Inc.

It's 2018 already, so use 2018 here instead of 2017 in this patch and
then updating it in the next.

> +/* supported number of interrupts */
> +#define PCI_NUM_INTX    4

This is already defined in include/linux/pci.h; you don't need another
one.

> +static inline u32 csr_readl(struct mobiveil_pcie *pcie,	const u32 reg)

Should be space, not tab, after ","

> +/*
> + * Routine to check the downstream link status, its recommended to
> + * check the link status before accessing downstream config resources.

Checking the link status before accessing downstream config resources
is racy because the link may go down after you check the status but
before you actually do the access.

> + */
> +static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
> +{
> +	return (csr_readl(pcie, LTSSM_STATUS) &
> +		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
> +}

> +static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
> +					unsigned int devfn, int where)
> +{
> +	struct mobiveil_pcie *pcie = bus->sysdata;
> +
> +	if (!mobiveil_pcie_valid_device(bus, devfn))
> +		return NULL;
> +
> +	if (bus->number == pcie->root_bus_nr) {
> +		/* RC config access */
> +		return pcie->csr_axi_slave_base + where;
> +	} else {

No "else" needed, since the "if" body always returns.  Then you can
unindent the block below.

> +		/*
> +		 * EP config access (in Config/APIO space)
> +		 * Program PEX Address base (31..16 bits) with appropriate value
> +		 * (BDF) in PAB_AXI_AMAP_PEX_WIN_L0 Register.
> +		 * Relies on pci_lock serialization
> +		 */
> +		csr_writel(pcie,
> +			bus->number << PAB_BUS_SHIFT |
> +			PCI_SLOT(devfn) << PAB_DEVICE_SHIFT |
> +			PCI_FUNC(devfn) << PAB_FUNCTION_SHIFT,
> +			PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
> +		return pcie->config_axi_slave_base + where;
> +	}

> +/*
> + * select_paged_register - routine to access paged register of root complex
> + *
> + * registers of RC are paged, for this scheme to work
> + * extracted higher 6 bits of the offset will be written to pg_sel
> + * field of PAB_CTRL register and rest of the lower 10 bits enabled with
> + * PAGE_SEL_EN are used as offset of the register.
> + *

Remove the extra blank line at the end of the comment.

> + */
> +static void select_paged_register(struct mobiveil_pcie *pcie, u32 offset)

> +	value = csr_readl(pcie, PCI_COMMAND);
> +	csr_writel(pcie, value | PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> +		PCI_COMMAND_MASTER,	PCI_COMMAND);

Use space, not tab, after the comma.

> +	/* program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
> +	 * PAB_AXI_PIO_CTRL Register
> +	 */

Wrong comment style, needs:

  /*
   * Program PIO ...
   * ...
   */

Bjorn
