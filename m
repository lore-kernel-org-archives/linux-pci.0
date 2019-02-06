Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1F9C169C4
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 23:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBC921900
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 23:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549496798;
	bh=6PbWpdvBWNkenOM8gP9Q/AnmzrKw3aNOA0Gmv/23tZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RgWzwvHG26HHZxBUbY2UWltaZEkDOmbX62pMwBGJ4JK5lCxeGL11whgP8aKyzYhUD
	 zYro0X8H/ICgmzl8pRAif2X9aT4VO334zi3n5kPv9QWD+pi2Z2xrCkcA/F8XCREmzc
	 7/kB7kZEbhJVuDmkbIuLSNydc4cxYhlcme/y+as8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfBFXqh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:46:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfBFXqh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Feb 2019 18:46:37 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A04218AF;
        Wed,  6 Feb 2019 23:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549496795;
        bh=6PbWpdvBWNkenOM8gP9Q/AnmzrKw3aNOA0Gmv/23tZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bP3yTN+7gH4ErhiPlFiF9miOZ77Ne5rusctBICF2+CZMzljfWgPqHu4944rPAjgZ0
         Xspj1P3IJKxmNzlw6s1UfkMqSwKjbwOyQEQEPyQWi2JYdxORlkcAOP/MGkFV6FNwno
         k+rHo6QlTyombmpigonBOXtRUmgq0TdmGo5E/b0U=
Date:   Wed, 6 Feb 2019 17:46:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daire McNamara <daire.mcnamara@microchip.com>
Cc:     linux-pci@vger.kernel.org, ivan.griffin@emdalo.com,
        cyril.jean@microchip.com
Subject: Re: [PATCH] Add Microchip/Microsemi PolarFire-SoC PCIe support
Message-ID: <20190206234633.GG7268@google.com>
References: <20190206155641.GA1540@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206155641.GA1540@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 06, 2019 at 03:56:42PM +0000, Daire McNamara wrote:
> Hi everyone,
> 
> This patch contains changes made in order to enable support of PCIe
> IP block on Microsemi PolarFire SoCs.
> 
> Feedback is welcome!
> 
> Thanks,
> Daire McNamara
> 
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>

Thanks for the patch, and welcome to PCI!

Your patch applied cleanly (as a test; Lorenzo will ultimately take
care of this), so you solved the mailer problems!

You can strip the conversational part of the changelog out; that could
go in a [0/N] cover letter, but the changelog for the patch itself
should just explain the patch.  You can run git log
drivers/pci/controller" to see other examples.

A few trivial nits below.  I would wait a few days before posting an
update in case anybody else it reviewing and has more substantive
comments.

Bjorn

> ---
>  .../bindings/pci/microsemi-pcie.txt           |  65 ++
>  .../devicetree/bindings/vendor-prefixes.txt   |   1 +
>  drivers/pci/controller/Kconfig                |   8 +
>  drivers/pci/controller/Makefile               |   1 +
>  drivers/pci/controller/pcie-microsemi.c       | 778 ++++++++++++++++++
>  5 files changed, 853 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microsemi-pcie.txt
>  create mode 100644 drivers/pci/controller/pcie-microsemi.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/microsemi-pcie.txt b/Documentation/devicetree/bindings/pci/microsemi-pcie.txt
> new file mode 100644
> index 000000000000..a16e48806edc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/microsemi-pcie.txt
> @@ -0,0 +1,65 @@
> +* Microsemi AXI PCIe Root Port Bridge DT description
> +
> +Required properties:
> +- #address-cells: Address representation for root ports, set to <3>
> +- #size-cells: Size representation for root ports, set to <2>
> +- #interrupt-cells: specifies the number of cells needed to encode an
> +	interrupt source. The value must be 1.
> +- compatible: Should contain "microsemi,ms-pf-axi-pcie-host"
> +- reg: Should contain AXI PCIe registers location and length
> +- device_type: must be "pci"
> +- interrupts: Should contain AXI PCIe interrupt
> +- interrupt-map-mask,
> +  interrupt-map: standard PCI properties to define the mapping of the
> +	PCI interface to interrupt numbers.
> +- ranges: ranges for the PCI memory regions (I/O space region is not
> +	supported by hardware)
> +	Please refer to the standard PCI bus binding document for a more
> +	detailed explanation
> +
> +Optional properties for PolarFire:
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
> +create an interrupt controller node to support 'interrupt-map' DT
> +functionality.  The driver will create an IRQ domain for this map, decode
> +the four INTx interrupts in ISR and route them to this domain.
> +
> +
> +Example:
> +++++++++
> +AloeVera:
> +
> +	pcie: pcie@2030000000 {
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		compatible = "microsemi,ms-pf-axi-pcie-host";
> +		device_type = "pci";
> +		bus-range = <0x01 0x7f>;
> +		interrupt-map = <0 0 0 1 &pcie_intc 1>,
> +				<0 0 0 2 &pcie_intc 2>,
> +				<0 0 0 3 &pcie_intc 3>,
> +				<0 0 0 4 &pcie_intc 4>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-parent = <&L4>;
> +		interrupts = <32>;
> +		ranges = <0x3000000 0 0x40000000 0x0 0x40000000 0x0 0x20000000>;
> +		reg = <0x20 0x30000000 0x0 0x4000000 0x20 0x0 0x0 0x100000>;
> +		reg-names = "control", "apb";
> +		pcie_intc: interrupt-controller {
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4b1a2a8fcc16..d13f6e40dbf4 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -238,6 +238,7 @@ micrel	Micrel Inc.
>  microchip	Microchip Technology Inc.
>  microcrystal	Micro Crystal AG
>  micron	Micron Technology Inc.
> +microsemi	Microsemi Corporation
>  mikroe		MikroElektronika d.o.o.
>  minix	MINIX Technology Ltd.
>  miramems	MiraMEMS Sensing Technology Co., Ltd.
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 6671946dbf66..31fa5e53d765 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -280,5 +280,13 @@ config VMD
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vmd.
>  
> +config PCIE_MICROSEMI
> +	bool "Microsemi AXI PCIe host bridge support"
> +	depends on PCI_MSI && OF
> +	help
> +	  Say 'Y' here if you want kernel to support the Microsemi AXI PCIe
> +	  Host Bridge driver.
> +
> +
>  source "drivers/pci/controller/dwc/Kconfig"
>  endmenu
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index d56a507495c5..c3b76ff221be 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
>  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>  obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
> +obj-$(CONFIG_PCIE_MICROSEMI) += pcie-microsemi.o
>  obj-$(CONFIG_VMD) += vmd.o
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y				+= dwc/
> diff --git a/drivers/pci/controller/pcie-microsemi.c b/drivers/pci/controller/pcie-microsemi.c
> new file mode 100644
> index 000000000000..3572c3e82f5c
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-microsemi.c
> @@ -0,0 +1,778 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PCIe host controller driver for Microsemi AXI PCIe Bridge
> + *
> + * Copyright (c) 2018 - 2019 Microsemi Corporation.
> + *
> + * Based on:
> + *	pcie-rcar.c
> + *	pcie-xilinx.c
> + *	pcie-altera.c
> + */
> +
> +#include <linux/bitmap.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "../pci.h"
> +
> +/* ECAM definitions */
> +#define ECAM_BUS_NUM_SHIFT		20
> +#define ECAM_DEV_NUM_SHIFT		12
> +
> +/* Number of MSI IRQs */
> +#define MICROSEMI_NUM_MSI_IRQS		32
> +#define MICROSEMI_NUM_MSI_IRQS_CODED	 5
> +
> +/* PCIe Bridge Phy and Controller Phy offsets */
> +#define MICROSEMI_PCIE0_BRIDGE_ADDR	0x00004000u
> +#define MICROSEMI_PCIE0_CTRL_ADDR	0x00006000u
> +
> +#define MICROSEMI_PCIE1_BRIDGE_ADDR	0x00008000u
> +#define MICROSEMI_PCIE1_CTRL_ADDR	0x0000A000u
> +
> +/* PCIe Controller Phy Regs */
> +#define MICROSEMI_SEC_ERROR_INT			0x28
> +#define SEC_ERROR_INT_TX_RAM_SEC_ERR_INT	GENMASK(3, 0)
> +#define SEC_ERROR_INT_RX_RAM_SEC_ERR_INT	GENMASK(7, 4)
> +#define SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT	GENMASK(11, 8)
> +#define SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT	GENMASK(15, 12)
> +#define MICROSEMI_SEC_ERROR_INT_MASK		0x2c
> +#define MICROSEMI_DED_ERROR_INT			0x30
> +#define DED_ERROR_INT_TX_RAM_DED_ERR_INT	GENMASK(3, 0)
> +#define DED_ERROR_INT_RX_RAM_DED_ERR_INT	GENMASK(7, 4)
> +#define DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT	GENMASK(11, 8)
> +#define DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT	GENMASK(15, 12)
> +#define MICROSEMI_DED_ERROR_INT_MASK		0x34
> +#define MICROSEMI_ECC_CONTROL			0x38
> +#define ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS	BIT(27)
> +#define ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS	BIT(26)
> +#define ECC_CONTROL_RX_RAM_ECC_BYPASS		BIT(25)
> +#define ECC_CONTROL_TX_RAM_ECC_BYPASS		BIT(24)
> +#define MICROSEMI_LTSSM_STATE			0x5c
> +#define MICROSEMI_LTSSM_L0_STATE		0x10
> +#define MICROSEMI_PCIE_EVENT_INT		0x14c
> +#define PCIE_EVENT_INT_L2_EXIT_INT		BIT(0)
> +#define PCIE_EVENT_INT_HOTRST_EXIT_INT		BIT(1)
> +#define PCIE_EVENT_INT_DLUP_EXIT_INT		BIT(2)
> +#define PCIE_EVENT_INT_L2_EXIT_INT_MASK		BIT(16)
> +#define PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK	BIT(17)
> +#define PCIE_EVENT_INT_DLUP_EXIT_INT_MASK	BIT(18)
> +
> +/* PCIe Bridge Phy Regs */
> +#define MICROSEMI_PCIE_PCI_IDS_DW1		0x9c
> +#define MICROSEMI_IMASK_LOCAL			0x180
> +#define MICROSEMI_PCIE_LOCAL_INT_ENABLE		0x0F000000u

Use upper-case hex or lower-case hex consistently.

> +#define MICROSEMI_PCI_INTS			0x0F000000u
> +#define MICROSEMI_PM_MSI_INT_SHIFT		24
> +#define MICROSEMI_PCIE_ENABLE_MSI		0x10000000u
> +#define MICROSEMI_MSI_INT			0x10000000u
> +#define MICROSEMI_MSI_INT_SHIFT			28
> +#define MICROSEMI_ISTATUS_LOCAL			0x184
> +#define MICROSEMI_IMASK_HOST			0x188
> +#define MICROSEMI_ISTATUS_HOST			0x18c
> +#define MICROSEMI_ISTATUS_MSI			0x194
> +
> +/* PCIe AXI slave table init defines */
> +#define MICROSEMI_ATR0_AXI4_SLV0_SRCADDR_PARAM	0x800u
> +#define ATR_SIZE_SHIFT				(1)

Bare single numbers like this don't need parens around them (several
occurrences).

> +#define ATR_IMPL_ENABLE				(1)
> +#define MICROSEMI_ATR0_AXI4_SLV0_SRC_ADDR	0x804u
> +#define MICROSEMI_ATR0_AXI4_SLV0_TRSL_ADDR_LSB	0x808u
> +#define MICROSEMI_ATR0_AXI4_SLV0_TRSL_ADDR_UDW	0x80cu
> +#define MICROSEMI_ATR0_AXI4_SLV0_TRSL_PARAM	0x810u
> +#define MICROSEMI_PCIE_TX_RX_INTERFACE		0x00000000u
> +#define MICROSEMI_PCIE_CONFIG_INTERFACE		0x00000001u
> +
> +#define MICROSEMI_ATR0_AXI4_SLV_SIZE		(32)
> +
> +/* PCIe Master table init defines */
> +#define MICROSEMI_ATR0_PCIE_WIN0_SRCADDR_31_12	0x600u
> +#define MICROSEMI_ATR0_PCIE_WIN0_SIZE		(0x1f)
> +#define MICROSEMI_ATR0_PCIE_WIN0_SIZE_SHIFT	(1)
> +#define MICROSEMI_ATR0_PCIE_WIN0_SRCADDR_63_32	0x604u
> +
> +#define MICROSEMI_MSI_MSG_ADDR			0x190u
> +
> +/* PCIe Config space MSI capability structure */
> +#define MSI_CAP_CTRL_OFFSET		0xE0u
> +#define MSI_ENABLE			(0x01u << 16)
> +#define MSI_ENABLE_MULTI		(MICROSEMI_NUM_MSI_IRQS_CODED << 20)
> +#define MSI_MSG_ADDR_OFFSET		0xE4u
> +#define MSI_MSG_UPPER_ADDR_OFFSET	0xE8u
> +#define MSI_MSG_DATA_OFFSET		0xF0u
> +
> +/**
> + * struct microsemi_pcie_port - PCIe port information
> + * @pcie_base_addr: IO Mapped Register Base
> + * @axi_base_addr: AMBA Mapped Register Base
> + * @irq: Interrupt number
> + * @root_busno: Root Bus number
> + * @dev: Device pointer
> + * @msi_domain: MSI IRQ domain pointer
> + * @leg_domain: Legacy IRQ domain pointer
> + * @resources: Bus Resources
> + */
> +struct microsemi_pcie_port {
> +	struct platform_device *pdev;
> +	void __iomem *pcie_base_addr;
> +	void __iomem *axi_base_addr;
> +	void __iomem *bridge_base_addr;
> +	void __iomem *ctrl_base_addr;
> +	int bridge;
> +	u32 irq;
> +	u8 root_busno;
> +	struct device *dev;
> +	struct irq_domain *msi_domain;
> +	struct irq_domain *leg_domain;
> +	struct list_head resources;
> +	struct mutex lock;
> +};
> +
> +static DECLARE_BITMAP(msi_irq_in_use, MICROSEMI_NUM_MSI_IRQS);

It's bad form to use static variables like this because they limit you
to a single instance of the device.  You probably know the platform
imposes that restriction anyway, but it's nice to avoid having
examples around that people could unwittingly copy to places *without*
such restrictions.

> +static inline u32 pcie_read(struct microsemi_pcie_port *port, u32 reg)
> +{
> +	return readl(port->pcie_base_addr + reg);
> +}
> +
> +static inline void pcie_write(struct microsemi_pcie_port *port,
> +			      u32 val, u32 reg)
> +{
> +	writel(val, port->pcie_base_addr + reg);
> +}
> +
> +static inline bool microsemi_pcie_is_enabled(struct microsemi_pcie_port *port)
> +{
> +	return (readl(port->bridge_base_addr + MICROSEMI_LTSSM_STATE)
> +		& MICROSEMI_LTSSM_L0_STATE) ? 1 : 0;
> +}
> +
> +static inline void microsemi_pcie_enable(struct microsemi_pcie_port *port)
> +{
> +	u32 enb;
> +
> +	enb = readl(port->bridge_base_addr + MICROSEMI_LTSSM_STATE);
> +	enb |= MICROSEMI_LTSSM_L0_STATE;
> +	writel(enb, port->bridge_base_addr + MICROSEMI_LTSSM_STATE);
> +}

There's not much point in marking trivial, single-use functions like
this as inline (and the compiler will probably do it for you anyway).

It would probably also be a little simpler and shorter to combine the
test and the enable into a single function.

> +/**
> + * microsemi_pcie_valid_device - Check if a valid device is present on bus
> + * @bus: PCI Bus structure
> + * @devfn: device/function
> + *
> + * Return: 'true' on success and 'false' if invalid device is found
> + */
> +static bool microsemi_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> +{
> +	struct microsemi_pcie_port *port = bus->sysdata;
> +
> +	/* Only one device down on each root port */
> +	if (bus->number == port->root_busno && devfn > 0)
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * microsemi_pcie_map_bus - Get configuration base
> + * @bus: PCI Bus structure
> + * @devfn: Device/function
> + * @where: Offset from base
> + *
> + * Return: Base address of the configuration space needed to be
> + *	 accessed.
> + */
> +static void __iomem *microsemi_pcie_map_bus(struct pci_bus *bus,
> +					    unsigned int devfn, int where)
> +{
> +	struct microsemi_pcie_port *port = bus->sysdata;
> +	int relbus;
> +
> +	if (!microsemi_pcie_valid_device(bus, devfn))
> +		return NULL;
> +
> +	relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
> +		(devfn << ECAM_DEV_NUM_SHIFT);
> +
> +	return port->pcie_base_addr + relbus + where;
> +}
> +
> +/* PCIe operations */
> +static struct pci_ops microsemi_pcie_ops = {
> +	.map_bus = microsemi_pcie_map_bus,
> +	.read	= pci_generic_config_read,
> +	.write	= pci_generic_config_write,
> +};
> +
> +/* MSI functions */
> +
> +/**
> + * microsemi_pcie_destroy_msi - Free MSI number
> + * @irq: IRQ to be freed
> + */
> +static void microsemi_pcie_destroy_msi(unsigned int irq)
> +{
> +	struct msi_desc *msi;
> +	struct microsemi_pcie_port *port;
> +	struct irq_data *d = irq_get_irq_data(irq);
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +
> +	if (!test_bit(hwirq, msi_irq_in_use)) {
> +		msi = irq_get_msi_desc(irq);
> +		port = msi_desc_to_pci_sysdata(msi);
> +		dev_err(port->dev, "Trying to free unused MSI#%d\n", irq);
> +	} else {
> +		clear_bit(hwirq, msi_irq_in_use);
> +	}
> +}
> +
> +/**
> + * microsemi_pcie_assign_msi - Allocate MSI number
> + *
> + * Return: A valid IRQ on success and error value on failure.
> + */
> +static int microsemi_pcie_assign_msi(struct microsemi_pcie_port *port)
> +{
> +	int pos;
> +
> +	mutex_lock(&port->lock);
> +	pos = find_first_zero_bit(msi_irq_in_use, MICROSEMI_NUM_MSI_IRQS);
> +	if (pos < MICROSEMI_NUM_MSI_IRQS)
> +		set_bit(pos, msi_irq_in_use);
> +	else {
> +		mutex_unlock(&port->lock);
> +		return -ENOSPC;
> +	}
> +
> +	mutex_unlock(&port->lock);
> +	return pos;
> +}
> +
> +/**
> + * microsemi_msi_teardown_irq - Destroy the MSI
> + * @chip: MSI Chip descriptor
> + * @irq: MSI IRQ to destroy
> + */
> +static void microsemi_msi_teardown_irq(struct msi_controller *chip,
> +				       unsigned int irq)
> +{
> +	microsemi_pcie_destroy_msi(irq);
> +	irq_dispose_mapping(irq);
> +}
> +
> +/**
> + * microsemi_pcie_msi_setup_irq - Setup MSI request
> + * @chip: MSI chip pointer
> + * @pdev: PCIe device pointer
> + * @desc: MSI descriptor pointer
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int microsemi_pcie_msi_setup_irq(struct msi_controller *chip,
> +					struct pci_dev *pdev,
> +					struct msi_desc *desc)
> +{
> +	struct microsemi_pcie_port *port = pdev->bus->sysdata;
> +	unsigned int irq;
> +	int hwirq;
> +	struct msi_msg msg;
> +
> +	hwirq = microsemi_pcie_assign_msi(port);
> +	if (hwirq < 0)
> +		return hwirq;
> +
> +	irq = irq_create_mapping(port->msi_domain, hwirq);
> +	if (!irq)
> +		return -EINVAL;
> +
> +	irq_set_msi_desc(irq, desc);
> +
> +	msg.address_hi = upper_32_bits(MICROSEMI_MSI_MSG_ADDR);
> +	msg.address_lo = lower_32_bits(MICROSEMI_MSI_MSG_ADDR);
> +	msg.data = hwirq;
> +
> +	pci_write_msi_msg(irq, &msg);
> +
> +	return 0;
> +}
> +
> +/* MSI Chip Descriptor */
> +static struct msi_controller microsemi_pcie_msi_chip = {
> +	.setup_irq = microsemi_pcie_msi_setup_irq,
> +	.teardown_irq = microsemi_msi_teardown_irq,
> +};
> +
> +/* HW Interrupt Chip Descriptor */
> +static struct irq_chip microsemi_msi_irq_chip = {
> +	.name = "Microsemi PCIe MSI",
> +	.irq_enable = pci_msi_unmask_irq,
> +	.irq_disable = pci_msi_mask_irq,
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +/**
> + * microsemi_pcie_msi_map - Set the handler for the MSI and mark IRQ as valid
> + * @domain: IRQ domain
> + * @irq: Virtual IRQ number
> + * @hwirq: HW interrupt number
> + *
> + * Return: Always returns 0.
> + */
> +static int microsemi_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> +				  irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &microsemi_msi_irq_chip,
> +				 handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +/* IRQ Domain operations */
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.map = microsemi_pcie_msi_map,
> +};
> +
> +/**
> + * microsemi_pcie_enable_msi - Enable MSI support
> + * @port: PCIe port information
> + */
> +static void microsemi_pcie_enable_msi(struct microsemi_pcie_port *port)
> +{
> +	u32 cap_ctrl;
> +
> +	cap_ctrl = pcie_read(port, MSI_CAP_CTRL_OFFSET);
> +
> +	pcie_write(port, cap_ctrl | MSI_ENABLE_MULTI |
> +		MSI_ENABLE, MSI_CAP_CTRL_OFFSET);
> +	pcie_write(port, MICROSEMI_MSI_MSG_ADDR, MSI_MSG_ADDR_OFFSET);
> +}
> +
> +/* INTx Functions */
> +
> +/**
> + * microsemi_pcie_intx_map - Set the handler for the INTx and mark IRQ as valid
> + * @domain: IRQ domain
> + * @irq: Virtual IRQ number
> + * @hwirq: HW interrupt number
> + *
> + * Return: Always returns 0.
> + */
> +static int microsemi_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +				   irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +/* INTx IRQ Domain operations */
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = microsemi_pcie_intx_map,
> +	.xlate = pci_irqd_intx_xlate,
> +};
> +
> +/* PCIe HW Functions */
> +
> +/**
> + * microsemi_pcie_intr_handler - Interrupt Service Handler
> + * @irq: IRQ number
> + * @data: PCIe port information
> + *
> + * Return: IRQ_HANDLED on success and IRQ_NONE on failure
> + */
> +static irqreturn_t microsemi_pcie_intr_handler(int irq, void *data)
> +{
> +	struct microsemi_pcie_port *port = (struct microsemi_pcie_port *)data;
> +	struct device *dev = port->dev;
> +	unsigned long status;
> +	unsigned long msi;
> +	u32 bit;
> +	u32 virq;
> +
> +	status = readl(port->bridge_base_addr + MICROSEMI_ISTATUS_LOCAL);
> +
> +	/* Might be sharing interrupt line.  Check if interrupt is for us */
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	status = (status & MICROSEMI_PCI_INTS) >> MICROSEMI_PM_MSI_INT_SHIFT;
> +	for_each_set_bit(bit, &status, PCI_NUM_INTX) {
> +		/* clear that interrupt bit */
> +		writel(1 << (bit + MICROSEMI_PM_MSI_INT_SHIFT),
> +		       port->bridge_base_addr + MICROSEMI_ISTATUS_LOCAL);
> +		virq = irq_find_mapping(port->leg_domain, bit);
> +
> +		if (virq)
> +			generic_handle_irq(virq);
> +		else
> +			dev_err(dev, "unexpected IRQ, INT%d\n", bit);
> +	}
> +
> +	status = readl(port->bridge_base_addr + MICROSEMI_ISTATUS_LOCAL);
> +	if (status & MICROSEMI_MSI_INT) {
> +		/* Clear the ISTATUS MSI bit */
> +		writel((1 << MICROSEMI_MSI_INT_SHIFT),
> +		       port->bridge_base_addr + MICROSEMI_ISTATUS_LOCAL);
> +		msi = readl(port->bridge_base_addr + MICROSEMI_ISTATUS_MSI);
> +		for_each_set_bit(bit, &msi, MICROSEMI_NUM_MSI_IRQS) {
> +			/* clear that MSI interrupt bit */
> +			writel((1 << bit),
> +			       port->bridge_base_addr + MICROSEMI_ISTATUS_MSI);
> +			virq = irq_find_mapping(port->msi_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +			else
> +				dev_err(dev, "unexpected IRQ, INT%d\n", bit);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * microsemi_pcie_init_irq_domain - Initialize IRQ domain
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int microsemi_pcie_init_irq_domain(struct microsemi_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct device_node *node = dev->of_node;
> +	struct device_node *pcie_intc_node;
> +
> +	/* Setup INTx */
> +	pcie_intc_node = of_get_next_child(node, NULL);
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -ENODEV;
> +	}
> +	dev_info(dev, "Intc node found %s\n", pcie_intc_node->name);
> +
> +	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> +						 &intx_domain_ops,
> +						 port);
> +	if (!port->leg_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Setup MSI */
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		port->msi_domain =
> +			irq_domain_add_linear(node,
> +					      MICROSEMI_NUM_MSI_IRQS,
> +					      &msi_domain_ops,
> +					      &microsemi_pcie_msi_chip);
> +		if (!port->msi_domain) {
> +			dev_err(dev, "Failed to get a MSI IRQ domain\n");
> +			return -ENODEV;
> +		}
> +		microsemi_pcie_enable_msi(port);
> +	}
> +
> +	/* Enable interrupts */
> +	writel(MICROSEMI_PCIE_ENABLE_MSI | MICROSEMI_PCIE_LOCAL_INT_ENABLE,
> +	       port->bridge_base_addr + MICROSEMI_IMASK_LOCAL);
> +
> +	return 0;
> +}
> +
> +/**
> + * microsemi_pcie_init_port - Parse Device tree, Initialize hardware
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int microsemi_pcie_init_port(struct microsemi_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct device_node *node = dev->of_node;
> +	struct of_pci_range_parser parser;
> +	struct of_pci_range range;
> +	struct resource regs;
> +	struct resource regs1;
> +	resource_size_t size;
> +	u32 atr_sz;
> +	const char *type;
> +	int err;
> +	u32 val;
> +	int index = 1;
> +
> +	type = of_get_property(node, "device_type", NULL);
> +	if (!type || strcmp(type, "pci")) {
> +		dev_err(dev, "invalid \"device_type\" %s\n", type);
> +		return -EINVAL;
> +	}
> +
> +	/* Only supporting bridge 1 */
> +	port->bridge = 1;
> +
> +	mutex_init(&port->lock);
> +
> +	err = of_address_to_resource(node, 0, &regs);
> +	if (err) {
> +		dev_err(dev, "missing \"reg\" property\n");
> +		return err;
> +	}
> +
> +	port->pcie_base_addr = devm_pci_remap_cfg_resource(dev, &regs);
> +	if (IS_ERR(port->pcie_base_addr))
> +		return PTR_ERR(port->pcie_base_addr);
> +
> +	err = of_address_to_resource(node, 1, &regs1);
> +	if (err) {
> +		dev_err(dev, "missing \"reg\" property\n");
> +		return err;
> +	}
> +
> +	port->axi_base_addr = devm_ioremap_resource(dev, &regs1);
> +	if (IS_ERR(port->axi_base_addr))
> +		return PTR_ERR(port->axi_base_addr);
> +
> +	if (port->bridge == 0) {
> +		port->bridge_base_addr = port->axi_base_addr
> +			+ MICROSEMI_PCIE0_BRIDGE_ADDR;
> +		port->ctrl_base_addr = port->axi_base_addr
> +			+ MICROSEMI_PCIE0_CTRL_ADDR;
> +	} else {
> +		port->bridge_base_addr = port->axi_base_addr
> +			+ MICROSEMI_PCIE1_BRIDGE_ADDR;
> +		port->ctrl_base_addr = port->axi_base_addr
> +			+ MICROSEMI_PCIE1_CTRL_ADDR;
> +	}
> +
> +	port->irq = irq_of_parse_and_map(node, 0);
> +
> +	err = devm_request_irq(dev, port->irq, microsemi_pcie_intr_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> +			       "microsemi-pcie", port);
> +	if (err) {
> +		dev_err(dev, "unable to request irq %d\n", port->irq);

s/irq %d/IRQ %d/ (as you do in other messages above and below).

Some of your messages have an initial capital; others don't.

> +		return err;
> +	}
> +
> +	if (!microsemi_pcie_is_enabled(port))
> +		microsemi_pcie_enable(port);
> +
> +	/* Clear and Disable interrupts */
> +	val = ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS
> +		| ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS
> +		| ECC_CONTROL_RX_RAM_ECC_BYPASS
> +		| ECC_CONTROL_TX_RAM_ECC_BYPASS;
> +	writel(val, port->ctrl_base_addr + MICROSEMI_ECC_CONTROL);
> +
> +	val = PCIE_EVENT_INT_L2_EXIT_INT
> +		| PCIE_EVENT_INT_HOTRST_EXIT_INT
> +		| PCIE_EVENT_INT_DLUP_EXIT_INT
> +		| PCIE_EVENT_INT_L2_EXIT_INT_MASK
> +		| PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK
> +		| PCIE_EVENT_INT_DLUP_EXIT_INT_MASK;
> +	writel(val, port->ctrl_base_addr + MICROSEMI_PCIE_EVENT_INT);
> +
> +	val = SEC_ERROR_INT_TX_RAM_SEC_ERR_INT
> +		| SEC_ERROR_INT_RX_RAM_SEC_ERR_INT
> +		| SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT
> +		| SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT;
> +	writel(val, port->ctrl_base_addr + MICROSEMI_SEC_ERROR_INT);
> +	writel(val, port->ctrl_base_addr + MICROSEMI_SEC_ERROR_INT_MASK);
> +
> +	val = DED_ERROR_INT_TX_RAM_DED_ERR_INT
> +		| DED_ERROR_INT_RX_RAM_DED_ERR_INT
> +		| DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT
> +		| DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT;
> +	writel(val, port->ctrl_base_addr + MICROSEMI_DED_ERROR_INT);
> +	writel(val, port->ctrl_base_addr + MICROSEMI_DED_ERROR_INT_MASK);
> +
> +	writel(0x00000000,
> +	       port->bridge_base_addr + MICROSEMI_IMASK_LOCAL);

Fits on one line.

> +	writel(GENMASK(31, 0),
> +	       port->bridge_base_addr + MICROSEMI_ISTATUS_LOCAL);
> +	writel(0x00000000, port->bridge_base_addr + MICROSEMI_IMASK_HOST);
> +	writel(GENMASK(31, 0), port->bridge_base_addr + MICROSEMI_ISTATUS_HOST);
> +
> +	dev_info(dev, "interrupt disabled\n");
> +
> +	/* Configure Address Translation Table 0 for PCIe config space */
> +	writel(MICROSEMI_PCIE_CONFIG_INTERFACE,
> +	       port->bridge_base_addr + MICROSEMI_ATR0_AXI4_SLV0_TRSL_PARAM);
> +
> +	size = resource_size(&regs);
> +
> +	atr_sz = find_first_bit((const unsigned long *)&size, 64) - 1;
> +
> +	writel(lower_32_bits(regs.start)
> +		| atr_sz << ATR_SIZE_SHIFT | ATR_IMPL_ENABLE,
> +		port->bridge_base_addr
> +		+ MICROSEMI_ATR0_AXI4_SLV0_SRCADDR_PARAM);
> +
> +	writel(lower_32_bits(regs.start),
> +	       port->bridge_base_addr + MICROSEMI_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
> +
> +	if (of_pci_range_parser_init(&parser, node)) {
> +		dev_err(dev, "missing \"ranges\" property\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		switch (range.flags & IORESOURCE_TYPE_BITS) {
> +		case IORESOURCE_MEM:
> +			size = range.size;
> +			atr_sz =
> +				find_first_bit((const unsigned long *)&size, 64)
> +				- 1;
> +
> +			/* Configure Address Translation Table index for PCIe
> +			 * mem space
> +			 */
> +			writel(MICROSEMI_PCIE_TX_RX_INTERFACE,
> +			       port->bridge_base_addr
> +				+ (index * MICROSEMI_ATR0_AXI4_SLV_SIZE)
> +				+ MICROSEMI_ATR0_AXI4_SLV0_TRSL_PARAM);
> +
> +			writel(lower_32_bits(range.cpu_addr)
> +				| (atr_sz << ATR_SIZE_SHIFT)
> +				| ATR_IMPL_ENABLE,
> +				port->bridge_base_addr
> +				+ (index * MICROSEMI_ATR0_AXI4_SLV_SIZE)
> +				+ MICROSEMI_ATR0_AXI4_SLV0_SRCADDR_PARAM);
> +
> +			writel(lower_32_bits(range.pci_addr),
> +			       port->bridge_base_addr
> +				+ (index * MICROSEMI_ATR0_AXI4_SLV_SIZE)
> +				+ MICROSEMI_ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
> +
> +			break;
> +		}
> +		index++;
> +	}
> +
> +	writel(readl(port->bridge_base_addr
> +		+ MICROSEMI_ATR0_PCIE_WIN0_SRCADDR_31_12)
> +		| (MICROSEMI_ATR0_PCIE_WIN0_SIZE
> +		<< MICROSEMI_ATR0_PCIE_WIN0_SIZE_SHIFT),
> +		port->bridge_base_addr +
> +		MICROSEMI_ATR0_PCIE_WIN0_SRCADDR_31_12);
> +
> +	writel(0x0,
> +	       port->bridge_base_addr + MICROSEMI_ATR0_PCIE_WIN0_SRCADDR_63_32);
> +
> +	writel((readl(port->bridge_base_addr + MICROSEMI_PCIE_PCI_IDS_DW1)
> +		& 0xffff)
> +		| (PCI_CLASS_BRIDGE_PCI << 16),
> +		port->bridge_base_addr + MICROSEMI_PCIE_PCI_IDS_DW1);
> +
> +	return 0;
> +}
> +
> +/**
> + * microsemi_pcie_probe - Probe function
> + * @pdev: Platform device pointer
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int microsemi_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct microsemi_pcie_port *port;
> +	struct pci_bus *bus, *child;
> +	struct pci_host_bridge *bridge;
> +	int err;
> +	resource_size_t iobase = 0;
> +	LIST_HEAD(res);
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	port = pci_host_bridge_priv(bridge);
> +
> +	port->dev = dev;
> +	port->pdev = pdev;
> +
> +	err = microsemi_pcie_init_port(port);
> +	if (err) {
> +		dev_err(dev, "PCIe port initialization failed\n");
> +		return err;
> +	}
> +
> +	err = microsemi_pcie_init_irq_domain(port);
> +	if (err) {
> +		dev_err(dev, "Failed creating IRQ Domain\n");
> +		return err;
> +	}
> +
> +	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
> +						    &iobase);
> +	if (err) {
> +		dev_err(dev, "Getting bridge resources failed\n");
> +		return err;
> +	}
> +
> +	err = devm_request_pci_bus_resources(dev, &res);
> +	if (err)
> +		goto error;
> +
> +	list_splice_init(&res, &bridge->windows);
> +	bridge->dev.parent = dev;
> +	bridge->sysdata = port;
> +	bridge->busnr = 0;
> +	bridge->ops = &microsemi_pcie_ops;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
> +
> +#ifdef CONFIG_PCI_MSI
> +	microsemi_pcie_msi_chip.dev = dev;
> +	bridge->msi = &microsemi_pcie_msi_chip;
> +#endif
> +	err = pci_scan_root_bus_bridge(bridge);
> +	dev_info(dev, "pci_scan_root_bus_bridge done\n");

Looks like a leftover debug message?

> +	if (err < 0)
> +		goto error;
> +
> +	bus = bridge->bus;
> +
> +	pci_assign_unassigned_bus_resources(bus);
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +	pci_bus_add_devices(bus);
> +
> +	return 0;
> +
> +error:
> +	pci_free_resource_list(&res);
> +	return err;
> +}
> +
> +static const struct of_device_id microsemi_pcie_of_match[] = {
> +	{ .compatible = "microsemi,ms-pf-axi-pcie-host", },
> +	{}
> +};
> +
> +static struct platform_driver microsemi_pcie_driver = {
> +	.driver = {
> +		.name = "microsemi-pcie",
> +		.of_match_table = microsemi_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = microsemi_pcie_probe,
> +};
> +builtin_platform_driver(microsemi_pcie_driver);
> -- 
> 2.17.1
> 
