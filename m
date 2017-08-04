Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <robh@kerenl.org>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
 <ryder.lee@mediatek.com>
Subject: [PATCH v3 5/6] PCI: mediatek: Add new generation controller support
Date: Fri, 4 Aug 2017 20:06:41 +0800
Message-ID: <2adcb5f915eb8bd5817592ea32974eb25da02e4f.1501846816.git.honghui.zhang@mediatek.com>
In-Reply-To: <cover.1501846816.git.honghui.zhang@mediatek.com>
References: <cover.1501846816.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, hongkun.cao@mediatek.com, sean.wang@mediatek.com,
 xinping.qian@mediatek.com, honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 yong.wu@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Ryder Lee <ryder.lee@mediatek.com>

MediaTek's PCIe host controller has two generation HWs, the new
generation HW has two root ports, it shares most probing flow with the
legacy controller. But the read/write config space logical is different
from the legacy controller. The per-port register must be touched for
read/write config space, And the per-port register base are in separate
address space.

Add support for new Gen2 controller which can be found on MT7622/MT2712.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/Kconfig         |   5 +-
 drivers/pci/host/pcie-mediatek.c | 473 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 471 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 89d61c2..5b1ae9f 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -182,14 +182,13 @@ config PCIE_ROCKCHIP
 
 config PCIE_MEDIATEK
 	bool "MediaTek PCIe controller"
-	depends on ARM && (ARCH_MEDIATEK || COMPILE_TEST)
+	depends on (ARM || ARM64) && (ARCH_MEDIATEK || COMPILE_TEST)
 	depends on OF
 	depends on PCI
 	select PCIEPORTBUS
 	help
 	  Say Y here if you want to enable PCIe controller support on
-	  MT7623 series SoCs.  There is one single root complex with 3 root
-	  ports available.  Each port supports Gen2 lane x1.
+	  MediaTek SoCs.
 
 config PCIE_TANGO_SMP8759
 	bool "Tango SMP8759 PCIe controller (DANGEROUS)"
diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 63d300f..91eb53b 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2017 MediaTek Inc.
  * Author: Ryder Lee <ryder.lee@mediatek.com>
+ *	   Honghui Zhang <honghui.zhang@mediatek.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -17,6 +18,8 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -64,16 +67,77 @@
 #define PCIE_FC_CREDIT_MASK	(GENMASK(31, 31) | GENMASK(28, 16))
 #define PCIE_FC_CREDIT_VAL(x)	((x) << 16)
 
+/* PCIe V2 share registers */
+#define PCIE_SYS_CFG_V2		0x0
+#define PCIE_CSR_LTSSM_EN(x)	BIT(0 + (x) * 8)
+#define PCIE_CSR_ASPM_L1_EN(x)	BIT(1 + (x) * 8)
+
+/* PCIe V2 per-port registers */
+#define PCIE_INT_MASK		0x420
+#define INTX_MASK		GENMASK(19, 16)
+#define INTX_SHIFT		16
+#define INTX_NUM		4
+#define PCIE_INT_STATUS		0x424
+
+#define PCIE_AHB_TRANS_BASE0_L	0x438
+#define PCIE_AHB_TRANS_BASE0_H	0x43c
+#define AHB2PCIE_BASEL(x)	((x) & GENMASK(31, 0))
+#define AHB2PCIE_BASEH(x)	(((u64)(x) >> 32) & GENMASK(31, 0))
+#define AHB2PCIE_SIZE(x)	((x) & GENMASK(4, 0))
+#define PCIE_AXI_WINDOW0	0x448
+#define WIN_ENABLE		BIT(7)
+
+/* PCIe V2 Configuration Transaction Header */
+#define PCIE_CFG_HEADER0	0x460
+#define PCIE_CFG_HEADER1	0x464
+#define PCIE_CFG_HEADER2	0x468
+#define PCIE_CFG_WDATA		0x470
+#define PCIE_APP_TLP_REQ	0x488
+#define PCIE_CFG_RDATA		0x48c
+#define APP_CFG_REQ		BIT(0)
+#define APP_CPL_STATUS		GENMASK(7, 5)
+
+#define CFG_WRRD_TYPE_0		4
+#define CFG_WR_FMT		2
+#define CFG_RD_FMT		0
+
+#define CFG_DW0_LENGTH(length)	((length) & GENMASK(9, 0))
+#define CFG_DW0_TYPE(type)	(((type) << 24) & GENMASK(28, 24))
+#define CFG_DW0_FMT(fmt)	(((fmt) << 29) & GENMASK(31, 29))
+#define CFG_DW2_REGN(regn)	((regn) & GENMASK(11, 2))
+#define CFG_DW2_FUN(fun)	(((fun) << 16) & GENMASK(18, 16))
+#define CFG_DW2_DEV(dev)	(((dev) << 19) & GENMASK(23, 19))
+#define CFG_DW2_BUS(bus)	(((bus) << 24) & GENMASK(31, 24))
+#define CFG_HEADER_DW0(type, fmt) \
+	(CFG_DW0_LENGTH(1) | CFG_DW0_TYPE(type) | CFG_DW0_FMT(fmt))
+#define CFG_HEADER_DW1(where, size) \
+	(GENMASK(((size) - 1), 0) << ((where) & 0x3))
+#define CFG_HEADER_DW2(regn, fun, dev, bus) \
+	(CFG_DW2_REGN(regn) | CFG_DW2_FUN(fun) | \
+	CFG_DW2_DEV(dev) | CFG_DW2_BUS(bus))
+
+#define PCIE_RST_CTRL		0x510
+#define PCIE_PHY_RSTB		BIT(0)
+#define PCIE_PIPE_SRSTB		BIT(1)
+#define PCIE_MAC_SRSTB		BIT(2)
+#define PCIE_CRSTB		BIT(3)
+#define PCIE_PERSTB		BIT(8)
+#define PCI_LINKDOWN_RST_EN	GENMASK(15, 13)
+#define PCIE_LINK_STATUS_V2	0x804
+#define PCIE_PORT_LINKUP_V2	BIT(10)
+
 struct mtk_pcie_port;
 
 /**
  * struct mtk_pcie_soc - differentiate between host generations
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
+ * @setup_irq: pointer to initialize IRQ functions
  */
 struct mtk_pcie_soc {
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
+	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
 };
 
 /**
@@ -82,10 +146,18 @@ struct mtk_pcie_soc {
  * @list: port list
  * @pcie: pointer to PCIe host info
  * @reset: pointer to port reset control
- * @sys_ck: pointer to bus clock
- * @phy: pointer to phy control block
+ * @sys_ck: pointer to transaction/data link layer clock
+ * @ahb_ck: pointer to AHB slave interface operating clock for CSR access
+ *          and RC initiated MMIO access
+ * @axi_ck: pointer to application layer MMIO channel operating clock
+ * @aux_ck: pointer to pe2_mac_bridge and pe2_mac_core operating clock
+ *          when pcie_mac_ck/pcie_pipe_ck is turned off
+ * @obff_ck: pointer to OBFF functional block operating clock
+ * @pipe_ck: pointer to LTSSM and PHY/MAC layer operating clock
+ * @phy: pointer to PHY control block
  * @lane: lane count
  * @index: port index
+ * @irq_domain: legacy INTx IRQ domain
  */
 struct mtk_pcie_port {
 	void __iomem *base;
@@ -93,9 +165,15 @@ struct mtk_pcie_port {
 	struct mtk_pcie *pcie;
 	struct reset_control *reset;
 	struct clk *sys_ck;
+	struct clk *ahb_ck;
+	struct clk *axi_ck;
+	struct clk *aux_ck;
+	struct clk *obff_ck;
+	struct clk *pipe_ck;
 	struct phy *phy;
 	u32 lane;
 	u32 index;
+	struct irq_domain *irq_domain;
 };
 
 /**
@@ -156,6 +234,12 @@ static void mtk_pcie_put_resources(struct mtk_pcie *pcie)
 
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
 		phy_power_off(port->phy);
+		phy_exit(port->phy);
+		clk_disable_unprepare(port->pipe_ck);
+		clk_disable_unprepare(port->obff_ck);
+		clk_disable_unprepare(port->axi_ck);
+		clk_disable_unprepare(port->aux_ck);
+		clk_disable_unprepare(port->ahb_ck);
 		clk_disable_unprepare(port->sys_ck);
 		mtk_pcie_port_free(port);
 	}
@@ -163,6 +247,278 @@ static void mtk_pcie_put_resources(struct mtk_pcie *pcie)
 	mtk_pcie_subsys_powerdown(pcie);
 }
 
+static int mtk_pcie_check_cfg_cpld(struct mtk_pcie_port *port)
+{
+	u32 val;
+	int err;
+
+	err = readl_poll_timeout_atomic(port->base + PCIE_APP_TLP_REQ, val,
+					!(val & APP_CFG_REQ), 10,
+					100 * USEC_PER_MSEC);
+	if (err)
+		return PCIBIOS_SET_FAILED;
+
+	if (readl(port->base + PCIE_APP_TLP_REQ) & APP_CPL_STATUS)
+		return PCIBIOS_SET_FAILED;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int mtk_pcie_hw_rd_cfg(struct mtk_pcie_port *port, u32 bus, u32 devfn,
+			      int where, int size, u32 *val)
+{
+	int reg, shift = 8 * (where & 3);
+
+	/* Write PCIe Configuration Transaction Header for cfgrd */
+	writel(CFG_HEADER_DW0(CFG_WRRD_TYPE_0, CFG_RD_FMT),
+	       port->base + PCIE_CFG_HEADER0);
+	writel(CFG_HEADER_DW1(where, size), port->base + PCIE_CFG_HEADER1);
+	writel(CFG_HEADER_DW2(where, PCI_FUNC(devfn), PCI_SLOT(devfn), bus),
+	       port->base + PCIE_CFG_HEADER2);
+
+	/* Trigger h/w to transmit Cfgrd TLP */
+	reg = readl(port->base + PCIE_APP_TLP_REQ);
+	writel(reg | APP_CFG_REQ, port->base + PCIE_APP_TLP_REQ);
+
+	/* Check completion status */
+	if (mtk_pcie_check_cfg_cpld(port))
+		return PCIBIOS_SET_FAILED;
+
+	/* Read cpld payload of Cfgrd */
+	*val = readl(port->base + PCIE_CFG_RDATA);
+
+	switch (size) {
+	case 4:
+		break;
+	case 3:
+		*val = (*val >> shift) & 0xffffff;
+		break;
+	case 2:
+		*val = (*val >> shift) & 0xffff;
+		break;
+	case 1:
+		*val = (*val >> shift) & 0xff;
+		break;
+	default:
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int mtk_pcie_hw_wr_cfg(struct mtk_pcie_port *port, u32 bus, u32 devfn,
+			      int where, int size, u32 val)
+{
+	/* Write PCIe Configuration Transaction Header for Cfgwr */
+	writel(CFG_HEADER_DW0(CFG_WRRD_TYPE_0, CFG_WR_FMT),
+	       port->base + PCIE_CFG_HEADER0);
+	writel(CFG_HEADER_DW1(where, size), port->base + PCIE_CFG_HEADER1);
+	writel(CFG_HEADER_DW2(where, PCI_FUNC(devfn), PCI_SLOT(devfn), bus),
+	       port->base + PCIE_CFG_HEADER2);
+
+	/* Write cfgwr data */
+	val = val << 8 * (where & 3);
+	writel(val, port->base + PCIE_CFG_WDATA);
+
+	/* Trigger h/w to transmit Cfgwr TLP */
+	val = readl(port->base + PCIE_APP_TLP_REQ);
+	val |= APP_CFG_REQ;
+	writel(val, port->base + PCIE_APP_TLP_REQ);
+
+	/* Check completion status */
+	return mtk_pcie_check_cfg_cpld(port);
+}
+
+static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *val)
+{
+	struct mtk_pcie_port *port = NULL, *iter, *tmp;
+	struct mtk_pcie *pcie = bus->sysdata;
+	u32 bn = bus->number;
+	int ret;
+
+	list_for_each_entry_safe(iter, tmp, &pcie->ports, list)
+		if (iter->index == PCI_SLOT(devfn)) {
+			port = iter;
+			break;
+		}
+
+	if (!port) {
+		*val = ~0;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	ret = mtk_pcie_hw_rd_cfg(port, bn, devfn, where, size, val);
+	if (ret)
+		*val = ~0;
+
+	return ret;
+}
+
+static int mtk_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 val)
+{
+	struct mtk_pcie_port *port = NULL, *iter, *tmp;
+	struct mtk_pcie *pcie = bus->sysdata;
+	u32 bn = bus->number;
+
+	list_for_each_entry_safe(iter, tmp, &pcie->ports, list)
+		if (iter->index == PCI_SLOT(devfn)) {
+			port = iter;
+			break;
+		}
+
+	if (!port)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return mtk_pcie_hw_wr_cfg(port, bn, devfn, where, size, val);
+}
+
+static struct pci_ops mtk_pcie_ops_v2 = {
+	.read  = mtk_pcie_config_read,
+	.write = mtk_pcie_config_write,
+};
+
+static int mtk_pcie_startup_ports_v2(struct mtk_pcie_port *port)
+{
+	struct mtk_pcie *pcie = port->pcie;
+	struct resource *mem = &pcie->mem;
+	u32 val;
+	size_t size;
+	int err;
+
+	/* mt7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
+	if (pcie->base) {
+		val = readl(pcie->base + PCIE_SYS_CFG_V2);
+		val |= PCIE_CSR_LTSSM_EN(port->index) |
+		       PCIE_CSR_ASPM_L1_EN(port->index);
+		writel(val, pcie->base + PCIE_SYS_CFG_V2);
+	}
+
+	/* Assert all reset signals */
+	writel(0, port->base + PCIE_RST_CTRL);
+
+	/*
+	 * Enable PCIe link down reset, if link status changed from link up to
+	 * link down, this will reset MAC control registers and configuration
+	 * space.
+	 */
+	writel(PCI_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
+
+	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
+	val = readl(port->base + PCIE_RST_CTRL);
+	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
+	       PCIE_MAC_SRSTB | PCIE_CRSTB;
+	writel(val, port->base + PCIE_RST_CTRL);
+
+	/* PCIe v2.0 need at least 100ms delay to train from Gen1 to Gen2 */
+	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
+				 !!(val & PCIE_PORT_LINKUP_V2), 20,
+				 100 * USEC_PER_MSEC);
+	if (err)
+		return -ETIMEDOUT;
+
+	/* Set INTx mask */
+	val = readl(port->base + PCIE_INT_MASK);
+	val &= ~INTX_MASK;
+	writel(val, port->base + PCIE_INT_MASK);
+
+	/* Set AHB to PCIe translation windows */
+	size = mem->end - mem->start;
+	val = AHB2PCIE_BASEL(mem->start) | AHB2PCIE_SIZE(fls(size));
+	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
+
+	val = AHB2PCIE_BASEH(mem->start);
+	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
+
+	/* Set PCIe to AXI translation memory space.*/
+	val = fls(0xffffffff) | WIN_ENABLE;
+	writel(val, port->base + PCIE_AXI_WINDOW0);
+
+	return 0;
+}
+
+static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = mtk_pcie_intx_map,
+};
+
+static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
+				    struct device_node *node)
+{
+	struct device *dev = port->pcie->dev;
+	struct device_node *pcie_intc_node;
+
+	/* Setup INTx */
+	pcie_intc_node = of_get_next_child(node, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "No PCIe Intc node found\n");
+		return PTR_ERR(pcie_intc_node);
+	}
+
+	port->irq_domain = irq_domain_add_linear(pcie_intc_node, INTX_NUM,
+						 &intx_domain_ops, port);
+	if (!port->irq_domain) {
+		dev_err(dev, "Failed to get INTx IRQ domain\n");
+		return PTR_ERR(port->irq_domain);
+	}
+
+	return 0;
+}
+
+static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
+{
+	struct mtk_pcie_port *port = (struct mtk_pcie_port *)data;
+	unsigned long status;
+	u32 virq;
+	u32 bit = INTX_SHIFT;
+
+	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
+		for_each_set_bit_from(bit, &status, INTX_NUM + INTX_SHIFT) {
+			/* Clear the INTx */
+			writel(1 << bit, port->base + PCIE_INT_STATUS);
+			virq = irq_find_mapping(port->irq_domain,
+						bit - INTX_SHIFT);
+			generic_handle_irq(virq);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
+			      struct device_node *node)
+{
+	struct mtk_pcie *pcie = port->pcie;
+	struct device *dev = pcie->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int err, irq;
+
+	irq = platform_get_irq(pdev, port->index);
+	err = devm_request_irq(dev, irq, mtk_pcie_intr_handler,
+			       IRQF_SHARED, "mtk-pcie", port);
+	if (err) {
+		dev_err(dev, "unable to request IRQ %d\n", irq);
+		return err;
+	}
+
+	err = mtk_pcie_init_irq_domain(port, node);
+	if (err) {
+		dev_err(dev, "failed to init PCIe legacy IRQ domain\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus,
 				      unsigned int devfn, int where)
 {
@@ -249,13 +605,49 @@ static void mtk_pcie_enable_ports(struct mtk_pcie_port *port)
 
 	err = clk_prepare_enable(port->sys_ck);
 	if (err) {
-		dev_err(dev, "failed to enable port%d clock\n", port->index);
+		dev_err(dev, "failed to enable sys_ck%d\n", port->index);
 		goto err_sys_clk;
 	}
 
+	err = clk_prepare_enable(port->ahb_ck);
+	if (err) {
+		dev_err(dev, "failed to enable ahb_ck%d\n", port->index);
+		goto err_ahb_clk;
+	}
+
+	err = clk_prepare_enable(port->aux_ck);
+	if (err) {
+		dev_err(dev, "failed to enable aux_ck%d\n", port->index);
+		goto err_aux_clk;
+	}
+
+	err = clk_prepare_enable(port->axi_ck);
+	if (err) {
+		dev_err(dev, "failed to enable axi_ck%d\n", port->index);
+		goto err_axi_clk;
+	}
+
+	err = clk_prepare_enable(port->obff_ck);
+	if (err) {
+		dev_err(dev, "failed to enable obff_ck%d\n", port->index);
+		goto err_obff_clk;
+	}
+
+	err = clk_prepare_enable(port->pipe_ck);
+	if (err) {
+		dev_err(dev, "failed to enable pipe_ck%d\n", port->index);
+		goto err_pipe_clk;
+	}
+
 	reset_control_assert(port->reset);
 	reset_control_deassert(port->reset);
 
+	err = phy_init(port->phy);
+	if (err) {
+		dev_err(dev, "failed to initialize port%d phy\n", port->index);
+		goto err_phy_init;
+	}
+
 	err = phy_power_on(port->phy);
 	if (err) {
 		dev_err(dev, "failed to power on port%d phy\n", port->index);
@@ -269,6 +661,18 @@ static void mtk_pcie_enable_ports(struct mtk_pcie_port *port)
 
 	phy_power_off(port->phy);
 err_phy_on:
+	phy_exit(port->phy);
+err_phy_init:
+	clk_disable_unprepare(port->pipe_ck);
+err_pipe_clk:
+	clk_disable_unprepare(port->obff_ck);
+err_obff_clk:
+	clk_disable_unprepare(port->axi_ck);
+err_axi_clk:
+	clk_disable_unprepare(port->aux_ck);
+err_aux_clk:
+	clk_disable_unprepare(port->ahb_ck);
+err_ahb_clk:
 	clk_disable_unprepare(port->sys_ck);
 err_sys_clk:
 	mtk_pcie_port_free(port);
@@ -306,10 +710,56 @@ static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
 	snprintf(name, sizeof(name), "sys_ck%d", index);
 	port->sys_ck = devm_clk_get(dev, name);
 	if (IS_ERR(port->sys_ck)) {
-		dev_err(dev, "failed to get port%d clock\n", index);
+		dev_err(dev, "failed to get sys_ck%d\n", index);
 		return PTR_ERR(port->sys_ck);
 	}
 
+	/* sys_ck might be divided into the following parts in some chips */
+	snprintf(name, sizeof(name), "ahb_ck%d", index);
+	port->ahb_ck = devm_clk_get(dev, name);
+	if (IS_ERR(port->ahb_ck)) {
+		if (PTR_ERR(port->ahb_ck) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		port->ahb_ck = NULL;
+	}
+
+	snprintf(name, sizeof(name), "axi_ck%d", index);
+	port->axi_ck = devm_clk_get(dev, name);
+	if (IS_ERR(port->axi_ck)) {
+		if (PTR_ERR(port->axi_ck) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		port->axi_ck = NULL;
+	}
+
+	snprintf(name, sizeof(name), "aux_ck%d", index);
+	port->aux_ck = devm_clk_get(dev, name);
+	if (IS_ERR(port->aux_ck)) {
+		if (PTR_ERR(port->aux_ck) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		port->aux_ck = NULL;
+	}
+
+	snprintf(name, sizeof(name), "obff_ck%d", index);
+	port->obff_ck = devm_clk_get(dev, name);
+	if (IS_ERR(port->obff_ck)) {
+		if (PTR_ERR(port->obff_ck) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		port->obff_ck = NULL;
+	}
+
+	snprintf(name, sizeof(name), "pipe_ck%d", index);
+	port->pipe_ck = devm_clk_get(dev, name);
+	if (IS_ERR(port->pipe_ck)) {
+		if (PTR_ERR(port->pipe_ck) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		port->pipe_ck = NULL;
+	}
+
 	snprintf(name, sizeof(name), "pcie-rst%d", index);
 	port->reset = devm_reset_control_get_optional_exclusive(dev, name);
 	if (PTR_ERR(port->reset) == -EPROBE_DEFER)
@@ -324,6 +774,12 @@ static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
 	port->index = index;
 	port->pcie = pcie;
 
+	if (pcie->soc->setup_irq) {
+		err = pcie->soc->setup_irq(port, node);
+		if (err)
+			return err;
+	}
+
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);
 
@@ -493,6 +949,7 @@ static int mtk_pcie_register_host(struct pci_host_bridge *host)
 	host->ops = pcie->soc->ops;
 	host->map_irq = of_irq_parse_and_map_pci;
 	host->swizzle_irq = pci_common_swizzle;
+	host->sysdata = pcie;
 
 	err = pci_scan_root_bus_bridge(host);
 	if (err < 0)
@@ -553,9 +1010,17 @@ static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
 	.startup = mtk_pcie_startup_ports,
 };
 
+static const struct mtk_pcie_soc mtk_pcie_soc_v2 = {
+	.ops = &mtk_pcie_ops_v2,
+	.startup = mtk_pcie_startup_ports_v2,
+	.setup_irq = mtk_pcie_setup_irq,
+};
+
 static const struct of_device_id mtk_pcie_ids[] = {
 	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
+	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_v2 },
+	{ .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_v2 },
 	{},
 };
 
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
