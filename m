Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32961 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbdC1Pnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2017 11:43:41 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, yurovsky@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <dongas86@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/4] PCI: imx6: Do not wait for speed change on i.MX7
Date: Tue, 28 Mar 2017 08:42:51 -0700
Message-Id: <20170328154252.6902-4-andrew.smirnov@gmail.com>
In-Reply-To: <20170328154252.6902-1-andrew.smirnov@gmail.com>
References: <20170328154252.6902-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As can be seen from [1]:

"...the different behavior between iMX6Q PCIe and iMX7D PCIe maybe
caused by the different controller version.

Regarding to the DOC description, the DIRECT_SPEED_CHANGE should be
cleared after the speed change from GEN1 to GEN2. Unfortunately, when
GEN1 device is used, the behavior is not documented.

So, IC design guys run the simulation and
find out the following behaviors:

     1. DIRECT_SPEED_CHANGE will be cleared in 7D after speed change
     	from GEN1 to GEN2. This matches doc’s description

     2. set MAX link speed(PCIE_CAP_TARGET_LINK_SPEED=0x01) as GEN1 and
     	re-run the simulation, DIRECT_SPEED_CHANGE will not be cleared;
     	remain as 1, this matches your result, but function test is
     	passed, so this bit should not affect the normal PCIe function.
..."

imx6_pcie_wait_for_speed_change will report false failures for Gen1 ->
Gen1 speed transition, so avoid doing that check and just rely on
imx6_pcie_wait_for_link only.

[1] https://community.nxp.com/message/867943

Cc: yurovsky@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dong Aisheng <dongas86@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/dwc/pci-imx6.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index 64de9bb..c731e41 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -545,10 +545,21 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	tmp |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 
-	ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
-	if (ret) {
-		dev_err(dev, "Failed to bring link up!\n");
-		goto err_reset_phy;
+	if (imx6_pcie->variant != IMX7D) {
+		/*
+		 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
+		 * from i.MX6 family when no link speed transition
+		 * occurs and we go Gen1 -> yep, Gen1. The difference
+		 * is that, in such case, it will not be cleared by HW
+		 * which will cause the following code to report false
+		 * failure.
+		 */
+
+		ret = imx6_pcie_wait_for_speed_change(imx6_pcie);
+		if (ret) {
+			dev_err(dev, "Failed to bring link up!\n");
+			goto err_reset_phy;
+		}
 	}
 
 	/* Make sure link training is finished as well! */
-- 
2.9.3
