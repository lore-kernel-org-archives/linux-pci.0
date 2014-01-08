Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25773 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753919AbaAHHzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Jan 2014 02:55:53 -0500
Date: Wed, 8 Jan 2014 08:57:58 +0100
From: Alexander Gordeev <agordeev@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 5/7] vfio: Use new interfaces for MSI/MSI-X enablement
Message-ID: <20140108075757.GB20157@dhcp-26-207.brq.redhat.com>
References: <cover.1389103215.git.agordeev@redhat.com>
 <1c2ab7cdd9f18f98ee86c73b182f4ee0697f7495.1389103215.git.agordeev@redhat.com>
 <1389119653.3209.124.camel@bling.home>
 <20140108074224.GA20157@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140108074224.GA20157@dhcp-26-207.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
