Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51098 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754162AbeFTENi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 00:13:38 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org (open list),
        kvm@vger.kernel.org (open list:VFIO DRIVER)
Subject: [PATCH V2 4/5] PCI: Unify try slot and bus reset API
Date: Wed, 20 Jun 2018 00:12:57 -0400
Message-Id: <1529467995-28780-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1529467995-28780-1-git-send-email-okaya@codeaurora.org>
References: <1529467995-28780-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Drivers are expected to call pci_try_reset_slot() or pci_try_reset_bus() by
querying if a system supports hotplug or not. A survey showed that most
drivers don't do this and we are leaking hotplug capability to the user.

Hide pci_try_slot_reset() from drivers and embed into pci_try_bus_reset().
Change pci_try_reset_bus() parameter from struct pci_bus to struct pci_dev.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c           | 26 +++++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci.c |  6 ++----
 include/linux/pci.h         |  3 +--
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 236220c..79a1566 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4817,12 +4817,12 @@ int pci_reset_slot(struct pci_slot *slot)
 EXPORT_SYMBOL_GPL(pci_reset_slot);
 
 /**
- * pci_try_reset_slot - Try to reset a PCI slot
+ * __pci_try_reset_slot - Try to reset a PCI slot
  * @slot: PCI slot to reset
  *
  * Same as above except return -EAGAIN if the slot cannot be locked
  */
-int pci_try_reset_slot(struct pci_slot *slot)
+static int __pci_try_reset_slot(struct pci_slot *slot)
 {
 	int rc;
 
@@ -4843,7 +4843,6 @@ int pci_try_reset_slot(struct pci_slot *slot)
 
 	return rc;
 }
-EXPORT_SYMBOL_GPL(pci_try_reset_slot);
 
 static int pci_bus_reset(struct pci_bus *bus, int probe)
 {
@@ -4906,12 +4905,12 @@ int pci_reset_bus(struct pci_bus *bus)
 EXPORT_SYMBOL_GPL(pci_reset_bus);
 
 /**
- * pci_try_reset_bus - Try to reset a PCI bus
+ * __pci_try_reset_bus - Try to reset a PCI bus
  * @bus: top level PCI bus to reset
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-int pci_try_reset_bus(struct pci_bus *bus)
+static int __pci_try_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
@@ -4932,6 +4931,23 @@ int pci_try_reset_bus(struct pci_bus *bus)
 
 	return rc;
 }
+
+/**
+ * pci_try_reset_bus - Try to reset a PCI bus
+ * @pdev: top level PCI device to reset via slot/bus
+ *
+ * Same as above except return -EAGAIN if the bus cannot be locked
+ */
+int pci_try_reset_bus(struct pci_dev *pdev)
+{
+	bool slot = false;
+
+	if (!pci_probe_reset_slot(pdev->slot))
+		slot = true;
+
+	return slot ? __pci_try_reset_slot(pdev->slot) :
+			__pci_try_reset_bus(pdev->bus);
+}
 EXPORT_SYMBOL_GPL(pci_try_reset_bus);
 
 /**
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b423a30..71018ec 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1010,8 +1010,7 @@ static long vfio_pci_ioctl(void *device_data,
 						    &info, slot);
 		if (!ret)
 			/* User has access, do the reset */
-			ret = slot ? pci_try_reset_slot(vdev->pdev->slot) :
-				     pci_try_reset_bus(vdev->pdev->bus);
+			ret = pci_try_reset_bus(vdev->pdev);
 
 hot_reset_release:
 		for (i--; i >= 0; i--)
@@ -1373,8 +1372,7 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
 	}
 
 	if (needs_reset)
-		ret = slot ? pci_try_reset_slot(vdev->pdev->slot) :
-			     pci_try_reset_bus(vdev->pdev->bus);
+		ret = pci_try_reset_bus(vdev->pdev);
 
 put_devs:
 	for (i = 0; i < devs.cur_index; i++) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6b12ce2..f5c85b6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1096,10 +1096,9 @@ int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_reset_slot(struct pci_slot *slot);
-int pci_try_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_bus *bus);
-int pci_try_reset_bus(struct pci_bus *bus);
+int pci_try_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
-- 
2.7.4
