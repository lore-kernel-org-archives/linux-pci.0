Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39868 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323Ab3AJBLl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 20:11:41 -0500
Message-ID: <50EE1594.4070905@infradead.org>
Date: Wed, 09 Jan 2013 17:12:52 -0800
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] pci: fix iov.c kernel-doc warnings
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning in iov.c:

Warning(drivers/pci/iov.c:752): No description found for parameter 'numvfs'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/pci/iov.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-38-rc2.orig/drivers/pci/iov.c
+++ lnx-38-rc2/drivers/pci/iov.c
@@ -739,7 +739,7 @@ EXPORT_SYMBOL_GPL(pci_num_vf);
 /**
  * pci_sriov_set_totalvfs -- reduce the TotalVFs available
  * @dev: the PCI PF device
- * numvfs: number that should be used for TotalVFs supported
+ * @numvfs: number that should be used for TotalVFs supported
  *
  * Should be called from PF driver's probe routine with
  * device's mutex held.
