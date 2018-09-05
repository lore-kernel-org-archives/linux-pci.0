Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:27539 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeIFBHG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:07:06 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCHv2 02/20] PCI: Fix faulty logic in pci_reset_bus()
Date: Wed,  5 Sep 2018 14:35:28 -0600
Message-Id: <20180905203546.21921-3-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
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
Reviewed-by: Keith Busch <keith.busch@intel.com>
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
2.14.4
