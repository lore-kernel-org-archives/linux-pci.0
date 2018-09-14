Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbeIOCer (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Sep 2018 22:34:47 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com, Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2 6/6] PCI: Expose reset type to users of pci_reset_bus()
Date: Fri, 14 Sep 2018 21:18:08 +0000
Message-Id: <20180914211808.2564-7-okaya@kernel.org>
In-Reply-To: <20180914211808.2564-1-okaya@kernel.org>
References: <20180914211808.2564-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looking to have more control between the users of the API vs. what the API
can do internally. The new reset_type tells the PCI core about the bounds
of the request.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci.c           | 18 +++++++++++++++---
 drivers/vfio/pci/vfio_pci.c |  4 ++--
 include/linux/pci.h         |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 32b367937cc1..7192cd460db4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5232,13 +5232,25 @@ static int __pci_reset_bus(struct pci_bus *bus)
 /**
  * pci_reset_bus - Try to reset a PCI bus
  * @pdev: top level PCI device to reset via slot/bus
+ * @reset_type: resets to try
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-int pci_reset_bus(struct pci_dev *pdev)
+int pci_reset_bus(struct pci_dev *pdev, u32 reset_type)
 {
-	return (!pci_probe_reset_slot(pdev->slot)) ?
-	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
+	if (reset_type & PCI_RESET_LINK) {
+		return (!pci_probe_reset_slot(pdev->slot)) ?
+				__pci_reset_slot(pdev->slot) :
+				__pci_reset_bus(pdev->bus);
+	}
+
+	if (reset_type & PCI_RESET_BUS)
+		return __pci_reset_bus(pdev->bus);
+
+	if (reset_type & PCI_RESET_SLOT)
+		return __pci_reset_slot(pdev->slot);
+
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(pci_reset_bus);
 
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index fe7ada997c51..754f08286bb1 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1015,7 +1015,7 @@ static long vfio_pci_ioctl(void *device_data,
 						    &info, slot);
 		if (!ret)
 			/* User has access, do the reset */
-			ret = pci_reset_bus(vdev->pdev);
+			ret = pci_reset_bus(vdev->pdev, PCI_RESET_LINK);
 
 hot_reset_release:
 		for (i--; i >= 0; i--)
@@ -1390,7 +1390,7 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
 	}
 
 	if (needs_reset)
-		ret = pci_reset_bus(vdev->pdev);
+		ret = pci_reset_bus(vdev->pdev, PCI_RESET_LINK);
 
 put_devs:
 	for (i = 0; i < devs.cur_index; i++) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4fdddcb85066..85f48e156753 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1128,7 +1128,7 @@ int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-int pci_reset_bus(struct pci_dev *dev);
+int pci_reset_bus(struct pci_dev *dev, u32 reset_type);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
-- 
2.18.0
