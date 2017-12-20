Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33752 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753740AbdLTAik (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 19:38:40 -0500
Received: by mail-qk0-f194.google.com with SMTP id x7so7403399qkb.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2017 16:38:39 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: dhdang@apm.com, linux-pci@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] PCI: xgene: Fix the error return code
Date: Tue, 19 Dec 2017 22:38:29 -0200
Message-Id: <1513730309-18831-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the case of IS_ERR() error, we should return PTR_ERR().

Fix the error return code.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/pci/host/pci-xgene-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index 1f42a20..4a1fb01 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -465,7 +465,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	xgene_msi->msi_regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(xgene_msi->msi_regs)) {
 		dev_err(&pdev->dev, "no reg space\n");
-		rc = -EINVAL;
+		rc = PTR_ERR(xgene_msi->msi_regs);
 		goto error;
 	}
 	xgene_msi->msi_addr = res->start;
-- 
2.7.4
