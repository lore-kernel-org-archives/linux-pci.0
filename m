Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33489 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdK1OSV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Nov 2017 09:18:21 -0500
Received: by mail-pf0-f195.google.com with SMTP id a84so198025pfl.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2017 06:18:21 -0800 (PST)
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc: mingkai.hu@nxp.com, peter.newton@nxp.com, minghuan.lian@nxp.com,
        rajesh.raina@nxp.com, rajan.kapoor@nxp.com, prabhjot.singh@nxp.com,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH v4 2/2] PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver
Date: Tue, 28 Nov 2017 09:18:08 -0500
Message-Id: <1511878688-8234-1-git-send-email-l.subrahmanya@mobiveil.co.in>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is the driver for Mobiveil AXI PCIe Host Bridge Soft IP -
GPEX 4.0, a PCIe gen4 IP. This configurable IP has upto 8
outbound and inbound windows for the address translation.

Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: bhelgaas@google.com
Cc: lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org

---
Fixes:
- used git mailer, as tabs were converted to spaces by thunderbird before
- 0x4* and 0x10* look a patterns wrapped into STRIDE* macros
- tested driver on 4.14 git tree, while the v3 was on 4.9
- moved global bitmap msi_irq_in_use into port information structure
- changed *_setup_config_access() to *_host_init()
- pci_scan_root_bus_bridge() is used to replace pci_scan_child_bus()
- Did split the irq domain into MSI and INTx domains
- comaptible string changed to recommended name
- long delays during link up wait replaced by shorter polls
- fixed review comments for v3 patch

 drivers/pci/host/Kconfig         |   8 +
 drivers/pci/host/Makefile        |   1 +
 drivers/pci/host/pcie-mobiveil.c | 911 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 920 insertions(+)
 create mode 100644 drivers/pci/host/pcie-mobiveil.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 38d1298..09bf1d9 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -27,6 +27,14 @@ config PCIE_XILINX_NWL
 	 or End Point. The current option selection will only
 	 support root port enabling.
 
+config PCIE_MOBIVEIL
+        bool "Mobiveil AXI PCIe host bridge support"
+        depends on ARCH_ZYNQMP || COMPILE_TEST
+        depends on PCI_MSI_IRQ_DOMAIN
+        help
+          Say 'Y' here if you want kernel to support the Mobiveil AXI PCIe
+          Host Bridge driver.
+
 config PCI_FTPCI100
 	bool "Faraday Technology FTPCI100 PCI controller"
 	depends on OF
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 34ec1d8..d745d68 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
+obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/host/pcie-mobiveil.c b/drivers/pci/host/pcie-mobiveil.c
new file mode 100644
index 0000000..63e46ad
--- /dev/null
+++ b/drivers/pci/host/pcie-mobiveil.c
@@ -0,0 +1,911 @@
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright Mobiveil Inc. (C) 2012-2017. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irq.h>
+#include <linux/msi.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/irqdomain.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+/* register offsets and bit positions */
+
+#define STRIDE4(window_num)	(0x4 * window_num)
+#define STRIDE10(window_num)	(0x10 * window_num)
+
+#define LTSSM_STATUS		0x0404
+#define  LTSSM_STATUS_L0_MASK	0x3f
+#define  LTSSM_STATUS_L0	0x2d
+
+#define PAB_CTRL		0x0808
+#define  AMBA_PIO_ENABLE_SHIFT	0
+#define  PEX_PIO_ENABLE_SHIFT	1
+#define  PAGE_SEL_SHIFT		13
+#define  PAGE_SEL_MASK		0x3f
+#define  PAGE_SEL_OFFSET_SHIFT	10
+
+#define PAB_AXI_PIO_CTRL	0x0840
+#define  APIO_EN_MASK		0xf
+
+#define PAB_PEX_PIO_CTRL	0x08c0
+#define  PIO_ENABLE_SHIFT	0
+
+#define PAB_INTP_AMBA_MISC_ENB	0x0b0c
+#define PAB_INTP_AMBA_MISC_STAT	0x0b1c
+#define  PAB_INTP_INTX_MASK	0x1e0
+#define  PAB_INTP_MSI_MASK	0x8
+
+#define PAB_AXI_AMAP_CTRL(win)	(0x0ba0 + STRIDE10(win))
+#define  WIN_ENABLE_SHIFT	0
+#define  WIN_TYPE_SHIFT		1
+#define  WIN_SIZE_SHIFT		10
+
+#define PAB_EXT_AXI_AMAP_SIZE(win)	(0xbaf0 + STRIDE4(win))
+
+#define PAB_AXI_AMAP_AXI_WIN(win)	(0x0ba4 + STRIDE10(win))
+#define  AXI_WINDOW_BASE_SHIFT		2
+
+#define PAB_AXI_AMAP_PEX_WIN_L(win)	(0x0ba8 + STRIDE10(win))
+#define  PAB_BUS_SHIFT			24
+#define  PAB_DEVICE_SHIFT		19
+#define  PAB_FUNCTION_SHIFT		16
+
+#define PAB_AXI_AMAP_PEX_WIN_H(win)	(0x0bac + STRIDE10(win))
+#define PAB_INTP_AXI_PIO_CLASS		0x474
+
+#define PAB_PEX_AMAP_CTRL(win)		(0x4ba0 + STRIDE10(win))
+#define  AMAP_CTRL_EN_SHIFT		0
+#define  AMAP_CTRL_TYPE_SHIFT		1
+
+#define PAB_EXT_PEX_AMAP_SIZEN(win)	(0xbef0 + STRIDE4(win))
+#define PAB_PEX_AMAP_AXI_WIN(win)	(0x4ba4 + STRIDE10(win))
+#define PAB_PEX_AMAP_PEX_WIN_L(win)	(0x4ba8 + STRIDE10(win))
+#define PAB_PEX_AMAP_PEX_WIN_H(win)	(0x4bac + STRIDE10(win))
+
+/* supported number of interrupts */
+#define PCI_NUM_INTX		4
+#define PCI_NUM_MSI		16
+#define PAB_INTA_POS		5
+
+/* MSI registers */
+#define MSI_BASE_LO_OFFSET	0x04
+#define MSI_BASE_HI_OFFSET	0x08
+#define MSI_SIZE_OFFSET		0x0c
+#define MSI_ENABLE_OFFSET	0x14
+#define MSI_STATUS_OFFSET	0x18
+#define MSI_DATA_OFFSET		0x20
+#define MSI_ADDR_L_OFFSET	0x24
+#define MSI_ADDR_H_OFFSET	0x28
+
+/* outbound and inbound window definitions */
+#define WIN_NUM_0		0
+#define WIN_NUM_1		1
+#define CFG_WINDOW_TYPE		0
+#define IO_WINDOW_TYPE		1
+#define MEM_WINDOW_TYPE		2
+#define IB_WIN_SIZE		(256 * 1024 * 1024)
+#define MAX_PIO_WINDOWS		8
+
+/* register access types */
+#define OP_READ			0
+#define OP_WRITE		1
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES	10
+#define LINK_WAIT_MIN		90000
+#define LINK_WAIT_MAX		100000
+
+/*
+ * PCIe port information
+ */
+struct mobiveil_pcie {
+	struct platform_device *pdev;
+	void __iomem *config_axi_slave_base;	/* endpoint config base */
+	void __iomem *csr_axi_slave_base;	/* root port config base */
+	void __iomem *gpio_slave_base;	/* GPIO register base */
+	void __iomem *apb_csr_base;	/* MSI register base */
+	struct irq_domain *intx_domain;
+	struct irq_domain *msi_domain;
+	struct list_head resources;
+	struct msi_controller msi_chip;
+	phys_addr_t msi_pages_phys;
+	int *msi_pages;
+	int irq;
+	int apio_wins;
+	int ppio_wins;
+	int ob_wins_configured;	/*  configured outbound windows */
+	int ib_wins_configured;	/*  configured inbound windows */
+	struct resource *ob_io_res;
+	struct resource *ob_mem_res[MAX_PIO_WINDOWS];
+	char root_bus_nr;
+	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
+};
+
+static inline struct mobiveil_pcie *
+chip_to_mobiveil_pcie(struct msi_controller *msi_chip)
+{
+	return container_of(msi_chip, struct mobiveil_pcie, msi_chip);
+}
+
+static inline void csr_writel(struct mobiveil_pcie *pcie,
+			const unsigned int value, const unsigned int reg)
+{
+	writel_relaxed(value, pcie->csr_axi_slave_base + reg);
+}
+
+static inline unsigned int csr_readl(struct mobiveil_pcie *pcie,
+			const unsigned int reg)
+{
+	return readl_relaxed(pcie->csr_axi_slave_base + reg);
+}
+
+static inline int gpio_read(struct mobiveil_pcie *pcie, int addr)
+{
+	return readl_relaxed(pcie->gpio_slave_base + addr);
+}
+
+static inline void gpio_write(struct mobiveil_pcie *pcie, int val, int addr)
+{
+	writel_relaxed(val, pcie->gpio_slave_base + addr);
+}
+
+static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
+{
+	return (csr_readl(pcie, LTSSM_STATUS) &
+		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
+}
+
+static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
+{
+	struct mobiveil_pcie *pcie = bus->sysdata;
+
+	/* Check if link is up when trying to access downstream ports */
+	if (bus->number != pcie->root_bus_nr)
+		if (!mobiveil_pcie_link_up(pcie))
+			return false;
+
+	/* Only one device down on each root port */
+	if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
+		return false;
+
+	/*
+	 * Do not read more than one device on the bus directly
+	 * attached to RC
+	 */
+	if ((bus->primary == pcie->root_bus_nr) && (devfn > 0))
+		return false;
+
+	return true;
+}
+
+/*
+ * mobiveil_pcie_map_bus - routine to get the configuration base of either
+ * root port or endpoint
+ */
+static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
+					unsigned int devfn, int where)
+{
+	struct mobiveil_pcie *pcie = bus->sysdata;
+	void __iomem *addr;
+
+	if (!mobiveil_pcie_valid_device(bus, devfn))
+		return NULL;
+
+	if (bus->number == pcie->root_bus_nr) {
+		/* RC config access */
+		addr =  pcie->csr_axi_slave_base + where;
+	} else {
+		/*
+		 * EP config access (in Config/APIO space)
+		 * Program PEX Address base (31..16 bits) with appropriate value
+		 * (BDF) in PAB_AXI_AMAP_PEX_WIN_L0 Register.
+		 * Relies on pci_lock serialization
+		 */
+		csr_writel(pcie,
+			bus->number << PAB_BUS_SHIFT |
+			PCI_SLOT(devfn) << PAB_DEVICE_SHIFT |
+			PCI_FUNC(devfn) << PAB_FUNCTION_SHIFT,
+			PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
+		addr = pcie->config_axi_slave_base + where;
+	}
+
+	return addr;
+}
+
+static struct pci_ops mobiveil_pcie_ops = {
+	.map_bus = mobiveil_pcie_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
+
+static irqreturn_t mobiveil_pcie_isr(int irq, void *data)
+{
+	struct mobiveil_pcie *pcie = (struct mobiveil_pcie *)data;
+	unsigned int msi_addr_l, msi_addr_h, msi_data;
+	unsigned int status, status2;
+	unsigned long shifted_status;
+	unsigned int bit1 = 0, virq;
+	unsigned int val, mask;
+
+	/*
+	 * The core provides a single interrupt for both INTx/MSI messages.
+	 * So we'll read both INTx and MSI statuses
+	 */
+
+	/* read INTx status */
+	val = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+	mask = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
+	status = val & mask;
+
+	/* Handle INTx */
+	if (status & PAB_INTP_INTX_MASK) {
+		shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+		do {
+			for_each_set_bit(bit1, &shifted_status, PCI_NUM_INTX) {
+
+				/* clear interrupts */
+				csr_writel(pcie, shifted_status << PAB_INTA_POS,
+						PAB_INTP_AMBA_MISC_STAT);
+
+				virq =
+				irq_find_mapping(pcie->intx_domain, bit1 + 1);
+				if (virq)
+					generic_handle_irq(virq);
+				else
+					dev_err(&pcie->pdev->dev,
+						"unexpected IRQ, INT%d\n",
+						bit1);
+
+			}
+
+			shifted_status =
+			csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+
+		} while ((shifted_status >>  PAB_INTA_POS) != 0);
+	}
+
+	/* read MSI status */
+	status2 = readl(pcie->apb_csr_base + MSI_STATUS_OFFSET);
+
+	/* handle MSI interrupts */
+	if ((status & PAB_INTP_MSI_MASK) || (status2 & 1)) {
+		do {
+			msi_data = readl(pcie->apb_csr_base + MSI_DATA_OFFSET);
+			msi_addr_l = readl(pcie->apb_csr_base
+						+ MSI_ADDR_L_OFFSET);
+			msi_addr_h = readl(pcie->apb_csr_base
+						+ MSI_ADDR_H_OFFSET);
+			/* Handle MSI */
+			if (msi_data)
+				generic_handle_irq(msi_data);
+			else
+				dev_err(&pcie->pdev->dev, "MSI data null\n");
+
+			status2 = readl(pcie->apb_csr_base + MSI_STATUS_OFFSET);
+		} while (status2 & 1);
+	}
+
+	csr_writel(pcie, status, PAB_INTP_AMBA_MISC_STAT);
+	return IRQ_HANDLED;
+}
+
+/* routine to parse device tree */
+static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	struct platform_device *pdev = pcie->pdev;
+	struct device_node *node = dev->of_node;
+	struct resource *res;
+	const char *type;
+	int err;
+
+	type = of_get_property(node, "device_type", NULL);
+	if (!type || strcmp(type, "pci")) {
+		dev_err(dev, "invalid \"device_type\" %s\n", type);
+		return -EINVAL;
+	}
+
+	/* map config resource */
+	res =
+	platform_get_resource_byname(pdev, IORESOURCE_MEM, "config_axi_slave");
+	pcie->config_axi_slave_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pcie->config_axi_slave_base))
+		return PTR_ERR(pcie->config_axi_slave_base);
+	pcie->ob_io_res = res;
+
+	/* map csr resource */
+	res =
+	platform_get_resource_byname(pdev, IORESOURCE_MEM, "csr_axi_slave");
+	pcie->csr_axi_slave_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pcie->csr_axi_slave_base))
+		return PTR_ERR(pcie->csr_axi_slave_base);
+
+	/* map gpio resource */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpio_slave");
+	pcie->gpio_slave_base =
+		devm_ioremap_nocache(dev, res->start, resource_size(res));
+	if (IS_ERR(pcie->gpio_slave_base))
+		return PTR_ERR(pcie->gpio_slave_base);
+
+	/* map gpio resource */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
+	pcie->apb_csr_base =
+		devm_ioremap_nocache(dev, res->start, resource_size(res));
+	if (IS_ERR(pcie->apb_csr_base))
+		return PTR_ERR(pcie->apb_csr_base);
+
+	/* read the number of windows requested */
+	if (!pcie->apio_wins &&
+		of_property_read_u32(node, "apio-wins", &pcie->apio_wins)) {
+		pcie->apio_wins = MAX_PIO_WINDOWS;
+	}
+
+	if (!pcie->ppio_wins &&
+		of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins)) {
+		pcie->ppio_wins = MAX_PIO_WINDOWS;
+	}
+
+	/* map IRQ resource */
+	pcie->irq = irq_of_parse_and_map(node, 0);
+	err = devm_request_irq(&pdev->dev, pcie->irq, mobiveil_pcie_isr,
+				IRQF_SHARED | IRQF_NO_THREAD,
+				"mobiveil-pcie", pcie);
+	if (err) {
+		dev_err(&pdev->dev, "unable to request IRQ %d\n", pcie->irq);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * access_paged_register - routine to access paged register of root complex
+ *
+ * registers of RC are paged, with pg_sel field of the PAB_CTRL
+ * register needs to be updated with page of the register, before
+ * accessing least significant 10 bits offset
+ *
+ * This routine does the PAB_CTRL updation and split access of the
+ * offset
+ *
+ */
+static unsigned int access_paged_register(struct mobiveil_pcie *pcie,
+					unsigned int write,
+					unsigned int val,
+					unsigned int offset)
+{
+	int pab_ctrl_dw, pg_sel;
+	unsigned int off = (offset & 0x3ff) + 0xc00;
+
+	pab_ctrl_dw = csr_readl(pcie, PAB_CTRL);
+	pg_sel = (offset >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK;
+
+	/* clear pg_sel field */
+	pab_ctrl_dw = (pab_ctrl_dw & ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT));
+
+	/* set pg_sel field */
+	pab_ctrl_dw |= ((pg_sel << PAGE_SEL_SHIFT));
+	csr_writel(pcie, pab_ctrl_dw, PAB_CTRL);
+
+	if (write == OP_WRITE)
+		csr_writel(pcie, val, off);
+	else
+		return csr_readl(pcie, off);
+	return 0;
+
+}
+
+/*
+ * routine to program the inbound windows
+ */
+static void program_ib_windows(struct mobiveil_pcie *pcie,
+				int win_num,
+				int pci_addr,
+				int type,
+				int size_kb)
+{
+	int pio_ctrl_val;
+	int amap_ctrl_dw;
+	u64 size64 = (-1 << (WIN_SIZE_SHIFT + ilog2(size_kb)));
+
+	if ((pcie->ib_wins_configured + 1) > pcie->ppio_wins) {
+		dev_err(&pcie->pdev->dev,
+			"ERROR: max inbound windows reached !\n");
+		return;
+	}
+
+	pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
+	csr_writel(pcie,
+		pio_ctrl_val | (1 << PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);
+	amap_ctrl_dw =	access_paged_register(pcie,
+				OP_READ, 0, PAB_PEX_AMAP_CTRL(win_num));
+	amap_ctrl_dw = (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
+	amap_ctrl_dw = (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
+
+	access_paged_register(pcie, OP_WRITE,
+				amap_ctrl_dw | lower_32_bits(size64),
+				PAB_PEX_AMAP_CTRL(win_num));
+
+	access_paged_register(pcie, OP_WRITE, upper_32_bits(size64),
+				PAB_EXT_PEX_AMAP_SIZEN(win_num));
+
+	access_paged_register(pcie, OP_WRITE, pci_addr,
+				PAB_PEX_AMAP_AXI_WIN(win_num));
+
+	access_paged_register(pcie, OP_WRITE, pci_addr,
+				PAB_PEX_AMAP_PEX_WIN_L(win_num));
+
+	access_paged_register(pcie, OP_WRITE, 0,
+				PAB_PEX_AMAP_PEX_WIN_H(win_num));
+}
+
+/*
+ * routine to program the outbound windows
+ */
+static void program_ob_windows(struct mobiveil_pcie *pcie,
+				int win_num,
+				u64 cpu_addr,
+				u64 pci_addr,
+				int config_io_bit,
+				int size_kb)
+{
+
+	unsigned int value, type;
+	u64 size64 = (-1 << (WIN_SIZE_SHIFT + ilog2(size_kb)));
+
+	if ((pcie->ob_wins_configured + 1) > pcie->apio_wins) {
+		dev_err(&pcie->pdev->dev,
+			"ERROR: max outbound windows reached !\n");
+		return;
+	}
+
+	/*
+	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
+	 * to 4 KB in PAB_AXI_AMAP_CTRL register
+	 */
+	type = config_io_bit;
+	value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
+	csr_writel(pcie,
+			1 << WIN_ENABLE_SHIFT |
+			type << WIN_TYPE_SHIFT |
+			lower_32_bits(size64),
+			PAB_AXI_AMAP_CTRL(win_num));
+
+	access_paged_register(pcie, OP_WRITE, upper_32_bits(size64),
+				PAB_EXT_AXI_AMAP_SIZE(win_num));
+
+	/*
+	 * program AXI window base with appropriate value in
+	 * PAB_AXI_AMAP_AXI_WIN0 register
+	 */
+	value = csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie,
+			cpu_addr >> AXI_WINDOW_BASE_SHIFT <<
+			AXI_WINDOW_BASE_SHIFT, PAB_AXI_AMAP_AXI_WIN(win_num));
+
+	value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(win_num));
+
+	csr_writel(pcie, lower_32_bits(pci_addr),
+			PAB_AXI_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, upper_32_bits(pci_addr),
+			PAB_AXI_AMAP_PEX_WIN_H(win_num));
+
+	pcie->ob_wins_configured++;
+}
+
+static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
+{
+	int retries;
+	struct device *dev = &pcie->pdev->dev;
+
+	if (!mobiveil_pcie_link_up(pcie)) {
+		/*
+		 * if FSBL is not patched, link won't be up so let's bring it
+		 * up by writing DIRM and OEN registers EMIO 6:0 programming
+		 * sequence [3:0] = Link Width; [6:4] = Link Speed. Current
+		 * setting width=4, speed = 1
+		 */
+		gpio_write(pcie, 0x7f, 0x000a02c4);
+		gpio_write(pcie, 0x7f, 0x000a02c8);
+		gpio_write(pcie, 0x14, 0x000a004c);
+
+		gpio_write(pcie, 0x0200, 0x000a0244);
+		gpio_write(pcie, 0x0200, 0x000a0248);
+		gpio_write(pcie, 0x37f7, 0x00180208);
+		gpio_write(pcie, 0xfdff, 0x000a0044);
+
+		/* check if the link is up or not */
+		for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+			if (mobiveil_pcie_link_up(pcie))
+				return 0;
+
+			/* send PRESET to the slot */
+			gpio_write(pcie, 0x80000000, 0x000a0344);
+			gpio_write(pcie, 0x80000000, 0x000a0348);
+			gpio_write(pcie, 0x00000000, 0x000a0054);
+			gpio_write(pcie, 0x80000000, 0x000a0054);
+
+			usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
+		}
+	}
+
+	dev_err(dev, "link never came up\n");
+	return -ETIMEDOUT;
+}
+
+static int mobiveil_host_init(struct mobiveil_pcie *pcie)
+{
+	unsigned int value;
+	int type = 0;
+	int pab_ctrl;
+	int err;
+	struct resource_entry *win, *tmp;
+
+	/* setup the PCIe slot link power*/
+	err = mobiveil_bringup_link(pcie);
+	if (err == 0)
+		dev_info(&pcie->pdev->dev, "link up\n");
+	else
+		return err;
+	/*
+	 * program Bus Master Enable Bit in Command Register in PAB Config
+	 * Space
+	 */
+	value = csr_readl(pcie, PCI_COMMAND);
+	csr_writel(pcie,
+		value |
+		PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
+		PCI_COMMAND);
+
+	/*
+	 * program PIO Enable Bit to 1 (and PEX PIO Enable to 1) in PAB_CTRL
+	 * register
+	 */
+	pab_ctrl = csr_readl(pcie, PAB_CTRL);
+	csr_writel(pcie, pab_ctrl | (1 << AMBA_PIO_ENABLE_SHIFT) |
+		(1 << PEX_PIO_ENABLE_SHIFT),
+		PAB_CTRL);
+
+	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
+		PAB_INTP_AMBA_MISC_ENB);
+
+	/* program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
+	 * PAB_AXI_PIO_CTRL Register
+	 */
+	value = csr_readl(pcie, PAB_AXI_PIO_CTRL);
+	csr_writel(pcie, value | APIO_EN_MASK, PAB_AXI_PIO_CTRL);
+
+	/*
+	 * we'll program one outbound window for config reads and
+	 * another default inbound window for all the upstream traffic
+	 * rest of the outbound windows will be configured according to
+	 * the "ranges" field defined in device tree
+	 */
+
+	/* config outbound translation window */
+	program_ob_windows(pcie,
+			pcie->ob_wins_configured, pcie->ob_io_res->start,
+			0,
+			CFG_WINDOW_TYPE,
+			resource_size(pcie->ob_io_res)/1024);
+
+	/* memory inbound  translation window */
+	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
+
+	/* Get the I/O and memory ranges from DT */
+	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
+		type = 0;
+		if (resource_type(win->res) == IORESOURCE_MEM)
+			type = MEM_WINDOW_TYPE;
+		if (resource_type(win->res) == IORESOURCE_IO)
+			type = IO_WINDOW_TYPE;
+		if (type) {
+			/* configure outbound translation window */
+			pcie->ob_mem_res[pcie->ob_wins_configured] =  win->res;
+			program_ob_windows(pcie,
+				pcie->ob_wins_configured,
+				win->res->start,
+				0,
+				type,
+				resource_size(win->res)/1024);
+		}
+	}
+
+	return err;
+}
+
+/* routine to setup the INTx related data */
+static int mobiveil_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				  irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	return 0;
+}
+
+/* INTx domain opeartions structure */
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = mobiveil_pcie_intx_map,
+};
+
+static void mobiveil_pcie_destroy_msi(struct msi_controller *msi_chip,
+					unsigned int irq)
+{
+	struct msi_desc *msi;
+	struct mobiveil_pcie *pcie = chip_to_mobiveil_pcie(msi_chip);
+
+	if (!test_bit(irq, pcie->msi_irq_in_use)) {
+		msi = irq_get_msi_desc(irq);
+		dev_info(&pcie->pdev->dev,
+			 "Trying to free unused MSI#%d\n", irq);
+	} else {
+		clear_bit(irq, pcie->msi_irq_in_use);
+	}
+}
+
+static int mobiveil_pcie_assign_msi(struct mobiveil_pcie *pcie)
+{
+	int pos;
+
+	pos = find_first_zero_bit(pcie->msi_irq_in_use, PCI_NUM_MSI);
+	if (pos < PCI_NUM_MSI)
+		set_bit(pos, pcie->msi_irq_in_use);
+	else
+		return -ENOSPC;
+
+	return pos;
+}
+
+static void mobiveil_msi_teardown_irq(struct msi_controller *msi_chip,
+				unsigned int irq)
+{
+	mobiveil_pcie_destroy_msi(msi_chip, irq);
+	irq_dispose_mapping(irq);
+}
+
+static int mobiveil_pcie_msi_setup_irq(struct msi_controller *msi_chip,
+				struct pci_dev *pdev,
+				struct msi_desc *desc)
+{
+	int hwirq;
+	unsigned int irq;
+	struct msi_msg msg;
+	phys_addr_t msg_addr;
+	struct mobiveil_pcie *pcie = pdev->bus->sysdata;
+
+	hwirq = mobiveil_pcie_assign_msi(pcie);
+	if (hwirq < 0)
+		return -EINVAL;
+
+	irq = irq_create_mapping(pcie->msi_domain, hwirq);
+	if (!irq)
+		return -EINVAL;
+
+	irq_set_msi_desc(irq, desc);
+
+	msg_addr =
+		virt_to_phys((void *)pcie->msi_pages + (hwirq * sizeof(int)));
+
+	msg.address_hi = upper_32_bits(msg_addr);
+	msg.address_lo = lower_32_bits(msg_addr);
+	msg.data = irq;
+
+	pci_write_msi_msg(irq, &msg);
+
+	return 0;
+}
+
+static struct irq_chip mobiveil_msi_irq_chip = {
+	.name = "Mobiveil PCIe MSI",
+	.irq_enable = pci_msi_unmask_irq,
+	.irq_disable = pci_msi_mask_irq,
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static int mobiveil_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
+				 irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &mobiveil_msi_irq_chip,
+				 handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.map = mobiveil_pcie_msi_map,
+};
+
+static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
+{
+	phys_addr_t msg_addr;
+
+	pcie->msi_pages = (void *)__get_free_pages(GFP_DMA, 0);
+	msg_addr = virt_to_phys((void *)pcie->msi_pages);
+	pcie->msi_pages_phys = (void *)msg_addr;
+
+	writel_relaxed(lower_32_bits(msg_addr),
+		pcie->apb_csr_base + MSI_BASE_LO_OFFSET);
+	writel_relaxed(upper_32_bits(msg_addr),
+		pcie->apb_csr_base + MSI_BASE_HI_OFFSET);
+	writel_relaxed(4096, pcie->apb_csr_base + MSI_SIZE_OFFSET);
+	writel_relaxed(1,
+		pcie->apb_csr_base + MSI_ENABLE_OFFSET);
+}
+
+static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	/* setup INTx */
+	pcie->intx_domain =
+		irq_domain_add_linear(node, PCI_NUM_INTX + 1, &intx_domain_ops,
+				  pcie);
+
+	if (!pcie->intx_domain) {
+		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		return -ENODEV;
+	}
+	/* setup MSI */
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pcie->msi_domain =
+			irq_domain_add_linear(node,
+						PCI_NUM_MSI,
+						&msi_domain_ops,
+						&pcie->msi_chip);
+		if (!pcie->msi_domain) {
+			dev_err(dev, "Failed to get a MSI IRQ domain\n");
+			return -ENODEV;
+		}
+
+		mobiveil_pcie_enable_msi(pcie);
+	}
+	return 0;
+}
+
+static int mobiveil_pcie_probe(struct platform_device *pdev)
+{
+	struct mobiveil_pcie *pcie;
+	struct pci_bus *bus;
+	struct pci_bus *child;
+	struct pci_host_bridge *bridge;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	resource_size_t iobase;
+	int ret;
+
+	/* allocate the PCIe port */
+	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
+	if (!bridge)
+		return -ENODEV;
+
+	pcie = pci_host_bridge_priv(bridge);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->pdev = pdev;
+
+	/* parse the device tree */
+	ret = mobiveil_pcie_parse_dt(pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "Parsing DT failed, ret: %x\n", ret);
+		return ret;
+	}
+
+	INIT_LIST_HEAD(&pcie->resources);
+
+	/* parse the host bridge base addresses from the device tree file */
+	ret = of_pci_get_host_bridge_resources(node,
+			0, 0xff, &pcie->resources, &iobase);
+	if (ret) {
+		dev_err(dev, "Getting bridge resources failed\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * configure all inbound and outbound windows and prepare the RC for
+	 * config access
+	 */
+	ret = mobiveil_host_init(pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize host\n");
+		goto error;
+	}
+
+	/* fixup for PCIe class register */
+	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
+
+	/* initialize the IRQ domains */
+	ret = mobiveil_pcie_init_irq_domain(pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
+		goto error;
+	}
+
+	ret = devm_request_pci_bus_resources(dev, &pcie->resources);
+	if (ret)
+		goto error;
+
+	/* Initialize bridge */
+	list_splice_init(&pcie->resources, &bridge->windows);
+	bridge->dev.parent = &pdev->dev;
+	bridge->sysdata = pcie;
+	bridge->busnr = pcie->root_bus_nr;
+	bridge->ops = &mobiveil_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
+
+	/* setup MSI, if enabled */
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pcie->msi_chip.dev = &pcie->pdev->dev;
+		pcie->msi_chip.setup_irq = mobiveil_pcie_msi_setup_irq;
+		pcie->msi_chip.teardown_irq = mobiveil_msi_teardown_irq;
+		bridge->msi = &pcie->msi_chip;
+	}
+
+	/* setup the kernel resources for the newly added PCIe root bus */
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret)
+		goto error;
+
+	bus = bridge->bus;
+
+	pci_assign_unassigned_bus_resources(bus);
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+	pci_bus_add_devices(bus);
+
+	return 0;
+error:
+	pci_free_resource_list(&pcie->resources);
+	return ret;
+}
+
+static const struct of_device_id mobiveil_pcie_of_match[] = {
+	{.compatible = "mbvl,gpex40-pcie",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
+
+static struct platform_driver mobiveil_pcie_driver = {
+	.probe = mobiveil_pcie_probe,
+	.driver = {
+			.name = "mobiveil-pcie",
+			.of_match_table = mobiveil_pcie_of_match,
+			.suppress_bind_attrs = true,
+		},
+};
+
+builtin_platform_driver(mobiveil_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
+MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
-- 
1.8.3.1
