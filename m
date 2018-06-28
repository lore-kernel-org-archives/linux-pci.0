Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH V4 4/7] PCI: Unify try slot and bus reset API
Date: Thu, 28 Jun 2018 15:31:02 -0400
Message-Id: <1530214274-21139-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
References: <1530214274-21139-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
 "open list:VFIO DRIVER" <kvm@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arm-msm@vger.kernel.org,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 open list <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
 Zhenyu Wang <zhenyuw@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Drivers are expected to call pci_try_reset_slot() or pci_try_reset_bus() by
querying if a system supports hotplug or not. A survey showed that most
drivers don't do this and we are leaking hotplug capability to the user.

Hide pci_try_slot_reset() from drivers and embed into pci_try_bus_reset().
Change pci_try_reset_bus() parameter from struct pci_bus to struct pci_dev.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/infiniband/hw/hfi1/pcie.c |  2 +-
 drivers/pci/pci.c                 | 26 +++++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci.c       |  6 ++----
 include/linux/pci.h               |  3 +--
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 4570c4d..df4f2d3 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -905,7 +905,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * delay after a reset is required.  Per spec requirements,
 	 * the link is either working or not after that point.
 	 */
-	return pci_try_reset_bus(dev->bus);
+	return pci_try_reset_bus(dev);
 }
 
 /*
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
