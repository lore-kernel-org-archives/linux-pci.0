Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <kishon@ti.com>, <nsekhar@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v4 4/7] PCI: dwc: all: Modify dbi accessors to take dbi_base as argument
Date: Mon, 13 Mar 2017 19:13:25 +0530
Message-ID: <20170313134328.1588-5-kishon@ti.com>
In-Reply-To: <20170313134328.1588-1-kishon@ti.com>
References: <20170313134328.1588-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

dwc has 2 dbi address space labeled dbics and dbics2. The existing
helper to access dbi address space can access only dbics. However
dbics2 has to be accessed for programming the BAR registers in the
case of EP mode. This is in preparation for adding EP mode support
to dwc driver.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-exynos.c      | 10 ++++++----
 drivers/pci/dwc/pcie-designware.c | 13 +++++++------
 drivers/pci/dwc/pcie-designware.h | 20 ++++++++++++++++----
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
index 993b650ef275..a0d40f74b88d 100644
--- a/drivers/pci/dwc/pci-exynos.c
+++ b/drivers/pci/dwc/pci-exynos.c
@@ -521,23 +521,25 @@ static void exynos_pcie_enable_interrupts(struct exynos_pcie *ep)
 		exynos_pcie_msi_init(ep);
 }
 
-static u32 exynos_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
+static u32 exynos_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base,
+				 u32 reg)
 {
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
 	u32 val;
 
 	exynos_pcie_sideband_dbi_r_mode(ep, true);
-	val = readl(pci->dbi_base + reg);
+	val = readl(base + reg);
 	exynos_pcie_sideband_dbi_r_mode(ep, false);
 	return val;
 }
 
-static void exynos_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
+static void exynos_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base,
+				   u32 reg, u32 val)
 {
 	struct exynos_pcie *ep = to_exynos_pcie(pci);
 
 	exynos_pcie_sideband_dbi_w_mode(ep, true);
-	writel(val, pci->dbi_base + reg);
+	writel(val, base + reg);
 	exynos_pcie_sideband_dbi_w_mode(ep, false);
 }
 
diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 3eaf3ccdc118..ea403e2240cf 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -61,20 +61,21 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
 	return PCIBIOS_SUCCESSFUL;
 }
 
-u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
+u32 __dw_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg)
 {
 	if (pci->ops->readl_dbi)
-		return pci->ops->readl_dbi(pci, reg);
+		return pci->ops->readl_dbi(pci, base, reg);
 
-	return readl(pci->dbi_base + reg);
+	return readl(base + reg);
 }
 
-void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
+void __dw_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			  u32 val)
 {
 	if (pci->ops->writel_dbi)
-		pci->ops->writel_dbi(pci, reg, val);
+		pci->ops->writel_dbi(pci, base, reg, val);
 	else
-		writel(val, pci->dbi_base + reg);
+		writel(val, base + reg);
 }
 
 static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, u32 index, u32 reg)
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 8f3dcb2b099b..e97fc4ce7d49 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -144,8 +144,9 @@ struct pcie_port {
 
 struct dw_pcie_ops {
 	u64	(*cpu_addr_fixup)(u64 cpu_addr);
-	u32	(*readl_dbi)(struct dw_pcie *pcie, u32 reg);
-	void	(*writel_dbi)(struct dw_pcie *pcie, u32 reg, u32 val);
+	u32	(*readl_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg);
+	void	(*writel_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			      u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
 };
 
@@ -163,8 +164,9 @@ struct dw_pcie {
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
 
-u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg);
-void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val);
+u32 __dw_pcie_readl_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg);
+void __dw_pcie_writel_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
+			  u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
@@ -172,6 +174,16 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       u32 size);
 void dw_pcie_setup(struct dw_pcie *pci);
 
+static inline dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
+{
+	__dw_pcie_writel_dbi(pci, pci->dbi_base, reg, val);
+}
+
+static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
+{
+	return  __dw_pcie_readl_dbi(pci, pci->dbi_base, reg);
+}
+
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
-- 
2.11.0
