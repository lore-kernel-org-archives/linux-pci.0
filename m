Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35234 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbJCVMD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2015 17:12:03 -0400
Received: by qgt47 with SMTP id 47so121575286qgt.2
        for <linux-pci@vger.kernel.org>; Sat, 03 Oct 2015 14:12:01 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: pratyush.anand@gmail.com, l.stach@pengutronix.de,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] PCI: imx6: Use define instead of hard coded value
Date: Sat,  3 Oct 2015 18:11:31 -0300
Message-Id: <1443906691-14642-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1443906691-14642-1-git-send-email-festevam@gmail.com>
References: <1443906691-14642-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Use LTSSM_STATE_RCVRY_LOCK define instead of hard coded value in order
to improve the code readability;

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 6f43086..4e7b577 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -508,7 +508,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 	if (rx_valid & PCIE_PHY_RX_ASIC_OUT_VALID)
 		return 0;
 
-	if ((debug_r0 & PCIE_PHY_DEBUG_R0_LTSSM_MASK) != 0x0d)
+	if ((debug_r0 & PCIE_PHY_DEBUG_R0_LTSSM_MASK) != LTSSM_STATE_RCVRY_LOCK)
 		return 0;
 
 	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");
-- 
1.9.1

