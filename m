Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:38424 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761064AbdAKDUu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2017 22:20:50 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: xgene: clean up the unnecessary memory free
Date: Wed, 11 Jan 2017 11:19:15 +0800
Message-Id: <1484104755-242853-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No need to free port as it is allocated by devm method.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pci-xgene.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 7c3b54b..790b6cb 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -246,14 +246,11 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
 	ret = xgene_get_csr_resource(adev, &csr);
 	if (ret) {
 		dev_err(dev, "can't get CSR resource\n");
-		kfree(port);
 		return ret;
 	}
 	port->csr_base = devm_ioremap_resource(dev, &csr);
-	if (IS_ERR(port->csr_base)) {
-		kfree(port);
+	if (IS_ERR(port->csr_base))
 		return -ENOMEM;
-	}
 
 	port->cfg_base = cfg->win;
 	port->version = ipversion;
-- 
1.9.1


