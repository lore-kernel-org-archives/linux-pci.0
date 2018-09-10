Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:24439 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727261AbeIJOnw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Sep 2018 10:43:52 -0400
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <marc.zyngier@arm.com>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>
CC: <ulf.hansson@linaro.org>, <honghui.zhang@mediatek.com>,
        <hongkun.cao@mediatek.com>, <youlin.pei@mediatek.com>,
        <yong.wu@mediatek.com>, <yt.shen@mediatek.com>,
        <sean.wang@mediatek.com>, <xinping.qian@mediatek.com>
Subject: [PATCH v4 4/4] PCI: mediatek: Add loadable kernel module support
Date: Mon, 10 Sep 2018 17:50:23 +0800
Message-ID: <1536573023-6720-5-git-send-email-honghui.zhang@mediatek.com>
In-Reply-To: <1536573023-6720-1-git-send-email-honghui.zhang@mediatek.com>
References: <1536573023-6720-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Honghui Zhang <honghui.zhang@mediatek.com>

Implement remove callback function for Mediatek PCIe driver to add
loadable kernel module support.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/Kconfig         |  2 +-
 drivers/pci/controller/pcie-mediatek.c | 60 +++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 028b287..465790f 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -231,7 +231,7 @@ config PCIE_ROCKCHIP_EP
 	  available to support GEN2 with 4 slots.
 
 config PCIE_MEDIATEK
-	bool "MediaTek PCIe controller"
+	tristate "MediaTek PCIe controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index bcc77bc..9d54fc9 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -15,6 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
@@ -184,6 +185,7 @@ struct mtk_pcie_port {
 	struct phy *phy;
 	u32 lane;
 	u32 slot;
+	int irq;
 	struct irq_domain *irq_domain;
 	struct irq_domain *inner_domain;
 	struct irq_domain *msi_domain;
@@ -538,6 +540,27 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
+static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+{
+	struct mtk_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+
+		if (port->irq_domain)
+			irq_domain_remove(port->irq_domain);
+
+		if (IS_ENABLED(CONFIG_PCI_MSI)) {
+			if (port->msi_domain)
+				irq_domain_remove(port->msi_domain);
+			if (port->inner_domain)
+				irq_domain_remove(port->inner_domain);
+		}
+
+		irq_dispose_mapping(port->irq);
+	}
+}
+
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
@@ -628,7 +651,7 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	int err, irq;
+	int err;
 
 	err = mtk_pcie_init_irq_domain(port, node);
 	if (err) {
@@ -636,8 +659,9 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 		return err;
 	}
 
-	irq = platform_get_irq(pdev, port->slot);
-	irq_set_chained_handler_and_data(irq, mtk_pcie_intr_handler, port);
+	port->irq = platform_get_irq(pdev, port->slot);
+	irq_set_chained_handler_and_data(port->irq,
+					 mtk_pcie_intr_handler, port);
 
 	return 0;
 }
@@ -1199,6 +1223,32 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+
+static void mtk_pcie_free_resources(struct mtk_pcie *pcie)
+{
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct list_head *windows = &host->windows;
+
+	pci_unmap_iospace(&pcie->pio);
+	pci_free_resource_list(windows);
+}
+
+static int mtk_pcie_remove(struct platform_device *pdev)
+{
+	struct mtk_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+
+	pci_stop_root_bus(host->bus);
+	pci_remove_root_bus(host->bus);
+	mtk_pcie_free_resources(pcie);
+
+	mtk_pcie_irq_teardown(pcie);
+
+	mtk_pcie_put_resources(pcie);
+
+	return 0;
+}
+
 static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
@@ -1286,6 +1336,7 @@ static const struct of_device_id mtk_pcie_ids[] = {
 
 static struct platform_driver mtk_pcie_driver = {
 	.probe = mtk_pcie_probe,
+	.remove = mtk_pcie_remove,
 	.driver = {
 		.name = "mtk-pcie",
 		.of_match_table = mtk_pcie_ids,
@@ -1293,4 +1344,5 @@ static struct platform_driver mtk_pcie_driver = {
 		.pm = &mtk_pcie_pm_ops,
 	},
 };
-builtin_platform_driver(mtk_pcie_driver);
+module_platform_driver(mtk_pcie_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.6.4
