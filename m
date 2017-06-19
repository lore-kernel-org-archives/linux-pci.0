Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/3] PCI: mediatek: turn off subsys power if no link up detected
Date: Mon, 19 Jun 2017 17:59:59 +0800
Message-ID: <1497866400-41844-3-git-send-email-ryder.lee@mediatek.com>
In-Reply-To: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
References: <1497866400-41844-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no need to keep controller power on if slots are all empty,
so a check is added to turn it off. Besides, host controllers may not
need PM domain in some SoCs, thus we add dev->pm_domain to check that.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 165d82d..d256263 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -118,6 +118,18 @@ static inline bool mtk_pcie_link_is_up(struct mtk_pcie_port *port)
 	return !!(readl(port->base + PCIE_LINK_STATUS) & PCIE_PORT_LINKUP);
 }
 
+static void mtk_pcie_subsys_powerdown(struct mtk_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+
+	clk_disable_unprepare(pcie->free_ck);
+
+	if (dev->pm_domain) {
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
+	}
+}
+
 static void mtk_pcie_port_free(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
@@ -130,7 +142,6 @@ static void mtk_pcie_port_free(struct mtk_pcie_port *port)
 
 static void mtk_pcie_put_resources(struct mtk_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
 	struct mtk_pcie_port *port, *tmp;
 
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
@@ -139,9 +150,7 @@ static void mtk_pcie_put_resources(struct mtk_pcie *pcie)
 		mtk_pcie_port_free(port);
 	}
 
-	clk_disable_unprepare(pcie->free_ck);
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
+	mtk_pcie_subsys_powerdown(pcie);
 }
 
 static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus,
@@ -340,10 +349,10 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 		return PTR_ERR(pcie->free_ck);
 	}
 
-	pm_runtime_enable(dev);
-	err = pm_runtime_get_sync(dev);
-	if (err)
-		goto err_pm;
+	if (dev->pm_domain) {
+		pm_runtime_enable(dev);
+		pm_runtime_get_sync(dev);
+	}
 
 	/* enable top level clock */
 	err = clk_prepare_enable(pcie->free_ck);
@@ -355,9 +364,10 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 	return 0;
 
 err_free_ck:
-	pm_runtime_put_sync(dev);
-err_pm:
-	pm_runtime_disable(dev);
+	if (dev->pm_domain) {
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
+	}
 
 	return err;
 }
@@ -439,6 +449,10 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		mtk_pcie_enable_ports(port);
 
+	/* power down PCIe subsys if slots are all empty(link down) */
+	if (list_empty(&pcie->ports))
+		mtk_pcie_subsys_powerdown(pcie);
+
 	return 0;
 }
 
@@ -522,7 +536,9 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 put_resources:
-	mtk_pcie_put_resources(pcie);
+	if (!list_empty(&pcie->ports))
+		mtk_pcie_put_resources(pcie);
+
 	return err;
 }
 
-- 
1.9.1
