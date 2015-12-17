Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:51900 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S966642AbbLQNX3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Dec 2015 08:23:29 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 3/4] PCI: rcar: Add runtime PM support to pcie-rcar
Date: Thu, 17 Dec 2015 13:22:36 +0000
Message-Id: <1450358557-28376-4-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If runtime PM is enabled in the kernel config, simply enable the
clocks once during probe.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 4a4f8e1..02a5993 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -26,6 +26,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #define DRV_NAME "rcar-pcie"
@@ -1019,32 +1020,51 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	 if (err)
 		return err;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		err = rcar_pcie_enable_msi(pcie);
-		if (err < 0) {
-			dev_err(&pdev->dev,
-				"failed to enable MSI support: %d\n",
-				err);
-			return err;
-		}
-	}
-
 	of_id = of_match_device(rcar_pcie_of_match, pcie->dev);
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 	hw_init_fn = of_id->data;
 
+	pm_runtime_enable(pcie->dev);
+	err = pm_runtime_get_sync(pcie->dev);
+	if (err < 0) {
+		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
+		goto err_pm_disable;
+	}
+
 	/* Failure to get a link might just be that no cards are inserted */
 	err = hw_init_fn(pcie);
 	if (err) {
 		dev_info(&pdev->dev, "PCIe link down\n");
-		return 0;
+		err = 0;
+		goto err_pm_put;
 	}
 
 	data = rcar_pci_read_reg(pcie, MACSR);
 	dev_info(&pdev->dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
 
-	return rcar_pcie_enable(pcie);
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		err = rcar_pcie_enable_msi(pcie);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"failed to enable MSI support: %d\n",
+				err);
+			goto err_pm_put;
+		}
+	}
+
+	err = rcar_pcie_enable(pcie);
+	if (err)
+		goto err_pm_put;
+
+	return 0;
+
+err_pm_put:
+	pm_runtime_put(pcie->dev);
+
+err_pm_disable:
+	pm_runtime_disable(pcie->dev);
+	return err;
 }
 
 static struct platform_driver rcar_pcie_driver = {
-- 
2.5.0

