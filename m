Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:35796 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932562AbaD2AgM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Apr 2014 20:36:12 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so6468213pbc.15
        for <linux-pci@vger.kernel.org>; Mon, 28 Apr 2014 17:36:11 -0700 (PDT)
Received: from localhost ([172.26.49.243])
        by mx.google.com with ESMTPSA id pr4sm37673718pbb.53.2014.04.28.17.36.10
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 17:36:11 -0700 (PDT)
Subject: [PATCH] PCI: Remove dead code
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 28 Apr 2014 18:36:09 -0600
Message-ID: <20140429003609.31283.49544.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"pdev" can never be NULL here, so remove the test.

Found by Coverity (CID 744313).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 650ce8935fd7..ff236ed4f5cf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1345,8 +1345,6 @@ static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 		return -ENODEV;
 
 	pdev = to_pci_dev(dev);
-	if (!pdev)
-		return -ENODEV;
 
 	if (add_uevent_var(env, "PCI_CLASS=%04X", pdev->class))
 		return -ENOMEM;
@@ -1367,6 +1365,7 @@ static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 			   (u8)(pdev->class >> 16), (u8)(pdev->class >> 8),
 			   (u8)(pdev->class)))
 		return -ENOMEM;
+
 	return 0;
 }
 

