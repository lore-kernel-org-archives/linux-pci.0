Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:37970 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968103AbeEXRjR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 13:39:17 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Doug Meyer <dmeyer@gigaio.com>
Date: Thu, 24 May 2018 11:39:13 -0600
Message-Id: <20180524173913.4506-1-logang@deltatee.com>
Subject: [PATCH v2] PCI: Expand documentation for pci_add_dma_alias()
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Seeing there's been some confusion about the use of pci_add_dma_alias(),
expand the comment to describe why it must be called early and how
early it must be called.

Also, expand on the purpose of this function and common reasons it would
be used.

[The comment was reworded to some extent by Alex Williamson]

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Doug Meyer <dmeyer@gigaio.com>
---

v2: Reworked the patch with Alex's suggested wording.

  drivers/pci/pci.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dbfe7c4f3776..1c0c1ea23b90 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5395,8 +5395,19 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
  * @dev: the PCI device for which alias is added
  * @devfn: alias slot and function
  *
- * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
- * It should be called early, preferably as PCI fixup header quirk.
+ * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
+ * which is used to program permissible BDF source addresses for DMA
+ * requests in an IOMMU. These aliases factor into IOMMU group creation
+ * and are useful for devices generating DMA requests beyond or different
+ * from their logical bus devfn. Examples include device quirks where the
+ * device simply uses the wronge devfn, as well as non-transparent bridges
+ * where the alias may be a proxy for devices in another domain.
+ *
+ * IOMMU group creation is performed during device discovery or addition,
+ * prior to any potential DMA mapping and therefore prior to driver probing
+ * (especially for userspace assigned devices where IOMMU group definition
+ * cannot be left as a userspace activity). DMA aliases should therefore
+ * be configured via quirks, such as the PCI fixup header quirk.
  */
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
--
2.11.0
