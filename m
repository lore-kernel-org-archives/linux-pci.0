Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] vfio-pci: Attempt bus/slot reset on open
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Date: Thu, 09 Apr 2015 09:55:22 -0600
Message-ID: <20150409155229.6935.47756.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Apply the same logic we use in vfio_pci_try_bus_reset() to perform a
bus or slot reset as devices are released to the device open path.
This not only improves our chances of handing the device to the user
in a clean state, but we can also avoid duplicate resets if the device
is released and re-opened while bound to vfio-pci.  We can also
potentially reset multiple device with a single bus/slot reset and
avoid multiple function-level resets later.  We switch to using
pci_probe_reset_function() since we still want to expose function
level reset to the user, but we may not use it as the reset mechanism
of choice when enabling the device.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Depends on export of pci_probe_reset_function()
http://article.gmane.org/gmane.linux.kernel.pci/40662

 drivers/vfio/pci/vfio_pci.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 69fab0f..d9f7ec5 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -119,16 +119,32 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 	u16 cmd;
 	u8 msix_pos;
 
-	pci_set_power_state(pdev, PCI_D0);
+	/*
+	 * Start by resetting the device(s).  A bus reset is our best method
+	 * and may not be available once other devices are in use.  It may
+	 * also mark multiple devices as clean, avoiding duplicate function
+	 * level resets later.
+	 */
+	vfio_pci_try_bus_reset(vdev);
+	if (vdev->needs_reset)
+		vdev->needs_reset = !(pci_try_reset_function(pdev) == 0);
 
-	/* Don't allow our initial saved state to include busmaster */
+	/*
+	 * These are reset defaults, but let's be sure the device is awake
+	 * and not doing DMA.  We do not want BusMaster enabled in save state.
+	 */
+	pci_set_power_state(pdev, PCI_D0);
 	pci_clear_master(pdev);
 
+	/* Initialize device */
 	ret = pci_enable_device(pdev);
 	if (ret)
 		return ret;
 
-	vdev->reset_works = (pci_reset_function(pdev) == 0);
+	/*
+	 * Checkpoint, this is the base level state we want to
+	 * restore when the device is released.
+	 */
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
@@ -948,6 +964,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	mutex_init(&vdev->igate);
 	spin_lock_init(&vdev->irqlock);
+	vdev->reset_works = (pci_probe_reset_function(pdev) == 0);
+	vdev->needs_reset = true;
 
 	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
 	if (ret) {

