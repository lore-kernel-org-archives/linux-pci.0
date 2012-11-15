Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768339Ab2KOQ0D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Nov 2012 11:26:03 -0500
Subject: [PATCH] vfio-pci: Re-order device reset
To: alex.williamson@redhat.com, hare@suse.de
From: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
Date: Thu, 15 Nov 2012 09:26:00 -0700
Message-ID: <20121115162329.6706.32995.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move the device reset to the end of our disable path, the device
should already be stopped from pci_disable_device().  This also allows
us to manipulate the save/restore to avoid the save/reset/restore +
save/restore that we had before.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Hannes, I think this does the move you're looking for, please let
me know if it works better for you.  This is also in my next branch:

git://github.com/awilliam/linux-vfio.git next

Thanks,

Alex

 drivers/vfio/pci/vfio_pci.c |   43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index a4dc21b..b179f5a 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -92,9 +92,10 @@ out:
 
 static void vfio_pci_disable(struct vfio_pci_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
 	int bar;
 
-	pci_disable_device(vdev->pdev);
+	pci_disable_device(pdev);
 
 	vfio_pci_set_irqs_ioctl(vdev, VFIO_IRQ_SET_DATA_NONE |
 				VFIO_IRQ_SET_ACTION_TRIGGER,
@@ -104,22 +105,40 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 
 	vfio_config_free(vdev);
 
-	pci_reset_function(vdev->pdev);
-
-	if (pci_load_and_free_saved_state(vdev->pdev,
-					  &vdev->pci_saved_state) == 0)
-		pci_restore_state(vdev->pdev);
-	else
-		pr_info("%s: Couldn't reload %s saved state\n",
-			__func__, dev_name(&vdev->pdev->dev));
-
 	for (bar = PCI_STD_RESOURCES; bar <= PCI_STD_RESOURCE_END; bar++) {
 		if (!vdev->barmap[bar])
 			continue;
-		pci_iounmap(vdev->pdev, vdev->barmap[bar]);
-		pci_release_selected_regions(vdev->pdev, 1 << bar);
+		pci_iounmap(pdev, vdev->barmap[bar]);
+		pci_release_selected_regions(pdev, 1 << bar);
 		vdev->barmap[bar] = NULL;
 	}
+
+	/*
+	 * If we have saved state, restore it.  If we can reset the device,
+	 * even better.  Resetting with current state seems better than
+	 * nothing, but saving and restoring current state without reset
+	 * is just busy work.
+	 */
+	if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
+		pr_info("%s: Couldn't reload %s saved state\n",
+			__func__, dev_name(&pdev->dev));
+
+		if (!vdev->reset_works)
+			return;
+
+		pci_save_state(pdev);
+	}
+
+	/*
+	 * Disable INTx and MSI, presumably to avoid spurious interrupts
+	 * during reset.  Stolen from pci_reset_function()
+	 */
+	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+
+	if (vdev->reset_works)
+		__pci_reset_function(pdev);
+
+	pci_restore_state(pdev);
 }
 
 static void vfio_pci_release(void *device_data)

