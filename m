Return-Path: <SRS0=2JBi=5G=bombadil.srs.infradead.org=BATV+3f8466ecba02b60e8dcb+5030+infradead.org+hch@kernel.org>
Return-Path: <SRS0=2JBi=5G=bombadil.srs.infradead.org=BATV+3f8466ecba02b60e8dcb+5030+infradead.org+hch@kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: helgaas@kernel.org
Cc: rakesh@tuxera.com,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] PCI: ensure the PCI device is locked over ->reset_notify calls
Date: Thu,  1 Jun 2017 13:10:37 +0200
Message-Id: <20170601111039.8913-2-hch@lst.de>
In-Reply-To: <20170601111039.8913-1-hch@lst.de>
References: <20170601111039.8913-1-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

Without this ->notify_reset instance may race with ->remove calls,
which can be easily triggered in NVMe.

Reported-by: Rakesh Pandit <rakesh@tuxera.com>
Tested-by: Rakesh Pandit <rakesh@tuxera.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/pci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 563901cd9c06..92f7e5ae2e5e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4276,11 +4276,13 @@ int pci_reset_function(struct pci_dev *dev)
 	if (rc)
 		return rc;
 
+	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
-	rc = pci_dev_reset(dev, 0);
+	rc = __pci_dev_reset(dev, 0);
 
 	pci_dev_restore(dev);
+	pci_dev_unlock(dev);
 
 	return rc;
 }
@@ -4300,16 +4302,14 @@ int pci_try_reset_function(struct pci_dev *dev)
 	if (rc)
 		return rc;
 
-	pci_dev_save_and_disable(dev);
+	if (pci_dev_trylock(dev))
+		return -EAGAIN;
 
-	if (pci_dev_trylock(dev)) {
-		rc = __pci_dev_reset(dev, 0);
-		pci_dev_unlock(dev);
-	} else
-		rc = -EAGAIN;
+	pci_dev_save_and_disable(dev);
+	rc = __pci_dev_reset(dev, 0);
+	pci_dev_unlock(dev);
 
 	pci_dev_restore(dev);
-
 	return rc;
 }
 EXPORT_SYMBOL_GPL(pci_try_reset_function);
@@ -4459,7 +4459,9 @@ static void pci_bus_save_and_disable(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_dev_lock(dev);
 		pci_dev_save_and_disable(dev);
+		pci_dev_unlock(dev);
 		if (dev->subordinate)
 			pci_bus_save_and_disable(dev->subordinate);
 	}
@@ -4474,7 +4476,9 @@ static void pci_bus_restore(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_dev_lock(dev);
 		pci_dev_restore(dev);
+		pci_dev_unlock(dev);
 		if (dev->subordinate)
 			pci_bus_restore(dev->subordinate);
 	}
-- 
2.11.0
