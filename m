Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: benve@cisco.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        mingo@redhat.com, peterz@infradead.org
Cc: Govindarajulu Varadarajan <gvaradar@cisco.com>
Subject: [PATCH 2/4] pci: code refactor pci_bus_lock/unlock/trylock
Date: Wed, 27 Sep 2017 14:42:18 -0700
Message-Id: <20170927214220.41216-3-gvaradar@cisco.com>
In-Reply-To: <20170927214220.41216-1-gvaradar@cisco.com>
References: <20170927214220.41216-1-gvaradar@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce __pci_bus_trylock and __pci_bus_unlock with lock and unlock cb
functions as arguments. User can pass on what they want to lock in pci_dev.

Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
---
 drivers/pci/pci.c   | 38 +++++++++++++++++++++++++++-----------
 include/linux/pci.h | 16 ++++++++++++++++
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6078dfc11b11..3c6a9210f27c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4377,29 +4377,38 @@ static void pci_bus_lock(struct pci_bus *bus)
 	}
 }
 
-/* Unlock devices from the bottom of the tree up */
-static void pci_bus_unlock(struct pci_bus *bus)
+void __pci_bus_unlock(struct pci_bus *bus,
+		      void (*unlock)(struct pci_dev *dev))
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+			__pci_bus_unlock(dev->subordinate, unlock);
+		unlock(dev);
 	}
 }
+EXPORT_SYMBOL_GPL(__pci_bus_unlock);
 
-/* Return 1 on successful lock, 0 on contention */
-static int pci_bus_trylock(struct pci_bus *bus)
+/* Unlock devices from the bottom of the tree up */
+static void pci_bus_unlock(struct pci_bus *bus)
+{
+	__pci_bus_unlock(bus, pci_dev_unlock);
+}
+
+int __pci_bus_trylock(struct pci_bus *bus,
+		      int (*lock)(struct pci_dev *dev),
+		      void (*unlock)(struct pci_dev *dev))
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!pci_dev_trylock(dev))
+		if (!lock(dev))
 			goto unlock;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!__pci_bus_trylock(dev->subordinate, lock,
+					       unlock)) {
+				unlock(dev);
 				goto unlock;
 			}
 		}
@@ -4409,11 +4418,18 @@ static int pci_bus_trylock(struct pci_bus *bus)
 unlock:
 	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+			__pci_bus_unlock(dev->subordinate, unlock);
+		unlock(dev);
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__pci_bus_trylock);
+
+/* Return 1 on successful lock, 0 on contention */
+static int pci_bus_trylock(struct pci_bus *bus)
+{
+	return __pci_bus_trylock(bus, pci_dev_trylock, pci_dev_unlock);
+}
 
 /* Do any devices on or below this slot prevent a bus reset? */
 static bool pci_slot_resetable(struct pci_slot *slot)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b4b1a8a164c0..33359c64cd2e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1515,6 +1515,22 @@ void pci_cfg_access_lock(struct pci_dev *dev);
 bool pci_cfg_access_trylock(struct pci_dev *dev);
 void pci_cfg_access_unlock(struct pci_dev *dev);
 
+void __pci_bus_unlock(struct pci_bus *bus,
+		      void (*unlock)(struct pci_dev *dev));
+int __pci_bus_trylock(struct pci_bus *bus,
+		      int (*lock)(struct pci_dev *dev),
+		      void (*unlock)(struct pci_dev *dev));
+static inline int pci_device_trylock(struct pci_dev *dev)
+{
+	return device_trylock(&dev->dev);
+}
+
+static inline void pci_device_unlock(struct pci_dev *dev)
+{
+	device_unlock(&dev->dev);
+}
+
+
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
  * a PCI domain is defined to be a set of PCI buses which share
-- 
2.14.1
