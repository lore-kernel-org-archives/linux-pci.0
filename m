Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36616 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932390AbdAIPnW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2017 10:43:22 -0500
MIME-Version: 1.0
In-Reply-To: <42d912c2-596e-29f6-8385-dc82a891895c@oracle.com>
References: <20170105192856.25559-1-dan.streetman@canonical.com>
 <20170107010651.GV16608@char.us.oracle.com> <42d912c2-596e-29f6-8385-dc82a891895c@oracle.com>
From: Dan Streetman <ddstreet@ieee.org>
Date: Mon, 9 Jan 2017 10:42:41 -0500
Message-ID: <CALZtONBNhh9WKPV16+cod-P1Fp2YudTkVzHQZMq81_NEne67pA@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] xen: do not re-use pirq number cached in pci
 device msi msg data
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Streetman <dan.streetman@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 9, 2017 at 9:59 AM, Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
> On 01/06/2017 08:06 PM, Konrad Rzeszutek Wilk wrote:
>> On Thu, Jan 05, 2017 at 02:28:56PM -0500, Dan Streetman wrote:
>>> Do not read a pci device's msi message data to see if a pirq was
>>> previously configured for the device's msi/msix, as the old pirq was
>>> unmapped and may now be in use by another pci device.  The previous
>>> pirq should never be re-used; instead a new pirq should always be
>>> allocated from the hypervisor.
>> Won't this cause a starvation problem? That is we will run out of PIRQs
>> as we are not reusing them?
>
> Don't we free the pirq when we unmap it?

I think this is actually a bit worse than I initially thought.  After
looking a bit closer, and I think there's an asymmetry with pirq
allocation:

tl;dr:

pci_enable_msix_range() -> each MSIX (or MSI) now has a pirq
allocated, and reserved in the hypervisor

request_irq() -> an event channel is opened for the specific pirq, and
maps the pirq with the hypervisor

free_irq() -> the event channel is closed, and the pirq is unmapped,
but that unmap function also frees the pirq!  The hypervisor can/will
give it away to the next call to get_free_pirq.  However, the pci
msi/msix data area still contains the pirq number, and the next call
to request_irq() will re-use the pirq.

pci_disable_msix() -> this has no effect on the pirq in the hypervisor
(it's already been freed), and it also doesn't clear anything from the
msi/msix data area, so the pirq is still cached there.


It seems like the hypervisor needs to be fixed to *not* unmap the pirq
when the event channel is closed - or at least, not to change it to
IRQ_UNBOUND state?  And, the pci_disable_msix call should eventually
call into something in the Xen guest kernel that actually does the
pirq unmapping, and clear it from the msi data area (i.e.
pci_write_msi_msg)

Alternately, if the hypervisor doesn't change, then the call into the
hypervisor to actually allocate a pirq needs to move from the
pci_enable_msix_range() call to the request_irq() call?  So that when
the msi/msix range is enabled, it doesn't actually reserve any pirq's
for any of the vectors; each request_irq/free_irq pair do the pirq
allocate-and-map/unmap...


longer details:

The chain of function calls starts in the initial call to configure
the msi vectors, which eventually calls __pci_enable_msix_range (or
msi_) which then eventually reaches xen_hvm_setup_msi_irqs(), which
either tries to re-use any cached pirq in the MSI data area, or (for
the first time setup) allocates a new pirq from the hypervisor via
PHYSDEVOP_get_free_pirq.  That pirq is then reserved from the
hypervisor's perspective, but it's not mapped to anything in the guest
kernel.

Then, the driver calls request_irq to actually start using the irq,
which calls __setup_irq to irq_startup to startup_pirq.  The
startup_pirq call actually creates the evtchn and binds it to the
previously allocated pirq via EVTCHNOP_bind_pirq.

At this point, the pirq is bound to a guest kernel evtchn (and irq)
and is in use.  But then, when the driver doesn't want it anymore, it
calls free_irq, and that calls irq_shutdown to shutdown_pirq; and that
function closes the evtchn via EVTCHNOP_close.

Inside the hypervisor, in xen/common/event_channel.c in
evtchn_close(), if the channel is type ECS_PIRQ (which our pirq
channel is) then it unmaps the pirq mapping via
unmap_domain_pirq_emuirq.  This unmaps the pirq, but also puts it back
to state IRQ_UNBOUND, which makes it available for the hypervisor to
give away to anyone requesting a new pirq!





>
> -boris
>
>>> The xen_hvm_setup_msi_irqs() function currently checks the pci device's
>>> msi descriptor message data for each msi/msix vector it sets up, and if
>>> it finds the vector was previously configured with a pirq, and that pirq
>>> is mapped to an irq, it re-uses the pirq instead of requesting a new pirq
>>> from the hypervisor.  However, that pirq was unmapped when the pci device
>>> disabled its msi/msix, and it cannot be re-used; it may have been given
>>> to a different pci device.
>> Hm, but this implies that we do keep track of it.
>>
>>
>> while (true)
>> do
>>  rmmod nvme
>>  modprobe nvme
>> done
>>
>> Things go boom without this patch. But with this patch does this
>> still work? As in we don't run out of PIRQs?
>>
>> Thanks.
>>> This exact situation is happening in a Xen guest where multiple NVMe
>>> controllers (pci devices) are present.  The NVMe driver configures each
>>> pci device's msi/msix twice; first to configure a single vector (to
>>> talk to the controller for its configuration info), and then it disables
>>> that msi/msix and re-configures with all the msi/msix it needs.  When
>>> multiple NVMe controllers are present, this happens concurrently on all
>>> of them, and in the time between controller A calling pci_disable_msix()
>>> and then calling pci_enable_msix_range(), controller B enables its msix
>>> and gets controller A's pirq allocated from the hypervisor.  Then when
>>> controller A re-configures its msix, its first vector tries to re-use
>>> the same pirq that it had before; but that pirq was allocated to
>>> controller B, and thus the Xen event channel for controller A's re-used
>>> pirq fails to map its irq to that pirq; the hypervisor already has the
>>> pirq mapped elsewhere.
>>>
>>> Signed-off-by: Dan Streetman <dan.streetman@canonical.com>
>>> ---
>>>  arch/x86/pci/xen.c | 23 +++++++----------------
>>>  1 file changed, 7 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
>>> index bedfab9..a00a6c0 100644
>>> --- a/arch/x86/pci/xen.c
>>> +++ b/arch/x86/pci/xen.c
>>> @@ -234,23 +234,14 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>>              return 1;
>>>
>>>      for_each_pci_msi_entry(msidesc, dev) {
>>> -            __pci_read_msi_msg(msidesc, &msg);
>>> -            pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
>>> -                    ((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
>>> -            if (msg.data != XEN_PIRQ_MSI_DATA ||
>>> -                xen_irq_from_pirq(pirq) < 0) {
>>> -                    pirq = xen_allocate_pirq_msi(dev, msidesc);
>>> -                    if (pirq < 0) {
>>> -                            irq = -ENODEV;
>>> -                            goto error;
>>> -                    }
>>> -                    xen_msi_compose_msg(dev, pirq, &msg);
>>> -                    __pci_write_msi_msg(msidesc, &msg);
>>> -                    dev_dbg(&dev->dev, "xen: msi bound to pirq=%d\n", pirq);
>>> -            } else {
>>> -                    dev_dbg(&dev->dev,
>>> -                            "xen: msi already bound to pirq=%d\n", pirq);
>>> +            pirq = xen_allocate_pirq_msi(dev, msidesc);
>>> +            if (pirq < 0) {
>>> +                    irq = -ENODEV;
>>> +                    goto error;
>>>              }
>>> +            xen_msi_compose_msg(dev, pirq, &msg);
>>> +            __pci_write_msi_msg(msidesc, &msg);
>>> +            dev_dbg(&dev->dev, "xen: msi bound to pirq=%d\n", pirq);
>>>              irq = xen_bind_pirq_msi_to_irq(dev, msidesc, pirq,
>>>                                             (type == PCI_CAP_ID_MSI) ? nvec : 1,
>>>                                             (type == PCI_CAP_ID_MSIX) ?
>>> --
>>> 2.9.3
>>>
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> https://lists.xen.org/xen-devel
