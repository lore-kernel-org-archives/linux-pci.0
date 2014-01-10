Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19137 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbaAJHkn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jan 2014 02:40:43 -0500
Date: Fri, 10 Jan 2014 08:42:47 +0100
From: Alexander Gordeev <agordeev@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 5/7] vfio: Use new interfaces for MSI/MSI-X enablement
Message-ID: <20140110074247.GA4883@dhcp-26-207.brq.redhat.com>
References: <cover.1389103215.git.agordeev@redhat.com>
 <1c2ab7cdd9f18f98ee86c73b182f4ee0697f7495.1389103215.git.agordeev@redhat.com>
 <1389119653.3209.124.camel@bling.home>
 <20140108074224.GA20157@dhcp-26-207.brq.redhat.com>
 <20140108075757.GB20157@dhcp-26-207.brq.redhat.com>
 <1389188753.3209.156.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389188753.3209.156.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 641bc87..4a9db1d 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -482,15 +482,19 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
 		for (i = 0; i < nvec; i++)
 			vdev->msix[i].entry = i;
 
-		ret = pci_enable_msix(pdev, vdev->msix, nvec);
-		if (ret) {
+		ret = pci_enable_msix_range(pdev, vdev->msix, 1, nvec);
+		if (ret < nvec) {
+			if (ret > 0)
+				pci_disable_msix(pdev);
 			kfree(vdev->msix);
 			kfree(vdev->ctx);
 			return ret;
 		}
 	} else {
-		ret = pci_enable_msi_block(pdev, nvec);
-		if (ret) {
+		ret = pci_enable_msi_range(pdev, 1, nvec);
+		if (ret < nvec) {
+			if (ret > 0)
+				pci_disable_msi(pdev);
 			kfree(vdev->ctx);
 			return ret;
 		}
-- 
1.7.7.6

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
