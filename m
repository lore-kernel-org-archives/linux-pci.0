Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:39505 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbaAORun (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2014 12:50:43 -0500
Received: by mail-ie0-f169.google.com with SMTP id tq11so554183ieb.14
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2014 09:50:43 -0800 (PST)
Received: from localhost ([172.29.122.199])
        by mx.google.com with ESMTPSA id ft2sm7598578igb.5.2014.01.15.09.50.42
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jan 2014 09:50:42 -0800 (PST)
Subject: [PATCH] PCI: Fix pci_check_and_unmask_intx() comment typos
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Jan 2014 10:50:41 -0700
Message-ID: <20140115175041.31331.85063.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix typos in pci_check_and_unmask_intx() function comment.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 33120d156668..4f89a99e2de3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3138,7 +3138,7 @@ bool pci_check_and_mask_intx(struct pci_dev *dev)
 EXPORT_SYMBOL_GPL(pci_check_and_mask_intx);
 
 /**
- * pci_check_and_mask_intx - unmask INTx of no interrupt is pending
+ * pci_check_and_unmask_intx - unmask INTx if no interrupt is pending
  * @dev: the PCI device to operate on
  *
  * Check if the device dev has its INTx line asserted, unmask it if not

