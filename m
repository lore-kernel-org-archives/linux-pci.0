Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39828 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965487AbeEIQ5m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 12:57:42 -0400
Received: by mail-qt0-f194.google.com with SMTP id f1-v6so46540135qtj.6
        for <linux-pci@vger.kernel.org>; Wed, 09 May 2018 09:57:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: lorenzo.pieralisi@arm.com
Cc: bhelgaas@google.com, m-karicheri2@ti.com,
        linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] PCI: keystone: Do not treat link up message as error
Date: Wed,  9 May 2018 13:57:36 -0300
Message-Id: <1525885056-7528-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

The "Link already up" message does not indicate any error, so
change it to dev_info() level instead.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/pci/dwc/pci-keystone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index d55ae07..3722a5f 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -89,7 +89,7 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 	dw_pcie_setup_rc(pp);
 
 	if (dw_pcie_link_up(pci)) {
-		dev_err(dev, "Link already up\n");
+		dev_info(dev, "Link already up\n");
 		return 0;
 	}
 
-- 
2.7.4
