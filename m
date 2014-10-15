Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:55891 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaJOXmJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Oct 2014 19:42:09 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 16 Oct 2014 09:42:06 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4A15D2CE8040
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2014 10:42:04 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id s9FNHL5355050414
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2014 10:17:29 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s9FNfVPg007376
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2014 10:41:31 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, weiyang@linux.vnet.ibm.com,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] PCI: Make reset warning messages different
Date: Thu, 16 Oct 2014 10:41:10 +1100
Message-Id: <1413416470-14828-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We have same warning message for FLR and AF FLR and users can't
know which type of resets the PCI device is taking when there are
pending transactions. The patch makes them different for FLR and
AF FLR cases.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 625a4ac..2d708cd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3144,7 +3144,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
 		return 0;
 
 	if (!pci_wait_for_pending_transaction(dev))
-		dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
+		dev_err(&dev->dev, "Force FLR with pending transaction\n");
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
 
@@ -3178,7 +3178,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 				 PCI_AF_STATUS_TP << 8))
 		goto clear;
 
-	dev_err(&dev->dev, "transaction is not cleared; proceeding with reset anyway\n");
+	dev_err(&dev->dev, "Force AF FLR with pending transaction\n");
 
 clear:
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
-- 
1.8.3.2

