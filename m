Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH v4 6/7] PCI: dwc: designware: Move _unroll configurations to a separate function
Date: Mon, 13 Mar 2017 19:13:27 +0530
Message-ID: <20170313134328.1588-7-kishon@ti.com>
In-Reply-To: <20170313134328.1588-1-kishon@ti.com>
References: <20170313134328.1588-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Rename dw_pcie_writel_unroll/dw_pcie_readl_unroll
to dw_pcie_writel_ob_unroll/dw_pcie_readl_ob_unroll respectively as these
functions are used to perform only outbound configurations. Also move
these _unroll configurations to a separate function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.c | 97 +++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 734acac1926d..54de468a745e 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -92,21 +92,56 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		dev_err(pci->dev, "write DBI address failed\n");
 }
 
-static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, u32 index, u32 reg)
+static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
 	return dw_pcie_readl_dbi(pci, offset + reg);
 }
 
-static void dw_pcie_writel_unroll(struct dw_pcie *pci, u32 index, u32 reg,
-				  u32 val)
+static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
+				     u32 val)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
 	dw_pcie_writel_dbi(pci, offset + reg, val);
 }
 
+void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index, int type,
+				      u64 cpu_addr, u64 pci_addr, u32 size)
+{
+	u32 retries, val;
+
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
+				 lower_32_bits(cpu_addr));
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
+				 upper_32_bits(cpu_addr));
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
+				 lower_32_bits(cpu_addr + size - 1));
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
+				 lower_32_bits(pci_addr));
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
+				 upper_32_bits(pci_addr));
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
+				 type);
+	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
+				 PCIE_ATU_ENABLE);
+
+	/*
+	 * Make sure ATU enable takes effect before any subsequent config
+	 * and I/O accesses.
+	 */
+	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
+		val = dw_pcie_readl_ob_unroll(pci, index,
+					      PCIE_ATU_UNR_REGION_CTRL2);
+		if (val & PCIE_ATU_ENABLE)
+			return;
+
+		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+	}
+	dev_err(pci->dev, "outbound iATU is not being enabled\n");
+}
+
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 			       u64 cpu_addr, u64 pci_addr, u32 size)
 {
@@ -116,54 +151,38 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 		cpu_addr = pci->ops->cpu_addr_fixup(cpu_addr);
 
 	if (pci->iatu_unroll_enabled) {
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
-				      lower_32_bits(cpu_addr));
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
-				      upper_32_bits(cpu_addr));
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
-				      lower_32_bits(cpu_addr + size - 1));
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
-				      lower_32_bits(pci_addr));
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
-				      upper_32_bits(pci_addr));
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
-				      type);
-		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
-				      PCIE_ATU_ENABLE);
-	} else {
-		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT,
-				   PCIE_ATU_REGION_OUTBOUND | index);
-		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_BASE,
-				   lower_32_bits(cpu_addr));
-		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_BASE,
-				   upper_32_bits(cpu_addr));
-		dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
-				   lower_32_bits(cpu_addr + size - 1));
-		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
-				   lower_32_bits(pci_addr));
-		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
-				   upper_32_bits(pci_addr));
-		dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type);
-		dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
+		dw_pcie_prog_outbound_atu_unroll(pci, index, type, cpu_addr,
+						 pci_addr, size);
+		return;
 	}
 
+	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT,
+			   PCIE_ATU_REGION_OUTBOUND | index);
+	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_BASE,
+			   lower_32_bits(cpu_addr));
+	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_BASE,
+			   upper_32_bits(cpu_addr));
+	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
+			   lower_32_bits(cpu_addr + size - 1));
+	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
+			   lower_32_bits(pci_addr));
+	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
+			   upper_32_bits(pci_addr));
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type);
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
+
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		if (pci->iatu_unroll_enabled)
-			val = dw_pcie_readl_unroll(pci, index,
-						   PCIE_ATU_UNR_REGION_CTRL2);
-		else
-			val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
-
+		val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
 		if (val == PCIE_ATU_ENABLE)
 			return;
 
 		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
 	}
-	dev_err(pci->dev, "iATU is not being enabled\n");
+	dev_err(pci->dev, "outbound iATU is not being enabled\n");
 }
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
-- 
2.11.0
