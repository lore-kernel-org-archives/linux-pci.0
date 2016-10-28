Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46396 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752824AbcJ1Wri (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Oct 2016 18:47:38 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 next 3/3] pci/msix: Skip disabling removed devices
Date: Fri, 28 Oct 2016 18:58:17 -0400
Message-Id: <1477695497-6207-4-git-send-email-keith.busch@intel.com>
In-Reply-To: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is no need to disable MSIx interrupts or write message data on a
device that isn't present. This patch checks the device removed state
prior to executing device shutdown operations so that tear down on
removed devices completes quicker.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/msi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index bfdd074..9249ec1 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -317,7 +317,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
 
-	if (dev->current_state != PCI_D0) {
+	if (dev->current_state != PCI_D0 || dev->is_removed) {
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
@@ -1017,6 +1017,11 @@ void pci_msix_shutdown(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msix_enabled)
 		return;
 
+	if (dev->is_removed) {
+		dev->msix_enabled = 0;
+		return;
+	}
+
 	/* Return the device with MSI-X masked as initial states */
 	for_each_pci_msi_entry(entry, dev) {
 		/* Keep cached states to be restored */
-- 
2.7.2

