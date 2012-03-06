Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:31895 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758467Ab2CFHQP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2012 02:16:15 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 13/23] PCI: move pci_stop_and_remove_behind_bridge down
Date: Mon,  5 Mar 2012 23:13:50 -0800
Message-Id: <1331018040-30725-14-git-send-email-yinghai@kernel.org>
In-Reply-To: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

later it will use pci_stop_bus_devices instead of pci_stop_behind_bridge.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/remove.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 04a4861..243d59b 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -129,21 +129,6 @@ static void pci_stop_behind_bridge(struct pci_dev *dev)
 			pci_stop_bus_device(pci_dev_b(l));
 }
 
-/**
- * pci_stop_and_remove_behind_bridge - stop and remove all devices behind
- *					 a PCI bridge
- * @dev: PCI bridge device
- *
- * Remove all devices on the bus, except for the parent bridge.
- * This also removes any child buses, and any devices they may
- * contain in a depth-first manner.
- */
-void pci_stop_and_remove_behind_bridge(struct pci_dev *dev)
-{
-	pci_stop_behind_bridge(dev);
-	__pci_remove_behind_bridge(dev);
-}
-
 static void pci_stop_bus_devices(struct pci_bus *bus)
 {
 	struct list_head *l, *n;
@@ -163,6 +148,21 @@ static void pci_stop_bus_devices(struct pci_bus *bus)
 }
 
 /**
+ * pci_stop_and_remove_behind_bridge - stop and remove all devices behind
+ *					 a PCI bridge
+ * @dev: PCI bridge device
+ *
+ * Remove all devices on the bus, except for the parent bridge.
+ * This also removes any child buses, and any devices they may
+ * contain in a depth-first manner.
+ */
+void pci_stop_and_remove_behind_bridge(struct pci_dev *dev)
+{
+	pci_stop_behind_bridge(dev);
+	__pci_remove_behind_bridge(dev);
+}
+
+/**
  * pci_stop_bus_device - stop a PCI device and any children
  * @dev: the device to stop
  *
-- 
1.7.7

