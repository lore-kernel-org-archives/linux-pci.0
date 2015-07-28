Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v4 3/3] PCI: host: pci-dra7xx: Idle the module by disabling MSE bit
Date: Tue, 28 Jul 2015 19:24:36 +0530
Message-ID: <1438091676-21243-4-git-send-email-kishon@ti.com>
In-Reply-To: <1438091676-21243-1-git-send-email-kishon@ti.com>
References: <1438091676-21243-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DRA7xx require MSE bit to be cleared to set the master in
standby mode. (In DRA7xx TRM_vE, section 24.9.4.5.2.2.1 PCIe
Controller Master Standby Behavior advises to use the clearing
of the local MSE bit to set the master in standby. Without this
some of the clocks do not idle).

Cleared the MSE bit on suspend and enabled it back on resume.
Clearing MSE bit is required to get clocks to be idled after
suspend.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/host/pci-dra7xx.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 08b999a..773349f 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -83,6 +83,17 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
 	writel(value, pcie->base + offset);
 }
 
+static inline u32 dra7xx_pcie_readl_rc(struct pcie_port *pp, u32 offset)
+{
+	return readl(pp->dbi_base + offset);
+}
+
+static inline void dra7xx_pcie_writel_rc(struct pcie_port *pp, u32 offset,
+					 u32 value)
+{
+	writel(value, pp->dbi_base + offset);
+}
+
 static int dra7xx_pcie_link_up(struct pcie_port *pp)
 {
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
@@ -434,6 +445,34 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int dra7xx_pcie_suspend(struct device *dev)
+{
+	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
+	struct pcie_port *pp = &dra7xx->pp;
+	u32 val;
+
+	/* clear MSE */
+	val = dra7xx_pcie_readl_rc(pp, PCI_COMMAND);
+	val &= ~PCI_COMMAND_MEMORY;
+	dra7xx_pcie_writel_rc(pp, PCI_COMMAND, val);
+
+	return 0;
+}
+
+static int dra7xx_pcie_resume(struct device *dev)
+{
+	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
+	struct pcie_port *pp = &dra7xx->pp;
+	u32 val;
+
+	/* Set MSE */
+	val = dra7xx_pcie_readl_rc(pp, PCI_COMMAND);
+	val |= PCI_COMMAND_MEMORY;
+	dra7xx_pcie_writel_rc(pp, PCI_COMMAND, val);
+
+	return 0;
+}
+
 static int dra7xx_pcie_suspend_noirq(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-- 
1.7.9.5

