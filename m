Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:34872 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758365AbaEMBfg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 May 2014 21:35:36 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 13 May 2014 11:35:35 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 4/4] vfio/pci: Restore MSIx message prior to enabling
Date: Tue, 13 May 2014 11:35:24 +1000
Message-Id: <1399944924-1200-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399944924-1200-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399944924-1200-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The MSIx vector table lives in device memory, which may be cleared as
part of a backdoor device reset. This is the case on the IBM IPR HBA
when the BIST is run on the device. When assigned to a QEMU guest,
the guest driver does a pci_save_state(), issues a BIST, then does a
pci_restore_state(). The BIST clears the MSIx vector table, but due
to the way interrupts are configured the pci_restore_state() does not
restore the vector table as expected. Eventually this results in an
EEH error on Power platforms when the device attempts to signal an
interrupt with the zero'd table entry.

Fix the problem by restoring the host cached MSI message prior to
enabling each vector.

Reported-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 9dd49c9..409346f 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -548,6 +548,20 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
 		return PTR_ERR(trigger);
 	}
 
+	/*
+	 * The MSIx vector table resides in device memory which may be cleared
+	 * via backdoor resets. We don't allow direct access to the vector
+	 * table so even if a userspace driver attempts to save/restore around
+	 * such a reset it would be unsuccessful. To avoid this, restore the
+	 * cached value of the message prior to enabling.
+	 */
+	if (msix) {
+		struct msi_msg msg;
+
+		get_cached_msi_msg(irq, &msg);
+		write_msi_msg(irq, &msg);
+	}
+
 	ret = request_irq(irq, vfio_msihandler, 0,
 			  vdev->ctx[vector].name, trigger);
 	if (ret) {
-- 
1.8.3.2

