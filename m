Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36478 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753286AbdBTPji (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2017 10:39:38 -0500
Received: by mail-pg0-f68.google.com with SMTP id a123so10607714pgc.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Feb 2017 07:39:38 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v5 3/4] PCI: imx6: Do not switch speed if Gen2 is disabled
Date: Mon, 20 Feb 2017 07:30:24 -0800
Message-Id: <20170220153025.32096-4-andrew.smirnov@gmail.com>
In-Reply-To: <20170220153025.32096-1-andrew.smirnov@gmail.com>
References: <20170220153025.32096-1-andrew.smirnov@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Save a bit of time and avoid going through link speed change procedure
in configuration where link max speed is limited to Gen1 in DT.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/host/pci-imx6.c | 52 ++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 473bbdc..071251f3 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -565,40 +565,40 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
 		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2;
 		dw_pcie_writel_rc(pp, PCIE_RC_LCR, tmp);
-	} else {
-		dev_info(dev, "Link: Gen2 disabled\n");
-	}
-
-	/*
-	 * Start Directed Speed Change so the best possible speed both link
-	 * partners support can be negotiated.
-	 */
-	tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	tmp |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-	if (imx6_pcie->variant != IMX7D) {
 		/*
-		 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
-		 * from i.MX6 family when no link speed transition
-		 * occurs and we go Gen1 -> yep, Gen1. The difference
-		 * is that, in such case, it will not be cleared by HW
-		 * which will cause the following code to report false
-		 * failure.
+		 * Start Directed Speed Change so the best possible
+		 * speed both link partners support can be negotiated.
 		 */
+		tmp = dw_pcie_readl_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL);
+		tmp |= PORT_LOGIC_SPEED_CHANGE;
+		dw_pcie_writel_rc(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
+
+		if (imx6_pcie->variant != IMX7D) {
+			/*
+			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
+			 * from i.MX6 family when no link speed transition
+			 * occurs and we go Gen1 -> yep, Gen1. The difference
+			 * is that, in such case, it will not be cleared by HW
+			 * which will cause the following code to report false
+			 * failure.
+			 */
+
+			ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
+			if (ret) {
+				dev_err(dev, "Failed to bring link up!\n");
+				goto err_reset_phy;
+			}
+		}
 
-		ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
+		/* Make sure link training is finished as well! */
+		ret = imx6_pcie_wait_for_link(imx6_pcie);
 		if (ret) {
 			dev_err(dev, "Failed to bring link up!\n");
 			goto err_reset_phy;
 		}
-	}
-
-	/* Make sure link training is finished as well! */
-	ret = imx6_pcie_wait_for_link(imx6_pcie);
-	if (ret) {
-		dev_err(dev, "Failed to bring link up!\n");
-		goto err_reset_phy;
+	} else {
+		dev_info(dev, "Link: Gen2 disabled\n");
 	}
 
 	tmp = dw_pcie_readl_rc(pp, PCIE_RC_LCSR);
-- 
2.9.3
