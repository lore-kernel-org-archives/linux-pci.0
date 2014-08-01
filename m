Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from na3sys010aog106.obsmtp.com ([74.125.245.80]:55896 "HELO
	na3sys010aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756295AbaHAWxI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Aug 2014 18:53:08 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so6590493pac.32
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2014 15:53:06 -0700 (PDT)
From: Sandeep Mann <sandeep@purestorage.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: pciehp: Use ordered workqueue for HPC events
Date: Fri,  1 Aug 2014 15:47:12 -0700
Message-Id: <1406933232-1560-1-git-send-email-sandeep@purestorage.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Using an ordered workqueue serializes processing of hotplug event. Processing
an hotplug event for some devices can take a relatively "long" time, which
means if a device is added and removed in quick succession (or due to flacky
hardware), it can lead to multiple outstanding hotplug events. Processing
these events concurrently can lead to unknown internal state and/or kernel
panics.

Signed-off-by: Sandeep Mann <sandeep@purestorage.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 42914e0..c4eedab 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -681,7 +681,7 @@ static int pcie_init_slot(struct controller *ctrl)
 	if (!slot)
 		return -ENOMEM;
 
-	slot->wq = alloc_workqueue("pciehp-%u", 0, 0, PSN(ctrl));
+	slot->wq = alloc_ordered_workqueue("pciehp-%u", 0, PSN(ctrl));
 	if (!slot->wq)
 		goto abort;
 
-- 
1.8.3.2

