Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbeIEUi7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 16:38:59 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH for-rc v2 1/3] PCI: Fix faulty logic in pci_reset_bus()
Date: Wed,  5 Sep 2018 16:08:03 +0000
Message-Id: <20180905160805.5680-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dennis Dalessandro <dennis.dalessandro@intel.com>

The pci_rest_bus() function calls into pci_probe_reset_slot() to determine
whether to call the slot or bus reset. The check has faulty logic in that
it does not account for pci_probe_reset_slot() being able to return an
errno. Fix by only calling the slot reset when the function returns 0.
Treat < 1 and > 1 the same.

Cc: Sinan Kaya <okaya@codeaurora.org>
Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ff9619b5fa..30b260332a10 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5200,7 +5200,7 @@ static int __pci_reset_bus(struct pci_bus *bus)
  */
 int pci_reset_bus(struct pci_dev *pdev)
 {
-	return pci_probe_reset_slot(pdev->slot) ?
+	return (!pci_probe_reset_slot(pdev->slot)) ?
 	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
 }
 EXPORT_SYMBOL_GPL(pci_reset_bus);
-- 
2.18.0
