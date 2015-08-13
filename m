Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0108.outbound.protection.outlook.com ([157.56.110.108]:52256
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753139AbbHMRxH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Aug 2015 13:53:07 -0400
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/4] PCI: dra7xx: Remove unneeded use of IS_ERR_VALUE()
Date: Thu, 13 Aug 2015 14:37:14 -0300
Message-ID: <1439487436-26989-2-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
References: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no need to use the IS_ERR_VALUE() macro for checking
the return value from pm_runtime_* functions.

Just do a simple negative test instead.

The semantic patch that makes this change is available
in scripts/coccinelle/api/pm_runtime.cocci.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pci-dra7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 80db09e..8d72bb9 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -382,7 +382,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
-	if (IS_ERR_VALUE(ret)) {
+	if (ret < 0) {
 		dev_err(dev, "pm_runtime_get_sync failed\n");
 		goto err_phy;
 	}
-- 
1.9.1

