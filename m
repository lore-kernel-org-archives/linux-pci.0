Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:60844 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdLAFHD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Dec 2017 00:07:03 -0500
From: Vignesh R <vigneshr@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH] pci: dwc: pci-dra7xx: Make shutdown handler static
Date: Fri, 1 Dec 2017 10:36:52 +0530
Message-ID: <20171201050652.13998-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Declare dra7xx_pcie_shutdown() as a static function as its not used
elsewhere.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 59e8de34cec6..b9db442af793 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -815,7 +815,7 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
 }
 #endif
 
-void dra7xx_pcie_shutdown(struct platform_device *pdev)
+static void dra7xx_pcie_shutdown(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-- 
2.15.0
