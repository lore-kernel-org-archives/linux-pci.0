Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 5/7] vfio: Use new interfaces for MSI/MSI-X enablement
Date: Tue,  7 Jan 2014 19:05:40 +0100
Message-Id: <1c2ab7cdd9f18f98ee86c73b182f4ee0697f7495.1389103215.git.agordeev@redhat.com>
In-Reply-To: <cover.1389103215.git.agordeev@redhat.com>
References: <cover.1389103215.git.agordeev@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This update also fixes a bug when deprecated pci_enable_msix()
and pci_enable_msi_block() functions return a positive return
value which indicats the number of interrupts that could have
been allocated rather than a successful allocation. The driver
misinterpreted this value and assumed MSI-X/MSIs are enabled,
although in fact it were not.

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 641bc87..66d1746 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -482,15 +482,15 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
 		for (i = 0; i < nvec; i++)
 			vdev->msix[i].entry = i;
 
-		ret = pci_enable_msix(pdev, vdev->msix, nvec);
-		if (ret) {
+		ret = pci_enable_msix_range(pdev, vdev->msix, nvec, nvec);
+		if (ret < 0) {
 			kfree(vdev->msix);
 			kfree(vdev->ctx);
 			return ret;
 		}
 	} else {
-		ret = pci_enable_msi_block(pdev, nvec);
-		if (ret) {
+		ret = pci_enable_msi_range(pdev, nvec, nvec);
+		if (ret < 0) {
 			kfree(vdev->ctx);
 			return ret;
 		}
-- 
1.7.7.6

