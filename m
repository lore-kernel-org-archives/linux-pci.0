Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v6 4/4] PCI: designware: Add iATU Unroll feature
To: Joao Pinto <Joao.Pinto@synopsys.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: jszhang@marvell.com, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 17 Aug 2016 15:00:22 -0500
Message-ID: <20160817200022.10418.88555.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160817195239.10418.7037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160817195239.10418.7037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joao Pinto <Joao.Pinto@synopsys.com>

Add support for the new iATU Unroll mechanism that will be used from Core
version 4.80.  The new Cores can support either iATU Unroll or the "old"
iATU method, now called Legacy Mode.  The driver is perfectly capable of
performing well for both.

[bhelgaas: split ATU enable timeout to separate patch]
Signed-off-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |   97 ++++++++++++++++++++++++++++++++----
 drivers/pci/host/pcie-designware.h |    1 
 2 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 947fac3..e489b18 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -80,6 +80,21 @@
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
+/*
+ * iATU Unroll-specific register definitions
+ * From 4.80 core version the address translation will be made by unroll
+ */
+#define PCIE_ATU_UNR_REGION_CTRL1	0x00
+#define PCIE_ATU_UNR_REGION_CTRL2	0x04
+#define PCIE_ATU_UNR_LOWER_BASE		0x08
+#define PCIE_ATU_UNR_UPPER_BASE		0x0C
+#define PCIE_ATU_UNR_LIMIT		0x10
+#define PCIE_ATU_UNR_LOWER_TARGET	0x14
+#define PCIE_ATU_UNR_UPPER_TARGET	0x18
+
+/* Register address builder */
+#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)  ((0x3 << 20) | (region << 9)
+
 /* PCIe Port Logic registers */
 #define PLR_OFFSET			0x700
 #define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
@@ -141,6 +156,27 @@ static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
 		writel(val, pp->dbi_base + reg);
 }
 
+static inline u32 dw_pcie_readl_unroll(struct pcie_port *pp, u32 index, u32 reg)
+{
+	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
+
+	if (pp->ops->readl_rc)
+		return pp->ops->readl_rc(pp, pp->dbi_base + offset + reg);
+
+	return readl(pp->dbi_base + offset + reg);
+}
+
+static inline void dw_pcie_writel_unroll(struct pcie_port *pp, u32 index,
+					 u32 val, u32 reg)
+{
+	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
+
+	if (pp->ops->writel_rc)
+		pp->ops->writel_rc(pp, val, pp->dbi_base + offset + reg);
+	else
+		writel(val, pp->dbi_base + offset + reg);
+}
+
 static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 			       u32 *val)
 {
@@ -164,23 +200,49 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 {
 	u32 retries, val;
 
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
+	if (pp->iatu_unroll_enabled) {
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
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_rc(pp, PCIE_ATU_CR2);
+		if (pp->iatu_unroll_enabled)
+			val = dw_pcie_readl_unroll(pp, index,
+						   PCIE_ATU_UNR_REGION_CTRL2);
+		else
+			val = dw_pcie_readl_rc(pp, PCIE_ATU_CR2);
+
 		if (val == PCIE_ATU_ENABLE)
 			return;
 
@@ -445,6 +507,17 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.map = dw_pcie_msi_map,
 };
 
+static u8 dw_pcie_iatu_unroll_enabled(struct pcie_port *pp)
+{
+	u32 val = 0;
+
+	dw_pcie_readl_rc(pp, PCIE_ATU_VIEWPORT, &val);
+	if (val == 0xffffffff)
+		return 1;
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct pcie_port *pp)
 {
 	struct device_node *np = pp->dev->of_node;
@@ -561,6 +634,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
+	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
+
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 285e1ed..e74cc4a 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -48,6 +48,7 @@ struct pcie_port {
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	unsigned long		msi_data;
+	u8			iatu_unroll_enabled;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 };
 
