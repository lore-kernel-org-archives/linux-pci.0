Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:50227 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbaFBQ5Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jun 2014 12:57:25 -0400
Received: by mail-ig0-f174.google.com with SMTP id h3so3596628igd.7
        for <linux-pci@vger.kernel.org>; Mon, 02 Jun 2014 09:57:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140531114252.GA8509@shangw>
References: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400468470-11262-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <20140530221232.GG4607@google.com> <20140531114252.GA8509@shangw>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Jun 2014 10:57:05 -0600
Message-ID: <CAErSpo4j8CSwKMn_V4=b5=JrX0M_GyTWoAqxWnRso+nvWbTQWA@mail.gmail.com>
Subject: Re: [PATCH 4/4] vfio/pci: Restore MSIx message prior to enabling
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 31, 2014 at 5:42 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Fri, May 30, 2014 at 04:12:32PM -0600, Bjorn Helgaas wrote:
>>On Mon, May 19, 2014 at 01:01:10PM +1000, Gavin Shan wrote:
>>> The MSIx vector table lives in device memory, which may be cleared as
>>> part of a backdoor device reset. This is the case on the IBM IPR HBA
>>> when the BIST is run on the device. When assigned to a QEMU guest,
>>> the guest driver does a pci_save_state(), issues a BIST, then does a
>>> pci_restore_state(). The BIST clears the MSIx vector table, but due
>>> to the way interrupts are configured the pci_restore_state() does not
>>> restore the vector table as expected. Eventually this results in an
>>> EEH error on Power platforms when the device attempts to signal an
>>> interrupt with the zero'd table entry.
>>>
>>> Fix the problem by restoring the host cached MSI message prior to
>>> enabling each vector.
>>>
>>> Reported-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>>  drivers/vfio/pci/vfio_pci_intrs.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
>>> index 9dd49c9..553212f 100644
>>> --- a/drivers/vfio/pci/vfio_pci_intrs.c
>>> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/device.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/eventfd.h>
>>> +#include <linux/msi.h>
>>>  #include <linux/pci.h>
>>>  #include <linux/file.h>
>>>  #include <linux/poll.h>
>>> @@ -548,6 +549,20 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
>>>              return PTR_ERR(trigger);
>>>      }
>>>
>>> +    /*
>>> +     * The MSIx vector table resides in device memory which may be cleared
>>> +     * via backdoor resets. We don't allow direct access to the vector
>>> +     * table so even if a userspace driver attempts to save/restore around
>>> +     * such a reset it would be unsuccessful. To avoid this, restore the
>>> +     * cached value of the message prior to enabling.
>>> +     */
>>> +    if (msix) {
>>> +            struct msi_msg msg;
>>> +
>>> +            get_cached_msi_msg(irq, &msg);
>>> +            write_msi_msg(irq, &msg);
>>> +    }
>>
>>I think this is pretty ugly.  Drivers should not be writing to the
>>MSI-X vector table, so I don't really want to export these internal
>>implementation functions if we can avoid it.
>>
>
> I agree that it's ugly and I need discuss with Alex about the potential
> solutions: fix the issue either from guest or qemu.
>
> - If the "reset" is special backdoor for some devices, the device driver
>   on guest side should have something like: disable MSIx entries that have
>   been enabled (updating MSIx entries maintained by QEMU), pci_save_state(),
>   reset(), pci_restore_state(), enable MSIx entries (updating MSIx entries
>   maintained by QEMU). Disadvantage of this way would be guest driver has
>   to accomodate QEMU, which sounds bad.

I agree, this sounds even worse.

> - In QEMU, we could have some quirk to trap when writting to registers
>   for reset on basis of devices. From there, to clear the MSIx entries
>   maintained by QEMU. It's similar thing to be applied when having FLR
>   reset. We have to have separate quirk to accomodate every kind of devices.

This also sounds bad.

> - Last one is what we had. However, it's really "hack".
>
>>I chatted with Alex about this last week on IRC, trying to understand
>>what's going on here, but I'm afraid I didn't get very far.
>>
>>I think I understand what happens when there's no virtualization
>>involved.  The driver enables MSI-X and writes the vector table via
>>this path:
>>
>>    pci_enable_msix
>>      msix_capability_init
>>       arch_setup_msi_irqs
>>         native_setup_msi_irqs         # .setup_msi_irqs (on x86)
>>           setup_msi_irq
>>             write_msi_msg
>>               __write_msi_msg         # write vector table
>>
>>When a device is reset, its MSI-X vector table is cleared.  The type
>>of reset (FLR, "backdoor", etc.) doesn't really matter.
>>
>>After a device reset, the driver would use this path to restore the
>>vector table:
>>
>>    pci_restore_state
>>      pci_restore_msi_state
>>        __pci_restore_msix_state
>>          arch_restore_msi_irqs
>>            default_restore_msi_irqs   # .restore_msi_irqs (on x86)
>>              default_restore_msi_irq
>>                write_msi_msg
>>                  __write_msi_msg      # write vector table
>>
>>This rewrites the MSI-X vector table (it doesn't use any data that was
>>saved by pci_save_state(), so it's not really a "restore" in that
>>sense; it writes the vector table from scratch based on the data
>>structures maintained by the MSI core).
>>
>>If the same driver is running in a qemu guest, it still calls
>>pci_enable_msix() and pci_restore_state(), but apparently the restore
>>path doesn't work.  Alex mentioned that qemu virtualizes the vector
>>table, so I assume it traps the writel() to the vector table when
>>enabling MSI-X?  And I assume qemu would also trap the writel() in the
>>restore path, but it sounded like it ignores the write because we're
>>writing the same data qemu believes to be there?
>>
>>I'd like to understand more details about how those writel()s
>>performed by the guest kernel are handled.  Alex mentioned that the
>>vector table is inaccessible to the guest, and I see code in
>>vfio_pci_bar_rw() that looks like it excludes the table area, so I
>>assume that is involved somehow, but I don't know how to connect the
>>dots.  Obviously the enable path must be handled differently from the
>>restore path somehow, because if the enable used vfio_pci_bar_rw(),
>>that write would just be dropped, too, and it's not.
>
> The problem is basically the MSIx entries maintained in QEMU mismatched
> with those in hardware (host kernel), which is caused by backdoor "reset":
>
> - Guest driver enables MSIx entries. MSIx entries are marked as "enabled"
>   in hardware, QEMU, guest.
> - Guest driver calls pci_save_state() and then issues backdoor reset. We
>   lose everything in MSIx table in hardware. QEMU still maintains "enabled"
>   MSIx entries.
> - Guest driver calls to pci_restore_state() and tries to enable MSIx entries.
>   Writing to MSIx entries trapped in QEMU. QEMU won't update MSIx entries in
>   hardware because the MSIx entries are marked as "enabled" in QEMU.

It sounds like QEMU assumes the MSIx entries can't be changed by
anything other than the writes it traps.  This assumption is false
(the entries are cleared when the driver resets the device, and QEMU
doesn't know about the reset).

Why can't QEMU trap the write from pci_restore_state() and update the
hardware, even if it thinks nothing has changed?

Bjorn
