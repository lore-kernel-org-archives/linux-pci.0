Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34135 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeG3W6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jul 2018 18:58:55 -0400
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, Narendra_K@Dell.com,
        Stuart_Hayes@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/MSI: Don't touch MSI bits when the PCI device is disconnected
Date: Mon, 30 Jul 2018 16:21:44 -0500
Message-Id: <20180730212146.31909-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a PCI device is gone, we don't want to send IO to it if we can
avoid it. We expose functionality via the irq_chip structure. As
users of that structure may not know about the underlying PCI device,
it's our responsibility to guard against removed devices.

irq_write_msi_msg is already guarded. pci_msi_(un)mask_irq are not.
Guard them for completeness.

For example, surprise removal of a PCIe device triggers teardown. This
touches the irq_chips ops some point to disable the interrupts. I/O
generated here can crash the system on machines with buggy firmware.
Not triggering the IO in the first place eliminates the problem.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

There's another patch by Lukas Wunner that is needed (not yet published)
in order to fully block IO on SURPRISE!!! removal. The existing code only
sets the PCI_DEV_DISCONNECTED bit in an unreasonably narrow set of
circumstances. Lukas' patch fixes that.

However, this change is otherwise fully independent, and enjoy!

 drivers/pci/msi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4d88afdfc843..5f47b5cb0401 100644
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
