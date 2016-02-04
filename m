Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [193.47.165.129] ([193.47.165.129]:33978 "EHLO mellanox.co.il"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933345AbcBDI3r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 03:29:47 -0500
From: Ilya Lesokhin <ilyal@mellanox.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com, ilyal@mellanox.com
Subject: [RFC V2 2/4] IOMMU: Force the VFs of an untrusted PF device to be in the PFs IOMMU group
Date: Thu,  4 Feb 2016 10:28:55 +0200
Message-Id: <1454574537-123466-3-git-send-email-ilyal@mellanox.com>
In-Reply-To: <1454574537-123466-1-git-send-email-ilyal@mellanox.com>
References: <1454574537-123466-1-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a new PCI_DEV_FLAGS_UNTRUSTED to indicate that a PCI device
is probed by a driver that gives untrusted entities access to that device.
Make iommu_group_get_for_pci_dev check the new flag when an IOMMU
group is selected for a virtual function.
Mark VFIO devices with the new flag.

Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
---
 drivers/iommu/iommu.c       | 4 ++++
 drivers/vfio/pci/vfio_pci.c | 3 +++
 include/linux/pci.h         | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 049df49..864b459 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -738,6 +738,10 @@ static struct iommu_group *iommu_group_get_for_pci_dev(struct pci_dev *pdev)
 	struct iommu_group *group = NULL;
 	u64 devfns[4] = { 0 };
 
+	if (pdev->is_virtfn && 
+	   (pdev->physfn->dev_flags & PCI_DEV_FLAGS_UNTRUSTED))
+		return iommu_group_get(&pdev->physfn->dev);
+	
 	/*
 	 * Find the upstream DMA alias for the device.  A device must not
 	 * be aliased due to topology in order to have its own IOMMU group.
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 964ad57..ddcfd2c 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -982,6 +982,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
 
+	pdev->dev_flags |= PCI_DEV_FLAGS_UNTRUSTED;
+
 	return ret;
 }
 
@@ -989,6 +991,7 @@ static void vfio_pci_remove(struct pci_dev *pdev)
 {
 	struct vfio_pci_device *vdev;
 
+	pdev->dev_flags &= ~PCI_DEV_FLAGS_UNTRUSTED;
 	vdev = vfio_del_group_dev(&pdev->dev);
 	if (!vdev)
 		return;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22..6330327 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -182,6 +182,7 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
 	/* Get VPD from function 0 VPD */
 	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
+	PCI_DEV_FLAGS_UNTRUSTED = (__force pci_dev_flags_t) (1 << 9),
 };
 
 enum pci_irq_reroute_variant {
-- 
1.8.3.1

