Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbeIQB3D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Sep 2018 21:29:03 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com, Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v3 4/6] PCI: Expose reset type to users of pci_try_reset_function()
Date: Sun, 16 Sep 2018 20:04:37 +0000
Message-Id: <20180916200439.21960-5-okaya@kernel.org>
In-Reply-To: <20180916200439.21960-1-okaya@kernel.org>
References: <20180916200439.21960-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looking to have more control between the users of the API vs. what the API
can do internally. The new reset_type tells the PCI core about the bounds
of the request.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci.c                  | 4 ++--
 drivers/vfio/pci/vfio_pci.c        | 7 ++++---
 drivers/vfio/pci/vfio_pci_config.c | 4 ++--
 include/linux/pci.h                | 2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3046c202bfea..c216ab56dbcc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4852,7 +4852,7 @@ EXPORT_SYMBOL_GPL(pci_reset_function_locked);
  *
  * Same as above, except return -EAGAIN if unable to lock device.
  */
-int pci_try_reset_function(struct pci_dev *dev)
+int pci_try_reset_function(struct pci_dev *dev, u32 reset_type)
 {
 	int rc;
 
@@ -4863,7 +4863,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 		return -EAGAIN;
 
 	pci_dev_save_and_disable(dev);
-	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
+	rc = __pci_reset_function_locked(dev, reset_type);
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
 
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index cddb453a1ba5..fe7ada997c51 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -228,7 +228,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
 		return ret;
 
 	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
+	ret = pci_try_reset_function(pdev, PCI_RESET_ANY);
 	if (ret == -EAGAIN) {
 		pci_disable_device(pdev);
 		return ret;
@@ -376,7 +376,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 	 * Try to reset the device.  The success of this is dependent on
 	 * being able to lock the device, which is not always possible.
 	 */
-	if (vdev->reset_works && !pci_try_reset_function(pdev))
+	if (vdev->reset_works && !pci_try_reset_function(pdev, PCI_RESET_ANY))
 		vdev->needs_reset = false;
 
 	pci_restore_state(pdev);
@@ -844,7 +844,8 @@ static long vfio_pci_ioctl(void *device_data,
 
 	} else if (cmd == VFIO_DEVICE_RESET) {
 		return vdev->reset_works ?
-			pci_try_reset_function(vdev->pdev) : -EINVAL;
+			pci_try_reset_function(vdev->pdev, PCI_RESET_ANY) :
+			 -EINVAL;
 
 	} else if (cmd == VFIO_DEVICE_GET_PCI_HOT_RESET_INFO) {
 		struct vfio_pci_hot_reset_info hdr;
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 115a36f6f403..0d66bac66211 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -831,7 +831,7 @@ static int vfio_exp_config_write(struct vfio_pci_device *vdev, int pos,
 						 &cap);
 
 		if (!ret && (cap & PCI_EXP_DEVCAP_FLR))
-			pci_try_reset_function(vdev->pdev);
+			pci_try_reset_function(vdev->pdev, PCI_RESET_ANY);
 	}
 
 	/*
@@ -910,7 +910,7 @@ static int vfio_af_config_write(struct vfio_pci_device *vdev, int pos,
 						&cap);
 
 		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP))
-			pci_try_reset_function(vdev->pdev);
+			pci_try_reset_function(vdev->pdev, PCI_RESET_ANY);
 	}
 
 	return count;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 09aa99dd1c1b..4fdddcb85066 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1125,7 +1125,7 @@ int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
-int pci_try_reset_function(struct pci_dev *dev);
+int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_dev *dev);
-- 
2.18.0
