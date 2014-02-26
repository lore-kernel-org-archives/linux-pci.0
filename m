Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:63447 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751747AbaBZQOQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 11:14:16 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1393430893-2466-1-git-send-email-phil.edworthy@renesas.com>
References: <1393430893-2466-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1393430893-2466-2-git-send-email-phil.edworthy@renesas.com>
Date: Wed, 26 Feb 2014 16:08:09 +0000
Subject: [PATCH 1/5] PCI: host: Add Renesas R-Car PCIe driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This PCIe Host driver currently does not support MSI, so cards
fall back to INTx interrupts.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/Kconfig     |    6 +
 drivers/pci/host/Makefile    |    1 +
 drivers/pci/host/pcie-rcar.c |  614 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-rcar.h |   84 ++++++
 4 files changed, 705 insertions(+)
 create mode 100644 drivers/pci/host/pcie-rcar.c
 create mode 100644 drivers/pci/host/pcie-rcar.h

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 47d46c6..b1c1787 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -33,4 +33,10 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
+config PCI_RCAR_GEN2_PCIE
+	bool "Renesas R-Car PCIe controller"
+	depends on ARM && (ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST)
+	help
+	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 13fb333..19946f9 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
+obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
new file mode 100644
index 0000000..d9a315f
--- /dev/null
+++ b/drivers/pci/host/pcie-rcar.c
@@ -0,0 +1,614 @@
+/*
+ * PCIe driver for Renesas R-Car SoCs
+ *  Copyright (C) 2013 Renesas Electronics Europe Ltd
+ *
+ * Based on:
+ *  arch/sh/drivers/pci/pcie-sh7786.c
+ *  arch/sh/drivers/pci/ops-sh7786.c
+ *  Copyright (C) 2009 - 2011  Paul Mundt
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include "pcie-rcar.h"
+
+#define DRV_NAME "rcar-pcie"
+
+enum chip_id {
+	RCAR_GENERIC,
+	RCAR_H1,
+};
+
+#define RCONF(x)	(PCICONF(0)+(x))
+#define REXPCAP(x)	(EXPCAP(0)+(x))
+#define RVCCAP(x)	(VCCAP(0)+(x))
+
+#define  PCIE_CONF_BUS(b)	(((b) & 0xff) << 24)
+#define  PCIE_CONF_DEV(d)	(((d) & 0x1f) << 19)
+#define  PCIE_CONF_FUNC(f)	(((f) & 0x7) << 16)
+
+#define NR_PCI_RESOURCES 4
+
+/* Structure representing the PCIe interface */
+struct rcar_pcie {
+	struct device		*dev;
+	void __iomem		*base;
+	int			irq;
+	struct clk		*clk;
+	struct resource		*res[NR_PCI_RESOURCES];
+	int			haslink;
+	enum chip_id		chip;
+	u8			root_bus_nr;
+};
+
+static inline struct rcar_pcie *sys_to_pcie(struct pci_sys_data *sys)
+{
+	return sys->private_data;
+}
+
+static void
+pci_write_reg(struct rcar_pcie *pcie, unsigned long val, unsigned long reg)
+{
+	writel(val, pcie->base + reg);
+}
+
+static unsigned long
+pci_read_reg(struct rcar_pcie *pcie, unsigned long reg)
+{
+	return readl(pcie->base + reg);
+}
+
+enum {
+	PCI_ACCESS_READ,
+	PCI_ACCESS_WRITE,
+};
+
+static void rcar_rmw32(struct rcar_pcie *pcie,
+			    int where, u32 mask, u32 data)
+{
+	int shift = 8 * (where & 3);
+	u32 val = pci_read_reg(pcie, where & ~3);
+	val &= ~(mask << shift);
+	val |= data << shift;
+	pci_write_reg(pcie, val, where & ~3);
+}
+
+static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
+{
+	int shift = 8 * (where & 3);
+	u32 val = pci_read_reg(pcie, where & ~3);
+	return val >> shift;
+}
+
+static int rcar_pcie_config_access(struct rcar_pcie *pcie,
+		unsigned char access_type, struct pci_bus *bus,
+		unsigned int devfn, int where, u32 *data)
+{
+	int dev, func, reg, index;
+
+	dev = PCI_SLOT(devfn);
+	func = PCI_FUNC(devfn);
+	reg = where & ~3;
+	index = reg / 4;
+
+	if (bus->number > 255 || dev > 31 || func > 7)
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+
+	/*
+	 * While each channel has its own memory-mapped extended config
+	 * space, it's generally only accessible when in endpoint mode.
+	 * When in root complex mode, the controller is unable to target
+	 * itself with either type 0 or type 1 accesses, and indeed, any
+	 * controller initiated target transfer to its own config space
+	 * result in a completer abort.
+	 *
+	 * Each channel effectively only supports a single device, but as
+	 * the same channel <-> device access works for any PCI_SLOT()
+	 * value, we cheat a bit here and bind the controller's config
+	 * space to devfn 0 in order to enable self-enumeration. In this
+	 * case the regular ECAR/ECDR path is sidelined and the mangled
+	 * config access itself is initiated as an internal bus  transaction.
+	 */
+	if (pci_is_root_bus(bus)) {
+		if (dev != 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+		if (access_type == PCI_ACCESS_READ)
+			*data = pci_read_reg(pcie, PCICONF(index));
+		else
+			pci_write_reg(pcie, *data, PCICONF(index));
+
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	/* Clear errors */
+	pci_write_reg(pcie, pci_read_reg(pcie, PCIEERRFR), PCIEERRFR);
+
+	/* Set the PIO address */
+	pci_write_reg(pcie, PCIE_CONF_BUS(bus->number) | PCIE_CONF_DEV(dev) |
+				PCIE_CONF_FUNC(func) | reg, PCIECAR);
+
+	/* Enable the configuration access */
+	if (bus->parent->number == pcie->root_bus_nr)
+		pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE0, PCIECCTLR);
+	else
+		pci_write_reg(pcie, CONFIG_SEND_ENABLE | TYPE1, PCIECCTLR);
+
+	/* Check for errors */
+	if (pci_read_reg(pcie, PCIEERRFR) & UNSUPPORTED_REQUEST)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Check for master and target aborts */
+	if (rcar_read_conf(pcie, RCONF(PCI_STATUS)) &
+		(PCI_STATUS_REC_MASTER_ABORT | PCI_STATUS_REC_TARGET_ABORT))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (access_type == PCI_ACCESS_READ)
+		*data = pci_read_reg(pcie, PCIECDR);
+	else
+		pci_write_reg(pcie, *data, PCIECDR);
+
+	/* Disable the configuration access */
+	pci_write_reg(pcie, 0, PCIECCTLR);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *val)
+{
+	struct rcar_pcie *pcie = sys_to_pcie(bus->sysdata);
+	int ret;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	ret = rcar_pcie_config_access(pcie, PCI_ACCESS_READ,
+				      bus, devfn, where, val);
+	if (ret != PCIBIOS_SUCCESSFUL) {
+		*val = 0xffffffff;
+		return ret;
+	}
+
+	if (size == 1)
+		*val = (*val >> (8 * (where & 3))) & 0xff;
+	else if (size == 2)
+		*val = (*val >> (8 * (where & 2))) & 0xffff;
+
+	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x "
+		"where=0x%04x size=%d val=0x%08lx\n", bus->number,
+		devfn, where, size, (unsigned long)*val);
+
+	return ret;
+}
+
+static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 val)
+{
+	struct rcar_pcie *pcie = sys_to_pcie(bus->sysdata);
+	int shift, ret;
+	u32 data;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	ret = rcar_pcie_config_access(pcie, PCI_ACCESS_READ,
+				      bus, devfn, where, &data);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
+
+	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x "
+		"where=0x%04x size=%d val=0x%08lx\n", bus->number,
+		devfn, where, size, (unsigned long)val);
+
+	if (size == 1) {
+		shift = 8 * (where & 3);
+		data &= ~(0xff << shift);
+		data |= ((val & 0xff) << shift);
+	} else if (size == 2) {
+		shift = 8 * (where & 2);
+		data &= ~(0xffff << shift);
+		data |= ((val & 0xffff) << shift);
+	} else
+		data = val;
+
+	ret = rcar_pcie_config_access(pcie, PCI_ACCESS_WRITE,
+				      bus, devfn, where, &data);
+
+	return ret;
+}
+
+static struct pci_ops rcar_pcie_ops = {
+	.read	= rcar_pcie_read_conf,
+	.write	= rcar_pcie_write_conf,
+};
+
+static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
+{
+	struct rcar_pcie *pcie = sys_to_pcie(sys);
+	int ret, i, win;
+
+	pcie->root_bus_nr = sys->busnr;
+
+	/* Setup IO mapped memory accesses */
+	ret = pci_ioremap_io(0, pcie->res[0]->start);
+	if (ret)
+		return ret;
+
+	/* Setup PCI resources */
+	/* Ignore first resource, as it's for IO */
+	for (i = 1; i < NR_PCI_RESOURCES; i++) {
+		struct resource *res = pcie->res[i];
+		pci_add_resource_offset(&sys->resources, res, sys->mem_offset);
+	}
+
+	/* Setup PCIe address space mappings for each resource */
+	for (i = win = 0; i < NR_PCI_RESOURCES; i++) {
+		struct resource *res = pcie->res[i];
+		resource_size_t size, bus_addr;
+		u32 mask;
+
+		pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
+
+		/*
+		 * The PAMR mask is calculated in units of 128Bytes, which
+		 * keeps things pretty simple.
+		 */
+		size = resource_size(res);
+		mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+		pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
+
+		bus_addr = i ? res->start : 0;
+		pci_write_reg(pcie, upper_32_bits(bus_addr), PCIEPARH(win));
+		pci_write_reg(pcie, lower_32_bits(bus_addr), PCIEPARL(win));
+
+		mask = PAR_ENABLE;
+		/* First resource is for IO */
+		if (i == 0)
+			mask |= IO_SPACE;
+
+		pci_write_reg(pcie, mask, PCIEPTCTLR(win));
+
+		win++;
+	}
+
+	return 1;
+}
+
+static int rcar_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct rcar_pcie *pcie = sys_to_pcie(dev->bus->sysdata);
+	return pcie->irq;
+}
+
+static void __init rcar_pcie_enable(struct rcar_pcie *pcie)
+{
+	struct hw_pci hw;
+
+	memset(&hw, 0, sizeof(hw));
+
+	hw.nr_controllers = 1;
+	hw.private_data   = (void **)&pcie;
+	hw.setup          = rcar_pcie_setup,
+	hw.map_irq        = rcar_pcie_map_irq,
+	hw.ops		  = &rcar_pcie_ops,
+
+	pci_common_init(&hw);
+}
+
+static int __init phy_wait_for_ack(struct rcar_pcie *pcie)
+{
+	unsigned int timeout = 100;
+
+	while (timeout--) {
+		if (pci_read_reg(pcie, H1_PCIEPHYADRR) & PHY_ACK)
+			return 0;
+
+		udelay(100);
+	}
+
+	dev_err(pcie->dev, "Access to PCIe phy timed out\n");
+
+	return -ETIMEDOUT;
+}
+
+static void __init phy_write_reg(struct rcar_pcie *pcie,
+				 unsigned int rate, unsigned int addr,
+				 unsigned int lane, unsigned int data)
+{
+	unsigned long phyaddr;
+
+	phyaddr = WRITE_CMD |
+		((rate & 1) << RATE_POS) |
+		((lane & 0xf) << LANE_POS) |
+		((addr & 0xff) << ADR_POS);
+
+	/* Set write data */
+	pci_write_reg(pcie, data, H1_PCIEPHYDOUTR);
+	pci_write_reg(pcie, phyaddr, H1_PCIEPHYADRR);
+
+	/* Ignore errors as they will be dealt with if the data link is down */
+	phy_wait_for_ack(pcie);
+
+	/* Clear command */
+	pci_write_reg(pcie, 0, H1_PCIEPHYDOUTR);
+	pci_write_reg(pcie, 0, H1_PCIEPHYADRR);
+
+	/* Ignore errors as they will be dealt with if the data link is down */
+	phy_wait_for_ack(pcie);
+}
+
+static int __init rcar_pcie_phy_init_rcar_h1(struct rcar_pcie *pcie)
+{
+	unsigned int timeout = 100;
+
+	/* Initialize the phy */
+	phy_write_reg(pcie, 0, 0x42, 0x1, 0x0EC34191);
+	phy_write_reg(pcie, 1, 0x42, 0x1, 0x0EC34180);
+	phy_write_reg(pcie, 0, 0x43, 0x1, 0x00210188);
+	phy_write_reg(pcie, 1, 0x43, 0x1, 0x00210188);
+	phy_write_reg(pcie, 0, 0x44, 0x1, 0x015C0014);
+	phy_write_reg(pcie, 1, 0x44, 0x1, 0x015C0014);
+	phy_write_reg(pcie, 1, 0x4C, 0x1, 0x786174A0);
+	phy_write_reg(pcie, 1, 0x4D, 0x1, 0x048000BB);
+	phy_write_reg(pcie, 0, 0x51, 0x1, 0x079EC062);
+	phy_write_reg(pcie, 0, 0x52, 0x1, 0x20000000);
+	phy_write_reg(pcie, 1, 0x52, 0x1, 0x20000000);
+	phy_write_reg(pcie, 1, 0x56, 0x1, 0x00003806);
+
+	phy_write_reg(pcie, 0, 0x60, 0x1, 0x004B03A5);
+	phy_write_reg(pcie, 0, 0x64, 0x1, 0x3F0F1F0F);
+	phy_write_reg(pcie, 0, 0x66, 0x1, 0x00008000);
+
+	while (timeout--) {
+		if (pci_read_reg(pcie, H1_PCIEPHYSR))
+			return 0;
+
+		udelay(100);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int __init rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
+{
+	unsigned int timeout = 100;
+
+	while (timeout--) {
+		if ((pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
+			return 0;
+
+		udelay(100);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void __init rcar_pcie_hw_init(struct rcar_pcie *pcie)
+{
+	/* Initialise R-Car H1 PHY & wait for it to be ready */
+	if (pcie->chip == RCAR_H1)
+		if (rcar_pcie_phy_init_rcar_h1(pcie))
+			return;
+
+	/* Begin initialization */
+	pci_write_reg(pcie, 0, PCIETCTLR);
+
+	/* Set mode */
+	pci_write_reg(pcie, 1, PCIEMSR);
+
+	/*
+	 * For target transfers, setup a single 64-bit 4GB mapping at address
+	 * 0. The hardware can only map memory that starts on a power of two
+	 * boundary, and size is power of 2, so best to ignore it.
+	 */
+	pci_write_reg(pcie, 0, PCIEPRAR(0));
+	pci_write_reg(pcie, 0, PCIELAR(0));
+	pci_write_reg(pcie, 0xfffffff0UL | LAM_PREFETCH |
+		LAM_64BIT | LAR_ENABLE, PCIELAMR(0));
+	pci_write_reg(pcie, 0, PCIELAR(1));
+	pci_write_reg(pcie, 0, PCIEPRAR(1));
+	pci_write_reg(pcie, 0, PCIELAMR(1));
+
+	/*
+	 * Initial header for port config space is type 1, set the device
+	 * class to match. Hardware takes care of propagating the IDSETR
+	 * settings, so there is no need to bother with a quirk.
+	 */
+	pci_write_reg(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
+
+	/*
+	 * Setup Secondary Bus Number & Subordinate Bus Number, even though
+	 * they aren't used, to avoid bridge being detected as broken.
+	 */
+	rcar_rmw32(pcie, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
+	rcar_rmw32(pcie, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
+
+	/* Initialize default capabilities. */
+	rcar_rmw32(pcie, REXPCAP(0), 0, PCI_CAP_ID_EXP);
+	rcar_rmw32(pcie, REXPCAP(PCI_EXP_FLAGS),
+		PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
+	rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE), 0x7f,
+		PCI_HEADER_TYPE_BRIDGE);
+
+	/* Enable data link layer active state reporting */
+	rcar_rmw32(pcie, REXPCAP(PCI_EXP_LNKCAP), 0, PCI_EXP_LNKCAP_DLLLARC);
+
+	/* Write out the physical slot number = 0 */
+	rcar_rmw32(pcie, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
+
+	/* Set the completion timer timeout to the maximum 50ms. */
+	rcar_rmw32(pcie, TLCTLR+1, 0x3f, 50);
+
+	/* Terminate list of capabilities (Next Capability Offset=0) */
+	rcar_rmw32(pcie, RVCCAP(0), 0xfff0, 0);
+
+	/* Enable MAC data scrambling. */
+	rcar_rmw32(pcie, MACCTLR, SCRAMBLE_DISABLE, 0);
+
+	/* Finish initialization - establish a PCI Express link */
+	pci_write_reg(pcie, CFINIT, PCIETCTLR);
+
+	/* This will timeout if we don't have a link. */
+	pcie->haslink = !rcar_pcie_wait_for_dl(pcie);
+
+	/* Enable INTx interrupts */
+	rcar_rmw32(pcie, RCONF(PCI_INTERRUPT_LINE), 0xff, 0);
+	rcar_rmw32(pcie, RCONF(PCI_INTERRUPT_PIN), 0xff, 1);
+	rcar_rmw32(pcie, PCIEINTXR, 0, 0xF << 8);
+
+	/* Enable slave Bus Mastering */
+	rcar_rmw32(pcie, RCONF(PCI_STATUS), PCI_STATUS_DEVSEL_MASK,
+		PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
+		PCI_STATUS_CAP_LIST | PCI_STATUS_DEVSEL_FAST);
+
+	wmb();
+}
+
+static int rcar_pcie_clocks_get(struct rcar_pcie *pcie)
+{
+	int err = 0;
+
+	pcie->clk = clk_get(pcie->dev, NULL);
+	if (IS_ERR(pcie->clk))
+		err = PTR_ERR(pcie->clk);
+	else
+		clk_enable(pcie->clk);
+
+	return err;
+}
+
+static void rcar_pcie_clocks_put(struct rcar_pcie *pcie)
+{
+	clk_put(pcie->clk);
+}
+
+struct rcar_pcie_errs {
+	int bit;
+	const char *description;
+};
+
+static int __init rcar_pcie_get_resources(struct platform_device *pdev,
+	struct rcar_pcie *pcie)
+{
+	struct resource *res;
+	int i;
+	int err;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	i = platform_get_irq(pdev, 0);
+	if (!res || i < 0) {
+		dev_err(pcie->dev, "cannot get platform resources\n");
+		return -ENOENT;
+	}
+	pcie->irq = i;
+
+	err = rcar_pcie_clocks_get(pcie);
+	if (err) {
+		dev_err(&pdev->dev, "failed to get clocks: %d\n", err);
+		return err;
+	}
+
+	pcie->base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!pcie->base) {
+		dev_err(&pdev->dev, "failed to map PCIe registers: %d\n", err);
+		err = -ENOMEM;
+		goto err_map_reg;
+	}
+
+	return 0;
+
+err_map_reg:
+	rcar_pcie_clocks_put(pcie);
+
+	return err;
+}
+
+static struct platform_device_id rcar_pcie_id_table[] = {
+	{ "r8a7779-pcie", RCAR_H1 },
+	{ "r8a7790-pcie", RCAR_GENERIC },
+	{ "r8a7791-pcie", RCAR_GENERIC },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, rcar_pcie_id_table);
+
+static int __init rcar_pcie_probe(struct platform_device *pdev)
+{
+	struct rcar_pcie *pcie;
+	struct resource *res;
+	unsigned int data;
+	int i, err;
+
+	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->dev = &pdev->dev;
+	pcie->chip = pdev->id_entry->driver_data;
+
+	/* Get resources */
+	err = rcar_pcie_get_resources(pdev, pcie);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to request resources: %d\n", err);
+		return err;
+	}
+
+	/* Get the I/O and memory ranges */
+	for (i = 0; i < NR_PCI_RESOURCES; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i+1);
+		if (!res) {
+			dev_err(&pdev->dev, "cannot get MEM%d resources\n", i);
+			return -ENOENT;
+		}
+		pcie->res[i] = res;
+	}
+
+	rcar_pcie_hw_init(pcie);
+
+	if (!pcie->haslink) {
+		dev_info(&pdev->dev, "PCI: PCIe link down\n");
+		return 0;
+	}
+
+	data = pci_read_reg(pcie, MACSR);
+	dev_info(&pdev->dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
+
+	rcar_pcie_enable(pcie);
+
+	platform_set_drvdata(pdev, pcie);
+	return 0;
+}
+
+static struct platform_driver rcar_pcie_driver = {
+	.probe		= rcar_pcie_probe,
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.id_table	= rcar_pcie_id_table,
+};
+
+module_platform_driver(rcar_pcie_driver);
+
+MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
+MODULE_DESCRIPTION("Renesas R-Car PCIe driver");
+MODULE_LICENSE("GPLv2");
diff --git a/drivers/pci/host/pcie-rcar.h b/drivers/pci/host/pcie-rcar.h
new file mode 100644
index 0000000..a6b407f
--- /dev/null
+++ b/drivers/pci/host/pcie-rcar.h
@@ -0,0 +1,84 @@
+/*
+ * PCI Express definitions for Renesas R-Car SoCs
+ */
+#ifndef __PCI_RCAR_H
+#define __PCI_RCAR_H
+
+#define PCI_DEVICE_ID_RENESAS_RCAR	0x0018
+
+#define PCIECAR			0x000010
+#define PCIECCTLR		0x000018
+#define  CONFIG_SEND_ENABLE	(1 << 31)
+#define  TYPE0			(0 << 8)
+#define  TYPE1			(1 << 8)
+#define PCIECDR			0x000020
+#define PCIEMSR			0x000028
+#define PCIEINTXR		0x000400
+#define PCIEPHYSR		0x0007f0
+
+/* Transfer control */
+#define PCIETCTLR		0x02000
+#define  CFINIT			1
+#define PCIETSTR		0x02004
+#define  DATA_LINK_ACTIVE	1
+#define PCIEINTR		0x02008
+#define PCIEINTER		0x0200c
+#define PCIEERRFR		0x02020
+#define  UNSUPPORTED_REQUEST	(1 << 4)
+#define PCIEERRFER		0x02024
+#define PCIEERRFR2		0x02028
+#define PCIEPMSR		0x02034
+#define PCIEPMSCIER		0x02038
+#define PCIEMSIFR		0x02044
+
+/* root port address */
+#define PCIEPRAR(x)		(0x02080 + ((x) * 0x4))
+
+/* local address reg & mask */
+#define PCIELAR(x)		(0x02200 + ((x) * 0x20))
+#define PCIELAMR(x)		(0x02208 + ((x) * 0x20))
+#define  LAM_PMIOLAMnB3		(1 << 3)
+#define  LAM_PMIOLAMnB2		(1 << 2)
+#define  LAM_PREFETCH		(1 << 3)
+#define  LAM_64BIT		(1 << 2)
+#define  LAR_ENABLE		(1 << 1)
+
+/* PCIe address reg & mask */
+#define PCIEPARL(x)		(0x03400 + ((x) * 0x20))
+#define PCIEPARH(x)		(0x03404 + ((x) * 0x20))
+#define PCIEPAMR(x)		(0x03408 + ((x) * 0x20))
+#define PCIEPTCTLR(x)		(0x0340c + ((x) * 0x20))
+#define  PAR_ENABLE		(1 << 31)
+#define  IO_SPACE		(1 << 8)
+
+/* Configuration */
+#define PCICONF(x)		(0x010000 + ((x) * 0x4))
+#define PMCAP(x)		(0x010040 + ((x) * 0x4))
+#define MSICAP(x)		(0x010050 + ((x) * 0x4))
+#define EXPCAP(x)		(0x010070 + ((x) * 0x4))
+#define VCCAP(x)		(0x010100 + ((x) * 0x4))
+#define SERNUMCAP(x)		(0x0101b0 + ((x) * 0x4))
+
+/* link layer */
+#define IDSETR0			0x011000
+#define IDSETR1			0x011004
+#define SUBIDSETR		0x011024
+#define DSERSETR0		0x01102c
+#define DSERSETR1		0x011030
+#define TLCTLR			0x011048
+#define MACSR			0x011054
+#define MACCTLR			0x011058
+#define  SCRAMBLE_DISABLE	(1 << 27)
+
+/* R-Car H1 PHY */
+#define H1_PCIEPHYCTLR		0x040008
+#define H1_PCIEPHYADRR		0x04000c
+#define  WRITE_CMD		(1 << 16)
+#define  PHY_ACK		(1 << 24)
+#define  RATE_POS		12
+#define  LANE_POS		8
+#define  ADR_POS		0
+#define H1_PCIEPHYDOUTR		0x040014
+#define H1_PCIEPHYSR		0x040018
+
+#endif /* __PCI_RCAR_H */
-- 
1.7.9.5

