Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:43294 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbaESDGw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 May 2014 23:06:52 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 19 May 2014 13:06:49 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 96F6A2CE8050
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 13:06:47 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s4J36Wmv48234744
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 13:06:32 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s4J36kar017891
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 13:06:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] PCI: Wrong register used to check pending traffic
Date: Mon, 19 May 2014 13:06:46 +1000
Message-Id: <1400468806-14884-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The incorrect register offset is passed to pci_wait_for_pending(),
which is caused by commit 157e876ffe ("PCI: Add pci_wait_for_pending()
(refactor pci_wait_for_pending_transaction())").

Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7325d43..759475e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3067,7 +3067,8 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return 1;
 
-	return pci_wait_for_pending(dev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_TRPND);
+	return pci_wait_for_pending(dev, pci_pcie_cap(dev) + PCI_EXP_DEVSTA,
+				    PCI_EXP_DEVSTA_TRPND);
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
@@ -3109,7 +3110,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 		return 0;
 
 	/* Wait for Transaction Pending bit clean */
-	if (pci_wait_for_pending(dev, PCI_AF_STATUS, PCI_AF_STATUS_TP))
+	if (pci_wait_for_pending(dev, pos + PCI_AF_STATUS, PCI_AF_STATUS_TP))
 		goto clear;
 
 	dev_err(&dev->dev, "transaction is not cleared; "
-- 
1.8.3.2

