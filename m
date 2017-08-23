Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:35049 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdHWHDP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2017 03:03:15 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 01/10] PCI: rockchip: spilt out rockchip_pcie_setup_irq
Date: Wed, 23 Aug 2017 15:02:05 +0800
Message-Id: <1503471725-73765-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
References: <1503471673-69478-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Spilt out rockchip_pcie_setup_irq in order to prepare for
the following bug fixing. No functional change intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 82 +++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 2eccd53..6dc3d83 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -929,6 +929,51 @@ static int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
+static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
+{
+	int irq, err;
+	struct device *dev = rockchip->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	irq = platform_get_irq_byname(pdev, "sys");
+	if (irq < 0) {
+		dev_err(dev, "missing sys IRQ resource\n");
+		return -EINVAL;
+	}
+
+	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
+			       IRQF_SHARED, "pcie-sys", rockchip);
+	if (err) {
+		dev_err(dev, "failed to request PCIe subsystem IRQ\n");
+		return err;
+	}
+
+	irq = platform_get_irq_byname(pdev, "legacy");
+	if (irq < 0) {
+		dev_err(dev, "missing legacy IRQ resource\n");
+		return -EINVAL;
+	}
+
+	irq_set_chained_handler_and_data(irq,
+					 rockchip_pcie_legacy_int_handler,
+					 rockchip);
+
+	irq = platform_get_irq_byname(pdev, "client");
+	if (irq < 0) {
+		dev_err(dev, "missing client IRQ resource\n");
+		return -EINVAL;
+	}
+
+	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
+			       IRQF_SHARED, "pcie-client", rockchip);
+	if (err) {
+		dev_err(dev, "failed to request PCIe client IRQ\n");
+		return err;
+	}
+
+	return 0;
+}
+
 /**
  * rockchip_pcie_parse_dt - Parse Device Tree
  * @rockchip: PCIe port information
@@ -941,7 +986,6 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *node = dev->of_node;
 	struct resource *regs;
-	int irq;
 	int err;
 
 	regs = platform_get_resource_byname(pdev,
@@ -1055,41 +1099,9 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		return PTR_ERR(rockchip->clk_pcie_pm);
 	}
 
-	irq = platform_get_irq_byname(pdev, "sys");
-	if (irq < 0) {
-		dev_err(dev, "missing sys IRQ resource\n");
-		return -EINVAL;
-	}
-
-	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
-			       IRQF_SHARED, "pcie-sys", rockchip);
-	if (err) {
-		dev_err(dev, "failed to request PCIe subsystem IRQ\n");
-		return err;
-	}
-
-	irq = platform_get_irq_byname(pdev, "legacy");
-	if (irq < 0) {
-		dev_err(dev, "missing legacy IRQ resource\n");
-		return -EINVAL;
-	}
-
-	irq_set_chained_handler_and_data(irq,
-					 rockchip_pcie_legacy_int_handler,
-					 rockchip);
-
-	irq = platform_get_irq_byname(pdev, "client");
-	if (irq < 0) {
-		dev_err(dev, "missing client IRQ resource\n");
-		return -EINVAL;
-	}
-
-	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
-			       IRQF_SHARED, "pcie-client", rockchip);
-	if (err) {
-		dev_err(dev, "failed to request PCIe client IRQ\n");
+	err = rockchip_pcie_setup_irq(rockchip);
+	if (err)
 		return err;
-	}
 
 	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
 	if (IS_ERR(rockchip->vpcie12v)) {
-- 
1.9.1
