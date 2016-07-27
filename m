Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45404 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbcG0SWm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Jul 2016 14:22:42 -0400
Date: Wed, 27 Jul 2016 13:22:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v7 2/2] PCI: Rockchip: Add Rockchip PCIe controller
 support
Message-ID: <20160727182233.GB8901@localhost>
References: <1468802533-17699-1-git-send-email-shawn.lin@rock-chips.com>
 <1468802533-17699-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468802533-17699-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

I have some relatively minor comments below.

On Mon, Jul 18, 2016 at 08:42:13AM +0800, Shawn Lin wrote:
> This patch adds Rockchip PCIe controller support found
> on RK3399 Soc platform.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v7:
> - make it as a build-in driver
> - improve gen1/2 training timeout checking
> - only clear known interrupt
> - fix INTx for 0-base index
> 
> Changes in v6:
> - use "depends on PCI_MSI_IRQ_DOMAIN" suggested by Arnd
> 
> Changes in v5:
> - handle multiple pending INTx at the same time
>   suggested by Marc
> 
> Changes in v4:
> - address the comments from Brain
> 
> Changes in v3:
> - remove header file
> - remove struct msi_controller and move most of variables
>   of rockchip_pcie_port to become the local ones.
> - allow legacy int even if enabling MSI
> - drop regulator set voltage operation suggested by Doug
> 
> Changes in v2:
> - remove phy related stuff and call phy API
> - add new head file and define lots of macro to make
>   the code more readable
> - remove lots msi related code suggested by Marc
> - add IO window address translation
> - init_port and parse_dt reconstruction suggested by Bharat
> - improve wr_own_conf suggested by Arnd
> - make pcie as an interrupt controller and fix wrong int handler
>   suggested by Marc
> - remove PCI_PROBE_ONLY suggested by Lorenzo
> 
>  drivers/pci/host/Kconfig         |   11 +
>  drivers/pci/host/Makefile        |    1 +
>  drivers/pci/host/pcie-rockchip.c | 1233 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1245 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-rockchip.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index c917e2f..4d714d2 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -264,4 +264,15 @@ config PCIE_ARTPEC6
>  	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
>  	  SoCs.  This PCIe controller uses the DesignWare core.
>  
> +config PCIE_ROCKCHIP
> +	bool "Rockchip PCIe controller"
> +	depends on ARM64 && ARCH_ROCKCHIP
> +	depends on OF
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select MFD_SYSCON
> +	help
> +	  Say Y here if you want internal PCI support on Rockchip SoC.
> +	  There is 1 internal PCIe port available to support GEN2 with
> +	  4 slots.
> +
>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 5bc0af2..695f716 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> +obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> new file mode 100644
> index 0000000..8a1fef1
> --- /dev/null
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -0,0 +1,1233 @@
> +/*
> + * Rockchip AXI PCIe host controller driver
> + *
> + * Copyright (c) 2016 Rockchip, Inc.
> + *
> + * Author: Shawn Lin <shawn.lin@rock-chips.com>
> + *         Wenrui Li <wenrui.li@rock-chips.com>
> + *
> + * Bits taken from Synopsys Designware Host controller driver and
> + * ARM PCI Host generic driver.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/pci_ids.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/regmap.h>
> +
> +#define PCIE_CLIENT_BASE                0x0
> +#define PCIE_RC_CONFIG_NORMAL_BASE      0x800000
> +#define PCIE_RC_CONFIG_BASE             0xa00000
> +#define PCIE_CORE_LINK_CTRL_STATUS      0x8000d0
> +#define PCIE_CORE_CTRL_MGMT_BASE        0x900000
> +#define PCIE_CORE_AXI_CONF_BASE         0xc00000
> +#define PCIE_CORE_AXI_INBOUND_BASE      0xc00800
> +#define PCIE_CLIENT_BASIC_STATUS0       0x44
> +#define PCIE_CLIENT_BASIC_STATUS1       0x48
> +#define PCIE_CLIENT_INT_MASK            0x4c
> +#define PCIE_CLIENT_INT_STATUS          0x50
> +#define PCIE_RC_CONFIG_RID_CCR          0x8
> +#define PCIE_RC_CONFIG_LCS              0xd0
> +#define PCIE_RC_BAR_CONF                0x300
> +#define PCIE_CORE_OB_REGION_ADDR1       0x4
> +#define PCIE_CORE_OB_REGION_DESC0       0x8
> +#define PCIE_CORE_OB_REGION_DESC1       0xc
> +#define PCIE_RP_IB_ADDR_TRANS           0x4
> +#define PCIE_CORE_INT_MASK              0x900210
> +#define PCIE_CORE_INT_STATUS            0x90020c
> +
> +/* Size of one AXI Region (not Region 0) */
> +#define AXI_REGION_SIZE                 BIT(20)
> +/* Size of Region 0, equal to sum of sizes of other regions */
> +#define AXI_REGION_0_SIZE              (32 * (0x1 << 20))
> +#define OB_REG_SIZE_SHIFT               5
> +#define IB_ROOT_PORT_REG_SIZE_SHIFT     3
> +#define AXI_WRAPPER_IO_WRITE            0x6
> +#define AXI_WRAPPER_MEM_WRITE           0x2
> +#define MAX_AXI_IB_ROOTPORT_REGION_NUM  3
> +#define MIN_AXI_ADDR_BITS_PASSED        8
> +#define ROCKCHIP_VENDOR_ID              0x1d87
> +#define PCIE_ECAM_BUS(x)		(((x) & 0xFF) << 20)

Use lowercase consistently for hex constants (or uppercase, but you
started with lowercase above).

> +#define PCIE_ECAM_DEV(x)		(((x) & 0x1F) << 15)
> +#define PCIE_ECAM_FUNC(x)		(((x) & 0x7) << 12)
> +#define PCIE_ECAM_REG(x)		(((x) & 0xFFF) << 0)
> +#define PCIE_ECAM_ADDR(bus, dev, func, reg) \
> +	  (PCIE_ECAM_BUS(bus) | PCIE_ECAM_DEV(dev) | \
> +	   PCIE_ECAM_FUNC(func) | PCIE_ECAM_REG(reg))
> +
> +/*
> +  * The higher 16-bit of this register is used for write protection
> +  * only if BIT(x + 16) set to 1 the BIT(x) can be written.
> +  */
> +#define HIWORD_UPDATE(val, mask, shift) \
> +	((val) << (shift) | (mask) << ((shift) + 16))
> +
> +#define RC_REGION_0_ADDR_TRANS_H        0x00000000
> +#define RC_REGION_0_ADDR_TRANS_L        0x00000000
> +#define RC_REGION_0_PASS_BITS           (25 - 1)
> +#define RC_REGION_1_ADDR_TRANS_H        0x00000000
> +#define RC_REGION_1_ADDR_TRANS_L        0x00400000
> +#define RC_REGION_1_PASS_BITS           (20 - 1)
> +#define MAX_AXI_WRAPPER_REGION_NUM      33
> +#define PCIE_CORE_LCSR_RETRAIN_LINK     BIT(5)
> +#define PCIE_CLIENT_CONF_ENABLE         1
> +#define PCIE_CLIENT_CONF_ENABLE_SHIFT   0
> +#define PCIE_CLIENT_CONF_ENABLE_MASK    0x1
> +#define PCIE_CLIENT_LINK_TRAIN_ENABLE   1
> +#define PCIE_CLIENT_LINK_TRAIN_SHIFT    1
> +#define PCIE_CLIENT_LINK_TRAIN_MASK     0x1
> +#define PCIE_CLIENT_ARI_ENABLE          1
> +#define PCIE_CLIENT_ARI_ENABLE_SHIFT    3
> +#define PCIE_CLIENT_ARI_ENABLE_MASK     0x1
> +#define PCIE_CLIENT_CONF_LANE_NUM(x)    (x / 2)
> +#define PCIE_CLIENT_CONF_LANE_NUM_SHIFT 4
> +#define PCIE_CLIENT_CONF_LANE_NUM_MASK  0x3
> +#define PCIE_CLIENT_MODE_RC             1
> +#define PCIE_CLIENT_MODE_SHIFT          6
> +#define PCIE_CLIENT_MODE_MASK           0x1
> +#define PCIE_CLIENT_GEN_SEL_2           1
> +#define PCIE_CLIENT_GEN_SEL_1           0
> +#define PCIE_CLIENT_GEN_SEL_SHIFT       7
> +#define PCIE_CLIENT_GEN_SEL_MASK        0x1
> +#define PCIE_CLIENT_LINK_STATUS_UP      0x3
> +#define PCIE_CLIENT_LINK_STATUS_SHIFT   20
> +#define PCIE_CLIENT_LINK_STATUS_MASK    0x3
> +#define PCIE_CORE_PL_CONF_SPEED_2_5G     0x0
> +#define PCIE_CORE_PL_CONF_SPEED_5G     0x1
> +#define PCIE_CORE_PL_CONF_SPEED_8G     0x2
> +#define PCIE_CORE_PL_CONF_SPEED_SHIFT   3
> +#define PCIE_CORE_PL_CONF_SPEED_MASK    0x3
> +#define PCIE_CORE_PL_CONF_LANE_SHIFT    1
> +#define PCIE_CORE_PL_CONF_LANE_MASK     0x3
> +#define PCIE_CORE_RC_CONF_SCC_SHIFT     16
> +
> +/* PCIE_CLIENT_INT_STATUS */
> +#define PCIE_CLIENT_INT_LEGACY_DONE     BIT(15)
> +#define PCIE_CLIENT_INT_MSG             BIT(14)
> +#define PCIE_CLIENT_INT_HOT_RST         BIT(13)
> +#define PCIE_CLIENT_INT_DPA             BIT(12)
> +#define PCIE_CLIENT_INT_FATAL_ERR       BIT(11)
> +#define PCIE_CLIENT_INT_NFATAL_ERR      BIT(10)
> +#define PCIE_CLIENT_INT_CORR_ERR        BIT(9)
> +#define PCIE_CLIENT_INT_INTD            BIT(8)
> +#define PCIE_CLIENT_INT_INTC            BIT(7)
> +#define PCIE_CLIENT_INT_INTB            BIT(6)
> +#define PCIE_CLIENT_INT_INTA            BIT(5)
> +#define PCIE_CLIENT_INT_LOCAL           BIT(4)
> +#define PCIE_CLIENT_INT_UDMA            BIT(3)
> +#define PCIE_CLIENT_INT_PHY             BIT(2)
> +#define PCIE_CLIENT_INT_HOT_PLUG        BIT(1)
> +#define PCIE_CLIENT_INT_PWR_STCG        BIT(0)
> +#define PCIE_CORE_INT_PRFPE             BIT(0)
> +#define PCIE_CORE_INT_CRFPE             BIT(1)
> +#define PCIE_CORE_INT_RRPE              BIT(2)
> +#define PCIE_CORE_INT_PRFO              BIT(3)
> +#define PCIE_CORE_INT_CRFO              BIT(4)
> +#define PCIE_CORE_INT_RT                BIT(5)
> +#define PCIE_CORE_INT_RTR               BIT(6)
> +#define PCIE_CORE_INT_PE                BIT(7)
> +#define PCIE_CORE_INT_MTR               BIT(8)
> +#define PCIE_CORE_INT_UCR               BIT(9)
> +#define PCIE_CORE_INT_FCE               BIT(10)
> +#define PCIE_CORE_INT_CT                BIT(11)
> +#define PCIE_CORE_INT_UTC               BIT(18)
> +#define PCIE_CORE_INT_MMVC              BIT(19)

It's conventional to put the register bits immediately below the
register offset itself, e.g.,

  #define PCIE_CLIENT_INT_STATUS          0x50
  #define  PCIE_CLIENT_INT_LEGACY_DONE     BIT(15)
  #define  PCIE_CLIENT_INT_MSG             BIT(14)
  ...

> +#define ROCKCHIP_PCIE_RPIFR1_INTR_MASK  GENMASK(8, 5)
> +#define ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT 5
> +
> +#define PCIE_CORE_INT \
> +		(PCIE_CORE_INT_PRFPE | PCIE_CORE_INT_CRFPE | \
> +		 PCIE_CORE_INT_RRPE | PCIE_CORE_INT_CRFO | \
> +		 PCIE_CORE_INT_RT | PCIE_CORE_INT_RTR | \
> +		 PCIE_CORE_INT_PE | PCIE_CORE_INT_MTR | \
> +		 PCIE_CORE_INT_UCR | PCIE_CORE_INT_FCE | \
> +		 PCIE_CORE_INT_CT | PCIE_CORE_INT_UTC | \
> +		 PCIE_CORE_INT_MMVC)
> +
> +#define PCIE_CLIENT_INT_SUBSYSTEM \
> +	(PCIE_CLIENT_INT_PWR_STCG | PCIE_CLIENT_INT_HOT_PLUG | \
> +	PCIE_CLIENT_INT_PHY | PCIE_CLIENT_INT_UDMA | \
> +	PCIE_CLIENT_INT_LOCAL)
> +
> +#define PCIE_CLIENT_INT_LEGACY \
> +	(PCIE_CLIENT_INT_INTA | PCIE_CLIENT_INT_INTB | \
> +	PCIE_CLIENT_INT_INTC | PCIE_CLIENT_INT_INTD)
> +
> +#define PCIE_CLIENT_INT_CLI \
> +	(PCIE_CLIENT_INT_CORR_ERR | PCIE_CLIENT_INT_NFATAL_ERR | \
> +	PCIE_CLIENT_INT_FATAL_ERR | PCIE_CLIENT_INT_DPA | \
> +	PCIE_CLIENT_INT_HOT_RST | PCIE_CLIENT_INT_MSG | \
> +	PCIE_CLIENT_INT_LEGACY_DONE | PCIE_CLIENT_INT_LEGACY)
> +
> +struct rockchip_pcie_port {
> +	void	__iomem *reg_base;
> +	void	__iomem *apb_base;
> +	struct	phy *phy;
> +	struct	reset_control *core_rst;
> +	struct	reset_control *mgmt_rst;
> +	struct	reset_control *mgmt_sticky_rst;
> +	struct	reset_control *pipe_rst;
> +	struct	clk *aclk_pcie;
> +	struct	clk *aclk_perf_pcie;
> +	struct	clk *hclk_pcie;
> +	struct	clk *clk_pcie_pm;
> +	struct	regulator *vpcie3v3; /* 3.3V power supply */
> +	struct	regulator *vpcie1v8; /* 1.8V power supply */
> +	struct	regulator *vpcie0v9; /* 0.9V power supply */
> +	struct	gpio_desc *ep_gpio;
> +	u32	lanes;
> +	u8	root_bus_nr;
> +	struct	device *dev;
> +	struct	irq_domain *irq_domain;
> +};
> +
> +static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg);
> +static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg);
> +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc);

If you reorder the code slightly, you can probably get rid of these
forward declarations.

> +static inline u32 pcie_read(struct rockchip_pcie_port *port, u32 reg)
> +{
> +	return readl(port->apb_base + reg);
> +}
> +
> +static inline void pcie_write(struct rockchip_pcie_port *port,
> +			      u32 val, u32 reg)
> +{
> +	writel(val, port->apb_base + reg);
> +}
> +
> +static int rockchip_pcie_valid_config(struct rockchip_pcie_port *pp,
> +				      struct pci_bus *bus, int dev)
> +{
> +	/* access only one slot on each root port */
> +	if (bus->number == pp->root_bus_nr && dev > 0)
> +		return 0;
> +
> +	/*
> +	 * do not read more than one device on the bus directly attached
> +	 * to RC's (Virtual Bridge's) DS side.

Does "DS" mean "downstream"?  Spell it out, please.  Unless "Virtual
Bridge" means something specific to Rockchip, you can omit that.  My guess
is that this is just the same as every other Root Complex and we don't need
a "Virtual Bridge" reminder.

> +	 */
> +	if (bus->primary == pp->root_bus_nr && dev > 0)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int rockchip_pcie_rd_own_conf(struct rockchip_pcie_port *pp,
> +				     int where, int size,
> +				     u32 *val)
> +{
> +	void __iomem *addr = pp->apb_base + PCIE_RC_CONFIG_BASE + where;
> +
> +	if (!IS_ALIGNED((uintptr_t)addr, size)) {
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	if (size == 4) {
> +		*val = readl(addr);
> +	} else if (size == 2) {
> +		*val = readw(addr);
> +	} else if (size == 1) {
> +		*val = readb(addr);
> +	} else {
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int rockchip_pcie_wr_own_conf(struct rockchip_pcie_port *pp,
> +				     int where, int size, u32 val)
> +{
> +	u32 mask, tmp, offset;
> +
> +	offset = (where & (~0x3));
> +
> +	if (size == 4) {
> +		writel(val, pp->apb_base + PCIE_RC_CONFIG_BASE + offset);
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
> +
> +	tmp = readl(pp->apb_base + PCIE_RC_CONFIG_BASE + offset) & mask;
> +	tmp |= val << ((where & 0x3) * 8);
> +	writel(tmp, pp->apb_base + PCIE_RC_CONFIG_BASE + offset);

This read/modify/write is not safe in general for config space because
it may inadvertently clear RW1C bits.

If your hardware actually does support 1, 2, and 4-byte accesses,
please use those instead.  Or, if this is used for only built-in
hardware and you know where every RW1C bit is, you can do something
like thunder_pem_bridge_write() does to handle them correctly.

If the hardware doesn't support small writes, and you have to support
arbitrary devices, this is a hardware quality of implementation issue
that may cause hard-to-reproduce problems, so please add a dev_warn in
the probe function similar to that in pcie-hisi.c.

> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *pp,
> +				       struct pci_bus *bus, u32 devfn,
> +				       int where, int size, u32 *val)
> +{
> +	u32 busdev;
> +
> +	busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
> +				PCI_FUNC(devfn), where);
> +
> +	if (!IS_ALIGNED(busdev, size)) {
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	if (size == 4) {
> +		*val = readl(pp->reg_base + busdev);
> +	} else if (size == 2) {
> +		*val = readw(pp->reg_base + busdev);
> +	} else if (size == 1) {
> +		*val = readb(pp->reg_base + busdev);
> +	} else {
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int rockchip_pcie_wr_other_conf(struct rockchip_pcie_port *pp,
> +				       struct pci_bus *bus, u32 devfn,
> +				       int where, int size, u32 val)
> +{
> +	u32 busdev;
> +
> +	busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
> +				PCI_FUNC(devfn), where);
> +	if (!IS_ALIGNED(busdev, size))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	if (size == 4)
> +		writel(val, pp->reg_base + busdev);
> +	else if (size == 2)
> +		writew(val, pp->reg_base + busdev);
> +	else if (size == 1)
> +		writeb(val, pp->reg_base + busdev);
> +	else
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
> +				 int size, u32 *val)
> +{
> +	struct rockchip_pcie_port *pp = bus->sysdata;
> +	int ret;
> +
> +	if (rockchip_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
> +		*val = 0xffffffff;
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	if (bus->number != pp->root_bus_nr)
> +		ret = rockchip_pcie_rd_other_conf(pp, bus, devfn,
> +						  where, size, val);
> +	else
> +		ret = rockchip_pcie_rd_own_conf(pp, where, size, val);

Reorganize these so the test is positive and no temporary "ret" is
needed, i.e.,

  if (bus->number == pp->root_bus_nr)
    return rockchip_pcie_rd_own_conf(pp, where, size, val);

  return rockchip_pcie_rd_other_conf(pp, bus, devfn, ...)

> +
> +	return ret;
> +}
> +
> +static int rockchip_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> +				 int where, int size, u32 val)
> +{
> +	struct rockchip_pcie_port *pp = bus->sysdata;
> +	int ret;
> +
> +	if (rockchip_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (bus->number != pp->root_bus_nr)
> +		ret = rockchip_pcie_wr_other_conf(pp, bus, devfn,
> +						  where, size, val);
> +	else
> +		ret = rockchip_pcie_wr_own_conf(pp, where, size, val);
> +
> +	return ret;
> +}
> +
> +static struct pci_ops rockchip_pcie_ops = {
> +	.read = rockchip_pcie_rd_conf,
> +	.write = rockchip_pcie_wr_conf,
> +};
> +
> +/**
> + * rockchip_pcie_init_port - Initialize hardware
> + * @port: PCIe port information
> + */
> +static int rockchip_pcie_init_port(struct rockchip_pcie_port *port)
> +{
> +	int err;
> +	u32 status;
> +	unsigned long timeout;
> +
> +	gpiod_set_value(port->ep_gpio, 0);
> +
> +	err = phy_init(port->phy);
> +	if (err < 0) {
> +		dev_err(port->dev, "fail to init phy, err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(port->core_rst);
> +	if (err) {
> +		dev_err(port->dev, "assert core_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(port->mgmt_rst);
> +	if (err) {
> +		dev_err(port->dev, "assert mgmt_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(port->mgmt_sticky_rst);
> +	if (err) {
> +		dev_err(port->dev, "assert mgmt_sticky_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(port->pipe_rst);
> +	if (err) {
> +		dev_err(port->dev, "assert pipe_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	pcie_write(port,
> +		   HIWORD_UPDATE(PCIE_CLIENT_CONF_ENABLE,
> +				 PCIE_CLIENT_CONF_ENABLE_MASK,
> +				 PCIE_CLIENT_CONF_ENABLE_SHIFT) |
> +		   HIWORD_UPDATE(PCIE_CLIENT_CONF_LANE_NUM(port->lanes),
> +				 PCIE_CLIENT_CONF_LANE_NUM_MASK,
> +				 PCIE_CLIENT_CONF_LANE_NUM_SHIFT) |
> +		   HIWORD_UPDATE(PCIE_CLIENT_MODE_RC,
> +				 PCIE_CLIENT_MODE_MASK,
> +				 PCIE_CLIENT_MODE_SHIFT) |
> +		   HIWORD_UPDATE(PCIE_CLIENT_ARI_ENABLE,
> +				 PCIE_CLIENT_ARI_ENABLE_MASK,
> +				 PCIE_CLIENT_ARI_ENABLE_SHIFT) |
> +		   HIWORD_UPDATE(PCIE_CLIENT_GEN_SEL_2,
> +				 PCIE_CLIENT_GEN_SEL_MASK,
> +				 PCIE_CLIENT_GEN_SEL_SHIFT),
> +		   PCIE_CLIENT_BASE);
> +
> +	err = phy_power_on(port->phy);
> +	if (err) {
> +		dev_err(port->dev, "fail to power on phy, err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_deassert(port->core_rst);
> +	if (err) {
> +		dev_err(port->dev, "deassert core_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_deassert(port->mgmt_rst);
> +	if (err) {
> +		dev_err(port->dev, "deassert mgmt_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_deassert(port->mgmt_sticky_rst);
> +	if (err) {
> +		dev_err(port->dev, "deassert mgmt_sticky_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_deassert(port->pipe_rst);
> +	if (err) {
> +		dev_err(port->dev, "deassert pipe_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	/* Enable Gen1 training */
> +	pcie_write(port,
> +		   HIWORD_UPDATE(PCIE_CLIENT_LINK_TRAIN_ENABLE,
> +				 PCIE_CLIENT_LINK_TRAIN_MASK,
> +				 PCIE_CLIENT_LINK_TRAIN_SHIFT),
> +		   PCIE_CLIENT_BASE);
> +
> +	gpiod_set_value(port->ep_gpio, 1);
> +
> +	/* 500ms timeout value should be enough for Gen1/2 training */
> +	timeout = jiffies + msecs_to_jiffies(500);
> +
> +	for (;;) {
> +		status = pcie_read(port, PCIE_CLIENT_BASIC_STATUS1);
> +		if (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
> +		      PCIE_CLIENT_LINK_STATUS_MASK) ==
> +		      PCIE_CLIENT_LINK_STATUS_UP) {
> +			dev_dbg(port->dev, "pcie link training gen1 pass!\n");

Capitalize as "PCIe" consistently in comments and console messages.
Similarly for "IRQ" and "ATU".

> +			break;
> +		}
> +
> +		msleep(20);
> +
> +		if (!time_before(jiffies, timeout)) {
> +			err = -ETIMEDOUT;
> +			break;
> +		}
> +
> +	}
> +
> +	/* Double check gen1 training */
> +	if (err) {
> +		status = pcie_read(port, PCIE_CLIENT_BASIC_STATUS1);
> +		err = (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
> +			PCIE_CLIENT_LINK_STATUS_MASK) ==
> +			PCIE_CLIENT_LINK_STATUS_UP) ? 0 : -ETIMEDOUT;
> +		if (err) {
> +			dev_err(port->dev, "pcie link training gen1 timeout!\n");
> +			return err;
> +		}
> +	}
> +
> +	/*
> +	 * Enable retrain for gen2. This should be configured only after
> +	 * gen1 finished.
> +	 */
> +	status = pcie_read(port,
> +			   PCIE_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
> +	status |= PCIE_CORE_LCSR_RETRAIN_LINK;
> +	pcie_write(port, status,
> +		   PCIE_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
> +
> +	timeout = jiffies + msecs_to_jiffies(500);
> +	for (;;) {
> +		status = pcie_read(port, PCIE_CORE_CTRL_MGMT_BASE);
> +		if (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
> +		     PCIE_CORE_PL_CONF_SPEED_MASK) ==
> +		     PCIE_CORE_PL_CONF_SPEED_5G) {
> +			dev_dbg(port->dev, "pcie link training gen2 pass!\n");
> +			break;
> +		}
> +
> +		msleep(20);
> +
> +		if (!time_before(jiffies, timeout)) {
> +			err = -ETIMEDOUT;
> +			break;
> +		}
> +	}
> +
> +	/* Double check gen2 training */
> +	if (err) {
> +		status = pcie_read(port, PCIE_CORE_CTRL_MGMT_BASE);
> +		err = (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
> +			PCIE_CORE_PL_CONF_SPEED_MASK) ==
> +			PCIE_CORE_PL_CONF_SPEED_5G) ? 0 : -ETIMEDOUT;
> +		if (err)
> +			dev_dbg(port->dev, "pcie link training gen2 timeout, fall back to gen1!\n");
> +	}
> +
> +	/* Check the final link with from negotiated lane counter from MGMT */

s/with/width/

> +	status = pcie_read(port, PCIE_CORE_CTRL_MGMT_BASE);
> +	status =  0x1 << ((status >> PCIE_CORE_PL_CONF_LANE_SHIFT) &
> +			   PCIE_CORE_PL_CONF_LANE_MASK);
> +	dev_dbg(port->dev, "current link width is x%d\n", status);
> +
> +	pcie_write(port, ROCKCHIP_VENDOR_ID, PCIE_RC_CONFIG_BASE);
> +	pcie_write(port, PCI_CLASS_BRIDGE_PCI << PCIE_CORE_RC_CONF_SCC_SHIFT,
> +		   PCIE_RC_CONFIG_BASE + PCIE_RC_CONFIG_RID_CCR);
> +	pcie_write(port, 0x0, PCIE_CORE_CTRL_MGMT_BASE + PCIE_RC_BAR_CONF);
> +
> +	pcie_write(port, (RC_REGION_0_ADDR_TRANS_L + RC_REGION_0_PASS_BITS),
> +		   PCIE_CORE_AXI_CONF_BASE);
> +	pcie_write(port, RC_REGION_0_ADDR_TRANS_H,
> +		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_ADDR1);
> +	pcie_write(port, 0x0080000a,
> +		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_DESC0);
> +	pcie_write(port, 0x0,
> +		   PCIE_CORE_AXI_CONF_BASE + PCIE_CORE_OB_REGION_DESC1);
> +
> +	return 0;
> +}
> +
> +/**
> + * rockchip_pcie_parse_dt - Parse Device tree
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int rockchip_pcie_parse_dt(struct rockchip_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct device_node *node = dev->of_node;
> +	struct resource *regs;
> +	int irq;
> +	int err = -ENODEV;
> +
> +	regs = platform_get_resource_byname(pdev,
> +					    IORESOURCE_MEM,
> +					    "axi-base");
> +	if (!regs) {
> +		dev_err(dev, "missing axi-base property\n");
> +		return err;

"return -ENODEV" so we don't have to look up to see what "err" was
initialized to.  Then you can remove the init.

> +	}
> +
> +	port->reg_base = devm_ioremap_resource(dev, regs);
> +	if (IS_ERR(port->reg_base))
> +		return PTR_ERR(port->reg_base);
> +
> +	regs = platform_get_resource_byname(pdev,
> +					    IORESOURCE_MEM,
> +					    "apb-base");
> +	if (!regs) {
> +		dev_err(dev, "missing apb-base property\n");
> +		return err;

Ditto.

> +	}
> +
> +	port->apb_base = devm_ioremap_resource(dev, regs);
> +	if (IS_ERR(port->apb_base))
> +		return PTR_ERR(port->apb_base);
> +
> +	port->phy = devm_phy_get(dev, "pcie-phy");
> +	if (IS_ERR(port->phy)) {
> +		if (PTR_ERR(port->phy) != -EPROBE_DEFER)
> +			dev_err(dev, "Missing phy\n");
> +		return PTR_ERR(port->phy);
> +	}
> +
> +	port->lanes = 1;
> +	err = of_property_read_u32(node, "num-lanes", &port->lanes);
> +	if (!err && ((port->lanes == 0) ||
> +		     (port->lanes == 3) ||
> +		     (port->lanes > 4))) {
> +		dev_warn(dev, "invalid num-lanes, default use one lane\n");
> +		port->lanes = 1;
> +	}
> +
> +	port->core_rst = devm_reset_control_get(dev, "core");
> +	if (IS_ERR(port->core_rst)) {
> +		if (PTR_ERR(port->core_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing core rst property in node %s\n",
> +				node->name);
> +		return PTR_ERR(port->core_rst);
> +	}
> +
> +	port->mgmt_rst = devm_reset_control_get(dev, "mgmt");
> +	if (IS_ERR(port->mgmt_rst)) {
> +		if (PTR_ERR(port->mgmt_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing mgmt rst property in node %s\n",
> +				node->name);
> +		return PTR_ERR(port->mgmt_rst);
> +	}
> +
> +	port->mgmt_sticky_rst = devm_reset_control_get(dev, "mgmt-sticky");
> +	if (IS_ERR(port->mgmt_sticky_rst)) {
> +		if (PTR_ERR(port->mgmt_sticky_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing mgmt-sticky rst property in node %s\n",
> +				node->name);
> +		return PTR_ERR(port->mgmt_sticky_rst);
> +	}
> +
> +	port->pipe_rst = devm_reset_control_get(dev, "pipe");
> +	if (IS_ERR(port->pipe_rst)) {
> +		if (PTR_ERR(port->pipe_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing pipe rst property in node %s\n",
> +				node->name);
> +		return PTR_ERR(port->pipe_rst);
> +	}
> +
> +	port->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> +	if (IS_ERR(port->ep_gpio)) {
> +		dev_err(dev, "missing ep-gpios property in node %s\n",
> +			node->name);
> +		return PTR_ERR(port->ep_gpio);
> +	}
> +
> +	port->aclk_pcie = devm_clk_get(dev, "aclk");
> +	if (IS_ERR(port->aclk_pcie)) {
> +		dev_err(dev, "aclk clock not found.\n");

Drop trailing periods, so these match the other messages.

> +		return PTR_ERR(port->aclk_pcie);
> +	}
> +
> +	port->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
> +	if (IS_ERR(port->aclk_perf_pcie)) {
> +		dev_err(dev, "aclk_perf clock not found.\n");
> +		return PTR_ERR(port->aclk_perf_pcie);
> +	}
> +
> +	port->hclk_pcie = devm_clk_get(dev, "hclk");
> +	if (IS_ERR(port->hclk_pcie)) {
> +		dev_err(dev, "hclk clock not found.\n");
> +		return PTR_ERR(port->hclk_pcie);
> +	}
> +
> +	port->clk_pcie_pm = devm_clk_get(dev, "pm");
> +	if (IS_ERR(port->clk_pcie_pm)) {
> +		dev_err(dev, "pm clock not found.\n");
> +		return PTR_ERR(port->clk_pcie_pm);
> +	}
> +
> +	irq = platform_get_irq_byname(pdev, "sys");
> +	if (irq < 0) {
> +		dev_err(dev, "missing pcie_sys IRQ resource\n");
> +		return -EINVAL;
> +	}
> +
> +	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
> +			       IRQF_SHARED, "pcie-sys", port);
> +	if (err) {
> +		dev_err(dev, "failed to request pcie subsystem irq\n");
> +		return err;
> +	}
> +
> +	irq = platform_get_irq_byname(pdev, "legacy");
> +	if (irq < 0) {
> +		dev_err(dev, "missing pcie_legacy IRQ resource\n");
> +		return -EINVAL;
> +	}
> +
> +	irq_set_chained_handler_and_data(irq,
> +					 rockchip_pcie_legacy_int_handler,
> +					 port);
> +
> +	irq = platform_get_irq_byname(pdev, "client");
> +	if (irq < 0) {
> +		dev_err(dev, "missing pcie-client IRQ resource\n");
> +		return -EINVAL;
> +	}
> +
> +	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
> +			       IRQF_SHARED, "pcie-client", port);
> +	if (err) {
> +		dev_err(dev, "failed to request pcie client irq\n");
> +		return err;
> +	}
> +
> +	port->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> +	if (IS_ERR(port->vpcie3v3)) {
> +		if (PTR_ERR(port->vpcie3v3) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(dev, "No vpcie3v3 regulator found.\n");

Lower-case "No" and drop period to match other messages.

> +	}
> +
> +	port->vpcie1v8 = devm_regulator_get_optional(dev, "vpcie1v8");
> +	if (IS_ERR(port->vpcie1v8)) {
> +		if (PTR_ERR(port->vpcie1v8) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(dev, "No vpcie1v8 regulator found.\n");
> +	}
> +
> +	port->vpcie0v9 = devm_regulator_get_optional(dev, "vpcie0v9");
> +	if (IS_ERR(port->vpcie0v9)) {
> +		if (PTR_ERR(port->vpcie0v9) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(dev, "No vpcie0v9 regulator found.\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_set_vpcie(struct rockchip_pcie_port *port)
> +{
> +	int err;
> +
> +	if (!IS_ERR(port->vpcie3v3)) {
> +		err = regulator_enable(port->vpcie3v3);
> +		if (err) {
> +			dev_err(port->dev, "Fail to enable vpcie3v3 regulator.\n");
> +			goto err_out;
> +		}
> +	}
> +
> +	if (!IS_ERR(port->vpcie1v8)) {
> +		err = regulator_enable(port->vpcie1v8);
> +		if (err) {
> +			dev_err(port->dev, "Fail to enable vpcie1v8 regulator.\n");
> +			goto err_disable_3v3;
> +		}
> +	}
> +
> +	if (!IS_ERR(port->vpcie0v9)) {
> +		err = regulator_enable(port->vpcie0v9);
> +		if (err) {
> +			dev_err(port->dev, "Fail to enable vpcie0v9 regulator.\n");
> +			goto err_disable_1v8;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_disable_1v8:
> +	if (!IS_ERR(port->vpcie1v8))
> +		regulator_disable(port->vpcie1v8);
> +err_disable_3v3:
> +	if (!IS_ERR(port->vpcie3v3))
> +		regulator_disable(port->vpcie3v3);
> +err_out:
> +	return err;
> +}
> +
> +static void rockchip_pcie_enable_interrupts(struct rockchip_pcie_port *port)
> +{
> +	pcie_write(port, (PCIE_CLIENT_INT_CLI << 16) &
> +		   (~PCIE_CLIENT_INT_CLI), PCIE_CLIENT_INT_MASK);
> +	pcie_write(port, PCIE_CORE_INT, PCIE_CORE_INT_MASK);
> +}
> +
> +static int rockchip_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +				  irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = rockchip_pcie_intx_map,
> +};
> +
> +static int rockchip_pcie_init_irq_domain(struct rockchip_pcie_port *pp)
> +{
> +	struct device *dev = pp->dev;
> +	struct device_node *intc = of_get_next_child(dev->of_node, NULL);
> +
> +	if (!intc) {
> +		dev_err(dev, "Missing child interrupt-controller node\n");
> +		return -EINVAL;
> +	}
> +
> +	pp->irq_domain = irq_domain_add_linear(intc, 4, &intx_domain_ops, pp);
> +	if (!pp->irq_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
> +{
> +	struct rockchip_pcie_port *pp = arg;
> +	u32 reg;
> +	u32 sub_reg;
> +
> +	reg = pcie_read(pp, PCIE_CLIENT_INT_STATUS);
> +	if (reg & PCIE_CLIENT_INT_LOCAL) {
> +		dev_dbg(pp->dev, "local interrupt recived\n");
> +		sub_reg = pcie_read(pp, PCIE_CORE_INT_STATUS);
> +		if (sub_reg & PCIE_CORE_INT_PRFPE)
> +			dev_dbg(pp->dev, "Parity error detected while reading from the PNP Receive FIFO RAM\n");

Lower-case these to match other messages (except for acronyms like
MSI).

> +
> +		if (sub_reg & PCIE_CORE_INT_CRFPE)
> +			dev_dbg(pp->dev, "Parity error detected while reading from the Completion Receive FIFO RAM\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_RRPE)
> +			dev_dbg(pp->dev, "Parity error detected while reading from Replay Buffer RAM\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_PRFO)
> +			dev_dbg(pp->dev, "Overflow occurred in the PNP Receive FIFO\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_CRFO)
> +			dev_dbg(pp->dev, "Overflow occurred in the Completion Receive FIFO\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_RT)
> +			dev_dbg(pp->dev, "Replay timer timed out\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_RTR)
> +			dev_dbg(pp->dev, "Replay timer rolled over after 4 transmissions of the same TLP\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_PE)
> +			dev_dbg(pp->dev, "Phy error detected on receive side\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_MTR)
> +			dev_dbg(pp->dev, "Malformed TLP received from the link\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_UCR)
> +			dev_dbg(pp->dev, "Malformed TLP received from the link\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_FCE)
> +			dev_dbg(pp->dev, "An error was observed in the flow control advertisements from the other side\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_CT)
> +			dev_dbg(pp->dev, "A request timed out waiting for completion\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_UTC)
> +			dev_dbg(pp->dev, "Unmapped TC error\n");
> +
> +		if (sub_reg & PCIE_CORE_INT_MMVC)
> +			dev_dbg(pp->dev, "MSI mask register changes\n");
> +
> +		pcie_write(pp, sub_reg, PCIE_CORE_INT_STATUS);
> +	}
> +
> +	pcie_write(pp, reg & PCIE_CLIENT_INT_LOCAL, PCIE_CLIENT_INT_STATUS);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
> +{
> +	struct rockchip_pcie_port *pp = arg;
> +	u32 reg;
> +
> +	reg = pcie_read(pp, PCIE_CLIENT_INT_STATUS);
> +	if (reg & PCIE_CLIENT_INT_LEGACY_DONE)
> +		dev_dbg(pp->dev, "legacy done interrupt recived\n");

s/recived/received/ here and below.

> +
> +	if (reg & PCIE_CLIENT_INT_MSG)
> +		dev_dbg(pp->dev, "message done interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_HOT_RST)
> +		dev_dbg(pp->dev, "hot reset interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_DPA)
> +		dev_dbg(pp->dev, "dpa interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_FATAL_ERR)
> +		dev_dbg(pp->dev, "fatal error interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_NFATAL_ERR)
> +		dev_dbg(pp->dev, "no fatal error interrupt recived\n");
> +
> +	if (reg & PCIE_CLIENT_INT_CORR_ERR)
> +		dev_dbg(pp->dev, "correctable error interrupt recived\n");
> +
> +	pcie_write(pp, reg & (PCIE_CLIENT_INT_LEGACY_DONE |
> +			      PCIE_CLIENT_INT_MSG | PCIE_CLIENT_INT_HOT_RST |
> +			      PCIE_CLIENT_INT_DPA | PCIE_CLIENT_INT_FATAL_ERR |
> +			      PCIE_CLIENT_INT_NFATAL_ERR |
> +			      PCIE_CLIENT_INT_CORR_ERR),
> +			      PCIE_CLIENT_INT_STATUS);
> +	return IRQ_HANDLED;
> +}
> +
> +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct rockchip_pcie_port *port;
> +	u32 reg;
> +	u32 hwirq;
> +	u32 virq;
> +
> +	chained_irq_enter(chip, desc);
> +	port = irq_desc_get_handler_data(desc);
> +
> +	reg = pcie_read(port, PCIE_CLIENT_INT_STATUS);
> +	reg = (reg & ROCKCHIP_PCIE_RPIFR1_INTR_MASK) >>
> +	       ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT;
> +
> +	while (reg) {
> +		hwirq = ffs(reg) - 1;
> +		reg &= ~BIT(hwirq);
> +
> +		virq = irq_find_mapping(port->irq_domain, hwirq);
> +		if (virq)
> +			generic_handle_irq(virq);
> +		else
> +			dev_err(port->dev, "unexpected IRQ, INT%d\n", hwirq);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int rockchip_pcie_prog_ob_atu(struct rockchip_pcie_port *pp,
> +				     int region_no,
> +				     int type, u8 num_pass_bits,
> +				     u32 lower_addr, u32 upper_addr)
> +{
> +	u32 ob_addr_0 = 0;
> +	u32 ob_addr_1 = 0;
> +	u32 ob_desc_0 = 0;

The above are initialized below before being used, so they don't need
to be initialized here.

> +	u32 ob_desc_1 = 0;

This is only read below.  I'd just get rid of ob_desc_1 completely and
use a "0" directly in the writel().  I don't think the variable
improves readability.

> +	void __iomem *aw_base;
> +
> +	if (!pp)
> +		return -EINVAL;

I don't think it's possible to get here with "pp == NULL", so drop the
test (also in rockchip_pcie_prog_ib_atu()).

> +	if (region_no >= MAX_AXI_WRAPPER_REGION_NUM)
> +		return -EINVAL;
> +	if ((num_pass_bits + 1) < 8)
> +		return -EINVAL;
> +	if (num_pass_bits > 63)
> +		return -EINVAL;
> +	if (region_no == 0) {
> +		if (AXI_REGION_0_SIZE < (2ULL << num_pass_bits))
> +		return -EINVAL;
> +	}
> +	if (region_no != 0) {
> +		if (AXI_REGION_SIZE < (2ULL << num_pass_bits))
> +		return -EINVAL;
> +	}
> +	aw_base = pp->apb_base + PCIE_CORE_AXI_CONF_BASE;
> +	aw_base += (region_no << OB_REG_SIZE_SHIFT);
> +
> +	ob_addr_0 = (ob_addr_0 &
> +		     ~0x0000003fU) | (num_pass_bits &
> +		     0x0000003fU);
> +	ob_addr_0 = (ob_addr_0 &
> +		     ~0xffffff00U) | (lower_addr & 0xffffff00U);

The masks with ~0x3f and ~0xffffff00 don't really make sense:
ob_addr_0 starts out as zero, so these masks are unnecessary.  You
could do something like the following and drop the initializations at
the declarations.

  ob_addr_0 = num_pass_bits & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS;
  ob_addr_0 |= lower_addr & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR;

> +	ob_addr_1 = upper_addr;
> +	ob_desc_0 = (1 << 23 | type);
> +
> +	writel(ob_addr_0, aw_base);

There should probably be a "#define PCIE_CORE_OB_REGION_ADDR0 0" above.

> +	writel(ob_addr_1, aw_base + PCIE_CORE_OB_REGION_ADDR1);
> +	writel(ob_desc_0, aw_base + PCIE_CORE_OB_REGION_DESC0);
> +	writel(ob_desc_1, aw_base + PCIE_CORE_OB_REGION_DESC1);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie_port *pp,
> +				     int region_no,
> +				     u8 num_pass_bits,
> +				     u32 lower_addr,
> +				     u32 upper_addr)
> +{
> +	u32 ib_addr_0 = 0;
> +	u32 ib_addr_1 = 0;
> +	void __iomem *aw_base;
> +
> +	if (!pp)
> +		return -EINVAL;
> +	if (region_no > MAX_AXI_IB_ROOTPORT_REGION_NUM)
> +		return -EINVAL;
> +	if ((num_pass_bits + 1) < MIN_AXI_ADDR_BITS_PASSED)
> +		return -EINVAL;
> +	if (num_pass_bits > 63)
> +		return -EINVAL;
> +	aw_base = pp->apb_base + PCIE_CORE_AXI_INBOUND_BASE;
> +	aw_base += (region_no << IB_ROOT_PORT_REG_SIZE_SHIFT);
> +	ib_addr_0 = (ib_addr_0 &
> +		     ~0x0000003fU) | (num_pass_bits &
> +		     0x0000003fU);
> +
> +	ib_addr_0 = (ib_addr_0 & ~0xffffff00U) |
> +		     ((lower_addr << 8) & 0xffffff00U);

Unnecessary masking here, too.  Drop the initializations and the
masking.

> +	ib_addr_1 = upper_addr;
> +
> +	writel(ib_addr_0, aw_base);
> +	writel(ib_addr_1, aw_base + PCIE_RP_IB_ADDR_TRANS);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_probe(struct platform_device *pdev)
> +{
> +	struct rockchip_pcie_port *port;
> +	struct device *dev = &pdev->dev;
> +	struct pci_bus *bus, *child;
> +	struct resource_entry *win;
> +	resource_size_t io_base;
> +	struct resource	*busn = NULL;
> +	struct resource	*mem = NULL;

Unnecessary initialization.

> +	struct resource	*io = NULL;

Unnecessary initialization.

> +	phys_addr_t io_bus_addr = 0;

Unnecessary initialization.

> +	u32 io_size = 0;
> +	phys_addr_t mem_bus_addr = 0;

Unnecessary initialization.

> +	u32 mem_size = 0;
> +	int reg_no = 0;

Unnecessary initialization.

> +	int err = 0;

Unnecessary initialization.

> +	int offset = 0;

Unnecessary initialization.  Initializing them unnecessarily doesn't
*break* anything, obviously, but it is a burden on the code reader,
because we have to remember, "oh, offset was initialized above, which
means there's something special about how it's used below".

> +
> +	LIST_HEAD(res);
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->dev = dev;
> +
> +	err = rockchip_pcie_parse_dt(port);
> +	if (err)
> +		return err;
> +
> +	err = clk_prepare_enable(port->aclk_pcie);
> +	if (err) {
> +		dev_err(dev, "Unable to enable aclk_pcie clock.\n");
> +		goto err_aclk_pcie;
> +	}
> +
> +	err = clk_prepare_enable(port->aclk_perf_pcie);
> +	if (err) {
> +		dev_err(dev, "Unable to enable aclk_perf_pcie clock.\n");
> +		goto err_aclk_perf_pcie;
> +	}
> +
> +	err = clk_prepare_enable(port->hclk_pcie);
> +	if (err) {
> +		dev_err(dev, "Unable to enable hclk_pcie clock.\n");
> +		goto err_hclk_pcie;
> +	}
> +
> +	err = clk_prepare_enable(port->clk_pcie_pm);
> +	if (err) {
> +		dev_err(dev, "Unable to enable hclk_pcie clock.\n");
> +		goto err_pcie_pm;
> +	}
> +
> +	err = rockchip_pcie_set_vpcie(port);
> +	if (err) {
> +		dev_err(port->dev, "Fail to set vpcie regulator.\n");
> +		goto err_set_vpcie;
> +	}
> +
> +	err = rockchip_pcie_init_port(port);
> +	if (err)
> +		goto err_vpcie;
> +
> +	platform_set_drvdata(pdev, port);
> +
> +	rockchip_pcie_enable_interrupts(port);
> +
> +	err = rockchip_pcie_init_irq_domain(port);
> +	if (err < 0)
> +		goto err_vpcie;
> +
> +	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
> +					       &res, &io_base);
> +	if (err)
> +		goto err_vpcie;

Use devm_request_pci_bus_resources() so the windows show up in
/proc/iomem.  I posted patches to do this with subject lines like
"Request host bridge window resources with core function".

> +	/* Get the I/O and memory ranges from DT */
> +	resource_list_for_each_entry(win, &res) {
> +		switch (resource_type(win->res)) {
> +		case IORESOURCE_IO:
> +			io = win->res;
> +			io->name = "I/O";
> +			io_size = resource_size(io);
> +			io_bus_addr = io->start - win->offset;
> +			err = pci_remap_iospace(io, io_base);
> +			if (err) {
> +				dev_warn(port->dev, "error %d: failed to map resource %pR\n",
> +					 err, io);
> +				continue;
> +			}
> +			break;
> +		case IORESOURCE_MEM:
> +			mem = win->res;
> +			mem->name = "MEM";
> +			mem_size = resource_size(mem);
> +			mem_bus_addr = mem->start - win->offset;
> +			break;
> +		case IORESOURCE_BUS:
> +			busn = win->res;
> +			break;
> +		default:
> +			continue;
> +		}
> +	}
> +
> +	if (mem_size)
> +		for (reg_no = 0; reg_no < (mem_size >> 20); reg_no++) {
> +			err = rockchip_pcie_prog_ob_atu(port, reg_no + 1,
> +							AXI_WRAPPER_MEM_WRITE,
> +							20 - 1,
> +							mem_bus_addr +
> +							(reg_no << 20),
> +							0);
> +			if (err) {
> +				dev_err(dev, "Program RC mem outbound atu failed\n");
> +				goto err_vpcie;
> +			}
> +		}
> +
> +	err = rockchip_pcie_prog_ib_atu(port, 2, 32 - 1, 0x0, 0);
> +	if (err) {
> +		dev_err(dev, "Program RC mem inbound atu failed\n");
> +		goto err_vpcie;
> +	}
> +
> +	offset = mem_size >> 20;
> +
> +	if (io_size)
> +		for (reg_no = 0; reg_no < (io_size >> 20); reg_no++) {
> +			err = rockchip_pcie_prog_ob_atu(port,
> +							reg_no + 1 + offset,
> +							AXI_WRAPPER_IO_WRITE,
> +							20 - 1,
> +							io_bus_addr +
> +							(reg_no << 20),
> +							0);
> +			if (err) {
> +				dev_err(dev, "Program RC io outbound atu failed\n");
> +				goto err_vpcie;
> +			}
> +		}
> +
> +	port->root_bus_nr = busn->start;

NULL pointer dereference here if the DT doesn't have an IORESOURCE_BUS
resource.

> +	bus = pci_scan_root_bus(&pdev->dev, 0,
> +				&rockchip_pcie_ops, port, &res);
> +
> +	if (!bus) {
> +		err = -ENOMEM;
> +		goto err_vpcie;
> +	}
> +
> +	pci_bus_size_bridges(bus);
> +	pci_bus_assign_resources(bus);
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +
> +	pci_bus_add_devices(bus);
> +
> +	return err;
> +
> +err_vpcie:
> +	if (!IS_ERR(port->vpcie3v3))
> +		regulator_disable(port->vpcie3v3);
> +	if (!IS_ERR(port->vpcie1v8))
> +		regulator_disable(port->vpcie1v8);
> +	if (!IS_ERR(port->vpcie0v9))
> +		regulator_disable(port->vpcie0v9);
> +err_set_vpcie:
> +	clk_disable_unprepare(port->clk_pcie_pm);
> +err_pcie_pm:
> +	clk_disable_unprepare(port->hclk_pcie);
> +err_hclk_pcie:
> +	clk_disable_unprepare(port->aclk_perf_pcie);
> +err_aclk_perf_pcie:
> +	clk_disable_unprepare(port->aclk_pcie);
> +err_aclk_pcie:
> +	return err;
> +}
> +
> +static const struct of_device_id rockchip_pcie_of_match[] = {
> +	{ .compatible = "rockchip,rk3399-pcie", },
> +	{}
> +};
> +
> +static struct platform_driver rockchip_pcie_driver = {
> +	.driver = {
> +		.name = "rockchip-pcie",
> +		.of_match_table = rockchip_pcie_of_match,
> +	},
> +	.probe = rockchip_pcie_probe,
> +
> +};
> +module_platform_driver(rockchip_pcie_driver);
> +
> +MODULE_AUTHOR("Rockchip Inc");
> +MODULE_DESCRIPTION("Rockchip AXI PCIe driver");
> +MODULE_LICENSE("GPL v2");

Per your Kconfig, this driver cannot be a module, so remove these MODULE_*
annotations.  This is to follow Paul Gortmaker's recent "Make explicitly
non-modular" work.  Also change the include of <linux/module.h> to
<linux/init.h>.
