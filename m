Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1675 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934281AbcI0UMr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Sep 2016 16:12:47 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Lukas Wunner <lukas@wunner.de>,
        Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 5/5] pci/msix: Skip disabling removed devices
Date: Tue, 27 Sep 2016 16:23:35 -0400
Message-Id: <1475007815-28354-6-git-send-email-keith.busch@intel.com>
In-Reply-To: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
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
index a02981e..2b5e67d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -316,7 +316,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
 
-	if (dev->current_state != PCI_D0) {
+	if (dev->current_state != PCI_D0 || dev->is_removed) {
 		/* Don't touch the hardware now */
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
@@ -999,6 +999,11 @@ void pci_msix_shutdown(struct pci_dev *dev)
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

