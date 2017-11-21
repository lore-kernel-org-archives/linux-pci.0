Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbdKUSA2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Nov 2017 13:00:28 -0500
Date: Tue, 21 Nov 2017 18:00:53 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: subrahmanya_lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Mingkai Hu <mingkai.hu@nxp.com>, peter.newton@nxp.com,
        minghuan.lian@nxp.com, Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>
Subject: Re: [PATCH v3] PCI: Mobiveil: Add Mobiveil PCIe Host Bridge IP
Message-ID: <20171121180053.GC15713@red-moon>
References: <e330e812-a6a1-1f72-393a-9610f334dba6@mobiveil.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e330e812-a6a1-1f72-393a-9610f334dba6@mobiveil.co.in>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please make sure you read this before a v4:

https://marc.info/?l=linux-pci&m=150905742808166&w=2

On Fri, Nov 17, 2017 at 06:21:25PM +0530, subrahmanya_lingappa wrote:
> From 6a514d9da7e58a2b9e98fa60a97d4b1bcbaeef02 Mon Sep 17 00:00:00 2001
> From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Date: Thu, 16 Nov 2017 23:56:10 -0500
> Subject: [PATCH v3] PCI: Mobiveil: Add Mobiveil PCIe Host Bridge IP driver
> 
> This is the driver for Mobiveil  AXI PCIe Host Bridge Soft IP

We need a driver succint description, following guidelines above.

> Cc: bhelgaas@google.com

Cc: format is not standard and goes below the Signed-off-by.

> v3 patch fixes:
> - spell checks
> - removed superfluous comments and headers
> - added COMPILE_TEST to Kconfig
> - removed spurious blank lines
> - removed unused functions
> - removed unused macro definitions
> - comments alignment
> - multi-line comment styles
> - removed bogus code from isr
> - made public functions static
> - made small functions inline
> - removed unnecessary functions replaced them inline
> - added irq_dispose_mapping() while  MSI tearing down
> - used upper_32_bits/lower_32_bits for bits extraction
> - removed mobiveil_pcie_remove and the children
> - removed superfluous printks
> - replaced printk with dev_info
> - replaced mobiveil_pcie_powerup_slot with mobiveil_pcie_establish_link
>   like other similar drivers
> - pci_scan_root_bus_bridge was not used to replace as testing branch is
>   4.9 version.
> - MODULE_LICENSE is fixed to "GPL v2" to align with file header
> - removed hard-coded inbound and out bound window parameters,
>   now read from device tree.

This does not belong in a commit log.

Please read the post above.

> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

Here goes the CC: list, following the same Signed-off-by: format.

> ---
>  .../devicetree/bindings/pci/mobiveil-pcie.txt      |  68 ++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  MAINTAINERS                                        |   7 +
>  drivers/pci/host/Kconfig                           |   9 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-mobiveil.c                   | 899
> +++++++++++++++++++++
>  6 files changed, 985 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-mobiveil.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> new file mode 100644
> index 0000000..c9e9818
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> @@ -0,0 +1,68 @@
> +* Mobiveil AXI PCIe Root Port Bridge DT description

Please read the DT guidelines before submitting v4:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/submitting-patches.txt?h=v4.14

Add a brief IP description.

> +Required properties:
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- compatible: Should contain "mbvl,axi-pcie-host-1.00"

See documentation above.

> +- reg: Should contain AXI PCIe registers location and length
> +- device_type: must be "pci"
> +- apio-wins : number of configured apio outbound windows
> +- ppio-wins : number of configured ppio inbound windows
> +- interrupts: Should contain AXI PCIe interrupt

What's an AXI interrupt ?

> +- interrupt-map-mask,
> +	interrupt-map: standard PCI properties to define the mapping of the
> +	PCI interface to interrupt numbers.
> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +	supported by hardware)
> +	Please refer to the standard PCI bus binding document for a more
> +	detailed explanation
> +
> +- bus-range: PCI bus numbers covered
> +
> +Interrupt controller child node
> ++++++++++++++++++++++++++++++++
> +Required properties:
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #address-cells: specifies the number of cells needed to encode an
> +	address. The value must be 0.
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +
> +NOTE:
> +The core provides a single interrupt for both INTx/MSI messages. So,
> +created a interrupt controller node to support 'interrupt-map' DT
> +functionality.  The driver will create an IRQ domain for this map, decode
> +the four INTx interrupts in ISR and route them to this domain.

DT bindings do not describe what the Linux kernel does, they describe
your HW, so please read the binding you wrote and make sure that's the
case.

> +Example:
> +++++++++
> +	pci_express: axi-pcie@a0000000 {
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		compatible = "mbvl,axi-pcie-host-1.00";
> +		reg =	< 0xa0000000 0x00001000 >,
> +			< 0xb0000000 0x00010000 >,
> +			< 0xFF000000 0x00200000 >,
> +			< 0xb0010000 0x00001000 >;
> +		reg-names =	"config_axi_slave",
> +				"csr_axi_slave",
> +				"gpio_slave",
> +				"apb_csr";
> +
> +		device_type = "pci";
> +		apio-wins = <3>;
> +		ppio-wins = <3>;
> +		interrupt-parent = <&gic>;
> +		interrupts = < 0 89 4 >;
> +		interrupt-controller;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pci_express 1>,
> +				<0 0 0 2 &pci_express 2>,
> +				<0 0 0 3 &pci_express 3>,
> +				<0 0 0 4 &pci_express 4>;
> +		ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;

Add an interrupt controller node because I want to understand how you
represent it.

I will get to the code below tomorrow.

Thanks,
Lorenzo

> +	};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index f0a48ea..be61439 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -179,6 +179,7 @@ msi	Micro-Star International Co. Ltd.
>  mti	Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
>  mundoreader	Mundo Reader S.L.
>  murata	Murata Manufacturing Co., Ltd.
> +mbvl	Mobiveil Inc.
>  mxicy	Macronix International Co., Ltd.
>  national	National Semiconductor
>  nec	NEC LCD Technologies, Ltd.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63cefa6..d7dc6c3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9336,6 +9336,13 @@ F:
> Documentation/devicetree/bindings/pci/host-generic-pci.txt
>  F:	drivers/pci/host/pci-host-common.c
>  F:	drivers/pci/host/pci-host-generic.c
> 
> +PCI DRIVER FOR MOBIVEIL PCIE IP
> +M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> +F:	drivers/pci/host/pcie-mobiveil.c
> +
>  PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
>  M:	Keith Busch <keith.busch@intel.com>
>  L:	linux-pci@vger.kernel.org
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 6f1de4f..d8fb02d 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -37,6 +37,14 @@ config PCIE_XILINX_NWL
>  	 or End Point. The current option selection will only
>  	 support root port enabling.
> 
> +config PCIE_MOBIVEIL
> +	bool "Mobiveil AXI PCIe host bridge support"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	help
> +	  Say 'Y' here if you want kernel to support the Mobiveil AXI PCIe
> +	  Host Bridge driver.
> +
>  config PCIE_DW_PLAT
>  	bool "Platform bus based DesignWare PCIe Controller"
>  	depends on PCI_MSI_IRQ_DOMAIN
> @@ -103,6 +111,7 @@ config PCI_HOST_GENERIC
>  	  Say Y here if you want to support a simple generic PCI host
>  	  controller, such as the one emulated by kvmtool.
> 
> +
>  config PCIE_SPEAR13XX
>  	bool "STMicroelectronics SPEAr PCIe controller"
>  	depends on ARCH_SPEAR13XX
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 9b113c2..d851978 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -34,3 +34,4 @@ obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>  obj-$(CONFIG_VMD) += vmd.o
> +obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
> diff --git a/drivers/pci/host/pcie-mobiveil.c
> b/drivers/pci/host/pcie-mobiveil.c
> new file mode 100644
> index 0000000..abc6adf
> --- /dev/null
> +++ b/drivers/pci/host/pcie-mobiveil.c
> @@ -0,0 +1,899 @@
> +/*
> + * PCIe host controller driver for Mobiveil PCIe Host controller
> + *
> + * Copyright Mobiveil Corporation (C) 2013-2017. All rights reserved
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public
> License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/irq.h>
> +#include <linux/msi.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/irqdomain.h>
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +
> +/* Register Offsets and Bit Positions*/
> +
> +#define WIN_NUM_0		0
> +#define WIN_NUM_1		1
> +
> +#define CFG_WINDOW_TYPE	0
> +#define IO_WINDOW_TYPE		1
> +#define MEM_WINDOW_TYPE	2
> +#define MAX_PIO_WINDOWS	8
> +
> +#define PAB_INTA_POS		5
> +#define OP_READ		0
> +#define OP_WRITE		1
> +
> +#define IB_WIN_SIZE_KB		(256*1024*1024)
> +
> +#define LTSSM_STATE_STATUS	0x0404
> +#define LTSSM_STATUS_CODE_MASK  0x3F
> +#define LTSSM_STATUS_CODE	0x2D	/* LTSSM Status Code L0 */
> +
> +#define PAB_CTRL		0x0808
> +#define  AMBA_PIO_ENABLE_SHIFT 0
> +#define  PEX_PIO_ENABLE_SHIFT	1
> +#define  PAGE_SEL_SHIFT	13
> +#define  PAGE_SEL_MASK		0x3f
> +#define  PAGE_SEL_OFFSET_SHIFT	10
> +
> +#define PAB_AXI_PIO_CTRL	0x0840
> +#define  APIO_EN_MASK		0xf
> +
> +#define PAB_PEX_PIO_CTRL	0x08C0
> +#define  PIO_ENABLE_SHIFT	0
> +#define PAB_INTP_AMBA_MISC_ENB 0x0B0C
> +#define PAB_INTP_AMBA_MISC_STAT 0x0B1C
> +#define  PAB_INTP_INTX_MASK    0x1E0	/* INTx(A-D) */
> +#define  PAB_INTP_MSI_MASK	0x8
> +
> +#define PAB_AXI_AMAP_CTRL(win_num)	(0x0BA0 + (0x10*win_num))
> +#define  WIN_ENABLE_SHIFT		0
> +#define  WIN_TYPE_SHIFT		1
> +#define  WIN_SIZE_SHIFT		10
> +#define PAB_EXT_AXI_AMAP_SIZE(win_num)  (0xBAF0 + (0x4*win_num))
> +
> +#define PAB_AXI_AMAP_AXI_WIN(win_num)	(0x0BA4 + (0x10*win_num))
> +#define  AXI_WINDOW_BASE_SHIFT    2
> +
> +#define PAB_AXI_AMAP_PEX_WIN_L(win_num)     (0x0BA8 + (0x10*win_num))
> +#define  PAB_BUS_SHIFT		24
> +#define  PAB_DEVICE_SHIFT	19
> +#define  PAB_FUNCTION_SHIFT	16
> +
> +#define PAB_AXI_AMAP_PEX_WIN_H(win_num) (0x0BAC + (0x10*win_num))
> +#define PAB_INTP_AXI_PIO_CLASS	0x474
> +
> +#define PAB_PEX_AMAP_CTRL(win_num)	(0x4BA0 + (0x10*win_num))
> +#define AMAP_CTRL_EN_SHIFT		0
> +#define AMAP_CTRL_TYPE_SHIFT		1	/* 0: interrupt, 2: memory */
> +
> +#define PAB_EXT_PEX_AMAP_SIZEN(win_num) (0xBEF0 + (0x4*win_num))
> +#define PAB_PEX_AMAP_AXI_WIN(win_num)   (0x4BA4 + (0x10*win_num))
> +#define PAB_PEX_AMAP_PEX_WIN_L(win_num) (0x4BA8 + (0x10*win_num))
> +#define PAB_PEX_AMAP_PEX_WIN_H(win_num) (0x4BAC + (0x10*win_num))
> +
> +#define PCI_NUM_INTX		4
> +#define PCI_NUM_MSI		16
> +
> +#define MSI_BASE_LO_OFFSET	0x04
> +#define MSI_BASE_HI_OFFSET	0x08
> +#define MSI_SIZE_OFFSET	0x0c
> +#define MSI_ENABLE_OFFSET	0x14
> +#define MSI_ENABLE_SHIFT	0
> +#define MSI_STATUS_OFFSET	0x18
> +#define MSI_STATUS_SHIFT	0
> +#define MSI_OCCUPANCY_OFFSET    0x1c
> +#define MSI_DATA_OFFSET	0x20
> +#define MSI_ADDR_L_OFFSET	0x24
> +#define MSI_ADDR_H_OFFSET	0x28
> +#define ilog2_u32(num) (__ffs(num)-1)
> +
> +/*
> + * PCIe port information
> + */
> +struct mobiveil_pcie {
> +	struct platform_device *pdev;
> +	void __iomem *config_axi_slave_base;	/* endpoint config base */
> +	void __iomem *csr_axi_slave_base;	/* root port config base */
> +	void __iomem *gpio_slave_base;	/* GPIO register base */
> +	void __iomem *apb_csr_base;	/* MSI register base */
> +	struct irq_domain *irq_domain;
> +	struct resource bus_range;
> +	struct list_head resources;
> +	int *msi_pages;
> +	int *msi_pages_phys;
> +	char root_bus_nr;
> +	int irq;
> +	int apio_wins;
> +	int ppio_wins;
> +	int ob_wins_configured;	/*  configured outbound windows */
> +	int ib_wins_configured;	/*  configured inbound windows */
> +	struct resource *ob_io_res;
> +	struct resource *ob_mem_res[3];
> +};
> +
> +static DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
> +
> +static inline void csr_writel(struct mobiveil_pcie *pcie,
> +			const unsigned int value, const unsigned int reg)
> +{
> +	writel_relaxed(value, pcie->csr_axi_slave_base + reg);
> +}
> +
> +static inline unsigned int csr_readl(struct mobiveil_pcie *pcie,
> +			const unsigned int reg)
> +{
> +	return readl_relaxed(pcie->csr_axi_slave_base + reg);
> +}
> +
> +static inline int gpio_read(struct mobiveil_pcie *pcie, int addr)
> +{
> +	return ioread32(pcie->gpio_slave_base + addr);
> +}
> +
> +static inline void gpio_write(struct mobiveil_pcie *pcie, int val,
> int addr)
> +{
> +	iowrite32(val, pcie->gpio_slave_base + addr);
> +	if (val != gpio_read(pcie, addr)) {
> +		dev_info(&pcie->pdev->dev,
> +			 "WARNING:gpio_write: expected : %x at: %x, found: %x\n ",
> +			 val, addr, gpio_read(pcie, addr));
> +	}
> +}
> +
> +static bool mobiveil_pcie_link_is_up(struct mobiveil_pcie *pcie)
> +{
> +	return (csr_readl(pcie, LTSSM_STATE_STATUS) &
> +		LTSSM_STATUS_CODE_MASK) == LTSSM_STATUS_CODE;
> +}
> +
> +static bool mobiveil_pcie_valid_device(struct pci_bus *bus,
> unsigned int devfn)
> +{
> +	struct mobiveil_pcie *pcie = bus->sysdata;
> +
> +	/* Check if link is up when trying to access downstream ports */
> +	if (bus->number != pcie->root_bus_nr)
> +		if (!mobiveil_pcie_link_is_up(pcie))
> +			return false;
> +
> +	/* Only one device down on each root port */
> +	if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
> +		return false;
> +
> +	/*
> +	 * Do not read more than one device on the bus directly
> +	 * attached to RC
> +	 */
> +	if ((bus->primary == pcie->root_bus_nr) && (devfn > 0))
> +		return false;
> +
> +	return true;
> +}
> +
> +/*
> + * mobiveil_pcie_map_bus - routine to get the configuration base of either
> + * root port or endpoint
> + *
> + * Relies on pci_lock serialization
> + */
> +static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
> +					   unsigned int devfn, int where)
> +{
> +	struct mobiveil_pcie *pcie = bus->sysdata;
> +	unsigned int value;
> +
> +	if (!mobiveil_pcie_valid_device(bus, devfn))
> +		return NULL;
> +
> +	if (bus->number == pcie->root_bus_nr) {
> +		/* RC config access (in CSR space) */
> +		return pcie->csr_axi_slave_base + where;
> +	} else {
> +		/*
> +		 * EP config access (in Config/APIO space)
> +		 * Program PEX Address base (31..16 bits) with appropriate value
> +		 * (BDF) in PAB_AXI_AMAP_PEX_WIN_L0 Register.
> +		 */
> +
> +		/* Relies on pci_lock serialization */
> +		value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_L(0));
> +		csr_writel(pcie,
> +			bus->number << PAB_BUS_SHIFT |
> +			(devfn >> 3) << PAB_DEVICE_SHIFT |
> +			(devfn & 7) << PAB_FUNCTION_SHIFT,
> +			PAB_AXI_AMAP_PEX_WIN_L(0));
> +		return pcie->config_axi_slave_base + where;
> +	}
> +}
> +
> +static struct pci_ops mobiveil_pcie_ops = {
> +	.map_bus = mobiveil_pcie_map_bus,
> +	.read = pci_generic_config_read,
> +	.write = pci_generic_config_write,
> +};
> +
> +static irqreturn_t mobiveil_pcie_isr(int irq, void *data)
> +{
> +	struct mobiveil_pcie *pcie = (struct mobiveil_pcie *)data;
> +	unsigned int fifo_occ;
> +	unsigned int msi_addr_l, msi_addr_h, msi_data;
> +	unsigned int status, status2;
> +	unsigned long shifted_status;
> +	unsigned int bit1 = 0, virq;
> +	unsigned int val, mask;
> +
> +	/*
> +	 * The core provides a single interrupt for both INTx/MSI messages.
> +	 * So we'll read both INTx and MSI statuses
> +	 */
> +
> +	/* read INTx status */
> +	val = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> +	mask = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
> +	status = val & mask;
> +
> +	/* Handle INTx */
> +	if (status & PAB_INTP_INTX_MASK) {
> +		while ((shifted_status =
> +			(csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT) >>
> +			 PAB_INTA_POS)) != 0) {
> +			for_each_set_bit(bit1, &shifted_status, PCI_NUM_INTX) {
> +				/* clear interrupts */
> +				csr_writel(pcie, shifted_status << PAB_INTA_POS,
> +					   PAB_INTP_AMBA_MISC_STAT);
> +
> +				virq =
> +				    irq_find_mapping(pcie->irq_domain,
> +						     bit1 + 1);
> +				if (virq)
> +					generic_handle_irq(virq);
> +				else
> +					dev_err(&pcie->pdev->dev,
> +						"unexpected IRQ, INT%d\n",
> +						bit1);
> +
> +			}
> +			shifted_status = 0;
> +		}
> +	}
> +
> +	/* read MSI status */
> +	status2 = readl(pcie->apb_csr_base + MSI_STATUS_OFFSET);
> +
> +	/* handle MSI interrupts */
> +	if ((status & PAB_INTP_MSI_MASK)
> +	    || (status2 & (1 << MSI_STATUS_SHIFT))) {
> +		do {
> +			fifo_occ = readl(pcie->apb_csr_base
> +					 + MSI_OCCUPANCY_OFFSET);
> +			msi_data = readl(pcie->apb_csr_base + MSI_DATA_OFFSET);
> +			msi_addr_l = readl(pcie->apb_csr_base
> +					   + MSI_ADDR_L_OFFSET);
> +			msi_addr_h = readl(pcie->apb_csr_base
> +					   + MSI_ADDR_H_OFFSET);
> +			/* Handle MSI */
> +			if (msi_data)
> +				generic_handle_irq(msi_data);
> +			else
> +				dev_err(&pcie->pdev->dev, "MSI data null\n");
> +
> +			status2 = readl(pcie->apb_csr_base + MSI_STATUS_OFFSET);
> +		} while ((status2 & (1 << MSI_STATUS_SHIFT)));
> +	}
> +
> +	csr_writel(pcie, status, PAB_INTP_AMBA_MISC_STAT);
> +	return IRQ_HANDLED;
> +}
> +
> +/* routine to parse device tree */
> +static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +	struct platform_device *pdev = pcie->pdev;
> +	struct device_node *node = dev->of_node;
> +	resource_size_t iobase;
> +	struct resource *res;
> +	const char *type;
> +	int err;
> +
> +	type = of_get_property(node, "device_type", NULL);
> +	if (!type || strcmp(type, "pci")) {
> +		dev_err(dev, "invalid \"device_type\" %s\n", type);
> +		return -EINVAL;
> +	}
> +
> +	/* map config resource */
> +	res =
> +	    platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +					 "config_axi_slave");
> +	pcie->config_axi_slave_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->config_axi_slave_base))
> +		return PTR_ERR(pcie->config_axi_slave_base);
> +	pcie->ob_io_res = res;
> +
> +	/* map csr resource */
> +	res =
> +	    platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr_axi_slave");
> +	pcie->csr_axi_slave_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->csr_axi_slave_base))
> +		return PTR_ERR(pcie->csr_axi_slave_base);
> +
> +	/* map gpio resource */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpio_slave");
> +	pcie->gpio_slave_base =
> +	    devm_ioremap_nocache(dev, res->start, resource_size(res));
> +	if (IS_ERR(pcie->gpio_slave_base))
> +		return PTR_ERR(pcie->gpio_slave_base);
> +
> +	/* map gpio resource */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
> +	pcie->apb_csr_base =
> +	    devm_ioremap_nocache(dev, res->start, resource_size(res));
> +	if (IS_ERR(pcie->apb_csr_base))
> +		return PTR_ERR(pcie->apb_csr_base);
> +
> +	/* read the number of windows requested */
> +	if (!pcie->apio_wins &&
> +		of_property_read_u32(node, "apio-wins", &pcie->apio_wins)) {
> +		pcie->apio_wins = MAX_PIO_WINDOWS;
> +	}
> +
> +	if (!pcie->ppio_wins &&
> +		of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins)) {
> +		pcie->ppio_wins = MAX_PIO_WINDOWS;
> +	}
> +
> +	/* map IRQ resource */
> +	pcie->irq = irq_of_parse_and_map(node, 0);
> +	err = devm_request_irq(&pdev->dev, pcie->irq, mobiveil_pcie_isr,
> +				IRQF_SHARED | IRQF_NO_THREAD,
> +				"mobiveil-pcie", pcie);
> +	if (err) {
> +		dev_err(&pdev->dev, "unable to request IRQ %d\n", pcie->irq);
> +		return err;
> +	}
> +
> +	INIT_LIST_HEAD(&pcie->resources);
> +	/* parse the host bridge base addresses from the device tree file */
> +	err = of_pci_get_host_bridge_resources(node,
> +			0, 0xff, &pcie->resources, &iobase);
> +	if (err) {
> +		dev_err(dev, "Getting bridge resources failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * access_paged_register - routine to access paged register of root complex
> + *
> + * registers of RC are paged, with pg_sel field of the PAB_CTRL
> + * register needs to be updated with page of the register, before
> + * accessing least significant 10 bits offset
> + *
> + * This routine does the PAB_CTRL updation and split access of the
> + * offset
> + *
> + */
> +static unsigned int access_paged_register(struct mobiveil_pcie *pcie,
> +					unsigned int write,
> +					unsigned int val,
> +					unsigned int offset)
> +{
> +	int pab_ctrl_dw, pg_sel;
> +	unsigned int off = (offset & 0x3FF) + 0xC00;
> +
> +	pab_ctrl_dw = csr_readl(pcie, PAB_CTRL);
> +	pg_sel = (offset >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK;
> +
> +	/* clear pg_sel field */
> +	pab_ctrl_dw = (pab_ctrl_dw & ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT));
> +
> +	/* set pg_sel field */
> +	pab_ctrl_dw |= ((pg_sel << PAGE_SEL_SHIFT));
> +	csr_writel(pcie, pab_ctrl_dw, PAB_CTRL);
> +
> +	if (write == OP_WRITE)
> +		csr_writel(pcie, val, off);
> +	else
> +		return csr_readl(pcie, off);
> +	return 0;
> +
> +}
> +
> +/*
> + * routine to program the inbound windows
> + */
> +static void program_ib_windows(struct mobiveil_pcie *pcie,
> +				int win_num,
> +				int pci_addr,
> +				int type,
> +				int size_kb)
> +{
> +	int pio_ctrl_val;
> +	int amap_ctrl_dw;
> +	u64 size64 = (-1 << (WIN_SIZE_SHIFT + ilog2_u32(size_kb)));
> +
> +	if ((pcie->ib_wins_configured + 1) > pcie->ppio_wins) {
> +		dev_err(&pcie->pdev->dev,
> +			"ERROR: trying for more than max inbound windows in device tree !\n");
> +		return;
> +	}
> +
> +	pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
> +	csr_writel(pcie,
> +		pio_ctrl_val | (1 << PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);
> +	amap_ctrl_dw =	access_paged_register(pcie,
> +				OP_READ, 0, PAB_PEX_AMAP_CTRL(win_num));
> +	amap_ctrl_dw = (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
> +	amap_ctrl_dw = (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
> +
> +	access_paged_register(pcie, OP_WRITE,
> +				amap_ctrl_dw | (size64 & 0xFFFFFFFF),
> +				PAB_PEX_AMAP_CTRL(win_num));
> +
> +	access_paged_register(pcie, OP_WRITE, upper_32_bits(size64),
> +				PAB_EXT_PEX_AMAP_SIZEN(win_num));
> +
> +	access_paged_register(pcie, OP_WRITE, pci_addr,
> +				PAB_PEX_AMAP_AXI_WIN(win_num));
> +
> +	access_paged_register(pcie, OP_WRITE, pci_addr,
> +				PAB_PEX_AMAP_PEX_WIN_L(win_num));
> +
> +	access_paged_register(pcie, OP_WRITE, 0,
> +				PAB_PEX_AMAP_PEX_WIN_H(win_num));
> +}
> +
> +/*
> + * routine to program the outbound windows
> + */
> +static void program_ob_windows(struct mobiveil_pcie *pcie,
> +				int win_num,
> +				u64 cpu_addr,
> +				u64 pci_addr,
> +				int config_io_bit,
> +				int size_kb)
> +{
> +
> +	unsigned int value, type;
> +	u64 size64 = (-1 << (WIN_SIZE_SHIFT + ilog2_u32(size_kb)));
> +
> +	if ((pcie->ob_wins_configured + 1) > pcie->apio_wins) {
> +		dev_err(&pcie->pdev->dev,
> +			"ERROR: trying for more than max outbound windows in device tree !\n");
> +		return;
> +	}
> +
> +
> +	/*
> +	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
> +	 * to 4 KB in PAB_AXI_AMAP_CTRL register
> +	 */
> +	type = config_io_bit;
> +	value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
> +	csr_writel(pcie,
> +			1 << WIN_ENABLE_SHIFT  |
> +			type << WIN_TYPE_SHIFT |
> +			lower_32_bits(size64),
> +			PAB_AXI_AMAP_CTRL(win_num));
> +
> +	access_paged_register(pcie, OP_WRITE, upper_32_bits(size64),
> +				PAB_EXT_AXI_AMAP_SIZE(win_num));
> +
> +	/*
> +	 * program AXI window base with appropriate value in
> +	 * PAB_AXI_AMAP_AXI_WIN0 register
> +	 */
> +	value = csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(win_num));
> +	csr_writel(pcie,
> +			cpu_addr >> AXI_WINDOW_BASE_SHIFT <<
> +			AXI_WINDOW_BASE_SHIFT, PAB_AXI_AMAP_AXI_WIN(win_num));
> +
> +	value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(win_num));
> +
> +	csr_writel(pcie, lower_32_bits(pci_addr),
> +			PAB_AXI_AMAP_PEX_WIN_L(win_num));
> +	csr_writel(pcie, upper_32_bits(pci_addr),
> +			PAB_AXI_AMAP_PEX_WIN_H(win_num));
> +
> +	pcie->ob_wins_configured++;
> +}
> +
> +/*
> + * routine to prepare the PCIe slot for power up
> + */
> +static void mobiveil_pcie_establish_link(struct mobiveil_pcie *pcie)
> +{
> +
> +	int secs = 4;
> +
> +	/* send PRESET to the slot */
> +	gpio_write(pcie, 0x80000000, 0xa0344);
> +	gpio_write(pcie, 0x80000000, 0xa0348);
> +	gpio_write(pcie, 0x00000000, 0xa0054);
> +	gpio_write(pcie, 0x80000000, 0xa0054);
> +	dev_info(&pcie->pdev->dev,
> +		 "mobiveil_pcie_establish_link: waiting for %d seconds\n",
> +		 secs);
> +	mdelay(secs * 1000);
> +}
> +
> +static void mobiveil_bringup_link(struct mobiveil_pcie *pcie)
> +{
> +	int reset_cnt = 0;
> +	struct device *dev = &pcie->pdev->dev;
> +
> +	if (!mobiveil_pcie_link_is_up(pcie)) {
> +		/*
> +		 * if FSBL is not patched, link won't be up so let's bring it
> +		 * up by writing DIRM and OEN registers EMIO 6:0 programming
> +		 * sequence [3:0] = Link Width; [6:4] = Link Speed. Current
> +		 * setting width=4, speed = 1
> +		 */
> +		gpio_write(pcie, 0x7f, 0xa02c4);
> +		gpio_write(pcie, 0x7f, 0xa02c8);
> +		gpio_write(pcie, 0x14, 0xa004c);
> +
> +		gpio_write(pcie, 0x0200, 0xa0244);
> +		gpio_write(pcie, 0x0200, 0xa0248);
> +		gpio_write(pcie, 0x37f7, 0x180208);
> +		gpio_write(pcie, 0xfdff, 0xa0044);
> +
> +		mdelay(2 * 1000);
> +
> +		while (!mobiveil_pcie_link_is_up(pcie)) {
> +			dev_info(dev,
> +				 "%s: PRESET retry, reset_cnt : %d\n",
> +				 __func__, reset_cnt++);
> +			mobiveil_pcie_establish_link(pcie);
> +		}
> +
> +	}
> +	dev_info(dev, "link up\n");
> +}
> +
> +static void mobiveil_setup_config_access(struct mobiveil_pcie *pcie)
> +{
> +	unsigned int value;
> +	int type = 0;
> +	int pab_ctrl;
> +	struct resource_entry *win, *tmp;
> +
> +	/*
> +	 * program Bus Master Enable Bit in Command Register in PAB Config
> +	 * Space
> +	 */
> +	value = csr_readl(pcie, PCI_COMMAND);
> +	csr_writel(pcie,
> +		value |
> +		PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
> +		PCI_COMMAND);
> +
> +	/*
> +	 * program PIO Enable Bit to 1 (and PEX PIO Enable to 1) in PAB_CTRL
> +	 * register
> +	 */
> +	pab_ctrl = csr_readl(pcie, PAB_CTRL);
> +	csr_writel(pcie, pab_ctrl | (1 << AMBA_PIO_ENABLE_SHIFT) |
> +		(1 << PEX_PIO_ENABLE_SHIFT),
> +		PAB_CTRL);
> +
> +	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> +		PAB_INTP_AMBA_MISC_ENB);
> +
> +	/* program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
> +	 * PAB_AXI_PIO_CTRL Register
> +	 */
> +	value = csr_readl(pcie, PAB_AXI_PIO_CTRL);
> +	csr_writel(pcie, value | APIO_EN_MASK, PAB_AXI_PIO_CTRL);
> +
> +	/*
> +	 * we'll program one outbound window for config reads and
> +	 * another default inbound window for all the upstream traffic
> +	 * rest of the outbound windows will be configured according to
> +	 * the "ranges" field defined in device tree
> +	 */
> +
> +	/* config outbound translation window */
> +	program_ob_windows(pcie,
> +			pcie->ob_wins_configured, pcie->ob_io_res->start,
> +			0,
> +			CFG_WINDOW_TYPE,
> +			resource_size(pcie->ob_io_res)/1024);
> +
> +	/* memory inbound  translation window */
> +	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE_KB);
> +
> +	/* Get the I/O and memory ranges from DT */
> +	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
> +		type = 0;
> +		if (resource_type(win->res) == IORESOURCE_MEM)
> +			type = MEM_WINDOW_TYPE;
> +		if (resource_type(win->res) == IORESOURCE_IO)
> +			type = IO_WINDOW_TYPE;
> +		if (type) {
> +			/* configure outbound translation window */
> +			pcie->ob_mem_res[pcie->ob_wins_configured] =  win->res;
> +			program_ob_windows(pcie,
> +				pcie->ob_wins_configured,
> +				win->res->start,
> +				0,
> +				type,
> +				resource_size(win->res)/1024);
> +		}
> +	}
> +
> +
> +
> +}
> +
> +/* routine to setup the INTx related data */
> +static int mobiveil_pcie_intx_map(struct irq_domain *domain,
> unsigned int irq,
> +				  irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	return 0;
> +}
> +
> +/* INTx domain opeartions structure */
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = mobiveil_pcie_intx_map,
> +};
> +
> +static void mobiveil_pcie_destroy_msi(unsigned int irq)
> +{
> +	struct msi_desc *msi;
> +	struct mobiveil_pcie *pcie;
> +
> +	if (!test_bit(irq, msi_irq_in_use)) {
> +		msi = irq_get_msi_desc(irq);
> +		pcie = msi_desc_to_pci_sysdata(msi);
> +		dev_info(&pcie->pdev->dev,
> +			 "Trying to free unused MSI#%d\n", irq);
> +	} else {
> +		clear_bit(irq, msi_irq_in_use);
> +	}
> +}
> +
> +static int mobiveil_pcie_assign_msi(struct mobiveil_pcie *pcie)
> +{
> +	int pos;
> +
> +	pos = find_first_zero_bit(msi_irq_in_use, PCI_NUM_MSI);
> +	if (pos < PCI_NUM_MSI)
> +		set_bit(pos, msi_irq_in_use);
> +	else
> +		return -ENOSPC;
> +
> +	return pos;
> +}
> +
> +static void mobiveil_msi_teardown_irq(struct msi_controller *chip,
> +				unsigned int irq)
> +{
> +	mobiveil_pcie_destroy_msi(irq);
> +	irq_dispose_mapping(irq);
> +}
> +
> +static int mobiveil_pcie_msi_setup_irq(struct msi_controller *chip,
> +				struct pci_dev *pdev,
> +				struct msi_desc *desc)
> +{
> +	int hwirq;
> +	unsigned int irq;
> +	struct msi_msg msg;
> +	phys_addr_t msg_addr;
> +	struct mobiveil_pcie *pcie = pdev->bus->sysdata;
> +
> +	hwirq = mobiveil_pcie_assign_msi(pcie);
> +	if (hwirq < 0)
> +		return -EINVAL;
> +
> +	irq = irq_create_mapping(pcie->irq_domain, hwirq);
> +	if (!irq)
> +		return -EINVAL;
> +
> +	irq_set_msi_desc(irq, desc);
> +
> +	msg_addr =
> +		virt_to_phys((void *)pcie->msi_pages + (hwirq * sizeof(int)));
> +
> +	msg.address_hi = upper_32_bits(msg_addr);
> +	msg.address_lo = lower_32_bits(msg_addr);
> +	msg.data = irq;
> +
> +	pci_write_msi_msg(irq, &msg);
> +
> +	return 0;
> +}
> +
> +static struct msi_controller mobiveil_pcie_msi_chip = {
> +	.setup_irq = mobiveil_pcie_msi_setup_irq,
> +	.teardown_irq = mobiveil_msi_teardown_irq,
> +};
> +
> +static struct irq_chip mobiveil_msi_irq_chip = {
> +	.name = "Mobiveil PCIe MSI",
> +	.irq_enable = pci_msi_unmask_irq,
> +	.irq_disable = pci_msi_mask_irq,
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +static int mobiveil_pcie_msi_map(struct irq_domain *domain,
> unsigned int irq,
> +				 irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &mobiveil_msi_irq_chip,
> +				 handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.map = mobiveil_pcie_msi_map,
> +};
> +
> +static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
> +{
> +	phys_addr_t msg_addr;
> +
> +	pcie->msi_pages = (void *)__get_free_pages(GFP_DMA, 0);
> +	msg_addr = virt_to_phys((void *)pcie->msi_pages);
> +	pcie->msi_pages_phys = (void *)msg_addr;
> +
> +	writel_relaxed(lower_32_bits(msg_addr),
> +		pcie->apb_csr_base + MSI_BASE_LO_OFFSET);
> +	writel_relaxed(upper_32_bits(msg_addr),
> +		pcie->apb_csr_base + MSI_BASE_HI_OFFSET);
> +	writel_relaxed(4096, pcie->apb_csr_base + MSI_SIZE_OFFSET);
> +	writel_relaxed(1 << MSI_ENABLE_SHIFT,
> +		pcie->apb_csr_base + MSI_ENABLE_OFFSET);
> +}
> +
> +static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +	struct device_node *node = dev->of_node;
> +
> +	/* Setup INTx */
> +	pcie->irq_domain =
> +		irq_domain_add_linear(node, PCI_NUM_INTX + 1, &intx_domain_ops,
> +				  pcie);
> +
> +	if (!pcie->irq_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +	/* Setup MSI */
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pcie->irq_domain =
> +			irq_domain_add_linear(node,
> +						PCI_NUM_MSI,
> +						&msi_domain_ops,
> +						&mobiveil_pcie_msi_chip);
> +		if (!pcie->irq_domain) {
> +			dev_err(dev, "Failed to get a MSI IRQ domain\n");
> +			return PTR_ERR(pcie->irq_domain);
> +		}
> +
> +		mobiveil_pcie_enable_msi(pcie);
> +	}
> +	return 0;
> +}
> +
> +static int mobiveil_pcie_probe(struct platform_device *pdev)
> +{
> +	struct mobiveil_pcie *pcie;
> +	struct pci_bus *bus;
> +	struct pci_bus *child;
> +	int ret;
> +
> +	/* allocate the PCIe port */
> +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->pdev = pdev;
> +
> +	/* parse the device tree */
> +	ret = mobiveil_pcie_parse_dt(pcie);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Parsing DT failed, ret: %x\n", ret);
> +		return ret;
> +	}
> +
> +	/* setup the PCIe slot link power*/
> +	mobiveil_bringup_link(pcie);
> +
> +	/*
> +	 * configure all inbound and outbound windows and prepare the RC for
> +	 * config access
> +	 */
> +	mobiveil_setup_config_access(pcie);
> +
> +	/* fixup for PCIe class register */
> +	csr_writel(pcie, 0x060402AB, PAB_INTP_AXI_PIO_CLASS);
> +
> +	/* initialize the IRQ domains */
> +	ret = mobiveil_pcie_init_irq_domain(pcie);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
> +		return ret;
> +	}
> +
> +	/* create the PCIe root bus */
> +	bus =
> +	pci_create_root_bus(&pdev->dev, 0,
> +			&mobiveil_pcie_ops, pcie, &pcie->resources);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	/* setup MSI, if enabled */
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		mobiveil_pcie_msi_chip.dev = &pcie->pdev->dev;
> +		bus->msi = &mobiveil_pcie_msi_chip;
> +	}
> +
> +	/* setup the kernel resources for the newly added PCIe root bus */
> +	pci_scan_child_bus(bus);
> +	pci_assign_unassigned_bus_resources(bus);
> +
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +
> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +	pci_bus_add_devices(bus);
> +	platform_set_drvdata(pdev, pcie);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id mobiveil_pcie_of_match[] = {
> +	{.compatible = "mbvl,axi-pcie-host-1.00",},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
> +
> +static struct platform_driver mobiveil_pcie_driver = {
> +	.probe = mobiveil_pcie_probe,
> +	.driver = {
> +			.name = "mobiveil-pcie",
> +			.of_match_table = mobiveil_pcie_of_match,
> +			.suppress_bind_attrs = true,
> +		},
> +};
> +
> +builtin_platform_driver(mobiveil_pcie_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
> +MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
> --
> 1.8.3.1
