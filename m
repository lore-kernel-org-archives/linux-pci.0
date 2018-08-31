Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14083 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeIABen (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 21:34:43 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 02/16] PCI: Fix pci_reset_bus
Date: Fri, 31 Aug 2018 15:26:25 -0600
Message-Id: <20180831212639.10196-3-keith.busch@intel.com>
In-Reply-To: <20180831212639.10196-1-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The check for slot reset capable, pci_probe_reset_slot, returns 0 when
slot reset is possible, but pci_reset_bus was proceeding to reset the
slot when the probe returned an error. This patch reverses the check to
fix that logic.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ff9619b5fa..bc8419e0065a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5200,7 +5200,7 @@ static int __pci_reset_bus(struct pci_bus *bus)
  */
 int pci_reset_bus(struct pci_dev *pdev)
 {
-	return pci_probe_reset_slot(pdev->slot) ?
+	return !pci_probe_reset_slot(pdev->slot) ?
 	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
 }
 EXPORT_SYMBOL_GPL(pci_reset_bus);
-- 
2.14.4
