Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 3/6] pci:host: Add Altera PCIe host controller driver
Date: Tue, 28 Jul 2015 18:45:42 +0800
Message-ID: <1438080345-7233-4-git-send-email-lftan@altera.com>
In-Reply-To: <1438080345-7233-1-git-send-email-lftan@altera.com>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the Altera PCIe host controller driver.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/Kconfig       |   9 +
 drivers/pci/host/Makefile      |   1 +
 drivers/pci/host/pcie-altera.c | 576 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 586 insertions(+)
 create mode 100644 drivers/pci/host/pcie-altera.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 675c2d1..af19039 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -145,4 +145,13 @@ config PCIE_IPROC_BCMA
 	  Say Y here if you want to use the Broadcom iProc PCIe controller
 	  through the BCMA bus interface
 
+config PCIE_ALTERA
+	bool "Altera PCIe controller"
+	depends on ARCH_SOCFPGA
+	depends on OF
+	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
+	help
+	  Say Y here if you want to enable PCIe controller support for Altera
+	  SoCFPGA family of SoCs.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 140d66f..6954f76 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
 obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
 obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
 obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
+obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
new file mode 100644
index 0000000..afa64e9
--- /dev/null
+++ b/drivers/pci/host/pcie-altera.c
@@ -0,0 +1,576 @@
+/*
+ * Copyright Altera Corporation (C) 2013-2015. All rights reserved
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
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define A2P_ADDR_MAP_LO0		0x1000
+#define A2P_ADDR_MAP_HI0		0x1004
+#define RP_TX_REG0			0x2000
+#define RP_TX_REG1			0x2004
+#define RP_TX_CNTRL			0x2008
+#define RP_TX_EOP			0x2
+#define RP_TX_SOP			0x1
+#define RP_RXCPL_STATUS		0x2010
+#define RP_RXCPL_EOP			0x2
+#define RP_RXCPL_SOP			0x1
+#define RP_RXCPL_REG0			0x2014
+#define RP_RXCPL_REG1			0x2018
+#define P2A_INT_STATUS			0x3060
+#define P2A_INT_STS_ALL			0xF
+#define P2A_INT_ENABLE			0x3070
+#define P2A_INT_ENA_ALL			0xF
+#define RP_LTSSM			0x3C64
+#define LTSSM_L0			0xF
+
+/* TLP configuration type 0 and 1 */
+#define TLP_FMTTYPE_CFGRD0		0x04	/* Configuration Read Type 0 */
+#define TLP_FMTTYPE_CFGWR0		0x44	/* Configuration Write Type 0 */
+#define TLP_FMTTYPE_CFGRD1		0x05	/* Configuration Read Type 1 */
+#define TLP_FMTTYPE_CFGWR1		0x45	/* Configuration Write Type 1 */
+#define TLP_PAYLOAD_SIZE		0x01
+#define TLP_READ_TAG			0x1D
+#define TLP_WRITE_TAG			0x10
+#define TLP_CFG_DW0(fmttype)		(((fmttype) << 24) | TLP_PAYLOAD_SIZE)
+#define TLP_CFG_DW1(reqid, tag)		(((reqid) << 16) | (tag << 8) | 0xF)
+#define TLP_CFG_DW2(bus, devfn, offset)	\
+				(((bus) << 24) | ((devfn) << 16) | (offset))
+#define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
+#define TLP_COMPL_STATUS(hdr)		(((hdr) & 0xE0) >> 13)
+#define TLP_HDR_SIZE			3
+#define TLP_LOOP			10
+
+#define INTX_NUM		4
+
+/* Address translation table entry size */
+#define ATT_ENTRY_SIZE		8
+
+#define DWORD_MASK		3
+
+struct altera_pcie {
+	struct platform_device	*pdev;
+	struct resource		*txs;
+	void __iomem		*cra_base;
+	int			hwirq;
+	u8			root_bus_nr;
+	struct irq_domain		*irq_domain;
+	struct resource		bus_range;
+	struct list_head		resources;
+};
+
+struct tlp_rp_regpair_t {
+	u32 ctrl;
+	u32 reg0;
+	u32 reg1;
+};
+
+static inline struct altera_pcie *sys_to_pcie(struct pci_sys_data *sys)
+{
+	return sys->private_data;
+}
+
+static void altera_pcie_retrain(struct pci_dev *dev)
+{
+	u16 linkcap, linkstat;
+
+	/*
+	 * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
+	 * current speed is 2.5 GB/s.
+	 */
+	pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &linkcap);
+
+	if ((linkcap & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
+		return;
+
+	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
+	if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB)
+		pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
+					PCI_EXP_LNKCTL_RL);
+
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, altera_pcie_retrain);
+
+static inline void cra_writel(struct altera_pcie *pcie, u32 value, u32 reg)
+{
+	writel(value, pcie->cra_base + reg);
+}
+
+static inline u32 cra_readl(struct altera_pcie *pcie, u32 reg)
+{
+	return readl(pcie->cra_base + reg);
+}
+
+static void tlp_read_rx(struct altera_pcie *pcie,
+			struct tlp_rp_regpair_t *tlp_rp_regdata)
+{
+	tlp_rp_regdata->ctrl = cra_readl(pcie, RP_RXCPL_STATUS);
+	tlp_rp_regdata->reg0 = cra_readl(pcie, RP_RXCPL_REG0);
+	tlp_rp_regdata->reg1 = cra_readl(pcie, RP_RXCPL_REG1);
+}
+
+static void tlp_write_tx(struct altera_pcie *pcie,
+			struct tlp_rp_regpair_t *tlp_rp_regdata)
+{
+	cra_writel(pcie, tlp_rp_regdata->reg0, RP_TX_REG0);
+	cra_writel(pcie, tlp_rp_regdata->reg1, RP_TX_REG1);
+	cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
+}
+
+static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
+{
+	return !!(cra_readl(pcie, RP_LTSSM) & LTSSM_L0);
+}
+
+static bool altera_pcie_valid_config(struct altera_pcie *pcie,
+				struct pci_bus *bus, int dev)
+{
+	/* If there is no link, then there is no device */
+	if (bus->number != pcie->root_bus_nr) {
+		if (!altera_pcie_link_is_up(pcie))
+			return false;
+	}
+
+	/* access only one slot on each root port */
+	if (bus->number == pcie->root_bus_nr && dev > 0)
+		return false;
+
+	/*
+	 * Do not read more than one device on the bus directly attached
+	 * to RC.
+	 */
+	if (bus->primary == pcie->root_bus_nr && dev > 0)
+		return false;
+
+	 return true;
+}
+
+static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
+{
+	u8 loop;
+	struct tlp_rp_regpair_t tlp_rp_regdata;
+
+	for (loop = TLP_LOOP; loop > 0; loop--) {
+
+		tlp_read_rx(pcie, &tlp_rp_regdata);
+
+		if (tlp_rp_regdata.ctrl & RP_RXCPL_EOP) {
+
+			if (value)
+				*value = tlp_rp_regdata.reg0;
+
+			return PCIBIOS_SUCCESSFUL;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static void tlp_write_packet(struct altera_pcie *pcie, u32 *headers, u32 data)
+{
+	struct tlp_rp_regpair_t tlp_rp_regdata;
+
+	tlp_rp_regdata.reg0 = headers[0];
+	tlp_rp_regdata.reg1 = headers[1];
+	tlp_rp_regdata.ctrl = RP_TX_SOP;
+	tlp_write_tx(pcie, &tlp_rp_regdata);
+
+	tlp_rp_regdata.reg0 = headers[2];
+	tlp_rp_regdata.reg1 = data;
+	tlp_rp_regdata.ctrl = RP_TX_EOP;
+	tlp_write_tx(pcie, &tlp_rp_regdata);
+}
+
+static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
+			      int where, u32 *value)
+{
+	int ret;
+	u32 headers[TLP_HDR_SIZE];
+
+	if (bus == pcie->root_bus_nr)
+		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD0);
+	else
+		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGRD1);
+
+	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
+					TLP_READ_TAG);
+	headers[2] = TLP_CFG_DW2(bus, devfn, where);
+
+	tlp_write_packet(pcie, headers, 0);
+
+	ret = tlp_read_packet(pcie, value);
+	if (ret)
+		*value = ~0UL;	/* return 0xFFFFFFFF if error */
+
+	return ret;
+}
+
+static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
+			       int where, u32 value)
+{
+	u32 headers[TLP_HDR_SIZE];
+
+	if (bus == pcie->root_bus_nr)
+		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR0);
+	else
+		headers[0] = TLP_CFG_DW0(TLP_FMTTYPE_CFGWR1);
+
+	headers[1] = TLP_CFG_DW1(TLP_REQ_ID(pcie->root_bus_nr, devfn),
+					TLP_WRITE_TAG);
+	headers[2] = TLP_CFG_DW2(bus, devfn, where);
+
+	tlp_write_packet(pcie, headers, value);
+
+	tlp_read_packet(pcie, NULL);
+
+	/* Keep an eye out for changes to the root bus number */
+	if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
+		pcie->root_bus_nr = (u8)(value);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *value)
+{
+	struct altera_pcie *pcie = sys_to_pcie(bus->sysdata);
+	int ret;
+
+	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
+		*value = ~0UL;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
+		(where & ~DWORD_MASK), value);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
+
+	if (size == 1)
+		*value = (*value >> (8 * (where & 0x3))) & 0xff;
+	else if (size == 2)
+		*value = (*value >> (8 * (where & 0x2))) & 0xffff;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 value)
+{
+	struct altera_pcie *pcie = sys_to_pcie(bus->sysdata);
+	u32 data32 = value;
+	u32 shift = 8 * (where & 3);
+	int ret;
+
+	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* write partial */
+	if (size != sizeof(u32)) {
+		ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
+			where & ~DWORD_MASK, &data32);
+		if (ret)
+			return ret;
+
+		if (size == 2)
+			data32 = (data32 & ~(0xffff << shift)) |
+					((value & 0xffff) << shift);
+		 else if (size == 1)
+			data32 = (data32 & ~(0xff << shift)) |
+					((value & 0xff) << shift);
+	}
+
+	return tlp_cfg_dword_write(pcie, bus->number, devfn,
+		(where & ~DWORD_MASK), data32);
+}
+
+static struct pci_ops altera_pcie_ops = {
+	.read = altera_pcie_cfg_read,
+	.write = altera_pcie_cfg_write,
+};
+
+static int altera_pcie_setup(int nr, struct pci_sys_data *sys)
+{
+	struct altera_pcie *pcie = sys->private_data;
+
+	list_splice_init(&pcie->resources, &sys->resources);
+
+	return 1;
+}
+
+static int altera_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
+{
+	struct altera_pcie *pcie = sys_to_pcie(pdev->bus->sysdata);
+	int irq;
+
+	irq = of_irq_parse_and_map_pci(pdev, slot, pin);
+
+	if (!irq)
+		irq = pcie->hwirq;
+
+	return irq;
+}
+
+static struct pci_bus *altera_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+{
+	struct altera_pcie *pcie = sys_to_pcie(sys);
+	struct pci_bus *bus;
+
+	pcie->root_bus_nr = sys->busnr;
+	bus = pci_scan_root_bus(&pcie->pdev->dev, sys->busnr, &altera_pcie_ops,
+				sys, &sys->resources);
+
+	return bus;
+}
+
+static struct hw_pci altera_pcie_hw __initdata = {
+#ifdef CONFIG_PCI_DOMAINS
+	.domain			= 0,
+#endif
+	.nr_controllers		= 1,
+	.ops			= &altera_pcie_ops,
+	.setup			= altera_pcie_setup,
+	.map_irq			= altera_pcie_map_irq,
+	.scan			= altera_pcie_scan_bus,
+};
+
+static int altera_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+				irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	set_irq_flags(irq, IRQF_VALID);
+
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = altera_pcie_intx_map,
+};
+
+static irqreturn_t altera_pcie_isr(int irq, void *arg)
+{
+	struct altera_pcie *pcie = arg;
+	u32 status, i;
+
+	status = cra_readl(pcie, P2A_INT_STATUS) & P2A_INT_STS_ALL;
+
+	/* clear interrupts */
+	cra_writel(pcie, status, P2A_INT_STATUS);
+
+	for (i = 0; i < INTX_NUM; i++) {
+		if (status & (1 << i))
+			generic_handle_irq(irq_find_mapping(pcie->irq_domain,
+							i + 1));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void altera_pcie_release_of_pci_ranges(struct altera_pcie *pcie)
+{
+	pci_free_resource_list(&pcie->resources);
+}
+
+static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
+{
+	int err, res_valid = 0;
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *np = dev->of_node;
+	resource_size_t iobase;
+	struct resource_entry *win;
+	int offset = 0;
+
+	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
+					       &iobase);
+	if (err)
+		return err;
+
+	resource_list_for_each_entry(win, &pcie->resources) {
+		struct resource *parent, *res = win->res;
+
+		switch (resource_type(res)) {
+		case IORESOURCE_MEM:
+			parent = &iomem_resource;
+			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
+			cra_writel(pcie, res->start,
+				A2P_ADDR_MAP_LO0 + offset);
+			cra_writel(pcie, 0,
+				A2P_ADDR_MAP_HI0 + offset);
+			offset += ATT_ENTRY_SIZE;
+			break;
+		default:
+			continue;
+		}
+
+		err = devm_request_resource(dev, parent, res);
+		if (err)
+			goto out_release_res;
+	}
+
+	if (!res_valid) {
+		dev_err(dev, "non-prefetchable memory resource required\n");
+		err = -EINVAL;
+		goto out_release_res;
+	}
+
+	return 0;
+
+out_release_res:
+	altera_pcie_release_of_pci_ranges(pcie);
+	return err;
+}
+
+static void altera_pcie_free_irq_domain(struct altera_pcie *pcie)
+{
+	int i;
+	u32 irq;
+
+	for (i = 0; i < INTX_NUM; i++) {
+		irq = irq_find_mapping(pcie->irq_domain, i);
+		if (irq > 0)
+			irq_dispose_mapping(irq);
+	}
+
+	irq_domain_remove(pcie->irq_domain);
+}
+
+static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	/* Setup INTx */
+	pcie->irq_domain = irq_domain_add_linear(node, INTX_NUM,
+					&intx_domain_ops, pcie);
+	if (!pcie->irq_domain) {
+		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		return PTR_ERR(pcie->irq_domain);
+	}
+
+	return 0;
+}
+
+static int altera_pcie_parse_dt(struct altera_pcie *pcie)
+{
+	struct resource *cra;
+	int ret;
+	struct platform_device *pdev = pcie->pdev;
+
+	cra = platform_get_resource_byname(pdev, IORESOURCE_MEM, "Cra");
+	pcie->cra_base = devm_ioremap_resource(&pdev->dev, cra);
+	if (IS_ERR(pcie->cra_base)) {
+		dev_err(&pdev->dev, "get Cra resource failed\n");
+		return PTR_ERR(pcie->cra_base);
+	}
+
+	/* setup IRQ */
+	pcie->hwirq = platform_get_irq(pdev, 0);
+	if (pcie->hwirq <= 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", pcie->hwirq);
+		return -EINVAL;
+	}
+	ret = devm_request_irq(&pdev->dev, pcie->hwirq, altera_pcie_isr,
+			IRQF_SHARED, pdev->name, pcie);
+
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request irq %d\n", pcie->hwirq);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int altera_pcie_probe(struct platform_device *pdev)
+{
+	struct altera_pcie *pcie;
+	int ret;
+
+	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->pdev = pdev;
+
+	ret = altera_pcie_parse_dt(pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "Parsing DT failed\n");
+		return ret;
+	}
+
+	INIT_LIST_HEAD(&pcie->resources);
+
+	ret = altera_pcie_parse_request_of_pci_ranges(pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed add resources\n");
+		return ret;
+	}
+
+	ret = altera_pcie_init_irq_domain(pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
+		return ret;
+	}
+
+	pcie->root_bus_nr = -1;
+
+	/* clear all interrupts */
+	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
+	/* enable all interrupts */
+	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
+
+	altera_pcie_hw.private_data = (void **)&pcie;
+
+	pci_common_init_dev(&pdev->dev, &altera_pcie_hw);
+
+	platform_set_drvdata(pdev, pcie);
+	return ret;
+}
+
+static int __exit altera_pcie_remove(struct platform_device *pdev)
+{
+	struct altera_pcie *pcie = platform_get_drvdata(pdev);
+
+	altera_pcie_free_irq_domain(pcie);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static const struct of_device_id altera_pcie_of_match[] = {
+	{ .compatible = "altr,pcie-root-port-1.0", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, altera_pcie_of_match);
+
+static struct platform_driver altera_pcie_driver = {
+	.probe		= altera_pcie_probe,
+	.remove		= altera_pcie_remove,
+	.driver = {
+		.name	= "altera-pcie",
+		.owner	= THIS_MODULE,
+		.of_match_table = altera_pcie_of_match,
+	},
+};
+
+module_platform_driver(altera_pcie_driver);
+
+MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
+MODULE_DESCRIPTION("Altera PCIe host controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.2.1

