Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0049.outbound.protection.outlook.com ([104.47.36.49]:22770
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751214AbeEVN1X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 May 2018 09:27:23 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>, <kishon@ti.com>,
        <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.com>,
        <cyrille.pitchen@free-electrons.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: [RESEND PATCH 2/4] PCI: cadence: Add generic PHY support to host and EP drivers
Date: Tue, 22 May 2018 14:27:06 +0100
Message-ID: <1526995626-9333-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If PHYs are present, they will be initialized and enabled in driver probe,
and disabled in driver shutdown.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/cadence/pcie-cadence-ep.c   | 14 ++++-
 drivers/pci/cadence/pcie-cadence-host.c | 31 +++++++++++
 drivers/pci/cadence/pcie-cadence.c      | 93 +++++++++++++++++++++++++++++++++
 drivers/pci/cadence/pcie-cadence.h      |  7 +++
 4 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
index 3d8283e..2581caf 100644
--- a/drivers/pci/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/cadence/pcie-cadence-ep.c
@@ -439,6 +439,7 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 	struct pci_epc *epc;
 	struct resource *res;
 	int ret;
+	int phy_count;
 
 	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
 	if (!ep)
@@ -472,6 +473,12 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 	if (!ep->ob_addr)
 		return -ENOMEM;
 
+	ret = cdns_pcie_init_phy(dev, pcie);
+	if (ret) {
+		dev_err(dev, "failed to init phy\n");
+		return ret;
+	}
+	platform_set_drvdata(pdev, pcie);
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -520,6 +527,10 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 
  err_get_sync:
 	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(pcie);
+	phy_count = pcie->phy_count;
+	while (phy_count--)
+		device_link_del(pcie->link[phy_count]);
 
 	return ret;
 }
@@ -527,6 +538,7 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
 	ret = pm_runtime_put_sync(dev);
@@ -535,7 +547,7 @@ static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
 
 	pm_runtime_disable(dev);
 
-	/* The PCIe controller can't be disabled. */
+	cdns_pcie_disable_phy(pcie);
 }
 
 static struct platform_driver cdns_pcie_ep_driver = {
diff --git a/drivers/pci/cadence/pcie-cadence-host.c b/drivers/pci/cadence/pcie-cadence-host.c
index a4ebbd3..7536926a 100644
--- a/drivers/pci/cadence/pcie-cadence-host.c
+++ b/drivers/pci/cadence/pcie-cadence-host.c
@@ -58,6 +58,9 @@ static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 
 		return pcie->reg_base + (where & 0xfff);
 	}
+	/* Check that the link is up */
+	if (!(cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE) & 0x1))
+		return NULL;
 
 	/* Update Output registers for AXI region 0. */
 	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
@@ -239,6 +242,7 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
+	int phy_count;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
 	if (!bridge)
@@ -290,6 +294,13 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	}
 	pcie->mem_res = res;
 
+	ret = cdns_pcie_init_phy(dev, pcie);
+	if (ret) {
+		dev_err(dev, "failed to init phy\n");
+		return ret;
+	}
+	platform_set_drvdata(pdev, pcie);
+
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -322,15 +333,35 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 
  err_get_sync:
 	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(pcie);
+	phy_count = pcie->phy_count;
+	while (phy_count--)
+		device_link_del(pcie->link[phy_count]);
 
 	return ret;
 }
 
+static void cdns_pcie_shutdown(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		dev_dbg(dev, "pm_runtime_put_sync failed\n");
+
+	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(pcie);
+}
+
+
 static struct platform_driver cdns_pcie_host_driver = {
 	.driver = {
 		.name = "cdns-pcie-host",
 		.of_match_table = cdns_pcie_host_of_match,
 	},
 	.probe = cdns_pcie_host_probe,
+	.shutdown = cdns_pcie_shutdown,
 };
 builtin_platform_driver(cdns_pcie_host_driver);
diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-cadence.c
index 138d113..681609a 100644
--- a/drivers/pci/cadence/pcie-cadence.c
+++ b/drivers/pci/cadence/pcie-cadence.c
@@ -124,3 +124,96 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), 0);
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
 }
+
+void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
+{
+	int i = pcie->phy_count;
+
+	while (i--) {
+		phy_power_off(pcie->phy[i]);
+		phy_exit(pcie->phy[i]);
+	}
+}
+
+int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < pcie->phy_count; i++) {
+		ret = phy_init(pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
+		ret = phy_power_on(pcie->phy[i]);
+		if (ret < 0) {
+			phy_exit(pcie->phy[i]);
+			goto err_phy;
+		}
+	}
+
+	return 0;
+
+err_phy:
+	while (--i >= 0) {
+		phy_power_off(pcie->phy[i]);
+		phy_exit(pcie->phy[i]);
+	}
+
+	return ret;
+}
+
+int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
+{
+	struct device_node *np = dev->of_node;
+	int phy_count;
+	struct phy **phy;
+	struct device_link **link;
+	int i;
+	int ret;
+	const char *name;
+
+	phy_count = of_property_count_strings(np, "phy-names");
+	if (phy_count < 1) {
+		dev_err(dev, "no phy-names.  PHY will not be initialized\n");
+		pcie->phy_count = 0;
+		return 0;
+	}
+
+	phy = devm_kzalloc(dev, sizeof(*phy) * phy_count, GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	link = devm_kzalloc(dev, sizeof(*link) * phy_count, GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	for (i = 0; i < phy_count; i++) {
+		of_property_read_string_index(np, "phy-names", i, &name);
+		phy[i] = devm_phy_get(dev, name);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+
+		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
+		if (!link[i]) {
+			ret = -EINVAL;
+			goto err_link;
+		}
+	}
+
+	pcie->phy_count = phy_count;
+	pcie->phy = phy;
+	pcie->link = link;
+
+	ret =  cdns_pcie_enable_phy(pcie);
+	if (ret)
+		goto err_link;
+
+	return 0;
+
+err_link:
+	while (--i >= 0)
+		device_link_del(link[i]);
+
+	return ret;
+}
diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-cadence.h
index ed336cc..b342c80 100644
--- a/drivers/pci/cadence/pcie-cadence.h
+++ b/drivers/pci/cadence/pcie-cadence.h
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/phy/phy.h>
 
 /*
  * Local Management Registers
@@ -229,6 +230,9 @@ struct cdns_pcie {
 	struct resource		*mem_res;
 	bool			is_rc;
 	u8			bus;
+	int			phy_count;
+	struct phy		**phy;
+	struct device_link	**link;
 };
 
 /* Register access */
@@ -307,5 +311,8 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u8 fn,
 						  u32 r, u64 cpu_addr);
 
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
+void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
+int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
+int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.2.2
