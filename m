Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751560AbeAPQHl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jan 2018 11:07:41 -0500
Date: Tue, 16 Jan 2018 16:07:33 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
        adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/6] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20180116160733.GA3644@e107981-ln.cambridge.arm.com>
References: <cover.1515621150.git.cyrille.pitchen@free-electrons.com>
 <990730f5c1156b3bb15f56fa877719941f219016.1515621150.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <990730f5c1156b3bb15f56fa877719941f219016.1515621150.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 10, 2018 at 11:47:35PM +0100, Cyrille Pitchen wrote:
> This patch adds support to the Cadence PCIe controller in host mode.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
>  MAINTAINERS                             |   7 +
>  drivers/pci/Kconfig                     |   1 +
>  drivers/pci/Makefile                    |   1 +
>  drivers/pci/cadence/Kconfig             |  16 ++
>  drivers/pci/cadence/Makefile            |   3 +
>  drivers/pci/cadence/pcie-cadence-host.c | 336 ++++++++++++++++++++++++++++++++
>  drivers/pci/cadence/pcie-cadence.c      |  68 +++++++
>  drivers/pci/cadence/pcie-cadence.h      | 196 +++++++++++++++++++

[...]

> +void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
> +{
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r), 0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r), 0);
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(r), 0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), 0);
> +
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), 0);
> +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
> +}

Unused function, please remove it.

> diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-cadence.h
> new file mode 100644
> index 000000000000..3a15b4016352
> --- /dev/null
> +++ b/drivers/pci/cadence/pcie-cadence.h
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe controller driver.
> +// Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> +
> +#ifndef _PCIE_CADENCE_H
> +#define _PCIE_CADENCE_H
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +
> +/*
> + * Local Management Registers
> + */
> +#define CDNS_PCIE_LM_BASE	0x00100000
> +
> +/* Vendor ID Register */
> +#define CDNS_PCIE_LM_ID		(CDNS_PCIE_LM_BASE + 0x0044)
> +#define  CDNS_PCIE_LM_ID_VENDOR_MASK	GENMASK(15, 0)
> +#define  CDNS_PCIE_LM_ID_VENDOR_SHIFT	0
> +#define  CDNS_PCIE_LM_ID_VENDOR(vid) \
> +	(((vid) << CDNS_PCIE_LM_ID_VENDOR_SHIFT) & CDNS_PCIE_LM_ID_VENDOR_MASK)
> +#define  CDNS_PCIE_LM_ID_SUBSYS_MASK	GENMASK(31, 16)
> +#define  CDNS_PCIE_LM_ID_SUBSYS_SHIFT	16
> +#define  CDNS_PCIE_LM_ID_SUBSYS(sub) \
> +	(((sub) << CDNS_PCIE_LM_ID_SUBSYS_SHIFT) & CDNS_PCIE_LM_ID_SUBSYS_MASK)
> +
> +/* Root Port Requestor ID Register */
> +#define CDNS_PCIE_LM_RP_RID	(CDNS_PCIE_LM_BASE + 0x0228)
> +#define  CDNS_PCIE_LM_RP_RID_MASK	GENMASK(15, 0)
> +#define  CDNS_PCIE_LM_RP_RID_SHIFT	0
> +#define  CDNS_PCIE_LM_RP_RID_(rid) \
> +	(((rid) << CDNS_PCIE_LM_RP_RID_SHIFT) & CDNS_PCIE_LM_RP_RID_MASK)
> +
> +/* Root Complex BAR Configuration Register */
> +#define CDNS_PCIE_LM_RC_BAR_CFG	(CDNS_PCIE_LM_BASE + 0x0300)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK	GENMASK(5, 0)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
> +	(((a) << 0) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK		GENMASK(8, 6)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(c) \
> +	(((c) << 6) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK	GENMASK(13, 9)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
> +	(((a) << 9) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_APERTURE_MASK)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK		GENMASK(16, 14)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(c) \
> +	(((c) << 14) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE	BIT(17)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_32BITS	0
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS	BIT(18)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE		BIT(19)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_16BITS		0
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS		BIT(20)
> +#define  CDNS_PCIE_LM_RC_BAR_CFG_CHECK_ENABLE		BIT(31)
> +
> +/* BAR control values applicable to both Endpoint Function and Root Complex */
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED		0x0
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS		0x1
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS		0x4
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x5
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS		0x6
> +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0x7
> +
> +
> +/*
> + * Root Port Registers (PCI configuration space for the root port function)
> + */
> +#define CDNS_PCIE_RP_BASE	0x00200000
> +
> +
> +/*
> + * Address Translation Registers
> + */
> +#define CDNS_PCIE_AT_BASE	0x00400000
> +
> +/* Region r Outbound AXI to PCIe Address Translation Register 0 */
> +#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
> +	(CDNS_PCIE_AT_BASE + 0x0000 + ((r) & 0x1f) * 0x0020)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK	GENMASK(5, 0)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
> +	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(19, 12)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
> +	(((devfn) << 12) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(27, 20)
> +#define  CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
> +	(((bus) << 20) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
> +
> +/* Region r Outbound AXI to PCIe Address Translation Register 1 */
> +#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
> +	(CDNS_PCIE_AT_BASE + 0x0004 + ((r) & 0x1f) * 0x0020)
> +
> +/* Region r Outbound PCIe Descriptor Register 0 */
> +#define CDNS_PCIE_AT_OB_REGION_DESC0(r) \
> +	(CDNS_PCIE_AT_BASE + 0x0008 + ((r) & 0x1f) * 0x0020)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MASK		GENMASK(3, 0)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM		0x2
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_IO		0x6
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0	0xa
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1	0xb
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG	0xc
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_VENDOR_MSG	0xd
> +/* Bit 23 MUST be set in RC mode. */
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID	BIT(23)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK	GENMASK(31, 24)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(devfn) \
> +	(((devfn) << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK)
> +
> +/* Region r Outbound PCIe Descriptor Register 1 */
> +#define CDNS_PCIE_AT_OB_REGION_DESC1(r)	\
> +	(CDNS_PCIE_AT_BASE + 0x000c + ((r) & 0x1f) * 0x0020)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK	GENMASK(7, 0)
> +#define  CDNS_PCIE_AT_OB_REGION_DESC1_BUS(bus) \
> +	((bus) & CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK)
> +
> +/* Region r AXI Region Base Address Register 0 */
> +#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
> +	(CDNS_PCIE_AT_BASE + 0x0018 + ((r) & 0x1f) * 0x0020)
> +#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK	GENMASK(5, 0)
> +#define  CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
> +	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK)
> +
> +/* Region r AXI Region Base Address Register 1 */
> +#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
> +	(CDNS_PCIE_AT_BASE + 0x001c + ((r) & 0x1f) * 0x0020)
> +
> +/* Root Port BAR Inbound PCIe to AXI Address Translation Register */
> +#define CDNS_PCIE_AT_IB_RP_BAR_ADDR0(bar) \
> +	(CDNS_PCIE_AT_BASE + 0x0800 + (bar) * 0x0008)
> +#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK	GENMASK(5, 0)
> +#define  CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
> +	(((nbits) - 1) & CDNS_PCIE_AT_IB_RP_BAR_ADDR0_NBITS_MASK)
> +#define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
> +	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
> +
> +enum cdns_pcie_rp_bar {
> +	RP_BAR0,
> +	RP_BAR1,
> +	RP_NO_BAR
> +};
> +
> +/**
> + * struct cdns_pcie - private data for Cadence PCIe controller drivers
> + * @reg_base: IO mapped register base
> + * @mem_res: start/end offsets in the physical system memory to map PCI accesses
> + * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
> + * @bus: In Root Complex mode, the bus number
> + */
> +struct cdns_pcie {
> +	void __iomem		*reg_base;
> +	struct resource		*mem_res;
> +	bool			is_rc;
> +	u8			bus;
> +};
> +
> +/* Register access */
> +static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
> +{
> +	writeb(value, pcie->reg_base + reg);
> +}
> +
> +static inline void cdns_pcie_writew(struct cdns_pcie *pcie, u32 reg, u16 value)
> +{
> +	writew(value, pcie->reg_base + reg);
> +}
> +
> +static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
> +{
> +	writel(value, pcie->reg_base + reg);
> +}
> +
> +static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
> +{
> +	return readl(pcie->reg_base + reg);
> +}
> +
> +/* Root Port register access */
> +static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
> +				       u32 reg, u8 value)
> +{
> +	writeb(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
> +}
> +
> +static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
> +				       u32 reg, u16 value)
> +{
> +	writew(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
> +}
> +
> +void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u32 r, bool is_io,
> +				   u64 cpu_addr, u64 pci_addr, size_t size);
> +
> +void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);

Ditto. I understand it is hard to untangle code that was written with
both EP and host bridge support in mind but, as I state below every
patch has to make sense on its own.

> +
> +#endif /* _PCIE_CADENCE_H */

Technically speaking, this 3-file (.c .h) split is not necessary and can
turn out unnecessary churn if we never merge the endpoint code -
actually you would not even need a special cadence directory, just a
host bridge driver file.

Bottom line, as you know: every patch has to be self contained.

It is already quite late -rc, I understand that changes this late
are error prone so I will accept that this file splitting is necessary
for "future" patches - if you manage to squash changes into a file I'd
appreciate though, it does not make sense to export functions that are
used in just one compilation unit (and some that are not used at all).

Thanks,
Lorenzo
