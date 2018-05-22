Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:43712
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751214AbeEVNdX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 09:33:23 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>, <kishon@ti.com>,
        <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.com>,
        <cyrille.pitchen@free-electrons.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [RESEND PATCH 4/4] PCI: cadence: Add Power Management ops for host and EP
Date: Tue, 22 May 2018 14:33:15 +0100
Message-ID: <1526995995-23872-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These PM ops will enable/disable the optional PHYs if present.  The
AXI link-down register in the host driver is now cleared in
cdns_pci_map_bus since the link-down bit will be set if the PHY has
been disabled.  It is not cleared when enabling the PHY, since the
link will not yet be up.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/cadence/pcie-cadence-ep.c   |  1 +
 drivers/pci/cadence/pcie-cadence-host.c |  3 +++
 drivers/pci/cadence/pcie-cadence.c      | 30 ++++++++++++++++++++++++++++++
 drivers/pci/cadence/pcie-cadence.h      |  4 ++++
 4 files changed, 38 insertions(+)

diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
index 2581caf..e74b8a4 100644
--- a/drivers/pci/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/cadence/pcie-cadence-ep.c
@@ -554,6 +554,7 @@ static struct platform_driver cdns_pcie_ep_driver = {
 	.driver = {
 		.name = "cdns-pcie-ep",
 		.of_match_table = cdns_pcie_ep_of_match,
+		.pm	= &cdns_pcie_pm_ops,
 	},
 	.probe = cdns_pcie_ep_probe,
 	.shutdown = cdns_pcie_ep_shutdown,
diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cadence/pcie-cadence-host.c
index 7536926a..a8b5eda 100644
--- a/drivers/pci/cadence/pcie-cadence-host.c
+++ b/drivers/pci/cadence/pcie-cadence-host.c
@@ -61,6 +61,8 @@ static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 	/* Check that the link is up */
 	if (!(cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE) & 0x1))
 		return NULL;
+	/* Clear AXI link-down status */
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);
 
 	/* Update Output registers for AXI region 0. */
 	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
@@ -360,6 +362,7 @@ static struct platform_driver cdns_pcie_host_driver = {
 	.driver = {
 		.name = "cdns-pcie-host",
 		.of_match_table = cdns_pcie_host_of_match,
+		.pm	= &cdns_pcie_pm_ops,
 	},
 	.probe = cdns_pcie_host_probe,
 	.shutdown = cdns_pcie_shutdown,
diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-cadence.c
index 681609a..7a34780 100644
--- a/drivers/pci/cadence/pcie-cadence.c
+++ b/drivers/pci/cadence/pcie-cadence.c
@@ -217,3 +217,33 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 
 	return ret;
 }
+
+#ifdef CONFIG_PM_SLEEP
+static int cdns_pcie_suspend_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+
+	cdns_pcie_disable_phy(pcie);
+
+	return 0;
+}
+
+static int cdns_pcie_resume_noirq(struct device *dev)
+{
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = cdns_pcie_enable_phy(pcie);
+	if (ret) {
+		dev_err(dev, "failed to enable phy\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+const struct dev_pm_ops cdns_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
+				      cdns_pcie_resume_noirq)
+};
diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-cadence.h
index b342c80..ae6bf2a 100644
--- a/drivers/pci/cadence/pcie-cadence.h
+++ b/drivers/pci/cadence/pcie-cadence.h
@@ -166,6 +166,9 @@
 #define CDNS_PCIE_AT_IB_RP_BAR_ADDR1(bar) \
 	(CDNS_PCIE_AT_BASE + 0x0804 + (bar) * 0x0008)
 
+/* AXI link down register */
+#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
+
 enum cdns_pcie_rp_bar {
 	RP_BAR0,
 	RP_BAR1,
@@ -314,5 +317,6 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.2.2
