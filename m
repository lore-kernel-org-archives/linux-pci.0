Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org
Cc: jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jszhang@marvell.com,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v5 2/3] pcie-designware: add iATU Unroll feature
Date: Wed, 10 Aug 2016 11:02:39 +0100
Message-Id: <e7ad782cee69b1cf722f3e705f447c576cd2b6fe.1470822461.git.jpinto@synopsys.com>
In-Reply-To: <cover.1470822461.git.jpinto@synopsys.com>
References: <cover.1470822461.git.jpinto@synopsys.com>
In-Reply-To: <cover.1470822461.git.jpinto@synopsys.com>
References: <cover.1470822461.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>

This patch adds the support to the new iATU mechanism that will be used
from Core version 4.80, which is called iATU Unroll.
The new Cores can support the iATU Unroll or support the "old" iATU 
method now called Legacy Mode. The driver is perfectly capable of
performing well for both.

In order to make sure that the iATU is really enabled a for loop was
introduced in dw_pcie_prog_outbound_atu() to improve reliability.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
changes v4->v5:
- v4 patch was not done properly
changes v3->v4:
- Unroll Mode is now obtained before the host initialization
- The iATU enable check loop is now returning instead of only
interrupting the loop
changes v2->v3 (Bjorn Helgaas):
- Unused *CTRL3 and *UPPR iATU Unroll registers were removed
- Inbound addr builder macro was removed to simplifiy the code
- *readl_unroll and *writel_unroll functions were simplified. Now the
scope is always outbound.
- dw_pcie_get_atu_mode changed to return the status
- iATU enable check routine was improved in dw_pcie_prog_outbound_atu()
changes v1->v2:
- Patch was breaking kernel build due to bad definition in macro funtion.
- Rebased on top of pci/next.

 drivers/pci/host/pcie-designware.c | 131 ++++++++++++++++++++++++++++++++-----
 drivers/pci/host/pcie-designware.h |   1 +
 2 files changed, 116 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 6fb88de..d239bc9 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -31,6 +31,11 @@
 #define LINK_WAIT_USLEEP_MIN		90000
 #define LINK_WAIT_USLEEP_MAX		100000
 
+/* Parameters for the waiting for iATU enabled routine */
+#define LINK_WAIT_MAX_IATU_RETRIES	5
+#define LINK_WAIT_IATU_MIN		9000
+#define LINK_WAIT_IATU_MAX		10000
+
 /* Synopsis specific PCIE configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		(0x3f << 16)
@@ -75,6 +80,26 @@
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
+/*
+ * iATU unroll specific registers and definitions
+ * from 4.80 core version the address translation will be made by unroll
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
+
+/* Register address builder */
+#define PCIE_GET_ATU_OUTB_UNR_REG_ADDR(region, register)		\
+					((0x3 << 20) | (region << 9) |	\
+					(register << 2))
+/* End of Unroll specific */
+
 /* PCIe Port Logic registers */
 #define PLR_OFFSET			0x700
 #define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
@@ -136,6 +161,28 @@ static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
 		writel(val, pp->dbi_base + reg);
 }
 
+static inline void dw_pcie_readl_unroll(struct pcie_port *pp,
+						u32 index, u32 reg, u32 *val)
+{
+	u32 reg_addr = PCIE_GET_ATU_OUTB_UNR_REG_ADDR(index, reg);
+
+	if (pp->ops->readl_rc)
+		pp->ops->readl_rc(pp, pp->dbi_base + reg_addr, val);
+	else
+		*val = readl(pp->dbi_base + reg_addr);
+}
+
+static inline void dw_pcie_writel_unroll(struct pcie_port *pp,
+						u32 index, u32 val, u32 reg)
+{
+	u32 reg_addr = PCIE_GET_ATU_OUTB_UNR_REG_ADDR(index, reg);
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
@@ -157,24 +204,61 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
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
+		dw_pcie_writel_unroll(pp, index,
+			lower_32_bits(cpu_addr), PCIE_ATU_UNR_LOWER_BASE);
+		dw_pcie_writel_unroll(pp, index,
+			upper_32_bits(cpu_addr), PCIE_ATU_UNR_UPPER_BASE);
+		dw_pcie_writel_unroll(pp, index,
+			lower_32_bits(cpu_addr + size - 1), PCIE_ATU_UNR_LIMIT);
+		dw_pcie_writel_unroll(pp, index,
+			lower_32_bits(pci_addr), PCIE_ATU_UNR_LOWER_TARGET);
+		dw_pcie_writel_unroll(pp, index,
+			upper_32_bits(pci_addr), PCIE_ATU_UNR_UPPER_TARGET);
+		dw_pcie_writel_unroll(pp, index,
+			type, PCIE_ATU_UNR_REGION_CTRL1);
+		dw_pcie_writel_unroll(pp, index,
+			PCIE_ATU_ENABLE, PCIE_ATU_UNR_REGION_CTRL2);
+	} else {
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
+	}
 
 	/*
-	 * Make sure ATU enable takes effect before any subsequent config
-	 * and I/O accesses.
-	 */
-	dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);
+	 * Make sure ATU enable takes effect before any subsequent config
+	 * and I/O accesses.
+	 */
+	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
+
+		if (pp->iatu_unroll_status) {
+			dw_pcie_readl_unroll(pp, index,
+					PCIE_ATU_UNR_REGION_CTRL2, &val);
+		} else {
+			dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);
+		}
+
+		if (val == PCIE_ATU_ENABLE)
+			return;
+
+		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+	}
+
+	dev_dbg(pp->dev, "iATU is not being enabled\n");
 }
 
 static struct irq_chip dw_msi_irq_chip = {
@@ -433,6 +517,19 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.map = dw_pcie_msi_map,
 };
 
+static u8 dw_pcie_get_atu_mode(struct pcie_port *pp)
+{
+	u32 val = 0;
+
+	/* Check if the iATU unroll is enabled or not */
+	dw_pcie_readl_rc(pp, PCIE_ATU_VIEWPORT, &val);
+
+	if (val == 0xFFFFFFFF)
+		return 1; /* enabled */
+
+	return 0; /* disabled */
+}
+
 int dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct device_node *np = pp->dev->of_node;
@@ -549,6 +646,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
+	pp->iatu_unroll_status = dw_pcie_get_atu_mode(pp);
+
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 384e79b..354a981 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -48,6 +48,7 @@ struct pcie_port {
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	unsigned long		msi_data;
+	u8			iatu_unroll_status;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
-- 
1.8.1.5
