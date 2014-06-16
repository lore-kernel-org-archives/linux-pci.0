Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:45747 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaFPL3u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jun 2014 07:29:50 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Mon, 16 Jun 2014 21:29:48 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 23E642CE8050
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2014 21:29:46 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5GBTUKs6816000
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2014 21:29:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5GBTjpg024091
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2014 21:29:45 +1000
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: Guo Chao <yan@linux.vnet.ibm.com>
Subject: [PATCH] PCI: don't UNSET resource even reassign fails
Date: Mon, 16 Jun 2014 19:29:42 +0800
Message-Id: <1402918182-13082-1-git-send-email-yan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit bd064f0a sets IORESOURCE_UNSET flag if resource can not be
assgined. Part of these changes breaks resource assignment.

If resource is too big, PCI core assgins basic part first and
extends (reassigns) it to include optional part (notably SR-IOV resources).
In this case, failure is permitted and IORESOURCE_UNSET should be not set.
Otherwise, these resources are never updated to hardware even they are
already propery assigned and we will see errors like this:

	pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
	pci 0003:00:00.0: Error enabling bridge (-22), continuing

Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
---
 drivers/pci/setup-res.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index caed1ce..1e1076a 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -334,12 +334,14 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
 	new_size = resource_size(res) + addsize;
 	ret = _pci_assign_resource(dev, resno, new_size, min_align);
 	if (!ret) {
-		res->flags &= ~IORESOURCE_UNSET;
 		res->flags &= ~IORESOURCE_STARTALIGN;
 		dev_info(&dev->dev, "BAR %d: reassigned %pR\n", resno, res);
 		if (resno < PCI_BRIDGE_RESOURCES)
 			pci_update_resource(dev, resno);
 	}
+
+	res->flags &= ~IORESOURCE_UNSET;
+
 	return ret;
 }
 
-- 
1.8.3.1

