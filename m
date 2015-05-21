Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:51910 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754853AbbEUVEk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2015 17:04:40 -0400
From: Sakari Ailus <sakari.ailus@iki.fi>
To: linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com
Subject: [PATCH 1/1] PCI: Add function 1 DMA alias quirk for Marvell 9120
Date: Fri, 22 May 2015 00:03:38 +0300
Message-Id: <1432242218-28414-1-git-send-email-sakari.ailus@iki.fi>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Marvell 9120 SATA controller has the same issue as a number of others, use
the same quirk for this one. The other quirks were added by patch
"PCI: Add function 1 DMA alias quirk for Marvell devices"
(commit id cc346a4714a59d08c118e8f33fd86692d3563133).

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
(Resending to linux-pci, was originally sent to linux-iommu list.)

Hi,

I recently booted the v4.0.1 kernel with intel-iommu enabled and had similar
issues as in the original bug report with Marvell 88SE9120 (rev 12). The
same quirk appears to work for that one as well.

 drivers/pci/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 85f247e..d4af5a8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3572,6 +3572,8 @@ static void quirk_dma_func1_alias(struct pci_dev *dev)
  * SKUs this function is not present, making this a ghost requester.
  * https://bugzilla.kernel.org/show_bug.cgi?id=42679
  */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9120,
+			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
 			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
-- 
1.7.10.4

