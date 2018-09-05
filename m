Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:27539 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbeIFBHG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 21:07:06 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 03/20] PCI: Add required waits on link active
Date: Wed,  5 Sep 2018 14:35:29 -0600
Message-Id: <20180905203546.21921-4-keith.busch@intel.com>
In-Reply-To: <20180905203546.21921-1-keith.busch@intel.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The spec has hard timing requirements when waiting for a link to become
active. This patch implements those hard delays when waiting for an
active link so each caller doesn't have to respect those timings.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 30b260332a10..8eb1d869fc98 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4485,21 +4485,33 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
 	bool ret;
 	u16 lnk_status;
 
+	/*
+	 * PCIe 4.0r1 6.6.1, a component must enter LTSSM Detect within 20ms,
+	 * after which we should expect an link active if the reset was
+	 * successful. If so, software must wait a minimum 100ms before sending
+	 * configuration requests to devices downstream this port.
+	 *
+	 * If the link fails to activate, either the device was physically
+	 * removed or the link is permanently failed.
+	 */
+	if (active)
+		msleep(20);
 	for (;;) {
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
 		if (ret == active)
-			return true;
+			break;
 		if (timeout <= 0)
 			break;
 		msleep(10);
 		timeout -= 10;
 	}
-
-	pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
-		 active ? "set" : "cleared");
-
-	return false;
+	if (active && ret)
+		msleep(100);
+	else if (ret != active)
+		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
+			active ? "set" : "cleared");
+	return ret == active;
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
-- 
2.14.4
