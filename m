Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbdBBO0w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Feb 2017 09:26:52 -0500
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, mstowe@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/MSI: Fix msi_desc->affinity memory leak when freeing MSI IRQs.
Date: Thu,  2 Feb 2017 09:26:44 -0500
Message-Id: <1486045604-17735-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During device setup, msix_setup_entries() and msi_setup_entry() allocate
msi_desc by calling alloc_msi_entry().  alloc_msi_entry() can also allocate a
affinity cpumask.  During device teardown free_msi_irqs() is called and the
msi_desc is freed, but the affinity cpumask is leaked.

Fix it by calling free_msi_entry() which frees both the msi_desc and the
affinity cpumask.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: mstowe@redhat.com
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 50c5003295ca..3d709311052d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -379,7 +379,7 @@ static void free_msi_irqs(struct pci_dev *dev)
 		}
 
 		list_del(&entry->list);
-		kfree(entry);
+		free_msi_entry(entry);
 	}
 
 	if (dev->msi_irq_groups) {
-- 
1.7.9.3
