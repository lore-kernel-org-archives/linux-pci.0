Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0134.outbound.protection.outlook.com ([65.55.169.134]:46780
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753235AbbHMRwe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Aug 2015 13:52:34 -0400
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Subject: [PATCH 3/4] PCI: spear: Use BUG_ON()
Date: Thu, 13 Aug 2015 14:37:15 -0300
Message-ID: <1439487436-26989-3-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
References: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use BUG_ON() instead of an if condition followed by BUG().

The semantic patch that makes this change is available
in scripts/coccinelle/misc/bugon.cocci.

Cc: Pratyush Anand <pratyush.anand@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pcie-spear13xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index c49fbdc..98d2683 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -223,8 +223,7 @@ static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
 	status = readl(&app_reg->int_sts);
 
 	if (status & MSI_CTRL_INT) {
-		if (!IS_ENABLED(CONFIG_PCI_MSI))
-			BUG();
+		BUG_ON(!IS_ENABLED(CONFIG_PCI_MSI));
 		dw_handle_msi_irq(pp);
 	}
 
-- 
1.9.1

