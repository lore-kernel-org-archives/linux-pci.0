Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753673AbeB0PcH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Feb 2018 10:32:07 -0500
Date: Tue, 27 Feb 2018 15:32:02 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 5/6] PCI: rockchip: Add Endpoint controller driver for
 Rockchip PCIe controller
Message-ID: <20180227153202.GB7184@e107981-ln.cambridge.arm.com>
References: <1519348503-243259-1-git-send-email-shawn.lin@rock-chips.com>
 <1519348654-243597-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519348654-243597-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 23, 2018 at 09:17:33AM +0800, Shawn Lin wrote:
> This patch adds support to the Rockchip PCIe controller in endpoint mode
> which currently supports up to 32 regions, and each regions should at
> least be 1MB per TRM.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - fix some error handling
> 
>  drivers/pci/rockchip/Kconfig            |  12 +
>  drivers/pci/rockchip/Makefile           |   1 +
>  drivers/pci/rockchip/pcie-rockchip-ep.c | 641 ++++++++++++++++++++++++++++++++
>  drivers/pci/rockchip/pcie-rockchip.c    |  25 +-
>  drivers/pci/rockchip/pcie-rockchip.h    |  92 +++++
>  5 files changed, 762 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/pci/rockchip/pcie-rockchip-ep.c
> 
> diff --git a/drivers/pci/rockchip/Kconfig b/drivers/pci/rockchip/Kconfig
> index d655b77..668f850 100644
> --- a/drivers/pci/rockchip/Kconfig
> +++ b/drivers/pci/rockchip/Kconfig
> @@ -17,4 +17,16 @@ config PCIE_ROCKCHIP_HOST
>  	  There is 1 internal PCIe port available to support GEN2 with
>  	  4 slots.
>  
> +config PCIE_ROCKCHIP_EP
> +	bool "Rockchip PCIe endpoint controller"
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on OF
> +	depends on PCI_ENDPOINT
> +	select MFD_SYSCON
> +	select PCIE_ROCKCHIP
> +	help
> +	  Say Y here if you want to support Rockchip PCIe controller in
> +	  endpoint mode on Rockchip SoC. There is 1 internal PCIe port
> +	  available to support GEN2 with 4 slots.
> +
>  endmenu
> diff --git a/drivers/pci/rockchip/Makefile b/drivers/pci/rockchip/Makefile
> index 0af40db..8dce495 100644
> --- a/drivers/pci/rockchip/Makefile
> +++ b/drivers/pci/rockchip/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
> +obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
> diff --git a/drivers/pci/rockchip/pcie-rockchip-ep.c b/drivers/pci/rockchip/pcie-rockchip-ep.c
> new file mode 100644
> index 0000000..afe9fc4
> --- /dev/null
> +++ b/drivers/pci/rockchip/pcie-rockchip-ep.c
> @@ -0,0 +1,641 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Rockchip AXI PCIe endpoint controller driver
> + *
> + * Copyright (c) 2018 Rockchip, Inc.
> + *
> + * Author: Shawn Lin <shawn.lin@rock-chips.com>
> + *         Simon Xue <xxm@rock-chips.com>
> + *
> + * Bits taken from Cadence endpoint controller driver

I reviewed this patch and I then realized that it is not bits, it is
that the drivers are almost identical. Are we talking about the same IP
(possibly with some HW wrapper of sorts) ?

Thanks,
Lorenzo

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/pci-epc.h>
> +#include <linux/platform_device.h>
> +#include <linux/sizes.h>
> +#include <linux/delay.h>
> +#include <linux/configfs.h>
> +#include <linux/pci-epf.h>
> +
> +#include "pcie-rockchip.h"
> +
> +/**
> + * struct rockchip_pcie_ep - private data for PCIe endpoint controller driver
> + * @pcie: Rockchip PCIe controller
> + * @data: pointer to a 'struct rockchip_pcie_data'
> + * @ob_region_map: bitmask of mapped outbound regions
> + * @ob_addr: base addresses in the AXI bus where the outbound regions start
> + * @irq_phys_addr: base address on the AXI bus where the MSI/legacy IRQ
> + *		   dedicated outbound regions is mapped.
> + * @irq_cpu_addr: base address in the CPU space where a write access triggers
> + *		  the sending of a memory write (MSI) / normal message (legacy
> + *		  IRQ) TLP through the PCIe bus.
> + * @irq_pci_addr: used to save the current mapping of the MSI/legacy IRQ
> + *		  dedicated outbound region.
> + * @irq_pci_fn: the latest PCI function that has updated the mapping of
> + *		the MSI/legacy IRQ dedicated outbound region.
> + * @irq_pending: bitmask of asserted legacy IRQs.
> + * @max_regions: maximum number of regions supported by hardware
> + */
> +struct rockchip_pcie_ep {
> +	rockchip_pcie_epc	pcie;
> +	struct pci_epc		*epc;
> +	unsigned long		ob_region_map;
> +	phys_addr_t		*ob_addr;
> +	phys_addr_t		irq_phys_addr;
> +	void __iomem		*irq_cpu_addr;
> +	u64			irq_pci_addr;
> +	u8			irq_pci_fn;
> +	u8			irq_pending;
> +	u32			max_regions;
> +};
> +
> +void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
> +				  u32 r, u32 type, u64 cpu_addr, u64 pci_addr,
> +				  size_t size, bool is_clr)
> +{
> +	u64 sz = 1ULL << fls64(size - 1);
> +	int num_pass_bits = ilog2(sz);
> +	u32 addr0, addr1, desc0, desc1;
> +	bool is_nor_msg = (type == AXI_WRAPPER_NOR_MSG);
> +
> +	if (is_clr) {
> +		rockchip_pcie_write(rockchip, 0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
> +		rockchip_pcie_write(rockchip, 0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
> +		rockchip_pcie_write(rockchip, 0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
> +		rockchip_pcie_write(rockchip, 0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
> +		rockchip_pcie_write(rockchip, 0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(r));
> +		rockchip_pcie_write(rockchip, 0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r));
> +		return;
> +	}
> +
> +	/* The minimal region size is 1MB */
> +	if (num_pass_bits < 8)
> +		num_pass_bits = 8;
> +
> +	cpu_addr -= rockchip->mem_res->start;
> +	addr0 = ((is_nor_msg ? 0x10 : (num_pass_bits - 1)) &
> +		PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
> +		(lower_32_bits(cpu_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
> +	addr1 = upper_32_bits(is_nor_msg ? cpu_addr : pci_addr);
> +	desc0 = ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(fn) | type;
> +	desc1 = 0;
> +
> +	if (is_nor_msg) {
> +		rockchip_pcie_write(rockchip, 0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
> +		rockchip_pcie_write(rockchip, 0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
> +		rockchip_pcie_write(rockchip, desc0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
> +		rockchip_pcie_write(rockchip, desc1,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
> +	} else {
> +		/* PCI bus address region */
> +		rockchip_pcie_write(rockchip, addr0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r));
> +		rockchip_pcie_write(rockchip, addr1,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r));
> +		rockchip_pcie_write(rockchip, desc0,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r));
> +		rockchip_pcie_write(rockchip, desc1,
> +				    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r));
> +
> +		addr0 =
> +		    ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
> +		    (lower_32_bits(cpu_addr) &
> +		     PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
> +		addr1 = upper_32_bits(cpu_addr);
> +	}
> +
> +	/* CPU bus address region */
> +	rockchip_pcie_write(rockchip, addr0,
> +			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(r));
> +	rockchip_pcie_write(rockchip, addr1,
> +			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r));
> +}
> +
> +static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
> +					 struct pci_epf_header *hdr)
> +{
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct rockchip_pcie *rockchip = &ep->pcie;
> +
> +	/* All functions share the same vendor ID with function 0 */
> +	if (fn == 0) {
> +		u32 vid_regs = (hdr->vendorid & GENMASK(15, 0)) |
> +			       (hdr->subsys_vendor_id & GENMASK(31, 16)) << 16;
> +
> +		rockchip_pcie_write(rockchip, vid_regs,
> +				    PCIE_CORE_CONFIG_VENDOR);
> +	}
> +
> +	rockchip_pcie_write(rockchip, hdr->deviceid << 16,
> +			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) + PCI_VENDOR_ID);
> +
> +	rockchip_pcie_write(rockchip,
> +			    hdr->revid |
> +			    hdr->progif_code << 8 |
> +			    hdr->subclass_code << 16 |
> +			    hdr->baseclass_code << 24,
> +			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) + PCI_REVISION_ID);
> +	rockchip_pcie_write(rockchip, hdr->cache_line_size,
> +			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +			    PCI_CACHE_LINE_SIZE);
> +	rockchip_pcie_write(rockchip, hdr->subsys_id << 16,
> +			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +			    PCI_SUBSYSTEM_VENDOR_ID);
> +	rockchip_pcie_write(rockchip, hdr->interrupt_pin << 8,
> +			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +			    PCI_INTERRUPT_LINE);
> +
> +	return 0;
> +
> +}
> +
> +static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
> +				    enum pci_barno bar, dma_addr_t bar_phys,
> +				    size_t size, int flags)
> +{
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct rockchip_pcie *rockchip = &ep->pcie;
> +	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
> +	u64 sz;
> +
> +	/* BAR size is 2^(aperture + 7) */
> +	sz = max_t(size_t, size, MIN_EP_APERTURE);
> +
> +	/*
> +	 * roundup_pow_of_two() returns an unsigned long, which is not suited
> +	 * for 64bit values.
> +	 */
> +	sz = 1ULL << fls64(sz - 1);
> +	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
> +
> +	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
> +		ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS;
> +	} else {
> +		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> +		bool is_64bits = sz > SZ_2G;
> +
> +		if (is_64bits && (bar & 1))
> +			return -EINVAL;
> +
> +		if (is_64bits && is_prefetch)
> +			ctrl =
> +			    ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
> +		else if (is_prefetch)
> +			ctrl =
> +			    ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
> +		else if (is_64bits)
> +			ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_64BITS;
> +		else
> +			ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_32BITS;
> +	}
> +
> +	if (bar < BAR_4) {
> +		reg = ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG0(fn);
> +		b = bar;
> +	} else {
> +		reg = ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG1(fn);
> +		b = bar - BAR_4;
> +	}
> +
> +	addr0 = lower_32_bits(bar_phys);
> +	addr1 = upper_32_bits(bar_phys);
> +
> +	cfg = rockchip_pcie_read(rockchip, reg);
> +	cfg &= ~(ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
> +		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
> +	cfg |= (ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
> +		ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
> +
> +	rockchip_pcie_write(rockchip, cfg, reg);
> +	rockchip_pcie_write(rockchip, addr0,
> +			    ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar));
> +	rockchip_pcie_write(rockchip, addr1,
> +			    ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar));
> +
> +	return 0;
> +}
> +
> +static void rockchip_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
> +				       enum pci_barno bar)
> +{
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct rockchip_pcie *rockchip = &ep->pcie;
> +	u32 reg, cfg, b, ctrl;
> +
> +	if (bar < BAR_4) {
> +		reg = ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG0(fn);
> +		b = bar;
> +	} else {
> +		reg = ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG1(fn);
> +		b = bar - BAR_4;
> +	}
> +
> +	ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_DISABLED;
> +	cfg = rockchip_pcie_read(rockchip, reg);
> +	cfg &= ~(ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
> +		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
> +	cfg |= ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl);
> +
> +	rockchip_pcie_write(rockchip, cfg, reg);
> +	rockchip_pcie_write(rockchip, 0x0,
> +			    ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar));
> +	rockchip_pcie_write(rockchip, 0x0,
> +			    ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar));
> +
> +}
> +
> +static int rockchip_pcie_ep_map_addr(struct pci_epc *epc, u8 fn,
> +				     phys_addr_t addr, u64 pci_addr,
> +				     size_t size)
> +{
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct rockchip_pcie *pcie = &ep->pcie;
> +	u32 r;
> +
> +	r = find_first_zero_bit(&ep->ob_region_map,
> +				sizeof(ep->ob_region_map) * BITS_PER_LONG);
> +	if (r >= ep->max_regions - 1) {
> +		dev_err(&epc->dev, "no free outbound region\n");
> +		return -EINVAL;
> +	}
> +
> +	rockchip_pcie_prog_ep_ob_atu(pcie, fn, r, AXI_WRAPPER_MEM_WRITE, addr,
> +				     pci_addr, size, false);
> +
> +	set_bit(r, &ep->ob_region_map);
> +	ep->ob_addr[r] = addr;
> +
> +	return 0;
> +
> +}
> +
> +static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
> +					phys_addr_t addr)
> +{
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct rockchip_pcie *rockchip = &ep->pcie;
> +	u32 r;
> +
> +	for (r = 0; r < ep->max_regions - 1; r++)
> +		if (ep->ob_addr[r] == addr)
> +			break;
> +
> +	if (r == ep->max_regions - 1)
> +		return;
> +
> +	rockchip_pcie_prog_ep_ob_atu(rockchip, 0, 0, 0, 0, 0, 0, true);
> +
> +	ep->ob_addr[r] = 0;
> +	clear_bit(r, &ep->ob_region_map);
> +}
> +
> +static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn,
> +				    u8 multi_msg_cap)
> +{
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct rockchip_pcie *rockchip = &ep->pcie;
> +	u16 flags;
> +
> +	flags = rockchip_pcie_read(rockchip,
> +				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +				   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> +	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK;
> +	flags |=
> +	   ((multi_msg_cap << 1) <<  ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |
> +	   PCI_MSI_FLAGS_64BIT;
> +	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP;
> +	rockchip_pcie_write(rockchip, flags,
> +			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +			    ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> +	return 0;
> +}
> +
> +static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
> +{
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct rockchip_pcie *rockchip = &ep->pcie;
> +	u16 flags;
> +
> +	flags = rockchip_pcie_read(rockchip,
> +				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +				   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> +	if (!(flags & ROCKCHIP_PCIE_EP_MSI_CTRL_ME))
> +		return -EINVAL;
> +
> +	return ((flags & ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK) >>
> +			ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET);
> +}
> +
> +static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
> +					 u8 intx, bool is_asserted)
> +{
> +	struct rockchip_pcie *rockchip = &ep->pcie;
> +	u32 r = ep->max_regions - 1;
> +	u32 offset;
> +	u16 status;
> +	u8 msg_code;
> +
> +	if (unlikely(ep->irq_pci_addr != ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR ||
> +		     ep->irq_pci_fn != fn)) {
> +		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
> +					     AXI_WRAPPER_NOR_MSG,
> +					     ep->irq_phys_addr, 0, 0, false);
> +		ep->irq_pci_addr = ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR;
> +		ep->irq_pci_fn = fn;
> +	}
> +
> +	intx &= 3;
> +	if (is_asserted) {
> +		ep->irq_pending |= BIT(intx);
> +		msg_code = ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA + intx;
> +	} else {
> +		ep->irq_pending &= ~BIT(intx);
> +		msg_code = ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA + intx;
> +	}
> +
> +	status = rockchip_pcie_read(rockchip,
> +				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +				    ROCKCHIP_PCIE_EP_CMD_STATUS);
> +	status &= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
> +
> +	if ((status != 0) ^ (ep->irq_pending != 0)) {
> +		status ^= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
> +		rockchip_pcie_write(rockchip, status,
> +				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +				    ROCKCHIP_PCIE_EP_CMD_STATUS);
> +	}
> +
> +	offset =
> +	   ROCKCHIP_PCIE_MSG_ROUTING(ROCKCHIP_PCIE_MSG_ROUTING_LOCAL_INTX) |
> +	   ROCKCHIP_PCIE_MSG_CODE(msg_code) | ROCKCHIP_PCIE_MSG_NO_DATA;
> +	writel(0, ep->irq_cpu_addr + offset);
> +}
> +
> +static int rockchip_pcie_ep_send_legacy_irq(struct rockchip_pcie_ep *ep, u8 fn,
> +					    u8 intx)
> +{
> +	u16 cmd;
> +
> +	cmd = rockchip_pcie_read(&ep->pcie,
> +				 ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +				 ROCKCHIP_PCIE_EP_CMD_STATUS);
> +
> +	if (cmd & PCI_COMMAND_INTX_DISABLE)
> +		return -EINVAL;
> +
> +	rockchip_pcie_ep_assert_intx(ep, fn, intx, true);
> +	mdelay(1);
> +	rockchip_pcie_ep_assert_intx(ep, fn, intx, false);
> +	return 0;
> +}
> +
> +static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
> +					 u8 interrupt_num)
> +{
> +	struct rockchip_pcie *rockchip = &ep->pcie;
> +	u16 flags, mme, data, data_mask;
> +	u8 msi_count;
> +	u64 pci_addr, pci_addr_mask = 0xff;
> +
> +	/* Check MSI enable bit */
> +	flags = rockchip_pcie_read(&ep->pcie,
> +				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +				   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> +	if (!(flags & ROCKCHIP_PCIE_EP_MSI_CTRL_ME))
> +		return -EINVAL;
> +
> +	/* Get MSI numbers from MME */
> +	mme = ((flags & ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK) >>
> +			ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET);
> +	msi_count = 1 << mme;
> +	if (!interrupt_num || interrupt_num > msi_count)
> +		return -EINVAL;
> +
> +	/* Set MSI private data */
> +	data_mask = msi_count - 1;
> +	data = rockchip_pcie_read(rockchip,
> +				  ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +				  ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
> +				  PCI_MSI_DATA_64);
> +	data = (data & ~data_mask) | ((interrupt_num - 1) & data_mask);
> +
> +	/* Get MSI PCI address */
> +	pci_addr = rockchip_pcie_read(rockchip,
> +				      ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +				      ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
> +				      PCI_MSI_ADDRESS_HI);
> +	pci_addr <<= 32;
> +	pci_addr |= rockchip_pcie_read(rockchip,
> +				       ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
> +				       ROCKCHIP_PCIE_EP_MSI_CTRL_REG +
> +				       PCI_MSI_ADDRESS_LO);
> +	pci_addr &= GENMASK_ULL(63, 2);
> +
> +	/* Set the outbound region if needed. */
> +	if (unlikely(ep->irq_pci_addr != (pci_addr & ~pci_addr_mask) ||
> +		     ep->irq_pci_fn != fn)) {
> +		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, ep->max_regions - 1,
> +					     AXI_WRAPPER_MEM_WRITE,
> +					     ep->irq_phys_addr,
> +					     pci_addr & ~pci_addr_mask,
> +					     pci_addr_mask + 1, false);
> +		ep->irq_pci_addr = (pci_addr & ~pci_addr_mask);
> +		ep->irq_pci_fn = fn;
> +	}
> +
> +	writew(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
> +	return 0;
> +}
> +
> +
> +static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
> +				      enum pci_epc_irq_type type,
> +				      u8 interrupt_num)
> +{
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		return rockchip_pcie_ep_send_legacy_irq(ep, fn, 0);
> +	case PCI_EPC_IRQ_MSI:
> +		return rockchip_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int rockchip_pcie_ep_start(struct pci_epc *epc)
> +{
> +	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct rockchip_pcie *rockchip = &ep->pcie;
> +	struct pci_epf *epf;
> +	u32 cfg;
> +
> +	cfg = BIT(0);
> +	list_for_each_entry(epf, &epc->pci_epf, list)
> +		cfg |= BIT(epf->func_no);
> +
> +	rockchip_pcie_write(rockchip, cfg, PCIE_CORE_PHY_FUNC_CFG);
> +
> +	list_for_each_entry(epf, &epc->pci_epf, list)
> +		pci_epf_linkup(epf);
> +
> +	return 0;
> +}
> +
> +static const struct pci_epc_ops rockchip_pcie_epc_ops = {
> +	.write_header	= rockchip_pcie_ep_write_header,
> +	.set_bar	= rockchip_pcie_ep_set_bar,
> +	.clear_bar	= rockchip_pcie_ep_clear_bar,
> +	.map_addr	= rockchip_pcie_ep_map_addr,
> +	.unmap_addr	= rockchip_pcie_ep_unmap_addr,
> +	.set_msi	= rockchip_pcie_ep_set_msi,
> +	.get_msi	= rockchip_pcie_ep_get_msi,
> +	.raise_irq	= rockchip_pcie_ep_raise_irq,
> +	.start		= rockchip_pcie_ep_start,
> +};
> +
> +/**
> + * rockchip_pcie_parse_dt - Parse Device Tree
> + * @rockchip: PCIe port information
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int rockchip_pcie_parse_ep_dt(struct rockchip_pcie *rockchip,
> +				     struct rockchip_pcie_ep *ep)
> +{
> +	struct device *dev = rockchip->dev;
> +	int err;
> +
> +	err = rockchip_pcie_parse_dt(rockchip);
> +	if (err)
> +		return err;
> +
> +	err = rockchip_pcie_get_phys(rockchip);
> +	if (err)
> +		return err;
> +
> +	err = of_property_read_u32(dev->of_node,
> +				   "rockchip,max-outbound-regions",
> +				   &ep->max_regions);
> +	if (err < 0 || ep->max_regions > MAX_REGION_LIMIT)
> +		ep->max_regions = MAX_REGION_LIMIT;
> +
> +	err = of_property_read_u8(dev->of_node, "max-functions",
> +				  &ep->epc->max_functions);
> +	if (err < 0)
> +		ep->epc->max_functions = 1;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rockchip_pcie_ep_of_match[] = {
> +	{ .compatible = "rockchip,rk3399-pcie-ep"},
> +	{},
> +};
> +
> +static int rockchip_pcie_ep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_pcie_ep *ep;
> +	rockchip_pcie_epc *rockchip;
> +	struct pci_epc *epc;
> +	size_t max_regions;
> +	int err;
> +
> +	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ep);
> +
> +	rockchip = &ep->pcie;
> +	rockchip->is_rc = false;
> +	rockchip->dev = dev;
> +
> +	epc = devm_pci_epc_create(dev, &rockchip_pcie_epc_ops);
> +	if (IS_ERR(epc)) {
> +		dev_err(dev, "failed to create epc device\n");
> +		return PTR_ERR(epc);
> +	}
> +
> +	ep->epc = epc;
> +	epc_set_drvdata(epc, ep);
> +
> +	err = rockchip_pcie_parse_ep_dt(rockchip, ep);
> +	if (err)
> +		return err;
> +
> +	err = rockchip_pcie_enable_clocks(rockchip);
> +	if (err)
> +		return err;
> +
> +	err = rockchip_pcie_init_port(rockchip);
> +	if (err)
> +		goto err_disable_clocks;
> +
> +	/* Establish the link automatically */
> +	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
> +			    PCIE_CLIENT_CONFIG);
> +
> +	max_regions = ep->max_regions;
> +	ep->ob_addr = devm_kzalloc(dev, max_regions * sizeof(*ep->ob_addr),
> +				   GFP_KERNEL);
> +
> +	if (!ep->ob_addr) {
> +		err = -ENOMEM;
> +		goto err_uninit_port;
> +	}
> +
> +	/* Only enable function 0 by default */
> +	rockchip_pcie_write(rockchip, BIT(0), PCIE_CORE_PHY_FUNC_CFG);
> +
> +
> +	err = pci_epc_mem_init(epc, rockchip->mem_res->start,
> +			       resource_size(rockchip->mem_res));
> +	if (err < 0) {
> +		dev_err(dev, "failed to initialize the memory space\n");
> +		goto err_uninit_port;
> +	}
> +
> +	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
> +						  SZ_128K);
> +	if (!ep->irq_cpu_addr) {
> +		dev_err(dev, "failed to reserve memory space for MSI\n");
> +		err = -ENOMEM;
> +		goto err_epc_mem_exit;
> +	}
> +
> +	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
> +
> +	return 0;
> +err_epc_mem_exit:
> +	pci_epc_mem_exit(epc);
> +err_uninit_port:
> +	rockchip_pcie_deinit_phys(rockchip);
> +err_disable_clocks:
> +	rockchip_pcie_disable_clocks(rockchip);
> +	return err;
> +}
> +
> +static struct platform_driver rockchip_pcie_ep_driver = {
> +	.driver = {
> +		.name = "rockchip-pcie-ep",
> +		.of_match_table = rockchip_pcie_ep_of_match,
> +	},
> +	.probe = rockchip_pcie_ep_probe,
> +};
> +
> +builtin_platform_driver(rockchip_pcie_ep_driver);
> diff --git a/drivers/pci/rockchip/pcie-rockchip.c b/drivers/pci/rockchip/pcie-rockchip.c
> index d03508c..1d38ad7 100644
> --- a/drivers/pci/rockchip/pcie-rockchip.c
> +++ b/drivers/pci/rockchip/pcie-rockchip.c
> @@ -29,15 +29,22 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	struct resource *regs;
>  	int err;
>  
> -	regs = platform_get_resource_byname(pdev,
> -					    IORESOURCE_MEM,
> -					    "axi-base");
> -	rockchip->reg_base = devm_pci_remap_cfg_resource(dev, regs);
> -	if (IS_ERR(rockchip->reg_base))
> -		return PTR_ERR(rockchip->reg_base);
> -
> -	regs = platform_get_resource_byname(pdev,
> -					    IORESOURCE_MEM,
> +	if (rockchip->is_rc) {
> +		regs = platform_get_resource_byname(pdev,
> +						    IORESOURCE_MEM,
> +						    "axi-base");
> +		rockchip->reg_base = devm_pci_remap_cfg_resource(dev, regs);
> +		if (IS_ERR(rockchip->reg_base))
> +			return PTR_ERR(rockchip->reg_base);
> +	} else {
> +		rockchip->mem_res =
> +			platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						     "mem-base");
> +		if (!rockchip->mem_res)
> +			return -EINVAL;
> +	}
> +
> +	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  					    "apb-base");
>  	rockchip->apb_base = devm_ioremap_resource(dev, regs);
>  	if (IS_ERR(rockchip->apb_base))
> diff --git a/drivers/pci/rockchip/pcie-rockchip.h b/drivers/pci/rockchip/pcie-rockchip.h
> index af3e74f..f4bfc22 100644
> --- a/drivers/pci/rockchip/pcie-rockchip.h
> +++ b/drivers/pci/rockchip/pcie-rockchip.h
> @@ -23,6 +23,9 @@
>  
>  #define ENCODE_LANES(x)			((((x) >> 1) & 3) << 4)
>  #define MAX_LANE_NUM			4
> +#define MAX_REGION_LIMIT		32
> +#define MIN_EP_APERTURE			28
> +
>  
>  #define PCIE_CLIENT_BASE		0x0
>  #define PCIE_CLIENT_CONFIG		(PCIE_CLIENT_BASE + 0x00)
> @@ -109,7 +112,14 @@
>  #define   PCIE_CORE_INT_MMVC			BIT(19)
>  #define PCIE_CORE_CONFIG_VENDOR		(PCIE_CORE_CTRL_MGMT_BASE + 0x44)
>  #define PCIE_CORE_INT_MASK		(PCIE_CORE_CTRL_MGMT_BASE + 0x210)
> +#define PCIE_CORE_PHY_FUNC_CFG	(PCIE_CORE_CTRL_MGMT_BASE + 0x2c0)
>  #define PCIE_RC_BAR_CONF		(PCIE_CORE_CTRL_MGMT_BASE + 0x300)
> +#define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_DISABLED			0x0
> +#define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS			0x1
> +#define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_32BITS			0x4
> +#define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x5
> +#define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_64BITS			0x6
> +#define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0x7
>  
>  #define PCIE_CORE_INT \
>  		(PCIE_CORE_INT_PRFPE | PCIE_CORE_INT_CRFPE | \
> @@ -120,6 +130,7 @@
>  		 PCIE_CORE_INT_CT | PCIE_CORE_INT_UTC | \
>  		 PCIE_CORE_INT_MMVC)
>  
> +#define PCIE_RC_RP_ATS_BASE			0x400000
>  #define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
>  #define PCIE_RC_CONFIG_BASE		0xa00000
>  #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
> @@ -188,6 +199,85 @@
>  #define RC_REGION_0_TYPE_MASK			GENMASK(3, 0)
>  #define MAX_AXI_WRAPPER_REGION_NUM		33
>  
> +
> +#define ROCKCHIP_PCIE_MSG_ROUTING_TO_RC			0x0
> +#define ROCKCHIP_PCIE_MSG_ROUTING_VIA_ADDR		0x1
> +#define ROCKCHIP_PCIE_MSG_ROUTING_VIA_ID		0x2
> +#define ROCKCHIP_PCIE_MSG_ROUTING_BROADCAST		0x3
> +#define ROCKCHIP_PCIE_MSG_ROUTING_LOCAL_INTX		0x4
> +#define ROCKCHIP_PCIE_MSG_ROUTING_PME_ACK		0x5
> +#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA		0x20
> +#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTB		0x21
> +#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTC		0x22
> +#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTD		0x23
> +#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA		0x24
> +#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTB		0x25
> +#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTC		0x26
> +#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTD		0x27
> +#define ROCKCHIP_PCIE_MSG_ROUTING_MASK			GENMASK(7, 5)
> +#define ROCKCHIP_PCIE_MSG_ROUTING(route) \
> +	(((route) << 5) & ROCKCHIP_PCIE_MSG_ROUTING_MASK)
> +#define ROCKCHIP_PCIE_MSG_CODE_MASK			GENMASK(15, 8)
> +#define ROCKCHIP_PCIE_MSG_CODE(code) \
> +	(((code) << 8) & ROCKCHIP_PCIE_MSG_CODE_MASK)
> +#define ROCKCHIP_PCIE_MSG_NO_DATA			BIT(16)
> +
> +
> +#define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
> +#define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
> +#define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
> +#define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
> +#define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
> +#define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET		20
> +#define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK		GENMASK(22, 20)
> +#define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
> +#define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
> +#define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
> +#define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
> +#define ROCKCHIP_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
> +#define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
> +		(PCIE_RC_RP_ATS_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
> +#define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
> +		(PCIE_RC_RP_ATS_BASE + 0x0844 + (fn) * 0x0040 + (bar) * 0x0008)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
> +		(PCIE_RC_RP_ATS_BASE + 0x0000 + ((r) & 0x1f) * 0x0020)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(19, 12)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
> +		(((devfn) << 12) & \
> +		 ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(27, 20)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
> +		(((bus) << 20) & ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
> +		(PCIE_RC_RP_ATS_BASE + 0x0004 + ((r) & 0x1f) * 0x0020)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID	BIT(23)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK	GENMASK(31, 24)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN(devfn) \
> +		(((devfn) << 24) & ROCKCHIP_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_DESC0(r) \
> +		(PCIE_RC_RP_ATS_BASE + 0x0008 + ((r) & 0x1f) * 0x0020)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_DESC1(r)	\
> +		(PCIE_RC_RP_ATS_BASE + 0x000c + ((r) & 0x1f) * 0x0020)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
> +		(PCIE_RC_RP_ATS_BASE + 0x0018 + ((r) & 0x1f) * 0x0020)
> +#define ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
> +		(PCIE_RC_RP_ATS_BASE + 0x001c + ((r) & 0x1f) * 0x0020)
> +
> +#define ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG0(fn) \
> +		(PCIE_CORE_CTRL_MGMT_BASE + 0x0240 + (fn) * 0x0008)
> +#define ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG1(fn) \
> +		(PCIE_CORE_CTRL_MGMT_BASE + 0x0244 + (fn) * 0x0008)
> +#define ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) \
> +		(GENMASK(4, 0) << ((b) * 8))
> +#define ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
> +		(((a) << ((b) * 8)) & \
> +		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b))
> +#define ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b) \
> +		(GENMASK(7, 5) << ((b) * 8))
> +#define ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
> +		(((c) << ((b) * 8 + 5)) & \
> +		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
> +
>  struct rockchip_pcie {
>  	void	__iomem *reg_base;		/* DT axi-base */
>  	void	__iomem *apb_base;		/* DT apb-base */
> @@ -225,8 +315,10 @@ struct rockchip_pcie {
>  	phys_addr_t msg_bus_addr;
>  	phys_addr_t mem_bus_addr;
>  	bool is_rc;
> +	struct resource *mem_res;
>  };
>  
> +typedef struct rockchip_pcie rockchip_pcie_epc;
>  
>  static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
>  {
> -- 
> 1.9.1
> 
> 
