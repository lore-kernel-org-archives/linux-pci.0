Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-arm-kernel@axis.com>
Subject: [PATCH v3 6/7] PCI: dwc: designware: Move _unroll configurations to a
 separate function
Date: Wed, 8 Mar 2017 16:17:16 +0530
Message-ID: <1488970037-17740-7-git-send-email-kishon@ti.com>
In-Reply-To: <1488970037-17740-1-git-send-email-kishon@ti.com>
References: <1488970037-17740-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: nsekhar@ti.com, Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Rename dw_pcie_writel_unroll/dw_pcie_readl_unroll
to dw_pcie_writel_ob_unroll/dw_pcie_readl_ob_unroll respectively as these
functions are used to perform only outbound configurations. Also move
these _unroll configurations to a separate function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.c |  112 ++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 557ee53..6657a84 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -92,22 +92,64 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		dev_err(pci->dev, "write DBI address failed\n");
 }
 
-static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, void __iomem *base,
-				u32 index, u32 reg)
+static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, void __iomem *base,
+				   u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
 	return dw_pcie_read_dbi(pci, base, offset + reg, 0x4);
 }
 
-static void dw_pcie_writel_unroll(struct dw_pcie *pci, void __iomem *base,
-				  u32 index, u32 reg, u32 val)
+static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, void __iomem *base,
+				     u32 index, u32 reg, u32 val)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
 	dw_pcie_write_dbi(pci, base, offset + reg, 0x4, val);
 }
 
+void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index, int type,
+				      u64 cpu_addr, u64 pci_addr, u32 size)
+{
+	u32 retries, val;
+	void __iomem *base = pci->dbi_base;
+
+	dw_pcie_writel_ob_unroll(pci, base, index,
+				 PCIE_ATU_UNR_LOWER_BASE,
+				 lower_32_bits(cpu_addr));
+	dw_pcie_writel_ob_unroll(pci, base, index,
+				 PCIE_ATU_UNR_UPPER_BASE,
+				 upper_32_bits(cpu_addr));
+	dw_pcie_writel_ob_unroll(pci, base, index, PCIE_ATU_UNR_LIMIT,
+				 lower_32_bits(cpu_addr + size - 1));
+	dw_pcie_writel_ob_unroll(pci, base, index,
+				 PCIE_ATU_UNR_LOWER_TARGET,
+				 lower_32_bits(pci_addr));
+	dw_pcie_writel_ob_unroll(pci, base, index,
+				 PCIE_ATU_UNR_UPPER_TARGET,
+				 upper_32_bits(pci_addr));
+	dw_pcie_writel_ob_unroll(pci, base, index,
+				 PCIE_ATU_UNR_REGION_CTRL1,
+				 type);
+	dw_pcie_writel_ob_unroll(pci, base, index,
+				 PCIE_ATU_UNR_REGION_CTRL2,
+				 PCIE_ATU_ENABLE);
+
+	/*
+	 * Make sure ATU enable takes effect before any subsequent config
+	 * and I/O accesses.
+	 */
+	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
+		val = dw_pcie_readl_ob_unroll(pci, base, index,
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
@@ -118,59 +160,39 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 		cpu_addr = pci->ops->cpu_addr_fixup(cpu_addr);
 
 	if (pci->iatu_unroll_enabled) {
-		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_LOWER_BASE,
-				      lower_32_bits(cpu_addr));
-		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_UPPER_BASE,
-				      upper_32_bits(cpu_addr));
-		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_LIMIT,
-				      lower_32_bits(cpu_addr + size - 1));
-		dw_pcie_writel_unroll(pci, base, index,
-				      PCIE_ATU_UNR_LOWER_TARGET,
-				      lower_32_bits(pci_addr));
-		dw_pcie_writel_unroll(pci, base, index,
-				      PCIE_ATU_UNR_UPPER_TARGET,
-				      upper_32_bits(pci_addr));
-		dw_pcie_writel_unroll(pci, base, index,
-				      PCIE_ATU_UNR_REGION_CTRL1,
-				      type);
-		dw_pcie_writel_unroll(pci, base, index,
-				      PCIE_ATU_UNR_REGION_CTRL2,
-				      PCIE_ATU_ENABLE);
-	} else {
-		dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
-				  PCIE_ATU_REGION_OUTBOUND | index);
-		dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_BASE, 0x4,
-				  lower_32_bits(cpu_addr));
-		dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_BASE, 0x4,
-				  upper_32_bits(cpu_addr));
-		dw_pcie_write_dbi(pci, base, PCIE_ATU_LIMIT, 0x4,
-				  lower_32_bits(cpu_addr + size - 1));
-		dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
-				  lower_32_bits(pci_addr));
-		dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
-				  upper_32_bits(pci_addr));
-		dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
-		dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4,
-				  PCIE_ATU_ENABLE);
+		dw_pcie_prog_outbound_atu_unroll(pci, index, type, cpu_addr,
+						 pci_addr, size);
+		return;
 	}
 
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
+			  PCIE_ATU_REGION_OUTBOUND | index);
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_BASE, 0x4,
+			  lower_32_bits(cpu_addr));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_BASE, 0x4,
+			  upper_32_bits(cpu_addr));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_LIMIT, 0x4,
+			  lower_32_bits(cpu_addr + size - 1));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
+			  lower_32_bits(pci_addr));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
+			  upper_32_bits(pci_addr));
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
+	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4,
+			  PCIE_ATU_ENABLE);
+
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		if (pci->iatu_unroll_enabled)
-			val = dw_pcie_readl_unroll(pci, base, index,
-						   PCIE_ATU_UNR_REGION_CTRL2);
-		else
-			val = dw_pcie_read_dbi(pci, base, PCIE_ATU_CR2, 0x4);
-
+		val = dw_pcie_read_dbi(pci, base, PCIE_ATU_CR2, 0x4);
 		if (val == PCIE_ATU_ENABLE)
 			return;
 
 		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
 	}
-	dev_err(pci->dev, "iATU is not being enabled\n");
+	dev_err(pci->dev, "outbound iATU is not being enabled\n");
 }
 
 int dw_pcie_wait_for_link(struct dw_pcie *pci)
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
