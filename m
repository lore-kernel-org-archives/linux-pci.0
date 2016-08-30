Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0070.outbound.protection.outlook.com ([104.47.37.70]:41108
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757740AbcH3KkC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Aug 2016 06:40:02 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <robh@kernel.org>, <bhelgaas@google.com>,
        <colin.king@canonical.com>, <soren.brinkmann@xilinx.com>,
        <marc.zyngier@arm.com>, <michal.simek@xilinx.com>, <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rgummal@xilinx.com>, Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: [PATCH 1/3] PCI: Xilinx NWL PCIe: Expanding PCIe core errors and printing event occurred.
Date: Tue, 30 Aug 2016 16:09:16 +0530
Message-ID: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current driver prints pcie core error, for all core events.
Instead of just printing PCIe core error, now adding prints to show
individual core events occurred.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 48 +++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 3479d30..86c1834 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -85,10 +85,15 @@
 #define MSGF_MISC_SR_MASTER_ERR		BIT(5)
 #define MSGF_MISC_SR_I_ADDR_ERR		BIT(6)
 #define MSGF_MISC_SR_E_ADDR_ERR		BIT(7)
-#define MSGF_MISC_SR_UR_DETECT          BIT(20)
-
-#define MSGF_MISC_SR_PCIE_CORE		GENMASK(18, 16)
-#define MSGF_MISC_SR_PCIE_CORE_ERR	GENMASK(31, 22)
+#define MSGF_MISC_SR_FATAL_AER		BIT(16)
+#define MSGF_MISC_SR_NON_FATAL_AER	BIT(17)
+#define MSGF_MISC_SR_CORR_AER		BIT(18)
+#define MSGF_MISC_SR_UR_DETECT		BIT(20)
+#define MSGF_MISC_SR_NON_FATAL_DEV	BIT(22)
+#define MSGF_MISC_SR_FATAL_DEV		BIT(23)
+#define MSGF_MISC_SR_LINK_DOWN		BIT(24)
+#define MSGF_MSIC_SR_LINK_AUTO_BWIDTH	BIT(25)
+#define MSGF_MSIC_SR_LINK_BWIDTH	BIT(26)
 
 #define MSGF_MISC_SR_MASKALL		(MSGF_MISC_SR_RXMSG_AVAIL | \
 					MSGF_MISC_SR_RXMSG_OVER | \
@@ -96,9 +101,15 @@
 					MSGF_MISC_SR_MASTER_ERR | \
 					MSGF_MISC_SR_I_ADDR_ERR | \
 					MSGF_MISC_SR_E_ADDR_ERR | \
+					MSGF_MISC_SR_FATAL_AER | \
+					MSGF_MISC_SR_NON_FATAL_AER | \
+					MSGF_MISC_SR_CORR_AER | \
 					MSGF_MISC_SR_UR_DETECT | \
-					MSGF_MISC_SR_PCIE_CORE | \
-					MSGF_MISC_SR_PCIE_CORE_ERR)
+					MSGF_MISC_SR_NON_FATAL_DEV | \
+					MSGF_MISC_SR_FATAL_DEV | \
+					MSGF_MISC_SR_LINK_DOWN | \
+					MSGF_MSIC_SR_LINK_AUTO_BWIDTH | \
+					MSGF_MSIC_SR_LINK_BWIDTH)
 
 /* Legacy interrupt status mask bits */
 #define MSGF_LEG_SR_INTA		BIT(0)
@@ -291,8 +302,29 @@ static irqreturn_t nwl_pcie_misc_handler(int irq, void *data)
 		dev_err(pcie->dev,
 			"In Misc Egress address translation error\n");
 
-	if (misc_stat & MSGF_MISC_SR_PCIE_CORE_ERR)
-		dev_err(pcie->dev, "PCIe Core error\n");
+	if (misc_stat & MSGF_MISC_SR_FATAL_AER)
+		dev_err(pcie->dev, "Fatal Error in AER Capability\n");
+
+	if (misc_stat & MSGF_MISC_SR_NON_FATAL_AER)
+		dev_err(pcie->dev, "Non-Fatal Error in AER Capability\n");
+
+	if (misc_stat & MSGF_MISC_SR_CORR_AER)
+		dev_err(pcie->dev, "Correctable Error in AER Capability\n");
+
+	if (misc_stat & MSGF_MISC_SR_UR_DETECT)
+		dev_err(pcie->dev, "Unsupported request Detected\n");
+
+	if (misc_stat & MSGF_MISC_SR_NON_FATAL_DEV)
+		dev_err(pcie->dev, "Non-Fatal Error Detected\n");
+
+	if (misc_stat & MSGF_MISC_SR_FATAL_DEV)
+		dev_err(pcie->dev, "Fatal Error Detected\n");
+
+	if (misc_stat & MSGF_MSIC_SR_LINK_AUTO_BWIDTH)
+		dev_info(pcie->dev, "Link Autonomous Bandwidth Management Status bit set\n");
+
+	if (misc_stat & MSGF_MSIC_SR_LINK_BWIDTH)
+		dev_info(pcie->dev, "Link Bandwidth Management Status bit set\n");
 
 	/* Clear misc interrupt status */
 	nwl_bridge_writel(pcie, misc_stat, MSGF_MISC_STATUS);
-- 
2.1.1

