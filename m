Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: aardvark: Implement emulated root PCI bridge
Date: Fri, 29 Jun 2018 11:22:31 +0200
Message-Id: <20180629092231.32207-4-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
References: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Russell King <linux@arm.linux.org.uk>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 Zachary Zhang <zhangzg@marvell.com>, Wilson Ding <dingwei@marvell.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Zachary Zhang <zhangzg@marvell.com>

The PCI controller in the Marvell Armada 3720 does not implement a
root port PCI bridge at the hardware level. This causes a number of
problems when using PCIe switches or when the Max Payload size needs
to be aligned between the root complex and the endpoint.

Implementing an emulated root PCI bridge, like is already done in the
pci-mvebu driver for older Marvell platforms allows to solve those
issues, and also to support features such as ASR, PME, VC, HP.

Signed-off-by: Zachary Zhang <zhangzg@marvell.com>
[Thomas: convert to the common PCI software bridge logic.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/Kconfig        |   1 +
 drivers/pci/controller/pci-aardvark.c | 119 +++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 0c307f804c8d..27b29b3f34e8 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -16,6 +16,7 @@ config PCI_AARDVARK
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCI_SW_BRIDGE
 	help
 	 Add support for Aardvark 64bit PCIe Host Controller. This
 	 controller is part of the South Bridge of the Marvel Armada
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index d3172d5d3d35..486c41721c89 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/pci-sw-bridge.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
@@ -22,10 +23,13 @@
 #include "../pci.h"
 
 /* PCIe core registers */
+#define PCIE_CORE_DEV_ID_REG					0x0
 #define PCIE_CORE_CMD_STATUS_REG				0x4
 #define     PCIE_CORE_CMD_IO_ACCESS_EN				BIT(0)
 #define     PCIE_CORE_CMD_MEM_ACCESS_EN				BIT(1)
 #define     PCIE_CORE_CMD_MEM_IO_REQ_EN				BIT(2)
+#define PCIE_CORE_DEV_REV_REG					0x8
+#define PCIE_CORE_PCIEXP_CAP					0xc0
 #define PCIE_CORE_DEV_CTRL_STATS_REG				0xc8
 #define     PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE	(0 << 4)
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT	5
@@ -41,7 +45,10 @@
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN			BIT(6)
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK			BIT(7)
 #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV			BIT(8)
-
+#define     PCIE_CORE_INT_A_ASSERT_ENABLE			1
+#define     PCIE_CORE_INT_B_ASSERT_ENABLE			2
+#define     PCIE_CORE_INT_C_ASSERT_ENABLE			3
+#define     PCIE_CORE_INT_D_ASSERT_ENABLE			4
 /* PIO registers base address and register offsets */
 #define PIO_BASE_ADDR				0x4000
 #define PIO_CTRL				(PIO_BASE_ADDR + 0x0)
@@ -93,7 +100,9 @@
 #define     PCIE_CORE_CTRL2_STRICT_ORDER_ENABLE	BIT(5)
 #define     PCIE_CORE_CTRL2_OB_WIN_ENABLE	BIT(6)
 #define     PCIE_CORE_CTRL2_MSI_ENABLE		BIT(10)
+#define PCIE_MSG_LOG_REG			(CONTROL_BASE_ADDR + 0x30)
 #define PCIE_ISR0_REG				(CONTROL_BASE_ADDR + 0x40)
+#define PCIE_MSG_PM_PME_MASK			BIT(7)
 #define PCIE_ISR0_MASK_REG			(CONTROL_BASE_ADDR + 0x44)
 #define     PCIE_ISR0_MSI_INT_PENDING		BIT(24)
 #define     PCIE_ISR0_INTX_ASSERT(val)		BIT(16 + (val))
@@ -207,6 +216,7 @@ struct advk_pcie {
 	struct mutex msi_used_lock;
 	u16 msi_msg;
 	int root_bus_nr;
+	struct pci_sw_bridge bridge;
 };
 
 static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
@@ -433,6 +443,101 @@ static int advk_pcie_wait_pio(struct advk_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static pci_sw_bridge_read_status_t
+advk_pci_sw_bridge_pcie_read(struct pci_sw_bridge *bridge,
+			     int reg, u32 *value)
+{
+	struct advk_pcie *pcie = bridge->data;
+
+	switch (reg) {
+	case PCI_EXP_SLTCTL:
+		*value = PCI_EXP_SLTSTA_PDS << 16;
+		return PCI_SW_BRIDGE_HANDLED;
+
+	case PCI_EXP_RTCTL:
+		*value = (advk_readl(pcie, PCIE_ISR0_MASK_REG) & PCIE_MSG_PM_PME_MASK) ?
+			PCI_EXP_RTCTL_PMEIE : 0;
+		return PCI_SW_BRIDGE_HANDLED;
+
+	case PCI_EXP_RTSTA:
+		*value = (advk_readl(pcie, PCIE_ISR0_REG) & PCIE_MSG_PM_PME_MASK) << 16 |
+			(advk_readl(pcie, PCIE_MSG_LOG_REG) >> 16);
+		return PCI_SW_BRIDGE_HANDLED;
+
+	case PCI_CAP_LIST_ID:
+	case PCI_EXP_DEVCAP:
+	case PCI_EXP_DEVCTL:
+	case PCI_EXP_LNKCAP:
+	case PCI_EXP_LNKCTL:
+		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
+		return PCI_SW_BRIDGE_HANDLED;
+	default:
+		return PCI_SW_BRIDGE_NOT_HANDLED;
+	}
+
+}
+
+static void advk_pci_sw_bridge_pcie_write(struct pci_sw_bridge *bridge,
+					  int reg, u32 old, u32 new, u32 mask)
+{
+	struct advk_pcie *pcie = bridge->data;
+
+	switch (reg) {
+	case PCI_EXP_DEVCTL:
+	case PCI_EXP_LNKCTL:
+		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
+		break;
+
+	case PCI_EXP_RTCTL:
+		new = (new & PCI_EXP_RTCTL_PMEIE) << 3;
+		advk_writel(pcie, new, PCIE_ISR0_MASK_REG);
+		break;
+
+	case PCI_EXP_RTSTA:
+		new = (new & PCI_EXP_RTSTA_PME) >> 9;
+		advk_writel(pcie, new, PCIE_ISR0_REG);
+		break;
+
+	default:
+		break;
+	}
+}
+
+struct pci_sw_bridge_ops advk_pci_sw_bridge_ops = {
+	.read_pcie = advk_pci_sw_bridge_pcie_read,
+	.write_pcie = advk_pci_sw_bridge_pcie_write,
+};
+
+/*
+ * Initialize the configuration space of the PCI-to-PCI bridge
+ * associated with the given PCIe interface.
+ */
+static void advk_sw_pci_bridge_init(struct advk_pcie *pcie)
+{
+	struct pci_sw_bridge *bridge = &pcie->bridge;
+
+	bridge->conf.vendor = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xffff;
+	bridge->conf.device = advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16;
+	bridge->conf.revision = advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff;
+
+	/* Support 32 bits I/O addressing */
+	bridge->conf.iobase = PCI_IO_RANGE_TYPE_32;
+	bridge->conf.iolimit = PCI_IO_RANGE_TYPE_32;
+
+	/* Support 64 bits memory pref */
+	bridge->conf.pref_mem_base = PCI_PREF_RANGE_TYPE_64;
+	bridge->conf.pref_mem_limit = PCI_PREF_RANGE_TYPE_64;
+
+	/* Support interrupt A for MSI feature */
+	bridge->conf.intpin = PCIE_CORE_INT_A_ASSERT_ENABLE;
+
+	bridge->has_pcie = true;
+	bridge->data = pcie;
+	bridge->ops = &advk_pci_sw_bridge_ops;
+
+	pci_sw_bridge_init(bridge);
+}
+
 static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 			     int where, int size, u32 *val)
 {
@@ -445,6 +550,9 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
+	if (bus->number == pcie->root_bus_nr)
+		return pci_sw_bridge_read(&pcie->bridge, where, size, val);
+
 	/* Start PIO */
 	advk_writel(pcie, 0, PIO_START);
 	advk_writel(pcie, 1, PIO_ISR);
@@ -452,7 +560,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the control register */
 	reg = advk_readl(pcie, PIO_CTRL);
 	reg &= ~PIO_CTRL_TYPE_MASK;
-	if (bus->number ==  pcie->root_bus_nr)
+	if (bus->primary ==  pcie->root_bus_nr)
 		reg |= PCIE_CONFIG_RD_TYPE0;
 	else
 		reg |= PCIE_CONFIG_RD_TYPE1;
@@ -497,6 +605,9 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	if (bus->number == pcie->root_bus_nr)
+		return pci_sw_bridge_write(&pcie->bridge, where, size, val);
+
 	if (where % size)
 		return PCIBIOS_SET_FAILED;
 
@@ -507,7 +618,7 @@ static int advk_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	/* Program the control register */
 	reg = advk_readl(pcie, PIO_CTRL);
 	reg &= ~PIO_CTRL_TYPE_MASK;
-	if (bus->number == pcie->root_bus_nr)
+	if (bus->primary == pcie->root_bus_nr)
 		reg |= PCIE_CONFIG_WR_TYPE0;
 	else
 		reg |= PCIE_CONFIG_WR_TYPE1;
@@ -922,6 +1033,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	advk_pcie_setup_hw(pcie);
 
+	advk_sw_pci_bridge_init(pcie);
+
 	ret = advk_pcie_init_irq_domain(pcie);
 	if (ret) {
 		dev_err(dev, "Failed to initialize irq\n");
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
