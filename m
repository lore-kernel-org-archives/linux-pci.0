Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, David.Laight@ACULAB.COM,
	alistair@popple.id.au, ruscur@russell.cc,
	Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH 2/5] iommu: Set PCI_BUS_FLAGS_MSI_REMAP if IOMMU have capability of IRQ remapping
Date: Wed, 27 Apr 2016 20:43:27 +0800
Message-Id: <1461761010-5452-3-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The capability of IRQ remapping is abstracted on IOMMU side on
some archs. There is a existing flag IOMMU_CAP_INTR_REMAP for this.

To have a universal flag to test this capability for different
archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
when IOMMU_CAP_INTR_REMAP is set.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/iommu/iommu.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0e3b009..5d2b6f6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -813,6 +813,16 @@ struct iommu_group *pci_device_group(struct device *dev)
 	return group;
 }
 
+static void pci_check_msi_remapping(struct pci_dev *pdev,
+					const struct iommu_ops *ops)
+{
+	struct pci_bus *bus = pdev->bus;
+
+	if (ops->capable(IOMMU_CAP_INTR_REMAP) &&
+		!(bus->bus_flags & PCI_BUS_FLAGS_MSI_REMAP))
+		bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -871,6 +881,9 @@ static int add_iommu_group(struct device *dev, void *data)
 	const struct iommu_ops *ops = cb->ops;
 	int ret;
 
+	if (dev_is_pci(dev) && ops->capable)
+		pci_check_msi_remapping(to_pci_dev(dev), ops);
+
 	if (!ops->add_device)
 		return 0;
 
@@ -913,6 +926,8 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	 * result in ADD/DEL notifiers to group->notifier
 	 */
 	if (action == BUS_NOTIFY_ADD_DEVICE) {
+		if (dev_is_pci(dev) && ops->capable)
+			pci_check_msi_remapping(to_pci_dev(dev), ops);
 		if (ops->add_device)
 			return ops->add_device(dev);
 	} else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
-- 
1.7.9.5
