Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 3/5] vfio-pci: Remove warning if try-reset fails
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2015 13:02:55 -0700
Message-ID: <20150304200255.26766.78294.stgit@gimli.home>
In-Reply-To: <20150304194711.26766.75450.stgit@gimli.home>
References: <20150304194711.26766.75450.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As indicated in the comment, this is not entirely uncommon and
causes user concern for no reason.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 9c854b0..e5eb2e6 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -171,14 +171,8 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 	 * Try to reset the device.  The success of this is dependent on
 	 * being able to lock the device, which is not always possible.
 	 */
-	if (vdev->reset_works) {
-		int ret = pci_try_reset_function(pdev);
-		if (ret)
-			pr_warn("%s: Failed to reset device %s (%d)\n",
-				__func__, dev_name(&pdev->dev), ret);
-		else
-			vdev->needs_reset = false;
-	}
+	if (vdev->reset_works && !pci_try_reset_function(pdev))
+		vdev->needs_reset = false;
 
 	pci_restore_state(pdev);
 out:

