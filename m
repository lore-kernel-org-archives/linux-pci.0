Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34391 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbFEWh6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2015 18:37:58 -0400
Received: by pdbki1 with SMTP id ki1so61650212pdb.1
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2015 15:37:58 -0700 (PDT)
From: Troy Kisky <troy.kisky@boundarydevices.com>
To: bhelgaas@google.com
Cc: festevam@gmail.com, marex@denx.de, linux-pci@vger.kernel.org,
	r65037@freescale.com, l.stach@pengutronix.de,
	tharvey@gateworks.com, Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 1/1] pci-imx6: add speed change timeout message
Date: Fri,  5 Jun 2015 15:37:44 -0700
Message-Id: <1433543864-7252-1-git-send-email-troy.kisky@boundarydevices.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, the timeout is never detected as count
has a value of -1 if a timeout happens, but the code is checking
for 0. Also, this patch removes the unneeded final wait
if a timeout occurs.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/pci/host/pci-imx6.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index fdb9536..51be92c 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -398,20 +398,22 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
 	writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
 
 	count = 200;
-	while (count--) {
+	while (1) {
 		tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
 		/* Test if the speed change finished. */
-		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
+		if (!(tmp & PORT_LOGIC_SPEED_CHANGE)) {
+			/* Make sure link training is finished as well! */
+			ret = imx6_pcie_wait_for_link(pp);
+			break;
+		}
+		if (count-- == 0) {
+			dev_err(pp->dev, "Speed change timeout\n");
+			ret = -EINVAL;
 			break;
+		}
 		usleep_range(100, 1000);
 	}
 
-	/* Make sure link training is finished as well! */
-	if (count)
-		ret = imx6_pcie_wait_for_link(pp);
-	else
-		ret = -EINVAL;
-
 	if (ret) {
 		dev_err(pp->dev, "Failed to bring link up!\n");
 	} else {
-- 
1.9.1

