Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:50814 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757454AbaFSL62 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jun 2014 07:58:28 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Thu, 19 Jun 2014 21:58:26 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 04E282BB0040
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 21:58:23 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5JBw6D67471608
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 21:58:07 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5JBwMpW001438
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2014 21:58:22 +1000
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: Guo Chao <yan@linux.vnet.ibm.com>
Subject: [PATCH v2] PCI: don't UNSET valid resources when reassign fails
Date: Thu, 19 Jun 2014 19:58:16 +0800
Message-Id: <1403179096-12113-1-git-send-email-yan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit bd064f0a sets IORESOURCE_UNSET flag if resources can not be
assgined. Part of these changes breaks resource assignment.

If resource is too big, PCI core assgins basic part first and
extends (reassigns) it to include optional part (notably SR-IOV resources).
In this case, IORESOURCE_UNSET should not be set if resource is properly
assigned before reassigning. Otherwise, these resources are never updated
to hardware and we will see errors like this:

	pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
	pci 0003:00:00.0: Error enabling bridge (-22), continuing

Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
---
Changed from v1: don't clear IORESOURCE_UNSET unconditionally
---
 drivers/pci/setup-res.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index caed1ce..2022f49 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -321,9 +321,14 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 {
 	struct resource *res = dev->resource + resno;
 	resource_size_t new_size;
-	int ret;
+	int ret, valid;
+
+	if (!(res->flags & IORESOURCE_UNSET)) {
+		valid = 1;
+		res->flags |= IORESOURCE_UNSET;
+	} else
+		valid = 0;
 
-	res->flags |= IORESOURCE_UNSET;
 	if (!res->parent) {
 		dev_info(&dev->dev, "BAR %d: can't reassign an unassigned resource %pR\n",
 			 resno, res);
@@ -339,7 +344,9 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 		dev_info(&dev->dev, "BAR %d: reassigned %pR\n", resno, res);
 		if (resno < PCI_BRIDGE_RESOURCES)
 			pci_update_resource(dev, resno);
-	}
+	} else if (valid)
+		res->flags &= ~IORESOURCE_UNSET;
+
 	return ret;
 }
 
-- 
1.8.3.1

