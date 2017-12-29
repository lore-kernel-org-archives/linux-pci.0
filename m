Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:25730 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdL2GKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 01:10:01 -0500
Subject: Re: [PATCH v2 9/9] PCI: cadence: Add EndPoint Controller driver for
 Cadence PCIe controller
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <29e81ceb112030032f42a467183106453a63123f.1513620412.git.cyrille.pitchen@free-electrons.com>
CC: <adouglas@cadence.com>, <stelford@cadence.com>,
        <dgary@cadence.com>, <kgopi@cadence.com>, <eandrews@cadence.com>,
        <thomas.petazzoni@free-electrons.com>, <sureshp@cadence.com>,
        <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <92922c4c-d18f-0c6b-7173-c6bf01274ddc@ti.com>
Date: Fri, 29 Dec 2017 11:38:38 +0530
MIME-Version: 1.0
In-Reply-To: <29e81ceb112030032f42a467183106453a63123f.1513620412.git.cyrille.pitchen@free-electrons.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Monday 18 December 2017 11:46 PM, Cyrille Pitchen wrote:
> This patch adds support to the Cadence PCIe controller in endpoint mode.
> 
> drivers/pci/Makefile was previously patched so
> drivers/pci/cadence/pcie-cadence-ep.o is linked after drivers/pci/endpoint
> objects, otherwise the built-in pci-cadence-ep driver would be probed
> before the PCI endpoint libraries would have been initialized, which would
> result in a kernel crash: controllers_group would still be NULL when
> devm_pci_epc_create() is called.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
>  drivers/pci/cadence/Kconfig           |   9 +
>  drivers/pci/cadence/Makefile          |   1 +
>  drivers/pci/cadence/pcie-cadence-ep.c | 531 ++++++++++++++++++++++++++++++++++
>  drivers/pci/cadence/pcie-cadence.c    |  27 ++
>  drivers/pci/cadence/pcie-cadence.h    | 114 ++++++++
>  5 files changed, 682 insertions(+)
>  create mode 100644 drivers/pci/cadence/pcie-cadence-ep.c
> 
> diff --git a/drivers/pci/cadence/Kconfig b/drivers/pci/cadence/Kconfig
> index 0d15b40861e9..70aa03b86e0d 100644
> --- a/drivers/pci/cadence/Kconfig
> +++ b/drivers/pci/cadence/Kconfig
> @@ -21,4 +21,13 @@ config PCIE_CADENCE_HOST
>  	  mode. This PCIe controller may be embedded into many different vendors
>  	  SoCs.
>  
> +config PCIE_CADENCE_EP
> +	bool "Cadence PCIe endpoint controller"
> +	depends on PCI_ENDPOINT
> +	select PCIE_CADENCE
> +	help
> +	  Say Y here if you want to support the Cadence PCIe  controller in
> +	  endpoint mode. This PCIe controller may be embedded into many
> +	  different vendors SoCs.
> +
>  endif # PCI_CADENCE
> diff --git a/drivers/pci/cadence/Makefile b/drivers/pci/cadence/Makefile
> index 589601a8ff89..719392b97998 100644
> --- a/drivers/pci/cadence/Makefile
> +++ b/drivers/pci/cadence/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
>  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
> +obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
> new file mode 100644
> index 000000000000..d940f5fb4ca0
> --- /dev/null
> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> @@ -0,0 +1,531 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe endpoint controller driver.
> +// Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/pci-epc.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/sizes.h>
> +
> +#include "pcie-cadence.h"
> +
> +#define CDNS_PCIE_EP_MIN_APERTURE		128	/* 128 bytes */
> +#define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
> +#define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
> +
> +/**
> + * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
> + * @pcie: Cadence PCIe controller
> + * @max_regions: maximum number of regions supported by hardware
> + * @ob_region_map: bitmask of mapped outbound regions
> + * @ob_addr: base addresses in the AXI bus where the outbound regions start
> + * @irq_phys_addr: base address on the AXI bus where the MSI/legacy IRQ
> + *		   dedicated outbound regions is mapped.
> + * @irq_cpu_addr: base address in the CPU space where a write access triggers
> + *		  the sending of a memory write (MSI) / normal message (legacy
> + *		  IRQ) TLP through the PCIe bus.
> + * @irq_pci_addr: used to save the current mapping of the MSI/legacy IRQ
> + *		  dedicated outbound region.
> + * @irq_pending: bitmask of asserted legacy IRQs.
> + */
> +struct cdns_pcie_ep {
> +	struct cdns_pcie		pcie;
> +	u32				max_regions;
> +	unsigned long			ob_region_map;
> +	phys_addr_t			*ob_addr;
> +	phys_addr_t			irq_phys_addr;
> +	void __iomem			*irq_cpu_addr;
> +	u64				irq_pci_addr;
> +	u8				irq_pending;
> +};
> +
> +static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
> +				     struct pci_epf_header *hdr)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +
> +	cdns_pcie_ep_fn_writew(pcie, fn, PCI_DEVICE_ID, hdr->deviceid);
> +	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_REVISION_ID, hdr->revid);
> +	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CLASS_PROG, hdr->progif_code);
> +	cdns_pcie_ep_fn_writew(pcie, fn, PCI_CLASS_DEVICE,
> +			       hdr->subclass_code | hdr->baseclass_code << 8);
> +	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CACHE_LINE_SIZE,
> +			       hdr->cache_line_size);
> +	cdns_pcie_ep_fn_writew(pcie, fn, PCI_SUBSYSTEM_ID, hdr->subsys_id);
> +	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_INTERRUPT_PIN, hdr->interrupt_pin);
> +
> +	/*
> +	 * Vendor ID can only be modified from function 0, all other functions
> +	 * use the same vendor ID as function 0.
> +	 * Besides, function 0 'enabled' bit is hard-wired to 1, only other
> +	 * functions can be enabled/disabled by software.
> +	 */
> +	if (fn == 0) {
> +		/* Update the vendor IDs. */
> +		u32 id = CDNS_PCIE_LM_ID_VENDOR(hdr->vendorid) |
> +			 CDNS_PCIE_LM_ID_SUBSYS(hdr->subsys_vendor_id);
> +
> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
> +	} else {
> +		/* Enable this endpoint function. */
> +		u32 cfg = cdns_pcie_readl(pcie, CDNS_PCIE_LM_EP_FUNC_CFG);
> +
> +		cfg |= BIT(fn);
> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);

hmm.. this is not related to $function. This can be done in ->start().
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, enum pci_barno bar,
> +				dma_addr_t bar_phys, size_t size, int flags)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
> +	u64 sz;
> +
> +	/* BAR size is 2^(aperture + 7) */
> +	sz = max_t(size_t, size, CDNS_PCIE_EP_MIN_APERTURE);
> +	sz = 1ULL << fls64(sz - 1);

I assume you didn't use __roundup_pow_of_two because it takes long as argument?
> +	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
> +
> +	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
> +		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
> +	} else {
> +		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> +		bool is_64bits = sz > SZ_2G;

Should this be set only based on size? it also depends on if it can be mapped
anywhere in the 64-bit address space right?
> +
> +		if (is_64bits && (bar & 1))
> +			return -EINVAL;
> +
> +		if (is_64bits && is_prefetch)
> +			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
> +		else if (is_prefetch)
> +			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
> +		else if (is_64bits)
> +			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS;
> +		else
> +			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS;
> +	}
> +
> +	addr0 = lower_32_bits(bar_phys);
> +	addr1 = upper_32_bits(bar_phys);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar),
> +			 addr0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),
> +			 addr1);
> +
> +	if (bar < BAR_4) {
> +		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
> +		b = bar;
> +	} else {
> +		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
> +		b = bar - BAR_4;
> +	}
> +
> +	cfg = cdns_pcie_readl(pcie, reg);
> +	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
> +		 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
> +	cfg |= (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
> +		CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
> +	cdns_pcie_writel(pcie, reg, cfg);
> +
> +	return 0;
> +}
> +
> +static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
> +				   enum pci_barno bar)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 reg, cfg, b, ctrl;
> +
> +	if (bar < BAR_4) {
> +		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
> +		b = bar;
> +	} else {
> +		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
> +		b = bar - BAR_4;
> +	}
> +
> +	ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
> +	cfg = cdns_pcie_readl(pcie, reg);
> +	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
> +		 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
> +	cfg |= CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(ctrl);
> +	cdns_pcie_writel(pcie, reg, cfg);
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), 0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), 0);
> +}
> +
> +static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, phys_addr_t addr,
> +				 u64 pci_addr, size_t size)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 r;
> +
> +	r = find_first_zero_bit(&ep->ob_region_map,
> +				sizeof(ep->ob_region_map) * BITS_PER_LONG);
> +	if (r >= ep->max_regions - 1) {
> +		dev_err(&epc->dev, "no free outbound region\n");
> +		return -EINVAL;
> +	}
> +
> +	cdns_pcie_set_outbound_region(pcie, r, false, addr, pci_addr, size);
> +
> +	set_bit(r, &ep->ob_region_map);
> +	ep->ob_addr[r] = addr;
> +
> +	return 0;
> +}
> +
> +static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
> +				    phys_addr_t addr)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 r;
> +
> +	for (r = 0; r < ep->max_regions - 1; r++)
> +		if (ep->ob_addr[r] == addr)
> +			break;
> +
> +	if (r == ep->max_regions - 1)
> +		return;
> +
> +	cdns_pcie_reset_outbound_region(pcie, r);
> +
> +	ep->ob_addr[r] = 0;
> +	clear_bit(r, &ep->ob_region_map);
> +}
> +
> +static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 mmc)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> +	u16 flags;
> +
> +	/* Validate the ID of the MSI Capability structure. */
> +	if (cdns_pcie_ep_fn_readb(pcie, fn, cap) != PCI_CAP_ID_MSI)
> +		return -EINVAL;

Not sure the usefulness of this since this is most likely going to be a RO value.
> +
> +	/*
> +	 * Set the Multiple Message Capable bitfield into the Message Control
> +	 * register.
> +	 */
> +	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> +	flags = (flags & ~PCI_MSI_FLAGS_QMASK) | (mmc << 1);
> +	flags |= PCI_MSI_FLAGS_64BIT;
> +	flags &= ~PCI_MSI_FLAGS_MASKBIT;
> +	cdns_pcie_ep_fn_writew(pcie, fn, cap + PCI_MSI_FLAGS, flags);
> +
> +	return 0;
> +}
> +
> +static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> +	u16 flags, mmc, mme;
> +
> +	/* Validate the ID of the MSI Capability structure. */
> +	if (cdns_pcie_ep_fn_readb(pcie, fn, cap) != PCI_CAP_ID_MSI)
> +		return -EINVAL;

here too..
> +
> +	/* Validate that the MSI feature is actually enabled. */
> +	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> +	if (!(flags & PCI_MSI_FLAGS_ENABLE))
> +		return -EINVAL;
> +
> +	/*
> +	 * Get the Multiple Message Enable bitfield from the Message Control
> +	 * register.
> +	 */
> +	mmc = (flags & PCI_MSI_FLAGS_QMASK) >> 1;
> +	mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
> +
> +	/*
> +	 * The Multiple Message Enable value should always be equal to or less
> +	 * than The Multiple Message Capable value.
> +	 */
> +	if (mme > mmc)
> +		mme = mmc;

if the host is allocating more interrupts, why not use it ;-)
> +
> +	/*
> +	 * There are up to 32 MSI: mme stores the number of enabled MSI as a
> +	 * power of two. Hence mme can't be geater than 5 (2^5 == 32).
> +	 */
> +	if (mme > 5)
> +		mme = 5;

IMO the above 2 checks are trying to fix buggy hosts and is not necessary.
> +
> +	return mme;
> +}
> +
> +static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
> +				     u8 intx, bool is_asserted)
> +{
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 r = ep->max_regions - 1;
> +	u32 offset;
> +	u16 status;
> +	u8 msg_code;
> +
> +	intx &= 3;
> +
> +	/* Set the outbound region if needed. */
> +	if (unlikely(ep->irq_pci_addr != CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY)) {
> +		/* Last region was reserved for IRQ writes. */
> +		cdns_pcie_set_outbound_region_for_normal_msg(pcie, r,
> +							     ep->irq_phys_addr);
> +		ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
> +	}
> +
> +	if (is_asserted) {
> +		ep->irq_pending |= BIT(intx);
> +		msg_code = MSG_CODE_ASSERT_INTA + intx;
> +	} else {
> +		ep->irq_pending &= ~BIT(intx);
> +		msg_code = MSG_CODE_DEASSERT_INTA + intx;
> +	}
> +
> +	status = cdns_pcie_ep_fn_readw(pcie, fn, PCI_STATUS);
> +	if (((status & PCI_STATUS_INTERRUPT) != 0) ^ (ep->irq_pending != 0)) {
> +		status ^= PCI_STATUS_INTERRUPT;
> +		cdns_pcie_ep_fn_writew(pcie, fn, PCI_STATUS, status);
> +	}
> +
> +	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
> +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
> +		 CDNS_PCIE_MSG_NO_DATA;
> +	writel(0, ep->irq_cpu_addr + offset);
> +}
> +
> +static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
> +{
> +	u16 cmd;
> +
> +	cmd = cdns_pcie_ep_fn_readw(&ep->pcie, fn, PCI_COMMAND);
> +	if (cmd & PCI_COMMAND_INTX_DISABLE)
> +		return -EINVAL;
> +
> +	cdns_pcie_ep_assert_intx(ep, fn, intx, true);
> +	/*
> +	 * The mdelay() value was taken from dra7xx_pcie_raise_legacy_irq()
> +	 * from drivers/pci/dwc/pci-dra7xx.c
> +	 */

ha ha.. that's not a great reference.

Ideally it should be deasserted once the interrupt is handled by the RC. But I
think we need a better way to handle it from EP core.
> +	mdelay(1);
> +	cdns_pcie_ep_assert_intx(ep, fn, intx, false);
> +	return 0;
> +}
> +
> +static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
> +				  enum pci_epc_irq_type type, u8 interrupt_num)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> +	u16 flags, mmc, mme, data, data_mask;
> +	u8 msi_count;
> +	u64 pci_addr, pci_addr_mask = 0xff;
> +
> +	/* Handle legacy IRQ. */
> +	if (type == PCI_EPC_IRQ_LEGACY)
> +		return cdns_pcie_ep_send_legacy_irq(ep, fn, 0);
> +
> +	/* Otherwise MSI. */
> +	if (type != PCI_EPC_IRQ_MSI)
> +		return -EINVAL;

Do you have plans for adding MSI-X support?

how about something like below

	switch (type) {
	case PCI_EPC_IRQ_LEGACY:
		return cdns_pcie_ep_send_legacy_irq(ep, fn, 0);
	case PCI_EPC_IRQ_MSI:
		return cdns_pcie_ep_send_msi_irq(ep, fn, 0);
		break;
	default:
		dev_err(pci->dev, "UNKNOWN IRQ type\n");
	}

rest of the code here should be added in cdns_pcie_ep_send_msi_irq.
> +
> +	/* Check whether the MSI feature has been enabled by the PCI host. */
> +	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> +	if (!(flags & PCI_MSI_FLAGS_ENABLE))
> +		return -EINVAL;
> +
> +	/* Get the number of enabled MSIs */
> +	mmc = (flags & PCI_MSI_FLAGS_QMASK) >> 1;
> +	mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
> +
> +	/*
> +	 * The Multiple Message Enable value should always be equal to or less
> +	 * than The Multiple Message Capable value.
> +	 */
> +	if (mme > mmc)
> +		mme = mmc;
> +
> +	/*
> +	 * There are up to 32 MSI: mme stores the number of enabled MSI as a
> +	 * power of two. Hence mme can't be geater than 5 (2^5 == 32).
> +	 */
> +	if (mme > 5)
> +		mme = 5;

not sure if the above 2 checks are required.
> +
> +	msi_count = 1 << mme;
> +	if (!interrupt_num || interrupt_num > msi_count)
> +		return -EINVAL;
> +
> +	/* Compute the data value to be written. */
> +	data_mask = msi_count - 1;
> +	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
> +	data = (data & ~data_mask) | ((interrupt_num - 1) & data_mask);
> +
> +	/* Get the PCI address where to write the data into. */
> +	pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
> +	pci_addr <<= 32;
> +	pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
> +	pci_addr &= GENMASK_ULL(63, 2);
> +
> +	/* Set the outbound region if needed. */
> +	if (unlikely(ep->irq_pci_addr != pci_addr)) {
> +		/* Last region was reserved for IRQ writes. */
> +		cdns_pcie_set_outbound_region(pcie, ep->max_regions - 1,
> +					      false,
> +					      ep->irq_phys_addr,
> +					      pci_addr & ~pci_addr_mask,
> +					      pci_addr_mask + 1);
> +		ep->irq_pci_addr = pci_addr;
> +	}
> +	writew(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
> +
> +	return 0;
> +}
> +
> +static int cdns_pcie_ep_start(struct pci_epc *epc)
> +{
> +	struct pci_epf *epf;

start should be used to start the link. Btw where do you actually start the link?
> +
> +	/*
> +	 * Already linked-up: don't call directly pci_epc_linkup() because we've
> +	 * already locked the epc->lock.
> +	 */
> +	list_for_each_entry(epf, &epc->pci_epf, list)
> +		pci_epf_linkup(epf);

Er.. There are better ways to handle it. (See linkup_notifier in pci_epf_test.c)
> +
> +	return 0;
> +}
> +
> +static const struct pci_epc_ops cdns_pcie_epc_ops = {
> +	.write_header	= cdns_pcie_ep_write_header,
> +	.set_bar	= cdns_pcie_ep_set_bar,
> +	.clear_bar	= cdns_pcie_ep_clear_bar,
> +	.map_addr	= cdns_pcie_ep_map_addr,
> +	.unmap_addr	= cdns_pcie_ep_unmap_addr,
> +	.set_msi	= cdns_pcie_ep_set_msi,
> +	.get_msi	= cdns_pcie_ep_get_msi,
> +	.raise_irq	= cdns_pcie_ep_raise_irq,
> +	.start		= cdns_pcie_ep_start,
> +};
> +
> +static const struct of_device_id cdns_pcie_ep_of_match[] = {
> +	{ .compatible = "cdns,cdns-pcie-ep" },
> +
> +	{ },
> +};
> +
> +static int cdns_pcie_ep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct cdns_pcie_ep *ep;
> +	struct cdns_pcie *pcie;
> +	struct pci_epc *epc;
> +	struct resource *res;
> +	int ret;
> +
> +	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	pcie = &ep->pcie;
> +	pcie->is_rc = false;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
> +	pcie->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->reg_base)) {
> +		dev_err(dev, "missing \"reg\"\n");
> +		return PTR_ERR(pcie->reg_base);
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
> +	if (!res) {
> +		dev_err(dev, "missing \"mem\"\n");
> +		return -EINVAL;
> +	}
> +	pcie->mem_res = res;
> +
> +	ep->max_regions = 32;

prefer using macros for 32 here?

I'd prefer making cdns,max-outbound-regions mandatory property and always get
the outbound regions from dt instead of having default values.
> +	of_property_read_u32(np, "cdns,max-outbound-regions", &ep->max_regions);
> +	ep->ob_addr = devm_kzalloc(dev, ep->max_regions * sizeof(*ep->ob_addr),
> +				   GFP_KERNEL);
> +	if (!ep->ob_addr)
> +		return -ENOMEM;
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync() failed\n");
> +		goto err_get_sync;
> +	}
> +
> +	/* Disable all but function 0 (anyway BIT(0) is hardwired to 1). */
> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
> +
> +	epc = devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
> +	if (IS_ERR(epc)) {
> +		dev_err(dev, "failed to create epc device\n");
> +		ret = PTR_ERR(epc);
> +		goto err_init;
> +	}
> +
> +	epc_set_drvdata(epc, ep);
> +
> +	epc->max_functions = 1;

Is it better to assign the default value after checking the return value of
of_property_read_u8?
> +	of_property_read_u8(np, "max-functions", &epc->max_functions);
> +
> +	ret = pci_epc_mem_init(epc, pcie->mem_res->start,
> +			       resource_size(pcie->mem_res));
> +	if (ret < 0) {
> +		dev_err(dev, "failed to initialize the memory space\n");
> +		goto err_init;
> +	}
> +
> +	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
> +						  SZ_128K);
> +	if (!ep->irq_cpu_addr) {
> +		dev_err(dev, "failed to reserve memory space for MSI\n");
> +		ret = -ENOMEM;
> +		goto free_epc_mem;
> +	}
> +	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
> +
> +	return 0;
> +
> + free_epc_mem:
> +	pci_epc_mem_exit(epc);
> +
> + err_init:
> +	pm_runtime_put_sync(dev);
> +
> + err_get_sync:
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver cdns_pcie_ep_driver = {
> +	.driver = {
> +		.name = "cdns-pcie-ep",
> +		.of_match_table = cdns_pcie_ep_of_match,
> +	},
> +	.probe = cdns_pcie_ep_probe,

.shutdown?
> +};
> +builtin_platform_driver(cdns_pcie_ep_driver);

builtin_platform_driver_probe?
> diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-cadence.c
> index 5c76e7f4c5f9..7b91147ce68e 100644
> --- a/drivers/pci/cadence/pcie-cadence.c
> +++ b/drivers/pci/cadence/pcie-cadence.c
> @@ -55,6 +55,33 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u32 r, bool is_io,
>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
>  }
>  
> +void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u32 r,
> +						  u64 cpu_addr)
> +{
> +	u32 addr0, addr1, desc0, desc1;
> +
> +	desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
> +	desc1 = 0;
> +	if (pcie->is_rc) {

why is this part of adding EP support?

Thanks
Kishon
