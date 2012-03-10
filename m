Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 16/37] PCI: Move pci_stop_and_remove_behind_bridge() down
Date: Fri,  9 Mar 2012 23:00:16 -0800
Message-Id: <1331362837-10740-17-git-send-email-yinghai@kernel.org>
In-Reply-To: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Later it will use pci_stop_bus_devices instead of pci_stop_behind_bridge.

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

