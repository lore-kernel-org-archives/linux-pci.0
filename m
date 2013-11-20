Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:36536 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3KTBwd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 20:52:33 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 3/6] PCI: Destroy pci dev only once
Date: Tue, 19 Nov 2013 17:51:54 -0800
Message-Id: <1384912317-3721-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1384912317-3721-1-git-send-email-yinghai@kernel.org>
References: <1384912317-3721-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Mutliple removing via /sys will call pci_destroy_dev two times.

Add is_removed to record if pci_destroy_dev is called already.

During second calling, still have extra dev ref hold via
device_schedule_call, so we are safe to check dev->is_removed.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/remove.c | 5 ++++-
 include/linux/pci.h  | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 0d2c36f..cffe269 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -20,7 +20,10 @@ static void pci_stop_dev(struct pci_dev *dev)
 
 static void pci_destroy_dev(struct pci_dev *dev)
 {
-	put_device(&dev->dev);
+	if (!dev->is_removed) {
+		dev->is_removed = 1;
+		put_device(&dev->dev);
+	}
 }
 
 void pci_remove_bus(struct pci_bus *bus)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1084a15..ccb316d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -321,6 +321,7 @@ struct pci_dev {
 	unsigned int	multifunction:1;/* Part of multi-function device */
 	/* keep track of device state */
 	unsigned int	is_added:1;
+	unsigned int	is_removed:1;	/* pci_destroy_dev is called */
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	block_cfg_access:1;	/* config space access is blocked */
-- 
1.8.1.4

