Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0142.outbound.protection.outlook.com ([65.55.169.142]:32173
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752210AbbHMRiL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Aug 2015 13:38:11 -0400
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 4/4] PCI: ats: Use BUG_ON()
Date: Thu, 13 Aug 2015 14:37:16 -0300
Message-ID: <1439487436-26989-4-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
References: <1439487436-26989-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use BUG_ON() instead of an if condition followed by BUG().

The semantic patch that makes this change is available
in scripts/coccinelle/misc/bugon.cocci.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/ats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index a8099d4..1c25b20 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -134,8 +134,7 @@ void pci_restore_ats_state(struct pci_dev *dev)
 
 	if (!pci_ats_enabled(dev))
 		return;
-	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS))
-		BUG();
+	BUG_ON(!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS));
 
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (!dev->is_virtfn)
-- 
1.9.1

