Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33603 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbcL0OlN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2016 09:41:13 -0500
Received: by mail-qt0-f194.google.com with SMTP id 41so15682870qtn.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Dec 2016 06:40:45 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] PCI: imx6: Remove redundant message
Date: Tue, 27 Dec 2016 12:40:43 -0200
Message-Id: <1482849643-1861-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

When a PCI card is not connected, the following messages are seen on mx6:

imx6q-pcie 1ffc000.pcie: phy link never came up
imx6q-pcie 1ffc000.pcie: Link never came up

The first one comes from the pcie-designware.c core file, so remove
the redundant one from the imx6 driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/host/pci-imx6.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index c8cefb0..66c3b84 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -502,10 +502,8 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
 
 	ret = imx6_pcie_wait_for_link(imx6_pcie);
-	if (ret) {
-		dev_info(dev, "Link never came up\n");
+	if (ret)
 		goto err_reset_phy;
-	}
 
 	if (imx6_pcie->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
-- 
2.7.4

