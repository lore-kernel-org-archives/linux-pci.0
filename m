Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22565 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbdBCRrU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 12:47:20 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv5 4/5] pci/msix: Skip disabling disconnected devices
Date: Fri,  3 Feb 2017 12:55:54 -0500
Message-Id: <1486144555-5526-5-git-send-email-keith.busch@intel.com>
In-Reply-To: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
References: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch checks the device connected state prior to executing device
shutdown operations so that tear down on disconnected devices completes
quicker.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/msi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 50c5003..17807eb3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -317,7 +317,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
 
-	if (dev->current_state != PCI_D0) {
+	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
@@ -1020,6 +1020,11 @@ void pci_msix_shutdown(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msix_enabled)
 		return;
 
+	if (pci_dev_is_disconnected(dev)) {
+		dev->msix_enabled = 0;
+		return;
+	}
+
 	/* Return the device with MSI-X masked as initial states */
 	for_each_pci_msi_entry(entry, dev) {
 		/* Keep cached states to be restored */
-- 
2.7.2
