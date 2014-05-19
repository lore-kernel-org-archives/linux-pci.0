Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:59767 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbaESCy2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 May 2014 22:54:28 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 19 May 2014 12:54:25 +1000
Date: Mon, 19 May 2014 12:54:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] vfio/pci: Restore MSIx message prior to enabling
Message-ID: <20140519025422.GA2253@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1399944924-1200-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1399944924-1200-5-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399944924-1200-5-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 13, 2014 at 11:35:24AM +1000, Gavin Shan wrote:
>The MSIx vector table lives in device memory, which may be cleared as
>part of a backdoor device reset. This is the case on the IBM IPR HBA
>when the BIST is run on the device. When assigned to a QEMU guest,
>the guest driver does a pci_save_state(), issues a BIST, then does a
>pci_restore_state(). The BIST clears the MSIx vector table, but due
>to the way interrupts are configured the pci_restore_state() does not
>restore the vector table as expected. Eventually this results in an
>EEH error on Power platforms when the device attempts to signal an
>interrupt with the zero'd table entry.
>
>Fix the problem by restoring the host cached MSI message prior to
>enabling each vector.
>
>Reported-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>---

Sorry about that the following line was missed. I'll add that and send
"v3" out.

#include <linux/msi.h>

> drivers/vfio/pci/vfio_pci_intrs.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
>index 9dd49c9..409346f 100644
>--- a/drivers/vfio/pci/vfio_pci_intrs.c
>+++ b/drivers/vfio/pci/vfio_pci_intrs.c
>@@ -548,6 +548,20 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
> 		return PTR_ERR(trigger);
> 	}
>
>+	/*
>+	 * The MSIx vector table resides in device memory which may be cleared
>+	 * via backdoor resets. We don't allow direct access to the vector
>+	 * table so even if a userspace driver attempts to save/restore around
>+	 * such a reset it would be unsuccessful. To avoid this, restore the
>+	 * cached value of the message prior to enabling.
>+	 */
>+	if (msix) {
>+		struct msi_msg msg;
>+
>+		get_cached_msi_msg(irq, &msg);
>+		write_msi_msg(irq, &msg);
>+	}
>+
> 	ret = request_irq(irq, vfio_msihandler, 0,
> 			  vdev->ctx[vector].name, trigger);
> 	if (ret) {

Thanks,
Gavin

