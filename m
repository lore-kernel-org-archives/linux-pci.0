Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Nov 2015 17:35:56 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<michals@xilinx.com>, <sorenb@xilinx.com>, <bhelgaas@google.com>,
	<arnd@arndb.de>, <tinamdar@apm.com>, <treding@nvidia.com>,
	<rjui@broadcom.com>, <Minghuan.Lian@freescale.com>,
	<m-karicheri2@ti.com>, <hauke@hauke-m.de>, <dhdang@apm.com>,
	<sbranden@broadcom.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Bharat Kumar Gogada" <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v9] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Message-ID: <20151124173556.18aff6b5@arm.com>
In-Reply-To: <1447911323-12567-1-git-send-email-bharatku@xilinx.com>
References: <1447911323-12567-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 19 Nov 2015 11:05:23 +0530
Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:

> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v9:
> - Modified logic in nwl_irq_domain_alloc to check availabilty of contiguous
> hw irq for multi MSI.
> - Removed allocation of page for MSI address, using dummy address.
> ---
>  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   68 ++
>  drivers/pci/host/Kconfig                           |   10 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pcie-xilinx-nwl.c                 | 1100 ++++++++++++++++++++
>  4 files changed, 1179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> new file mode 100644
> index 0000000..3b2a9ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> @@ -0,0 +1,68 @@
> +* Xilinx NWL PCIe Root Port Bridge DT description
> +
> +Required properties:
> +- compatible: Should contain "xlnx,nwl-pcie-2.11"
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- reg: Should contain Bridge, PCIe Controller registers location,
> +	configuration sapce, and length
> +- reg-names: Must include the following entries:
> +	"breg": bridge registers
> +	"pcireg": PCIe controller registers
> +	"cfg": configuration space region
> +- device_type: must be "pci"
> +- interrupts: Should contain NWL PCIe interrupt
> +- interrupt-names: Must include the following entries:
> +	"msi1, msi0": interrupt asserted when msi is received
> +	"intx": interrupt that is asserted when an legacy interrupt is received
> +	"misc": interrupt asserted when miscellaneous is received
> +- interrupt-map-mask and interrupt-map: standard PCI properties to define the
> +	mapping of the PCI interface to interrupt numbers.
> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +	supported by hardware)
> +	Please refer to the standard PCI bus binding document for a more
> +	detailed explanation
> +- msi-controller: indicates that this is MSI controller node
> +- msi-parent:  MSI parent of the root complex itself
> +- legacy-interrupt-controller: Interrupt controller device node for Legacy interrupts
> +	- interrupt-controller: identifies the node as an interrupt controller
> +	- #interrupt-cells: should be set to 1
> +	- #address-cells: specifies the number of cells needed to encode an
> +		address. The value must be 0.
> +
> +
> +Example:
> +++++++++
> +
> +nwl_pcie: pcie@fd0e0000 {
> +	#address-cells = <3>;
> +	#size-cells = <2>;
> +	compatible = "xlnx,nwl-pcie-2.11";
> +	#interrupt-cells = <1>;
> +	msi-controller;
> +	device_type = "pci";
> +	interrupt-parent = <&gic>;
> +	interrupts = <0 114 4>, <0 115 4>, <0 116 4>, <0 117 4>, <0 118 4>;
> +	interrupt-names = "msi0", "msi1", "intx", "dummy", "misc";
> +	interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +	interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
> +			<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
> +			<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
> +			<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
> +
> +	msi-parent = <&nwl_pcie>;
> +	reg = <0x0 0xfd0e0000 0x1000>,
> +	      <0x0 0xfd480000 0x1000>,
> +	      <0x0 0xe0000000 0x1000000>;
> +	reg-names = "breg", "pcireg", "cfg";
> +	ranges = <0x02000000 0x00000000 0xe1000000 0x00000000 0xe1000000 0 0x0f000000>;
> +
> +	pcie_intc: legacy-interrupt-controller {
> +		interrupt-controller;
> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +	};
> +
> +};
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index d5e58ba..24cbcba 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -15,6 +15,16 @@ config PCI_MVEBU
>  	depends on ARCH_MVEBU || ARCH_DOVE
>  	depends on OF
>  
> +config PCIE_XILINX_NWL
> +	bool "NWL PCIe Core"
> +	depends on ARCH_ZYNQMP
> +	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
> +	help
> +	 Say 'Y' here if you want kernel to support for Xilinx
> +	 NWL PCIe controller. The controller can act as Root Port
> +	 or End Point. The current option selection will only
> +	 support root port enabling.
> +
>  config PCIE_DW
>  	bool
>  
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 140d66f..6a56df7 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
> +obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
>  obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
>  obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> new file mode 100644
> index 0000000..661f2e1
> --- /dev/null
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -0,0 +1,1100 @@
> +/*
> + * PCIe host controller driver for NWL PCIe Bridge
> + * Based on pcie-xilinx.c, pci-tegra.c
> + *
> + * (C) Copyright 2014 - 2015, Xilinx, Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/irqchip/chained_irq.h>
> +
> +/* Bridge core config registers */
> +#define BRCFG_PCIE_RX0			0x00000000
> +#define BRCFG_PCIE_RX1			0x00000004
> +#define BRCFG_AXI_MASTER		0x00000008
> +#define BRCFG_PCIE_TX			0x0000000C
> +#define BRCFG_INTERRUPT			0x00000010
> +#define BRCFG_RAM_DISABLE0		0x00000014
> +#define BRCFG_RAM_DISABLE1		0x00000018
> +#define BRCFG_PCIE_RELAXED_ORDER	0x0000001C
> +#define BRCFG_PCIE_RX_MSG_FILTER	0x00000020
> +
> +/* Attribute registers */
> +#define NWL_ATTRIB_100			0x00000190
> +
> +/* Egress - Bridge translation registers */
> +#define E_BREG_CAPABILITIES		0x00000200
> +#define E_BREG_STATUS			0x00000204
> +#define E_BREG_CONTROL			0x00000208
> +#define E_BREG_BASE_LO			0x00000210
> +#define E_BREG_BASE_HI			0x00000214
> +#define E_ECAM_CAPABILITIES		0x00000220
> +#define E_ECAM_STATUS			0x00000224
> +#define E_ECAM_CONTROL			0x00000228
> +#define E_ECAM_BASE_LO			0x00000230
> +#define E_ECAM_BASE_HI			0x00000234
> +
> +/* Ingress - address translations */
> +#define I_MSII_CAPABILITIES		0x00000300
> +#define I_MSII_CONTROL			0x00000308
> +#define I_MSII_BASE_LO			0x00000310
> +#define I_MSII_BASE_HI			0x00000314
> +
> +#define I_ISUB_CONTROL			0x000003E8
> +#define SET_ISUB_CONTROL		BIT(0)
> +/* Rxed msg fifo  - Interrupt status registers */
> +#define MSGF_MISC_STATUS		0x00000400
> +#define MSGF_MISC_MASK			0x00000404
> +#define MSGF_LEG_STATUS			0x00000420
> +#define MSGF_LEG_MASK			0x00000424
> +#define MSGF_MSI_STATUS_LO		0x00000440
> +#define MSGF_MSI_STATUS_HI		0x00000444
> +#define MSGF_MSI_MASK_LO		0x00000448
> +#define MSGF_MSI_MASK_HI		0x0000044C
> +#define MSGF_RX_FIFO_POP		0x00000484
> +#define MSGF_RX_FIFO_TYPE		0x00000488
> +#define MSGF_RX_FIFO_ADDRLO		0x00000490
> +#define MSGF_RX_FIFO_ADDRHI		0x00000494
> +#define MSGF_RX_FIFO_DATA		0x00000498
> +
> +/* Msg filter mask bits */
> +#define CFG_ENABLE_PM_MSG_FWD		BIT(1)
> +#define CFG_ENABLE_INT_MSG_FWD		BIT(2)
> +#define CFG_ENABLE_ERR_MSG_FWD		BIT(3)
> +#define CFG_ENABLE_SLT_MSG_FWD		BIT(5)
> +#define CFG_ENABLE_VEN_MSG_FWD		BIT(7)
> +#define CFG_ENABLE_OTH_MSG_FWD		BIT(13)
> +#define CFG_ENABLE_VEN_MSG_EN		BIT(14)
> +#define CFG_ENABLE_VEN_MSG_VEN_INV	BIT(15)
> +#define CFG_ENABLE_VEN_MSG_VEN_ID	GENMASK(31, 16)
> +#define CFG_ENABLE_MSG_FILTER_MASK	(CFG_ENABLE_PM_MSG_FWD | \
> +					CFG_ENABLE_INT_MSG_FWD | \
> +					CFG_ENABLE_ERR_MSG_FWD | \
> +					CFG_ENABLE_SLT_MSG_FWD | \
> +					CFG_ENABLE_VEN_MSG_FWD | \
> +					CFG_ENABLE_OTH_MSG_FWD | \
> +					CFG_ENABLE_VEN_MSG_EN | \
> +					CFG_ENABLE_VEN_MSG_VEN_INV | \
> +					CFG_ENABLE_VEN_MSG_VEN_ID)
> +
> +/* Misc interrupt status mask bits */
> +#define MSGF_MISC_SR_RXMSG_AVAIL	BIT(0)
> +#define MSGF_MISC_SR_RXMSG_OVER		BIT(1)
> +#define MSGF_MISC_SR_SLAVE_ERR		BIT(4)
> +#define MSGF_MISC_SR_MASTER_ERR		BIT(5)
> +#define MSGF_MISC_SR_I_ADDR_ERR		BIT(6)
> +#define MSGF_MISC_SR_E_ADDR_ERR		BIT(7)
> +
> +#define MSGF_MISC_SR_PCIE_CORE		GENMASK(18, 16)
> +#define MSGF_MISC_SR_PCIE_CORE_ERR	GENMASK(31, 20)
> +
> +#define MSGF_MISC_SR_MASKALL		(MSGF_MISC_SR_RXMSG_AVAIL | \
> +					MSGF_MISC_SR_RXMSG_OVER | \
> +					MSGF_MISC_SR_SLAVE_ERR | \
> +					MSGF_MISC_SR_MASTER_ERR | \
> +					MSGF_MISC_SR_I_ADDR_ERR | \
> +					MSGF_MISC_SR_E_ADDR_ERR | \
> +					MSGF_MISC_SR_PCIE_CORE | \
> +					MSGF_MISC_SR_PCIE_CORE_ERR)
> +
> +/* Message rx fifo type mask bits */
> +#define MSGF_RX_FIFO_TYPE_MSI	(1)
> +#define MSGF_RX_FIFO_TYPE_TYPE	GENMASK(1, 0)
> +
> +/* Legacy interrupt status mask bits */
> +#define MSGF_LEG_SR_INTA		BIT(0)
> +#define MSGF_LEG_SR_INTB		BIT(1)
> +#define MSGF_LEG_SR_INTC		BIT(2)
> +#define MSGF_LEG_SR_INTD		BIT(3)
> +#define MSGF_LEG_SR_MASKALL		(MSGF_LEG_SR_INTA | MSGF_LEG_SR_INTB | \
> +					MSGF_LEG_SR_INTC | MSGF_LEG_SR_INTD)
> +
> +/* MSI interrupt status mask bits */
> +#define MSGF_MSI_SR_LO_MASK		BIT(0)
> +#define MSGF_MSI_SR_HI_MASK		BIT(0)
> +
> +#define MSII_PRESENT			BIT(0)
> +#define MSII_ENABLE			BIT(0)
> +#define MSII_STATUS_ENABLE		BIT(15)
> +
> +/* Bridge config interrupt mask */
> +#define BRCFG_INTERRUPT_MASK		BIT(0)
> +#define BREG_PRESENT			BIT(0)
> +#define BREG_ENABLE			BIT(0)
> +#define BREG_ENABLE_FORCE		BIT(1)
> +
> +/* E_ECAM status mask bits */
> +#define E_ECAM_PRESENT			BIT(0)
> +#define E_ECAM_SR_WR_PEND		BIT(16)
> +#define E_ECAM_SR_RD_PEND		BIT(0)
> +#define E_ECAM_SR_MASKALL		(E_ECAM_SR_WR_PEND | E_ECAM_SR_RD_PEND)
> +#define E_ECAM_CR_ENABLE		BIT(0)
> +#define E_ECAM_SIZE_LOC			GENMASK(20, 16)
> +#define E_ECAM_SIZE_SHIFT		16
> +#define ECAM_BUS_LOC_SHIFT		20
> +#define ECAM_DEV_LOC_SHIFT		12
> +#define NWL_ECAM_VALUE_DEFAULT		12
> +#define NWL_ECAM_SIZE_MIN		4096
> +
> +#define ATTR_UPSTREAM_FACING		BIT(6)
> +#define CFG_DMA_REG_BAR			GENMASK(2, 0)
> +
> +/* msgf_rx_fifo_pop bits */
> +#define MSGF_RX_FIFO_POP_POP	BIT(0)
> +
> +#define INT_PCI_MSI_NR			(2 * 32)
> +
> +/* Readin the PS_LINKUP */
> +#define PS_LINKUP_OFFSET			0x00000238
> +#define PCIE_PHY_LINKUP_BIT			BIT(0)
> +#define PHY_RDY_LINKUP_BIT			BIT(1)
> +#define PCIE_USER_LINKUP			0
> +#define PHY_RDY_LINKUP				1
> +#define LINKUP_ITER_CHECK			5
> +
> +/* PCIE Message Request */
> +#define TX_PCIE_MSG				0x00000620
> +#define TX_PCIE_MSG_CNTL			0x00000004
> +#define TX_PCIE_MSG_SPEC_LO			0x00000008
> +#define TX_PCIE_MSG_SPEC_HI			0x0000000C
> +#define TX_PCIE_MSG_DATA			0x00000010
> +
> +#define MSG_BUSY_BIT				BIT(8)
> +#define MSG_EXECUTE_BIT				BIT(0)
> +#define MSG_DONE_BIT				BIT(16)
> +#define MSG_DONE_STATUS_BIT			(BIT(25) | BIT(24))
> +#define RANDOM_DIGIT				0x11223344

That looks very random indeed.

> +#define PATTRN_SSLP_TLP				0x01005074
> +
> +#define EXP_CAP_BASE				0x60
> +
> +/* SSPL ERROR */
> +#define SLVERR					0x02
> +#define DECERR					0x03
> +
> +#define MSI_ADDRESS				0xDEED0000

How did you pick this value? What if it intersect with some actual RAM?
What if a device actually does DMA to that location?

Wouldn't it make sense to actually pick a real *device* address (hint:
your MSI controller itself) for this purpose, as the device will never
DMA there?


[...]

> +static int nwl_check_hwirq(struct nwl_msi *msi, int nr_irqs)
> +{
> +	int curr_pos, next_pos;
> +	u8 first = 1;
> +	int i;
> +
> +	for (i = 0; i < INT_PCI_MSI_NR; i++) {
> +		if (first) {
> +			curr_pos = find_first_zero_bit(msi->used,
> +						       INT_PCI_MSI_NR);
> +			if (curr_pos == INT_PCI_MSI_NR)
> +				return -ENOSPC;
> +			first = 0;
> +		} else {
> +			curr_pos = find_next_zero_bit(msi->used,
> +						(INT_PCI_MSI_NR - next_pos),
> +						next_pos);
> +			if (curr_pos == (INT_PCI_MSI_NR - next_pos))
> +				return -ENOSPC;
> +		}
> +		next_pos = find_next_bit(msi->used,
> +					(INT_PCI_MSI_NR - curr_pos), curr_pos);
> +		if ((next_pos - curr_pos) >= nr_irqs)
> +			break;
> +	}
> +
> +	return curr_pos;
> +}

Terrifying. See below.

> +
> +static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				unsigned int nr_irqs, void *args)
> +{
> +	struct nwl_pcie *pcie = domain->host_data;
> +	struct nwl_msi *msi = &pcie->msi;
> +	int bit;
> +	int i;
> +	int ret;
> +
> +	mutex_lock(&msi->lock);
> +	if (nr_irqs > 1) {
> +		ret = nwl_check_hwirq(msi, nr_irqs);
> +		if (ret < 0) {
> +			mutex_unlock(&msi->lock);
> +			return ret;
> +		}
> +	} else {
> +		ret = find_first_zero_bit(msi->used, INT_PCI_MSI_NR);
> +		if (ret == INT_PCI_MSI_NR) {
> +			mutex_unlock(&msi->lock);
> +			return -ENOSPC;
> +		}
> +	}

Let's be serious for a minute. What's wrong with
bitmap_find_next_zero_area, for example?

> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		bit = ret + i;
> +		set_bit(bit, msi->used);
> +
> +		irq_domain_set_info(domain, virq + i, bit, &nwl_irq_chip,
> +				domain->host_data, handle_simple_irq,
> +				NULL, NULL);
> +	}
> +	mutex_unlock(&msi->lock);
> +
> +	return 0;
> +}

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
