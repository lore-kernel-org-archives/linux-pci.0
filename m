Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43408 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbeISDtv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 23:49:51 -0400
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is disconnected
Date: Tue, 18 Sep 2018 17:15:00 -0500
Message-Id: <20180918221501.13112-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a PCI device is gone, we don't want to send IO to it if we can
avoid it. We expose functionality via the irq_chip structure. As
users of that structure may not know about the underlying PCI device,
it's our responsibility to guard against removed devices.

.irq_write_msi_msg() is already guarded inside __pci_write_msi_msg().
.irq_mask/unmask() are not. Guard them for completeness.

For example, surprise removal of a PCIe device triggers teardown. This
touches the irq_chips ops some point to disable the interrupts. I/O
generated here can crash the system on firmware-first machines.
Not triggering the IO in the first place greatly reduces the
possibility of the problem occurring.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f2ef896464b3..f31058fd2260 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
+	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
+		return;
+
 	if (desc->msi_attrib.is_msix) {
 		msix_mask_irq(desc, flag);
 		readl(desc->mask_base);		/* Flush write to device */
-- 
2.17.1
