Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35944 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbbJIBsx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 21:48:53 -0400
Received: by qkht68 with SMTP id t68so27074380qkh.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2015 18:48:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: pratyush.anand@gmail.com, m-karicheri2@ti.com,
	l.stach@pengutronix.de, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2 2/2] PCI: imx6: Use define instead of hard coded value
Date: Thu,  8 Oct 2015 22:48:26 -0300
Message-Id: <1444355306-21486-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1444355306-21486-1-git-send-email-festevam@gmail.com>
References: <1444355306-21486-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Use LTSSM_STATE_RCVRY_LOCK define instead of hard coded value in order
to improve the code readability;

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 drivers/pci/host/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 6f43086..4e7b577 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivePCIE_PHY_DEBUG_R0_LTSSM_MASKrs/pci/host/pci-imx6.c
@@ -508,7 +508,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 	if (rx_valid & PCIE_PHY_RX_ASIC_OUT_VALID)
 		return 0;
 
-	if ((debug_r0 & PCIE_PHY_DEBUG_R0_LTSSM_MASK) != 0x0d)
+	if ((debug_r0 & PCIE_PHY_DEBUG_R0_LTSSM_MASK) != LTSSM_STATE_RCVRY_LOCK)
 		return 0;
 
 	dev_err(pp->dev, "transition to gen2 is stuck, reset PHY!\n");
-- 
1.9.1

