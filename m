Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33221 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbJLPtX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 11:49:23 -0400
Received: by qkas79 with SMTP id s79so59514236qka.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2015 08:49:23 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: pratyush.anand@gmail.com, m-karicheri2@ti.com,
	l.stach@pengutronix.de, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v3 2/3] PCI: imx6: Use define instead of hard coded value
Date: Mon, 12 Oct 2015 12:46:47 -0300
Message-Id: <1444664808-16445-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1444664808-16445-1-git-send-email-festevam@gmail.com>
References: <1444664808-16445-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Use LTSSM_STATE_RCVRY_LOCK define instead of hard coded value in order
to improve the code readability.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
Changes since v2:
- Use . instead of ; in the commit log

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

