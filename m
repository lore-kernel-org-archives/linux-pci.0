Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:38457 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbbD0GjW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2015 02:39:22 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 27 Apr 2015 16:39:21 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7FD572CE8056
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:39:18 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3R6dA8144171284
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:39:18 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3R6ciSe009505
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:38:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 11/21] powerpc/powernv: Fundamental reset for PCI bus reset
Date: Mon, 27 Apr 2015 16:37:43 +1000
Message-Id: <1430116673-22500-12-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function pnv_pci_reset_secondary_bus() is used to reset specified
PCI bus, which is leaded by root complex or PCI bridge. That means
the function shouldn't be called on PCI root bus and the patch
removes the logic for that case.

Also, some adapters beneath the indicated PCI bus may require
fundamental reset in order to successfully reload their firmwares
after the reset. The patch translates hot reset to fundamental reset
for that case.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 35 +++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 3c01095..58e4dcf 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -888,18 +888,35 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
 }
 
-void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
 {
-	struct pci_controller *hose;
+	int *freset = data;
 
-	if (pci_is_root_bus(dev->bus)) {
-		hose = pci_bus_to_host(dev->bus);
-		pnv_eeh_phb_reset(hose, EEH_RESET_HOT);
-		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
-	} else {
-		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
-		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
+	/*
+	 * Stop the iteration immediately if there is any
+	 * one PCI device requesting fundamental reset
+	 */
+	*freset |= pdev->needs_freset;
+	return *freset;
+}
+
+void pnv_pci_reset_secondary_bus(struct pci_dev *pdev)
+{
+	int option = EEH_RESET_HOT;
+	int freset = 0;
+
+	/* Check if there're any PCI devices asking for fundamental reset */
+	if (pdev->subordinate) {
+		pci_walk_bus(pdev->subordinate,
+			     pnv_pci_dev_reset_type,
+			     &freset);
+		if (freset)
+			option = EEH_RESET_FUNDAMENTAL;
 	}
+
+	/* Issue the requested type of reset */
+	pnv_eeh_bridge_reset(pdev, option);
+	pnv_eeh_bridge_reset(pdev, EEH_RESET_DEACTIVATE);
 }
 
 /**
-- 
2.1.0

