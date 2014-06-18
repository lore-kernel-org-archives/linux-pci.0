Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:50418 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbaFRPRX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jun 2014 11:17:23 -0400
Received: by mail-yk0-f170.google.com with SMTP id q9so688977ykb.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2014 08:17:23 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: jg1.han@samsung.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] PCI: designware: Use IS_ENABLED()
Date: Wed, 18 Jun 2014 12:16:53 -0300
Message-Id: <1403104613-9867-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

We can get rid of the 'ifdef' by using the IS_ENABLED() macro.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pcie-designware.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1eaf4df3..dc842fd 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -497,9 +497,8 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 
 	pci_common_init_dev(pp->dev, &dw_pci);
 	pci_assign_unassigned_resources();
-#ifdef CONFIG_PCI_DOMAINS
-	dw_pci.domain++;
-#endif
+	if (IS_ENABLED(CONFIG_PCI_DOMAINS))
+		dw_pci.domain++;
 
 	return 0;
 }
-- 
1.8.3.2

