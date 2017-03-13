Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 11/23] PCI: dwc: dra7xx: Facilitate wrapper and msi
 interrupts to be enabled independently
Date: Mon, 13 Mar 2017 19:52:47 +0530
Message-ID: <20170313142259.25397-12-kishon@ti.com>
In-Reply-To: <20170313142259.25397-1-kishon@ti.com>
References: <20170313142259.25397-1-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, nsekhar@ti.com, kishon@ti.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

No functional change. Split dra7xx_pcie_enable_interrupts into
dra7xx_pcie_enable_wrapper_interrupts and dra7xx_pcie_enable_msi_interrupts
so that wrapper interrupts and msi interrupts can be enabled independently.
This is in preparation for adding EP mode support to dra7xx driver since
EP mode doesn't have to enable msi_interrupts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 7c9ed6a6675c..d78974d20360 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -140,18 +140,30 @@ static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 	return dw_pcie_wait_for_link(pci);
 }
 
-static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
+static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
 {
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
-			   ~INTERRUPTS);
-	dra7xx_pcie_writel(dra7xx,
-			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN, INTERRUPTS);
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
 			   ~LEG_EP_INTERRUPTS & ~MSI);
-	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
+
+	dra7xx_pcie_writel(dra7xx,
+			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
 			   MSI | LEG_EP_INTERRUPTS);
 }
 
+static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
+			   ~INTERRUPTS);
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
+			   INTERRUPTS);
+}
+
+static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
+{
+	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
+	dra7xx_pcie_enable_msi_interrupts(dra7xx);
+}
+
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
