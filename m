Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 5/6] vfio-pci: Remove warning if try-reset fails
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, bsd@redhat.com,
	linux-kernel@vger.kernel.org
Date: Wed, 18 Mar 2015 14:13:36 -0600
Message-ID: <20150318201336.24807.33423.stgit@gimli.home>
In-Reply-To: <20150318200053.24807.74115.stgit@gimli.home>
References: <20150318200053.24807.74115.stgit@gimli.home>
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
index 43517ce..d0f1e70 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -217,14 +217,8 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
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

