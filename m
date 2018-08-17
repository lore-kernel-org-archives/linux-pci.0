Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 5/6] pci: Protect the enable/disable state of pci_dev using the state mutex
Date: Fri, 17 Aug 2018 14:49:01 +1000
Message-Id: <20180817044902.31420-6-benh@kernel.crashing.org>
In-Reply-To: <20180817044902.31420-1-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

This protects enable/disable operations using the state mutex to
avoid races with, for example, concurrent enables on a bridge.

The bus hierarchy is walked first before taking the lock to
avoid lock nesting (though it would be ok if we ensured that
we always nest them bottom-up, it is better to just avoid the
issue alltogether, especially as we might find cases where
we want to take it top-down later).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/pci.c | 51 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 62591c153999..68152de2b5a0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1540,26 +1540,33 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
  */
 int pci_reenable_device(struct pci_dev *dev)
 {
+	int rc = 0;
+
+	pci_dev_state_lock(dev);
 	if (pci_is_enabled(dev))
-		return do_pci_enable_device(dev, (1 << PCI_NUM_RESOURCES) - 1);
-	return 0;
+		rc = do_pci_enable_device(dev, (1 << PCI_NUM_RESOURCES) - 1);
+	pci_dev_state_unlock(dev);
+	return rc;
 }
 EXPORT_SYMBOL(pci_reenable_device);
 
 static void pci_enable_bridge(struct pci_dev *dev)
 {
 	struct pci_dev *bridge;
-	int retval;
+	int retval, enabled;
 
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
 		pci_enable_bridge(bridge);
 
-	if (pci_is_enabled(dev)) {
-		if (!dev->is_busmaster)
-			pci_set_master(dev);
+	/* Already enabled ? */
+	pci_dev_state_lock(dev);
+	enabled = pci_is_enabled(dev);
+	if (enabled && !dev->is_busmaster)
+		pci_set_master(dev);
+	pci_dev_state_unlock(dev);
+	if (enabled)
 		return;
-	}
 
 	retval = pci_enable_device(dev);
 	if (retval)
@@ -1571,9 +1578,16 @@ static void pci_enable_bridge(struct pci_dev *dev)
 static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 {
 	struct pci_dev *bridge;
-	int err;
+	int err = 0;
 	int i, bars = 0;
 
+	/* Handle upstream bridges first to avoid locking issues */
+	bridge = pci_upstream_bridge(dev);
+	if (bridge)
+		pci_enable_bridge(bridge);
+
+	pci_dev_state_lock(dev);
+
 	/*
 	 * Power state could be unknown at this point, either due to a fresh
 	 * boot or a device removal call.  So get the current power state
@@ -1586,12 +1600,9 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
 	}
 
+	/* Already enabled ? */
 	if (atomic_inc_return(&dev->enable_cnt) > 1)
-		return 0;		/* already enabled */
-
-	bridge = pci_upstream_bridge(dev);
-	if (bridge)
-		pci_enable_bridge(bridge);
+		goto bail;
 
 	/* only skip sriov related */
 	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
@@ -1604,6 +1615,8 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 	err = do_pci_enable_device(dev, bars);
 	if (err < 0)
 		atomic_dec(&dev->enable_cnt);
+ bail:
+	pci_dev_state_unlock(dev);
 	return err;
 }
 
@@ -1820,12 +1833,16 @@ static void do_pci_disable_device(struct pci_dev *dev)
  * @dev: PCI device to disable
  *
  * NOTE: This function is a backend of PCI power management routines and is
- * not supposed to be called drivers.
+ * not supposed to be called drivers. It will keep enable_cnt and is_busmaster
+ * unmodified so that the resume code knows how to restore the corresponding
+ * command register bits.
  */
 void pci_disable_enabled_device(struct pci_dev *dev)
 {
+	pci_dev_state_lock(dev);
 	if (pci_is_enabled(dev))
 		do_pci_disable_device(dev);
+	pci_dev_state_unlock(dev);
 }
 
 /**
@@ -1849,12 +1866,14 @@ void pci_disable_device(struct pci_dev *dev)
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
+	pci_dev_state_lock(dev);
 	if (atomic_dec_return(&dev->enable_cnt) != 0)
-		return;
+		goto bail;
 
 	do_pci_disable_device(dev);
-
 	dev->is_busmaster = 0;
+ bail:
+	pci_dev_state_unlock(dev);
 }
 EXPORT_SYMBOL(pci_disable_device);
 
-- 
2.17.1
