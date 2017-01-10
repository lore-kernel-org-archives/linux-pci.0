Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35952 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdAJVdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2017 16:33:01 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1701101046270.8205@sstabellini-ThinkPad-X260>
References: <20170105192856.25559-1-dan.streetman@canonical.com>
 <20170107010651.GV16608@char.us.oracle.com> <42d912c2-596e-29f6-8385-dc82a891895c@oracle.com>
 <CALZtONBNhh9WKPV16+cod-P1Fp2YudTkVzHQZMq81_NEne67pA@mail.gmail.com>
 <20170109155929.GA10991@char.us.oracle.com> <alpine.DEB.2.10.1701091049130.2866@sstabellini-ThinkPad-X260>
 <CALZtONDSD6SF9cd2uftGWsXARF-QiNaBA5zPdnjwQ7j0Z-C76g@mail.gmail.com>
 <CALZtONBJ=kjsKiKtLORxBq3Xn6=SV7+33GAkSi+3cqjs9wVW2g@mail.gmail.com> <alpine.DEB.2.10.1701101046270.8205@sstabellini-ThinkPad-X260>
From: Dan Streetman <ddstreet@ieee.org>
Date: Tue, 10 Jan 2017 16:32:19 -0500
Message-ID: <CALZtONAuMvFP-GX801k1Cy=ja_65PDWO2ZXfSof-1mGfhV=Pew@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] xen: do not re-use pirq number cached in pci
 device msi msg data
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Streetman <dan.streetman@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 10, 2017 at 2:03 PM, Stefano Stabellini
<sstabellini@kernel.org> wrote:
> On Tue, 10 Jan 2017, Dan Streetman wrote:
>> On Tue, Jan 10, 2017 at 10:57 AM, Dan Streetman <ddstreet@ieee.org> wrote:
>> > On Mon, Jan 9, 2017 at 2:30 PM, Stefano Stabellini
>> > <sstabellini@kernel.org> wrote:
>> >> On Mon, 9 Jan 2017, Konrad Rzeszutek Wilk wrote:
>> >>> On Mon, Jan 09, 2017 at 10:42:41AM -0500, Dan Streetman wrote:
>> >>> > On Mon, Jan 9, 2017 at 9:59 AM, Boris Ostrovsky
>> >>> > <boris.ostrovsky@oracle.com> wrote:
>> >>> > > On 01/06/2017 08:06 PM, Konrad Rzeszutek Wilk wrote:
>> >>> > >> On Thu, Jan 05, 2017 at 02:28:56PM -0500, Dan Streetman wrote:
>> >>> > >>> Do not read a pci device's msi message data to see if a pirq was
>> >>> > >>> previously configured for the device's msi/msix, as the old pirq was
>> >>> > >>> unmapped and may now be in use by another pci device.  The previous
>> >>> > >>> pirq should never be re-used; instead a new pirq should always be
>> >>> > >>> allocated from the hypervisor.
>> >>> > >> Won't this cause a starvation problem? That is we will run out of PIRQs
>> >>> > >> as we are not reusing them?
>> >>> > >
>> >>> > > Don't we free the pirq when we unmap it?
>> >>> >
>> >>> > I think this is actually a bit worse than I initially thought.  After
>> >>> > looking a bit closer, and I think there's an asymmetry with pirq
>> >>> > allocation:
>> >>>
>> >>> Lets include Stefano,
>> >>>
>> >>> Thank you for digging in this! This has quite the deja-vu
>> >>> feeling as I believe I hit this at some point in the past and
>> >>> posted some possible ways of fixing this. But sadly I can't
>> >>> find the thread.
>> >>
>> >> This issue seems to be caused by:
>> >>
>> >> commit af42b8d12f8adec6711cb824549a0edac6a4ae8f
>> >> Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>> >> Date:   Wed Dec 1 14:51:44 2010 +0000
>> >>
>> >>     xen: fix MSI setup and teardown for PV on HVM guests
>> >>
>> >> which was a fix to a bug:
>> >>
>> >>     This fixes a bug in xen_hvm_setup_msi_irqs that manifests itself when
>> >>     trying to enable the same MSI for the second time: the old MSI to pirq
>> >>     mapping is still valid at this point but xen_hvm_setup_msi_irqs would
>> >>     try to assign a new pirq anyway.
>> >>     A simple way to reproduce this bug is to assign an MSI capable network
>> >>     card to a PV on HVM guest, if the user brings down the corresponding
>> >>     ethernet interface and up again, Linux would fail to enable MSIs on the
>> >>     device.
>> >>
>> >> I don't remember any of the details. From the description of this bug,
>> >> it seems that Xen changed behavior in the past few years: before it used
>> >> to keep the pirq-MSI mapping, while today it doesn't. If I wrote "the
>> >> old MSI to pirq mapping is still valid at this point", the pirq couldn't
>> >> have been completely freed, then reassigned to somebody else the way it
>> >> is described in this email.
>> >>
>> >> I think we should indentify the changeset or Xen version that introduced
>> >> the new behavior. If it is old enough, we might be able to just revert
>> >> af42b8d12f8adec6711cb824549a0edac6a4ae8f. Otherwise we could make the
>> >> behavior conditional to the Xen version.
>> >
>> > Are PT devices the only MSI-capable devices available in a Xen guest?
>> > That's where I'm seeing this problem, with PT NVMe devices.
>
> They are the main ones. It is possible to have emulated virtio devices
> with emulated MSIs, for example virtio-net. Althought they are not in
> the Xen Project CI-loop, so I wouldn't be surprised if they are broken
> too.
>
>
>> > I can say that on the Xen guest with NVMe PT devices I'm testing on,
>> > with the patch from this thread (which essentially reverts your commit
>> > above) as well as some added debug to see the pirq numbers, cycles of
>> > 'modprobe nvme ; rmmod nvme' don't cause pirq starvation, as the
>> > hypervisor provides essentially the same pirqs for each modprobe,
>> > since they were freed by the rmmod.
>
> I am fine with reverting the old patch, but we need to understand what
> caused the change in behavior first. Maybe somebody else with a Xen PCI
> passthrough setup at hand can help with that.
>
> In the Xen code I can still see:
>
>     case ECS_PIRQ: {
>         struct pirq *pirq = pirq_info(d1, chn1->u.pirq.irq);
>
>         if ( !pirq )
>             break;
>         if ( !is_hvm_domain(d1) )
>             pirq_guest_unbind(d1, pirq);
>
> which means that pirq_guest_unbind should only be called on evtchn_close
> if the guest is not an HVM guest.

I tried an experiment to call get_free_pirq on both sides of a
evtchn_close hcall, using two SRIOV nics.  When I rmmod/modprobe, I
see something interesting; each nic uses 3 MSIs, and it looks like
when they shut down, each nic's 3 pirqs are not available until after
the nic is done shutting down, so it seems like closing the evtchn
isn't what makes the pirq free.

[3697700.390188] xen:events: creating evtchn using pirq 101 irq 290
[3697700.390214] xen:events: creating evtchn using pirq 100 irq 291
[3697700.390228] xen:events: creating evtchn using pirq 99 irq 292
[3697700.392789] ixgbevf 0000:00:03.0: NIC Link is Up 10 Gbps
[3697700.406167] xen:events: creating evtchn using pirq 98 irq 293
[3697700.406222] xen:events: creating evtchn using pirq 97 irq 294
[3697700.406259] xen:events: creating evtchn using pirq 96 irq 295
[3697700.408345] ixgbevf 0000:00:04.0: NIC Link is Up 10 Gbps

nic 3 uses pirq 99-101, while nic 4 uses pirq 96-98.

[3697705.470151] xen:events: shutdown_pirq: xen_domain() == 1,
xen_pv_domain() == 0, xen_hvm_domain() == 1, xen_initial_domain() ==
0, xen_pvh_domain() == 0

just to be sure, a bit of dbg so I know what domain this is :-)

[3697778.781463] xen:events: shutdown_pirq: get_free_pirq returned pirq 93
[3697778.781465] xen:events: shutdown_pirq: closing evtchn for pirq 96 irq 295
[3697778.781475] xen:events: shutdown_pirq: get_free_pirq returned pirq 92
[3697778.781489] xen:events: shutdown_pirq: get_free_pirq returned pirq 91
[3697778.781490] xen:events: shutdown_pirq: closing evtchn for pirq 97 irq 294
[3697778.781498] xen:events: shutdown_pirq: get_free_pirq returned pirq 90
[3697778.781508] xen:events: shutdown_pirq: get_free_pirq returned pirq 89
[3697778.781509] xen:events: shutdown_pirq: closing evtchn for pirq 98 irq 293
[3697778.781517] xen:events: shutdown_pirq: get_free_pirq returned pirq 88

nic 4 is shutdown first, and closes its evtchns for pirqs 96-98; but
none of those become available for get_free_pirq.

[3697779.005501] xen:events: shutdown_pirq: get_free_pirq returned pirq 98

aha, now nic 4 has fully finished shutting down, and nic 3 has started
shutdown; we see those pirqs from nic 4 are now available.  So it must
not be evtchn closing that frees the pirqs.

[3697779.005503] xen:events: shutdown_pirq: closing evtchn for pirq 99 irq 292
[3697779.005512] xen:events: shutdown_pirq: get_free_pirq returned pirq 97
[3697779.005524] xen:events: shutdown_pirq: get_free_pirq returned pirq 96
[3697779.005526] xen:events: shutdown_pirq: closing evtchn for pirq 100 irq 291
[3697779.005540] xen:events: shutdown_pirq: get_free_pirq returned pirq 87
[3697779.005611] xen:events: shutdown_pirq: get_free_pirq returned pirq 86
[3697779.005624] xen:events: shutdown_pirq: closing evtchn for pirq 101 irq 290
[3697779.005659] xen:events: shutdown_pirq: get_free_pirq returned pirq 85


so, since pci_disable_msix eventually calls xen_teardown_msi_irq()
which calls xen_destroy_irq(), i moved the dbg to xen_destroy_irq()
(and recompiled/rebooted) and found the pirqs have already been freed
before that is called:

[3700084.714686] xen:events: shutdown_pirq: closing evtchn for pirq 98 irq 295
[3700084.714702] xen:events: shutdown_pirq: closing evtchn for pirq 99 irq 294
[3700084.714708] xen:events: shutdown_pirq: closing evtchn for pirq 100 irq 293
[3700084.775598] xen:events: xen_destroy_irq: get_free_pirq returned pirq 100
[3700084.775599] xen:events: xen_destroy_irq: pirq 100 irq 293
[3700084.775624] xen:events: xen_destroy_irq: get_free_pirq returned pirq 99
[3700084.775631] xen:events: xen_destroy_irq: get_free_pirq returned pirq 98
[3700084.775632] xen:events: xen_destroy_irq: pirq 99 irq 294
[3700084.775646] xen:events: xen_destroy_irq: get_free_pirq returned pirq 97
[3700084.775653] xen:events: xen_destroy_irq: get_free_pirq returned pirq 96
[3700084.775654] xen:events: xen_destroy_irq: pirq 98 irq 295
[3700084.775666] xen:events: xen_destroy_irq: get_free_pirq returned pirq 95


I'm still following thru the kernel code, but it's not immediately
obvious what exactly is telling the hypervisor to free the pirqs; any
idea?

>From the hypervisor code, it seems that the pirq is "available" via
is_free_pirq():
    return !pirq || (!pirq->arch.irq && (!is_hvm_domain(d) ||
        pirq->arch.hvm.emuirq == IRQ_UNBOUND));

when the evtchn is closed, it does:
        if ( is_hvm_domain(d1) && domain_pirq_to_irq(d1, pirq->pirq) > 0 )
            unmap_domain_pirq_emuirq(d1, pirq->pirq);

and that call to unmap_domain_pirq_emuirq does:
        info->arch.hvm.emuirq = IRQ_UNBOUND;

so, the only thing left is to clear pirq->arch.irq,but the only place
I can find that does that is clear_domain_irq_pirq(), which is only
called from pirq_guest_unbind() and unmap_domain_pirq(), but I'm not
seeing where either of those would be called when all the kernel is
doing is disabling a pci device.







>
>
>> >>> > tl;dr:
>> >>> >
>> >>> > pci_enable_msix_range() -> each MSIX (or MSI) now has a pirq
>> >>> > allocated, and reserved in the hypervisor
>> >>> >
>> >>> > request_irq() -> an event channel is opened for the specific pirq, and
>> >>> > maps the pirq with the hypervisor
>> >>> >
>> >>> > free_irq() -> the event channel is closed, and the pirq is unmapped,
>> >>> > but that unmap function also frees the pirq!  The hypervisor can/will
>> >>> > give it away to the next call to get_free_pirq.  However, the pci
>> >>> > msi/msix data area still contains the pirq number, and the next call
>> >>> > to request_irq() will re-use the pirq.
>> >>> >
>> >>> > pci_disable_msix() -> this has no effect on the pirq in the hypervisor
>> >>> > (it's already been freed), and it also doesn't clear anything from the
>> >>> > msi/msix data area, so the pirq is still cached there.
>> >>> >
>> >>> >
>> >>> > It seems like the hypervisor needs to be fixed to *not* unmap the pirq
>> >>> > when the event channel is closed - or at least, not to change it to
>> >>> > IRQ_UNBOUND state?  And, the pci_disable_msix call should eventually
>> >>> > call into something in the Xen guest kernel that actually does the
>> >>> > pirq unmapping, and clear it from the msi data area (i.e.
>> >>> > pci_write_msi_msg)
>> >>>
>> >>> The problem is that Xen changes have sailed a long long time ago.
>> >>> >
>> >>> > Alternately, if the hypervisor doesn't change, then the call into the
>> >>> > hypervisor to actually allocate a pirq needs to move from the
>> >>> > pci_enable_msix_range() call to the request_irq() call?  So that when
>> >>> > the msi/msix range is enabled, it doesn't actually reserve any pirq's
>> >>> > for any of the vectors; each request_irq/free_irq pair do the pirq
>> >>> > allocate-and-map/unmap...
>> >>>
>> >>>
>> >>> Or a third one: We keep an pirq->device lookup and inhibit free_irq()
>> >>> from actually calling evtchn_close() until the pci_disable_msix() is done?
>> >>
>> >> I think that's a reasonable alternative: we mask the evtchn, but do not
>> >> call xen_evtchn_close in shutdown_pirq for PV on HVM guests.
>> >> Something like (not compiled, untested):
>> >>
>> >> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
>> >> index 137bd0e..3174923 100644
>> >> --- a/drivers/xen/events/events_base.c
>> >> +++ b/drivers/xen/events/events_base.c
>> >> @@ -577,7 +577,8 @@ static void shutdown_pirq(struct irq_data *data)
>> >>                 return;
>> >>
>> >>         mask_evtchn(evtchn);
>> >> -       xen_evtchn_close(evtchn);
>> >> +       if (!xen_hvm_domain())
>> >> +               xen_evtchn_close(evtchn);
>> >
>> > wouldn't we need to also add code to the pci_disable_msix path that
>> > would actually close the evtchn?  Would this leave the evtchn around
>> > forever?
>> >
>> >>         xen_irq_info_cleanup(info);
>> >>  }
>> >>
>> >>
>> >> We want to keep the pirq allocated to the device - not closing the
>> >> evtchn seems like the right thing to do. I suggest we test for the
>> >> original bug too: enable/disable the network interface of an MSI capable
>> >> network card.
>> >
>> > I don't have a Xen hypervisor setup myself, I'm just using AWS, but
>> > I'll try to test this on an instance with a SRIOV/PT nic.
>>
>> I started an instance with SRIOV nics, with the latest upstream kernel
>> plus this patch and debug to show the pirqs.  Taking an interface down
>> and back up uses the same pirq, because the driver only does
>> free_irq/request_irq, which just closes/reopens the evtchn using the
>> same pirq (which is cached in the struct irq_info) - it doesn't
>> disable/reenable the MSIX vectors.  Doing a complete rmmod/modprobe of
>> the driver does disable and reenable the MSIX vectors, but the
>> hypervisor provides the same pirqs from the get_free_pirq() call that
>> were used before (since nothing else is asking for free pirqs).
>
> Good! Thanks for testing, it's very helpful. I believe it should work
> even if the hypervisor returned a different pirq though.
>
>
>> >>> > longer details:
>> >>> >
>> >>> > The chain of function calls starts in the initial call to configure
>> >>> > the msi vectors, which eventually calls __pci_enable_msix_range (or
>> >>> > msi_) which then eventually reaches xen_hvm_setup_msi_irqs(), which
>> >>> > either tries to re-use any cached pirq in the MSI data area, or (for
>> >>> > the first time setup) allocates a new pirq from the hypervisor via
>> >>> > PHYSDEVOP_get_free_pirq.  That pirq is then reserved from the
>> >>> > hypervisor's perspective, but it's not mapped to anything in the guest
>> >>> > kernel.
>> >>> >
>> >>> > Then, the driver calls request_irq to actually start using the irq,
>> >>> > which calls __setup_irq to irq_startup to startup_pirq.  The
>> >>> > startup_pirq call actually creates the evtchn and binds it to the
>> >>> > previously allocated pirq via EVTCHNOP_bind_pirq.
>> >>> >
>> >>> > At this point, the pirq is bound to a guest kernel evtchn (and irq)
>> >>> > and is in use.  But then, when the driver doesn't want it anymore, it
>> >>> > calls free_irq, and that calls irq_shutdown to shutdown_pirq; and that
>> >>> > function closes the evtchn via EVTCHNOP_close.
>> >>> >
>> >>> > Inside the hypervisor, in xen/common/event_channel.c in
>> >>> > evtchn_close(), if the channel is type ECS_PIRQ (which our pirq
>> >>> > channel is) then it unmaps the pirq mapping via
>> >>> > unmap_domain_pirq_emuirq.  This unmaps the pirq, but also puts it back
>> >>> > to state IRQ_UNBOUND, which makes it available for the hypervisor to
>> >>> > give away to anyone requesting a new pirq!
>> >>> >
>> >>> >
>> >>> >
>> >>> >
>> >>> >
>> >>> > >
>> >>> > > -boris
>> >>> > >
>> >>> > >>> The xen_hvm_setup_msi_irqs() function currently checks the pci device's
>> >>> > >>> msi descriptor message data for each msi/msix vector it sets up, and if
>> >>> > >>> it finds the vector was previously configured with a pirq, and that pirq
>> >>> > >>> is mapped to an irq, it re-uses the pirq instead of requesting a new pirq
>> >>> > >>> from the hypervisor.  However, that pirq was unmapped when the pci device
>> >>> > >>> disabled its msi/msix, and it cannot be re-used; it may have been given
>> >>> > >>> to a different pci device.
>> >>> > >> Hm, but this implies that we do keep track of it.
>> >>> > >>
>> >>> > >>
>> >>> > >> while (true)
>> >>> > >> do
>> >>> > >>  rmmod nvme
>> >>> > >>  modprobe nvme
>> >>> > >> done
>> >>> > >>
>> >>> > >> Things go boom without this patch. But with this patch does this
>> >>> > >> still work? As in we don't run out of PIRQs?
>> >>> > >>
>> >>> > >> Thanks.
>> >>> > >>> This exact situation is happening in a Xen guest where multiple NVMe
>> >>> > >>> controllers (pci devices) are present.  The NVMe driver configures each
>> >>> > >>> pci device's msi/msix twice; first to configure a single vector (to
>> >>> > >>> talk to the controller for its configuration info), and then it disables
>> >>> > >>> that msi/msix and re-configures with all the msi/msix it needs.  When
>> >>> > >>> multiple NVMe controllers are present, this happens concurrently on all
>> >>> > >>> of them, and in the time between controller A calling pci_disable_msix()
>> >>> > >>> and then calling pci_enable_msix_range(), controller B enables its msix
>> >>> > >>> and gets controller A's pirq allocated from the hypervisor.  Then when
>> >>> > >>> controller A re-configures its msix, its first vector tries to re-use
>> >>> > >>> the same pirq that it had before; but that pirq was allocated to
>> >>> > >>> controller B, and thus the Xen event channel for controller A's re-used
>> >>> > >>> pirq fails to map its irq to that pirq; the hypervisor already has the
>> >>> > >>> pirq mapped elsewhere.
>> >>> > >>>
>> >>> > >>> Signed-off-by: Dan Streetman <dan.streetman@canonical.com>
>> >>> > >>> ---
>> >>> > >>>  arch/x86/pci/xen.c | 23 +++++++----------------
>> >>> > >>>  1 file changed, 7 insertions(+), 16 deletions(-)
>> >>> > >>>
>> >>> > >>> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
>> >>> > >>> index bedfab9..a00a6c0 100644
>> >>> > >>> --- a/arch/x86/pci/xen.c
>> >>> > >>> +++ b/arch/x86/pci/xen.c
>> >>> > >>> @@ -234,23 +234,14 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>> >>> > >>>              return 1;
>> >>> > >>>
>> >>> > >>>      for_each_pci_msi_entry(msidesc, dev) {
>> >>> > >>> -            __pci_read_msi_msg(msidesc, &msg);
>> >>> > >>> -            pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
>> >>> > >>> -                    ((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
>> >>> > >>> -            if (msg.data != XEN_PIRQ_MSI_DATA ||
>> >>> > >>> -                xen_irq_from_pirq(pirq) < 0) {
>> >>> > >>> -                    pirq = xen_allocate_pirq_msi(dev, msidesc);
>> >>> > >>> -                    if (pirq < 0) {
>> >>> > >>> -                            irq = -ENODEV;
>> >>> > >>> -                            goto error;
>> >>> > >>> -                    }
>> >>> > >>> -                    xen_msi_compose_msg(dev, pirq, &msg);
>> >>> > >>> -                    __pci_write_msi_msg(msidesc, &msg);
>> >>> > >>> -                    dev_dbg(&dev->dev, "xen: msi bound to pirq=%d\n", pirq);
>> >>> > >>> -            } else {
>> >>> > >>> -                    dev_dbg(&dev->dev,
>> >>> > >>> -                            "xen: msi already bound to pirq=%d\n", pirq);
>> >>> > >>> +            pirq = xen_allocate_pirq_msi(dev, msidesc);
>> >>> > >>> +            if (pirq < 0) {
>> >>> > >>> +                    irq = -ENODEV;
>> >>> > >>> +                    goto error;
>> >>> > >>>              }
>> >>> > >>> +            xen_msi_compose_msg(dev, pirq, &msg);
>> >>> > >>> +            __pci_write_msi_msg(msidesc, &msg);
>> >>> > >>> +            dev_dbg(&dev->dev, "xen: msi bound to pirq=%d\n", pirq);
>> >>> > >>>              irq = xen_bind_pirq_msi_to_irq(dev, msidesc, pirq,
>> >>> > >>>                                             (type == PCI_CAP_ID_MSI) ? nvec : 1,
>> >>> > >>>                                             (type == PCI_CAP_ID_MSIX) ?
>> >>> > >>> --
>> >>> > >>> 2.9.3
>> >>> > >>>
>> >>> > >
>> >>> > >
>> >>> > > _______________________________________________
>> >>> > > Xen-devel mailing list
>> >>> > > Xen-devel@lists.xen.org
>> >>> > > https://lists.xen.org/xen-devel
>> >>>
>>
