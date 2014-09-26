Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:56181 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbaIZDUG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Sep 2014 23:20:06 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 26 Sep 2014 13:20:04 +1000
Date: Fri, 26 Sep 2014 13:19:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] vfio/pci: Restore MSIx message prior to enabling
Message-ID: <20140926031958.GA30285@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400468470-11262-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <20140910081342.GA18833@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140910081342.GA18833@shangw>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 10, 2014 at 06:13:42PM +1000, Gavin Shan wrote:
>On Mon, May 19, 2014 at 01:01:10PM +1000, Gavin Shan wrote:
>>The MSIx vector table lives in device memory, which may be cleared as
>>part of a backdoor device reset. This is the case on the IBM IPR HBA
>>when the BIST is run on the device. When assigned to a QEMU guest,
>>the guest driver does a pci_save_state(), issues a BIST, then does a
>>pci_restore_state(). The BIST clears the MSIx vector table, but due
>>to the way interrupts are configured the pci_restore_state() does not
>>restore the vector table as expected. Eventually this results in an
>>EEH error on Power platforms when the device attempts to signal an
>>interrupt with the zero'd table entry.
>>
>>Fix the problem by restoring the host cached MSI message prior to
>>enabling each vector.
>>
>>Reported-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>
>Alex, please let me know if I need resend this one to you. The patch
>has been pending for long time, I'm not sure if you still can grab
>it somewhere.
>
>As you might see, Bjorn will take that one with PCI changes. This patch
>depends on the changes.
>

Alex, I guess you probably missed last reply. Bjorn acked the first
patch and you can pick both of them if I understand correctly. Please
let me know if I need resend those 2 patches?

Thanks,
Gavin

>Thanks,
>Gavin
>
>>---
>> drivers/vfio/pci/vfio_pci_intrs.c | 15 +++++++++++++++
>> 1 file changed, 15 insertions(+)
>>
>>diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
>>index 9dd49c9..553212f 100644
>>--- a/drivers/vfio/pci/vfio_pci_intrs.c
>>+++ b/drivers/vfio/pci/vfio_pci_intrs.c
>>@@ -16,6 +16,7 @@
>> #include <linux/device.h>
>> #include <linux/interrupt.h>
>> #include <linux/eventfd.h>
>>+#include <linux/msi.h>
>> #include <linux/pci.h>
>> #include <linux/file.h>
>> #include <linux/poll.h>
>>@@ -548,6 +549,20 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
>> 		return PTR_ERR(trigger);
>> 	}
>>
>>+	/*
>>+	 * The MSIx vector table resides in device memory which may be cleared
>>+	 * via backdoor resets. We don't allow direct access to the vector
>>+	 * table so even if a userspace driver attempts to save/restore around
>>+	 * such a reset it would be unsuccessful. To avoid this, restore the
>>+	 * cached value of the message prior to enabling.
>>+	 */
>>+	if (msix) {
>>+		struct msi_msg msg;
>>+
>>+		get_cached_msi_msg(irq, &msg);
>>+		write_msi_msg(irq, &msg);
>>+	}
>>+
>> 	ret = request_irq(irq, vfio_msihandler, 0,
>> 			  vdev->ctx[vector].name, trigger);
>> 	if (ret) {
>>-- 
>>1.8.3.2
>>

