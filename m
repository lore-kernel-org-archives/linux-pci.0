Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33726 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbbLEAaI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 19:30:08 -0500
Date: Fri, 4 Dec 2015 18:30:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, CARLOS.PALMINHA@synopsys.com,
	Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 1/2] add new platform driver for PCI RC
Message-ID: <20151205003003.GA7994@localhost>
References: <cover.1448375184.git.jpinto@synopsys.com>
 <cee062b7e3ad115ec3b391dfef5ef9a7334fde74.1448375184.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cee062b7e3ad115ec3b391dfef5ef9a7334fde74.1448375184.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc DT guys]

Hi Joao,

On Tue, Nov 24, 2015 at 02:32:05PM +0000, Joao Pinto wrote:
> This patch adds a new driver that will be the reference platform driver for all
> PCI RC IP Protoyping Kits based on ARC SDP. This patch is composed by:
> 
> -Changes to pcie-designware driver add a function that enables the feature
> of starting the LTSSM (Link Train Status State) used by the new driver
> -MAINTAINERS file was updated to include the new driver
> -Documentation/devicetree/bindings/pci was updated to include the new driver
> documentation
> -New driver called pcie-snpsdev
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
>  .../devicetree/bindings/pci/pcie-snpsdev.txt       |  28 ++
>  MAINTAINERS                                        |   7 +
>  drivers/pci/host/Kconfig                           |   5 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pcie-designware.c                 |  15 +
>  drivers/pci/host/pcie-designware.h                 |   1 +
>  drivers/pci/host/pcie-snpsdev.c                    | 342 +++++++++++++++++++++
>  7 files changed, 399 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
>  create mode 100644 drivers/pci/host/pcie-snpsdev.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/pcie-snpsdev.txt b/Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
> new file mode 100644
> index 0000000..b833c8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
> @@ -0,0 +1,28 @@
> +Synopsys PCI RC IP Prototyping Kit
> +----------------------------------
> +
> +This is the reference platform driver to be used in the Synopsys PCI RC IP
> +Prototyping Kits.
> +
> +Required properties:
> +- compatible: "snps,pcie-snpsdev";
> +- reg:	A list of physical regions to access the device.
> +- interrupts: interrupt for the device.
> +- #address-cells: must be 3.
> +- #size-cells: must be 2.
> +
> +Example configuration:
> +
> +	pcie: pcie@0xdffff000 {
> +		#interrupt-cells = <1>;
> +		compatible = "snps,pcie-snpsdev";
> +		reg = <0xdffff000 0x1000>;
> +		interrupts = <25>, <24>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		ranges = <0x00000800 0 0xd0000000 0xd0000000 0 0x00002000
> +			  0x81000000 0 0x00000000 0xde000000 0 0x00010000
> +			  0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
> +		num-lanes = <1>;
> +	};

It'd be nice to get an ack from the DT guys (cc'd).

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9caa4b..d2e4506 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8230,6 +8230,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>  F:	drivers/pci/host/pcie-hisi.c
>  
> +PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
> +M:	Joao Pinto <jpinto@synopsys.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
> +F:	drivers/pci/host/pcie-snpsdev.c
> +
>  PCMCIA SUBSYSTEM
>  P:	Linux PCMCIA Team
>  L:	linux-pcmcia@lists.infradead.org
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index f131ba9..a874b1e 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -172,4 +172,9 @@ config PCI_HISI
>  	help
>  	  Say Y here if you want PCIe controller support on HiSilicon HIP05 SoC
>  
> +config PCIE_SNPSDEV
> +	bool "Platform Driver for Synopsys Device"
> +	select PCIEPORTBUS
> +	select PCIE_DW
> +
>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 9d4d3c6..e422f65 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>  obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
>  obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
> +obj-$(CONFIG_PCIE_SNPSDEV) += pcie-snpsdev.o
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 540f077..3251695 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -22,9 +22,15 @@
>  #include <linux/pci_regs.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
> +#include <linux/delay.h>
> +#include <linux/sizes.h>
>  
>  #include "pcie-designware.h"
>  
> +/* Synopsys Default PCIE Control and Status Register Memory-Mapped */
> +#define LINK_CONTROL_LINK_STATUS_REG  0x80
> +#define PCIE_RETRAIN_LINK_MASK        (1<<5)
> +
>  /* Synopsis specific PCIE configuration registers */
>  #define PCIE_PORT_LINK_CONTROL		0x710
>  #define PORT_LINK_MODE_MASK		(0x3f << 16)
> @@ -706,6 +712,15 @@ static struct pci_ops dw_pcie_ops = {
>  	.write = dw_pcie_wr_conf,
>  };
>  
> +void dw_pcie_link_retrain(struct pcie_port *pp)
> +{
> +	u32 val = 0;
> +
> +	dw_pcie_readl_rc(pp, LINK_CONTROL_LINK_STATUS_REG, &val);
> +	val = val | PCIE_RETRAIN_LINK_MASK;
> +	dw_pcie_writel_rc(pp, val, LINK_CONTROL_LINK_STATUS_REG);
> +}
> +
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>  	u32 val;
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index 2356d29..249b631 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -79,5 +79,6 @@ void dw_pcie_msi_init(struct pcie_port *pp);
>  int dw_pcie_link_up(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);
> +void dw_pcie_link_retrain(struct pcie_port *pp);
>  
>  #endif /* _PCIE_DESIGNWARE_H */
> diff --git a/drivers/pci/host/pcie-snpsdev.c b/drivers/pci/host/pcie-snpsdev.c
> new file mode 100644
> index 0000000..5721da9
> --- /dev/null
> +++ b/drivers/pci/host/pcie-snpsdev.c
> @@ -0,0 +1,342 @@
> +/*
> + * PCIe RC driver for Synopsys Designware Core
> + *
> + * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
> + *
> + * Authors: Manjunath Bettegowda <manjumb@synopsys.com>,
> + *	    Jie Deng <jiedeng@synopsys.com>
> + *	    Joao Pinto <jpinto@synopsys.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/signal.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_snpsdev_pcie(x)	container_of(x, struct snpsdev_pcie, pp)
> +
> +struct snpsdev_pcie {
> +	void __iomem		*mem_base; /* Memory Base to access Core's [RC]
> +					    * Config Space Layout
> +					    */
> +	struct pcie_port	pp;        /* RC Root Port specific structure -
> +					    * DWC_PCIE_RC stuff
> +					    */
> +};
> +
> +#define SIZE_1GB 0x40000000
> +#define PCI_EQUAL_CONTROL_PHY 0x00000707
> +
> +/* PCIe Port Logic registers (memory-mapped) */
> +#define PLR_OFFSET 0x700
> +#define PCIE_PHY_DEBUG_R0 (PLR_OFFSET + 0x28) /* 0x728 */
> +#define PCIE_PHY_DEBUG_R1 (PLR_OFFSET + 0x2c) /* 0x72c */
> +
> +/* PCIE PHY CONTROL REGISTER: Useful for cfg_phy_control GPIO outputs */

Use "PCIe" (not "PCIE") consistently in comments.

> +#define PCIE_PHY_CTRL (PLR_OFFSET + 0x114)    /* 0x814 */
> +/* PCIE PHY STATUS REGISTER: Useful for phy_cfg_status GPIO inputs */
> +#define PCIE_PHY_STAT (PLR_OFFSET + 0x110)    /* 0x810 */

These #defines are both unused anyway, so remove them.

> +
> +static void snpsdev_pcie_fixup_bridge(struct pci_dev *dev)
> +{
> +	u32 slot_cap;
> +

Remove this empty line.

> +	u16 caps_reg = pcie_caps_reg(dev) | PCI_EXP_FLAGS_SLOT;
> +
> +	pcie_capability_write_word(dev, PCI_EXP_FLAGS, caps_reg);

Per spec, the PCIe Capabilities register has no writable fields.  The
"Slot Implemented" bit (PCI_EXP_FLAGS_SLOT) is HwInit, which means
it's supposed to be initialized by firmware or hardware.  What's
happening here?

This fixup will be called for every PCI device we enumerate, including
conventional PCI devices (you have to assume somebody will use a
PCIe-to-PCI bridge with a conventional PCI device below it), PCIe Root
Ports, Switch Ports, Endpoints, etc.  Not all of these devices have
PCIe Capabilities.  I guess the pcie_capability_write_word() will
catch the non-PCIe cases, but it looks sloppy.

And I don't get this anyway; you're trying to set the "Slot
Implemented" bit for *every single device*, including Endpoints?  This
doesn't make sense.

> +	dev->pcie_flags_reg = caps_reg;
> +
> +	pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &slot_cap);
> +
> +	slot_cap = slot_cap & (~PCI_EXP_SLTCAP_SPLV);
> +	slot_cap = slot_cap | (0x30 << 7);
> +
> +	pcie_capability_write_dword(dev, PCI_EXP_SLTCAP, slot_cap);

I guess your "Slot Power Limit Value" (also HwInit) is actually
writable, and your hardware doesn't set it up correctly?

> +	if (pcibios_enable_device(dev, ~0) < 0)
> +		pr_err("PCI: synopsys device enable failed\n");

pcibios_enable_device() is normally called when a driver claims the
device and calls pci_enable_device().  Why do you want to do it here?

> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, snpsdev_pcie_fixup_bridge);
> +
> +static void snpsdev_pcie_fixup_res(struct pci_dev *dev)
> +{
> +	struct resource *res;
> +	resource_size_t size;
> +	int bar;
> +
> +	for (bar = 0; bar < 6; bar++) {

bar = PCI_STD_RESOURCES; bar <= PCI_STD_RESOURCE_END

> +		res = dev->resource + bar;
> +		size = resource_size(res);
> +
> +		if (size == SIZE_1GB) {
> +			res->start = 0;
> +			res->end   = 0;
> +			res->flags = 0;
> +		}

What's this for?  You want to invalidate any 1GB BAR on any PCI or
PCIe device in the system?  That doesn't seem safe because the device
is still responding to whatever range is in its BAR, but you're
telling Linux that range can be used for something else.

> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, snpsdev_pcie_fixup_res);
> +
> +/* This handler was created for future work */
> +static irqreturn_t snpsdev_pcie_irq_handler(int irq, void *arg)
> +{
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t snpsdev_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +
> +	dw_handle_msi_irq(pp);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void snpsdev_pcie_init_phy(struct pcie_port *pp)
> +{
> +	/* write Lane 0 Equalization Control fields register */
> +	writel(PCI_EQUAL_CONTROL_PHY, pp->dbi_base + 0x154);
> +}
> +
> +static int snpsdev_pcie_deassert_core_reset(struct pcie_port *pp)
> +{
> +	return 0;
> +}
> +
> +/*
> + * snpsdev_pcie_host_init()
> + * Platform specific host/RC initialization
> + *	a. Assert the core reset
> + *	b. Assert and deassert phy reset and initialize the phy
> + *	c. De-Assert the core reset
> + *	d. Initializet the Root Port (BARs/Memory Or IO/ Interrupt/ Commnad Reg)
> + *	e. Initiate Link startup procedure
> + *
> + */
> +static void snpsdev_pcie_host_init(struct pcie_port *pp)
> +{
> +	int count = 0;
> +
> +	/* Initialize Phy (Reset/poweron/control-inputs ) */
> +	snpsdev_pcie_init_phy(pp);
> +
> +	/* de-assert core reset */
> +	snpsdev_pcie_deassert_core_reset(pp);
> +
> +	/* We expect the PCIE Link to be up by this time */
> +	dw_pcie_setup_rc(pp);
> +
> +	/* Start LTSSM here */
> +	dw_pcie_link_retrain(pp);
> +
> +	/* Check for Link up indication */
> +	while (!dw_pcie_link_up(pp)) {
> +		usleep_range(1000, 1100);
> +		count++;
> +		if (count == 20) {
> +			dev_err(pp->dev, "phy link never came up\n");
> +			dev_dbg(pp->dev,
> +				"PL_DEBUG0: 0x%08x, DEBUG_R1: 0x%08x\n",
> +				readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
> +				readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
> +			break;
> +		}
> +	}
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +}
> +/**
> + *
> + * Let all outof band signalling be handled by cfg_phy_control[31:0]

s/outof/out of/

> + * which is selected through optional config attribute PHY_CONTROL_REG

This comment doesn't seem very useful because there's no code that
does anything with PCIE_PHY_CTRL.

> + *
> + * Monitor cxpl_debug_info as required to take necessary action
> + * This is available in the register PCIE_PHY_DEBUG_R0 & PCIE_PHY_DEBUG_R1

This also seems to talk about something that's not implemented yet.

> + *
> + */
> +static int snpsdev_pcie_link_up(struct pcie_port *pp)
> +{
> +	u32 status;
> +
> +	/* Bit number 36: reports LTSSM PHY Link UP; Available in bit 3 of
> +	 * PCIE_PHY_DEBUG_R1
> +	 */
> +	status = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) & (0x1 << 4);
> +	if (status != 0)
> +		return 1;
> +
> +	/* TODO:Now Link is in L0;Initiate GEN2/GEN3 migration if RC Supports*/
> +	return 0;
> +}
> +
> +
> +/**
> + * This is RC operation structure
> + * snpsdev_pcie_link_up: the function which initiates the phy link up procedure
> + * snpsdev_pcie_host_init: the function whihc does the host/RC Root port

s/whihc/which/

> + * initialization.
> + */
> +static struct pcie_host_ops snpsdev_pcie_host_ops = {
> +	.link_up = snpsdev_pcie_link_up,
> +	.host_init = snpsdev_pcie_host_init,
> +};
> +
> +/**
> + * snpsdev_add_pcie_port
> + * This function
> + * a. installs the interrupt handler
> + * b. registers host operations int he pcie_port structure

s/int he/in the/

> + */
> +static int snpsdev_add_pcie_port(struct pcie_port *pp,
> +				 struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	pp->irq = platform_get_irq(pdev, 1);
> +
> +	if (pp->irq < 0) {
> +		if (pp->irq != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "cannot get irq\n");
> +		return pp->irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, pp->irq, snpsdev_pcie_irq_handler,
> +				IRQF_SHARED, "snpsdev-pcie", pp);
> +
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request irq\n");
> +		return ret;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq(pdev, 0);
> +
> +		if (pp->msi_irq < 0) {
> +			if (pp->msi_irq != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "cannot get msi irq\n");
> +			return pp->msi_irq;
> +		}
> +
> +		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
> +					snpsdev_pcie_msi_irq_handler,
> +					IRQF_SHARED, "snpsdev-pcie-msi", pp);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to request msi irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &snpsdev_pcie_host_ops;
> +
> +	/* Below function:
> +	 * Checks for range property from DT
> +	 * Gets the IO and MEMORY and CONFIG-Space ranges from DT
> +	 * Does IOREMAPS on the physical addresses
> +	 * Gets the num-lanes from DT
> +	 * Gets MSI capability from DT
> +	 * Calls the platform specific host initialization
> +	 * Program the correct class, BAR0, Link width, in Config space
> +	 * Then it calls pci common init routine
> +	 * Then it calls function to assign "unassigned resources"
> +	 */
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * snpsdev_pcie_rc_probe()
> + * This function gets called as part of pcie registration. if the id matches
> + * the platform driver framework will call this function.
> + *
> + * @pdev: Pointer to the platform_device structure
> + *
> + * Returns zero on success; Negative errorno on failure
> + */
> +static int __init snpsdev_pcie_rc_probe(struct platform_device *pdev)
> +{
> +	struct snpsdev_pcie *snpsdev_pcie;
> +	struct pcie_port *pp;
> +	struct resource *dwc_pcie_rc_res;  /* Resource from DT */
> +	int ret;
> +
> +	snpsdev_pcie = devm_kzalloc(&pdev->dev, sizeof(*snpsdev_pcie),
> +					GFP_KERNEL);
> +	if (!snpsdev_pcie)
> +		return -ENOMEM;
> +
> +	pp = &snpsdev_pcie->pp;
> +	pp->dev = &pdev->dev;
> +
> +	dwc_pcie_rc_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (!dwc_pcie_rc_res)
> +		return -ENODEV;
> +
> +	snpsdev_pcie->mem_base = devm_ioremap_resource(&pdev->dev,
> +							dwc_pcie_rc_res);
> +	if (IS_ERR(snpsdev_pcie->mem_base)) {
> +		ret = PTR_ERR(snpsdev_pcie->mem_base);
> +		return ret;
> +	}
> +	pp->dbi_base = snpsdev_pcie->mem_base;
> +
> +	ret = snpsdev_add_pcie_port(pp, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, snpsdev_pcie);
> +
> +	return 0;
> +}
> +
> +static int __exit snpsdev_pcie_rc_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static const struct of_device_id snpsdev_pcie_rc_of_match[] = {
> +	{ .compatible = "snps,pcie-snpsdev", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, snpsdev_pcie_rc_of_match);
> +
> +static struct platform_driver snpsdev_pcie_rc_driver = {
> +	.remove		= __exit_p(snpsdev_pcie_rc_remove),
> +	.driver = {
> +		.name	= "pcie-snpsdev",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = snpsdev_pcie_rc_of_match,
> +	},
> +};
> +
> +static int __init snpsdev_pcie_init(void)
> +{
> +	return platform_driver_probe(&snpsdev_pcie_rc_driver,
> +					snpsdev_pcie_rc_probe);
> +}
> +subsys_initcall(snpsdev_pcie_init);
> +
> +MODULE_AUTHOR("Manjunath Bettegowda <manjumb@synopsys.com>");
> +MODULE_DESCRIPTION("Platform Driver for Synopsys Device");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
