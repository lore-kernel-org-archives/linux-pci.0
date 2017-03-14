Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v6 3/4] PCI: imx6: Do not switch speed if Gen2 is disabled
Date: Tue, 14 Mar 2017 08:18:26 -0700
Message-Id: <20170314151827.31248-4-andrew.smirnov@gmail.com>
In-Reply-To: <20170314151827.31248-1-andrew.smirnov@gmail.com>
References: <20170314151827.31248-1-andrew.smirnov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 yurovsky@gmail.com, linux-arm-kernel@lists.infradead.org,
 Lucas Stach <l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Save a bit of time and avoid going through link speed change procedure
in configuration where link max speed is limited to Gen1 in DT.

Cc: yurovsky@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
