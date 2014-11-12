Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:59464 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933155AbaKLCmB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 21:42:01 -0500
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 12 Nov 2014 08:11:57 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 73A533940045
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:11:54 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAC2fdVx55640222
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:11:40 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAC2frZR020532
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 08:11:53 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2] PCI: Make reset warning messages different
Date: Wed, 12 Nov 2014 13:41:51 +1100
Message-Id: <1415760111-12344-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We have same warning message for FLR and AF FLR and users can't
know which type of resets the PCI device is taking when there are
pending transactions. The patch makes them different for FLR and
AF FLR cases.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v2: Adjusted messages according to Bjorn's suggestion
---
 drivers/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 625a4ac..3f12383 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3144,7 +3144,8 @@ static int pcie_flr(struct pci_dev *dev, int probe)
 		return 0;
 
 	if (!pci_wait_for_pending_transaction(dev))
-		dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
+		dev_err(&dev->dev, "timed out waiting for pending transaction; "
+				   "performing function level reset\n");
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
 
@@ -3178,7 +3179,8 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 				 PCI_AF_STATUS_TP << 8))
 		goto clear;
 
-	dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
+	dev_err(&dev->dev, "timed out waiting for pending transaction; "
+			   "performing AF function level reset\n");
 
 clear:
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
-- 
1.8.3.2

