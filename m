Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:39621 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbbDJIy2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 04:54:28 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 10 Apr 2015 18:54:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 328362CE8052
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 18:54:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3A8sDi925690218
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 18:54:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3A8rmgQ030435
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 18:53:48 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH] pci/iov: return a reference to PF on destroying VF
Date: Fri, 10 Apr 2015 16:53:04 +0800
Message-Id: <1428655984-26903-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Each VF will get a reference to its PF, while it is not returned back in
all cases and leave a removed PF's pci_dev un-released.

As commit ac205b7b ("PCI: make sriov work with hotplug remove") indicates,
when removing devices on a bus, we do it in the reverse order. This means
we would remove VFs first, then PFs. After doing so, VF's removal is done
with pci_stop_and_remove_bus_device() instead of virtfn_remove().
virtfn_remove() returns the reference of its PF, while
pci_stop_and_remove_bus_device() doesn't.

This patches moves the return of PF's reference to pci_destroy_dev() to
make sure the PF's pci_dev is released in any case.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c    |    1 -
 drivers/pci/remove.c |    5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4b3a4ea..9b04bde 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -167,7 +167,6 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 
 	/* balance pci_get_domain_bus_and_slot() */
 	pci_dev_put(virtfn);
-	pci_dev_put(dev);
 }
 
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8bd76c9..836ddf6 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -41,6 +41,11 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
+#ifdef CONFIG_PCI_IOV
+	if (dev->is_virtfn)
+		pci_dev_put(dev->physfn);
+#endif
+
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }
-- 
1.7.9.5

