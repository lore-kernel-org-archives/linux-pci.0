Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org,
	jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jszhang@marvell.com, CARLOS.PALMINHA@synopsys.com,
	MiguelFalcao.Sousa@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 1/2] pcie-designware: add iATU Unroll feature
Date: Fri, 22 Jul 2016 14:29:38 +0100
Message-Id: <0ce5678ac78d082afa3df7ad284111afcc03b2a1.1469193895.git.jpinto@synopsys.com>
In-Reply-To: <cover.1469193895.git.jpinto@synopsys.com>
References: <cover.1469193895.git.jpinto@synopsys.com>
In-Reply-To: <cover.1469193895.git.jpinto@synopsys.com>
References: <cover.1469193895.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>

This patch adds the support to the new iATU mechanism that will be used
from Core version 4.80, which is called iATU Unroll.
The new Cores can support the iATU Unroll or support the "old" iATU 
method now called Legacy Mode. The driver is perfectly capable of
performing well for both.

In order to make sure that the iATU is really enabled a for loop was
introduced in dw_pcie_prog_outbound_atu() to improve reliability.

This patch also moves the sleep definitions to the *.c file like
suggested by Jisheng Zhang in a previous patch.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
changes v1->v2:
- Patch was breaking kernel build due to bad definition in macro funtion.
- Rebased on top of pci/next.

 drivers/pci/host/pcie-designware.c | 157 +++++++++++++++++++++++++++++++++----
 drivers/pci/host/pcie-designware.h |   6 +-
 2 files changed, 144 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce1..9135725 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -26,7 +26,15 @@
 
 #include "pcie-designware.h"
 
-/* Synopsis specific PCIE configuration registers */
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES		10
+#define LINK_WAIT_MAX_ATU_RETRIES	5
+#define LINK_WAIT_USLEEP_MIN		90000
+#define LINK_WAIT_USLEEP_MAX		100000
+#define LINK_WAIT_IATU_MIN		9000
+#define LINK_WAIT_IATU_MAX		10000
+
+/* Synopsys specific PCIE configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		(0x3f << 16)
 #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
@@ -58,6 +66,7 @@
 #define PCIE_ATU_TYPE_IO		(0x2 << 0)
 #define PCIE_ATU_TYPE_CFG0		(0x4 << 0)
 #define PCIE_ATU_TYPE_CFG1		(0x5 << 0)
+
 #define PCIE_ATU_CR2			0x908
 #define PCIE_ATU_ENABLE			(0x1 << 31)
 #define PCIE_ATU_BAR_MODE_ENABLE	(0x1 << 30)
@@ -75,6 +84,37 @@
 #define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
 #define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
 
+/*
+ * iatu unroll specific registers and definitions
+ * From 4.80 Core version the address translation will be made by unroll
+ */
+
+/* Registers */
+#define PCIE_ATU_UNR_REGION_CTRL1	0x00
+#define PCIE_ATU_UNR_REGION_CTRL2	0x01
+#define PCIE_ATU_UNR_LOWER_BASE		0x02
+#define PCIE_ATU_UNR_UPPER_BASE		0x03
+#define PCIE_ATU_UNR_LIMIT		0x04
+#define PCIE_ATU_UNR_LOWER_TARGET	0x05
+#define PCIE_ATU_UNR_UPPER_TARGET	0x06
+#define PCIE_ATU_UNR_REGION_CTRL3	0x07
+#define PCIE_ATU_UNR_UPPR_LIMIT		0x08
+
+/* register address builder */
+#define PCIE_GET_ATU_INB_UNR_REG_ADDR(region, register)		\
+					((0x3 << 20) | (region << 9) |	\
+					(0x1 << 8) | (register << 2))
+
+#define PCIE_GET_ATU_OUTB_UNR_REG_ADDR(region, register)		\
+					((0x3 << 20) | (region << 9) |	\
+					(register << 2))
+
+/* translation types */
+#define PCIE_TRANSL_INB			0x1
+#define PCIE_TRANSL_OUTB		0x2
+
+/* end of Unroll specific */
+
 static struct pci_ops dw_pcie_ops;
 
 int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
@@ -131,6 +171,38 @@ static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
 		writel(val, pp->dbi_base + reg);
 }
 
+static inline void dw_pcie_readl_unroll(struct pcie_port *pp, u32 type,
+						u32 index, u32 reg, u32 *val)
+{
+	u32 reg_addr = 0;
+
+	if (type == PCIE_TRANSL_OUTB)
+		reg_addr = PCIE_GET_ATU_OUTB_UNR_REG_ADDR(index, reg);
+	else if  (type == PCIE_TRANSL_INB)
+		reg_addr = PCIE_GET_ATU_INB_UNR_REG_ADDR(index, reg);
+
+	if (pp->ops->readl_rc)
+		pp->ops->readl_rc(pp, pp->dbi_base + reg_addr, val);
+	else
+		*val = readl(pp->dbi_base + reg_addr);
+}
+
+static inline void dw_pcie_writel_unroll(struct pcie_port *pp, u32 type,
+						u32 index, u32 val, u32 reg)
+{
+	u32 reg_addr = 0;
+
+	if (type == PCIE_TRANSL_OUTB)
+		reg_addr = PCIE_GET_ATU_OUTB_UNR_REG_ADDR(index, reg);
+	else if  (type == PCIE_TRANSL_INB)
+		reg_addr = PCIE_GET_ATU_INB_UNR_REG_ADDR(index, reg);
+
+	if (pp->ops->writel_rc)
+		pp->ops->writel_rc(pp, val, pp->dbi_base + reg_addr);
+	else
+		writel(val, pp->dbi_base + reg_addr);
+}
+
 static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 			       u32 *val)
 {
@@ -152,24 +224,66 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 		int type, u64 cpu_addr, u64 pci_addr, u32 size)
 {
-	u32 val;
-
-	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | index,
-			  PCIE_ATU_VIEWPORT);
-	dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr), PCIE_ATU_LOWER_BASE);
-	dw_pcie_writel_rc(pp, upper_32_bits(cpu_addr), PCIE_ATU_UPPER_BASE);
-	dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr + size - 1),
-			  PCIE_ATU_LIMIT);
-	dw_pcie_writel_rc(pp, lower_32_bits(pci_addr), PCIE_ATU_LOWER_TARGET);
-	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
-	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
-	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+	u32 val = 0;
+	u32 retries = 0;
+
+	if (pp->iatu_unroll_status) {
+		/* outbound translation using Unroll feature*/
+		dw_pcie_writel_unroll(pp, PCIE_TRANSL_OUTB, index,
+			lower_32_bits(cpu_addr), PCIE_ATU_UNR_LOWER_BASE);
+		dw_pcie_writel_unroll(pp, PCIE_TRANSL_OUTB, index,
+			upper_32_bits(cpu_addr), PCIE_ATU_UNR_UPPER_BASE);
+		dw_pcie_writel_unroll(pp, PCIE_TRANSL_OUTB, index,
+			lower_32_bits(cpu_addr + size - 1), PCIE_ATU_UNR_LIMIT);
+		dw_pcie_writel_unroll(pp, PCIE_TRANSL_OUTB, index,
+			lower_32_bits(pci_addr), PCIE_ATU_UNR_LOWER_TARGET);
+		dw_pcie_writel_unroll(pp, PCIE_TRANSL_OUTB, index,
+			upper_32_bits(pci_addr), PCIE_ATU_UNR_UPPER_TARGET);
+		dw_pcie_writel_unroll(pp, PCIE_TRANSL_OUTB, index,
+			type, PCIE_ATU_UNR_REGION_CTRL1);
+		dw_pcie_writel_unroll(pp, PCIE_TRANSL_OUTB, index,
+			PCIE_ATU_ENABLE, PCIE_ATU_UNR_REGION_CTRL2);
+		dw_pcie_readl_unroll(pp, PCIE_TRANSL_OUTB, index,
+			PCIE_ATU_UNR_REGION_CTRL2, &val);
+	} else {
+		/* outbound translation using legacy mechanism */
+		dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | index,
+						PCIE_ATU_VIEWPORT);
+		dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr),
+						PCIE_ATU_LOWER_BASE);
+		dw_pcie_writel_rc(pp, upper_32_bits(cpu_addr),
+						PCIE_ATU_UPPER_BASE);
+		dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr + size - 1),
+						PCIE_ATU_LIMIT);
+		dw_pcie_writel_rc(pp, lower_32_bits(pci_addr),
+						PCIE_ATU_LOWER_TARGET);
+		dw_pcie_writel_rc(pp, upper_32_bits(pci_addr),
+						PCIE_ATU_UPPER_TARGET);
+		dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
+		dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+		dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);
+	}
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
-	dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);
+	for (retries = 0; retries < LINK_WAIT_MAX_ATU_RETRIES; retries++) {
+
+		if (val == PCIE_ATU_ENABLE)
+			break;
+
+		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+
+		if (pp->iatu_unroll_status) {
+			dw_pcie_readl_unroll(pp, PCIE_TRANSL_OUTB, index,
+				PCIE_ATU_UNR_REGION_CTRL2, &val);
+		} else {
+			dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);
+		}
+	}
+
+	dev_dbg(pp->dev, "iATU is not being enabled\n");
 }
 
 static struct irq_chip dw_msi_irq_chip = {
@@ -428,6 +542,18 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.map = dw_pcie_msi_map,
 };
 
+static void dw_pcie_get_atu_mode(struct pcie_port *pp)
+{
+	u32 val = 0;
+
+	/* Check if the iATU unroll is enabled or not */
+	dw_pcie_readl_rc(pp, PCIE_ATU_VIEWPORT, &val);
+
+	pp->iatu_unroll_status = 0; /* disabled - legacy is used */
+	if (val == 0xFFFFFFFF)
+		pp->iatu_unroll_status = 1; /* enabled */
+}
+
 int dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct device_node *np = pp->dev->of_node;
@@ -544,6 +670,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
+	/* get ATU mode */
+	dw_pcie_get_atu_mode(pp);
+
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index f437f9b..354a981 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -22,11 +22,6 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_USLEEP_MIN		90000
-#define LINK_WAIT_USLEEP_MAX		100000
-
 struct pcie_port {
 	struct device		*dev;
 	u8			root_bus_nr;
@@ -53,6 +48,7 @@ struct pcie_port {
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	unsigned long		msi_data;
+	u8			iatu_unroll_status;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
-- 
1.8.1.5
