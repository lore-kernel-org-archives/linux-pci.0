Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36448 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbdAKX0l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2017 18:26:41 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1701111032240.8205@sstabellini-ThinkPad-X260>
References: <20170105192856.25559-1-dan.streetman@canonical.com>
 <20170107010651.GV16608@char.us.oracle.com> <42d912c2-596e-29f6-8385-dc82a891895c@oracle.com>
 <CALZtONBNhh9WKPV16+cod-P1Fp2YudTkVzHQZMq81_NEne67pA@mail.gmail.com>
 <20170109155929.GA10991@char.us.oracle.com> <alpine.DEB.2.10.1701091049130.2866@sstabellini-ThinkPad-X260>
 <CALZtONDSD6SF9cd2uftGWsXARF-QiNaBA5zPdnjwQ7j0Z-C76g@mail.gmail.com>
 <CALZtONBJ=kjsKiKtLORxBq3Xn6=SV7+33GAkSi+3cqjs9wVW2g@mail.gmail.com>
 <alpine.DEB.2.10.1701101046270.8205@sstabellini-ThinkPad-X260>
 <CALZtONAuMvFP-GX801k1Cy=ja_65PDWO2ZXfSof-1mGfhV=Pew@mail.gmail.com>
 <alpine.DEB.2.10.1701101710530.8205@sstabellini-ThinkPad-X260>
 <CALZtONBFSicVxo4P-ULHdyhxgsuUmmYcv1zDTp2AoiHqfBwQFw@mail.gmail.com> <alpine.DEB.2.10.1701111032240.8205@sstabellini-ThinkPad-X260>
From: Dan Streetman <ddstreet@ieee.org>
Date: Wed, 11 Jan 2017 18:25:59 -0500
Message-ID: <CALZtONDGNygj5en7hXzoKMA8dxs1fed_FSC9OzPw1ue=kQjD_w@mail.gmail.com>
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

On Wed, Jan 11, 2017 at 1:46 PM, Stefano Stabellini
<sstabellini@kernel.org> wrote:
> On Wed, 11 Jan 2017, Dan Streetman wrote:
>> On Tue, Jan 10, 2017 at 8:25 PM, Stefano Stabellini
>> <sstabellini@kernel.org> wrote:
>> > On Tue, 10 Jan 2017, Dan Streetman wrote:
>> >> On Tue, Jan 10, 2017 at 2:03 PM, Stefano Stabellini
>> >> <sstabellini@kernel.org> wrote:
>> >> > On Tue, 10 Jan 2017, Dan Streetman wrote:
>> >> >> On Tue, Jan 10, 2017 at 10:57 AM, Dan Streetman <ddstreet@ieee.org> wrote:
>> >> >> > On Mon, Jan 9, 2017 at 2:30 PM, Stefano Stabellini
>> >> >> > <sstabellini@kernel.org> wrote:
>> >> >> >> On Mon, 9 Jan 2017, Konrad Rzeszutek Wilk wrote:
>> >> >> >>> On Mon, Jan 09, 2017 at 10:42:41AM -0500, Dan Streetman wrote:
>> >> >> >>> > On Mon, Jan 9, 2017 at 9:59 AM, Boris Ostrovsky
>> >> >> >>> > <boris.ostrovsky@oracle.com> wrote:
>> >> >> >>> > > On 01/06/2017 08:06 PM, Konrad Rzeszutek Wilk wrote:
>> >> >> >>> > >> On Thu, Jan 05, 2017 at 02:28:56PM -0500, Dan Streetman wrote:
>> >> >> >>> > >>> Do not read a pci device's msi message data to see if a pirq was
>> >> >> >>> > >>> previously configured for the device's msi/msix, as the old pirq was
>> >> >> >>> > >>> unmapped and may now be in use by another pci device.  The previous
>> >> >> >>> > >>> pirq should never be re-used; instead a new pirq should always be
>> >> >> >>> > >>> allocated from the hypervisor.
>> >> >> >>> > >> Won't this cause a starvation problem? That is we will run out of PIRQs
>> >> >> >>> > >> as we are not reusing them?
>> >> >> >>> > >
>> >> >> >>> > > Don't we free the pirq when we unmap it?
>> >> >> >>> >
>> >> >> >>> > I think this is actually a bit worse than I initially thought.  After
>> >> >> >>> > looking a bit closer, and I think there's an asymmetry with pirq
>> >> >> >>> > allocation:
>> >> >> >>>
>> >> >> >>> Lets include Stefano,
>> >> >> >>>
>> >> >> >>> Thank you for digging in this! This has quite the deja-vu
>> >> >> >>> feeling as I believe I hit this at some point in the past and
>> >> >> >>> posted some possible ways of fixing this. But sadly I can't
>> >> >> >>> find the thread.
>> >> >> >>
>> >> >> >> This issue seems to be caused by:
>> >> >> >>
>> >> >> >> commit af42b8d12f8adec6711cb824549a0edac6a4ae8f
>> >> >> >> Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>> >> >> >> Date:   Wed Dec 1 14:51:44 2010 +0000
>> >> >> >>
>> >> >> >>     xen: fix MSI setup and teardown for PV on HVM guests
>> >> >> >>
>> >> >> >> which was a fix to a bug:
>> >> >> >>
>> >> >> >>     This fixes a bug in xen_hvm_setup_msi_irqs that manifests itself when
>> >> >> >>     trying to enable the same MSI for the second time: the old MSI to pirq
>> >> >> >>     mapping is still valid at this point but xen_hvm_setup_msi_irqs would
>> >> >> >>     try to assign a new pirq anyway.
>> >> >> >>     A simple way to reproduce this bug is to assign an MSI capable network
>> >> >> >>     card to a PV on HVM guest, if the user brings down the corresponding
>> >> >> >>     ethernet interface and up again, Linux would fail to enable MSIs on the
>> >> >> >>     device.
>> >> >> >>
>> >> >> >> I don't remember any of the details. From the description of this bug,
>> >> >> >> it seems that Xen changed behavior in the past few years: before it used
>> >> >> >> to keep the pirq-MSI mapping, while today it doesn't. If I wrote "the
>> >> >> >> old MSI to pirq mapping is still valid at this point", the pirq couldn't
>> >> >> >> have been completely freed, then reassigned to somebody else the way it
>> >> >> >> is described in this email.
>> >> >> >>
>> >> >> >> I think we should indentify the changeset or Xen version that introduced
>> >> >> >> the new behavior. If it is old enough, we might be able to just revert
>> >> >> >> af42b8d12f8adec6711cb824549a0edac6a4ae8f. Otherwise we could make the
>> >> >> >> behavior conditional to the Xen version.
>> >> >> >
>> >> >> > Are PT devices the only MSI-capable devices available in a Xen guest?
>> >> >> > That's where I'm seeing this problem, with PT NVMe devices.
>> >> >
>> >> > They are the main ones. It is possible to have emulated virtio devices
>> >> > with emulated MSIs, for example virtio-net. Althought they are not in
>> >> > the Xen Project CI-loop, so I wouldn't be surprised if they are broken
>> >> > too.
>> >> >
>> >> >
>> >> >> > I can say that on the Xen guest with NVMe PT devices I'm testing on,
>> >> >> > with the patch from this thread (which essentially reverts your commit
>> >> >> > above) as well as some added debug to see the pirq numbers, cycles of
>> >> >> > 'modprobe nvme ; rmmod nvme' don't cause pirq starvation, as the
>> >> >> > hypervisor provides essentially the same pirqs for each modprobe,
>> >> >> > since they were freed by the rmmod.
>> >> >
>> >> > I am fine with reverting the old patch, but we need to understand what
>> >> > caused the change in behavior first. Maybe somebody else with a Xen PCI
>> >> > passthrough setup at hand can help with that.
>> >> >
>> >> > In the Xen code I can still see:
>> >> >
>> >> >     case ECS_PIRQ: {
>> >> >         struct pirq *pirq = pirq_info(d1, chn1->u.pirq.irq);
>> >> >
>> >> >         if ( !pirq )
>> >> >             break;
>> >> >         if ( !is_hvm_domain(d1) )
>> >> >             pirq_guest_unbind(d1, pirq);
>> >> >
>> >> > which means that pirq_guest_unbind should only be called on evtchn_close
>> >> > if the guest is not an HVM guest.
>> >>
>> >> I tried an experiment to call get_free_pirq on both sides of a
>> >> evtchn_close hcall, using two SRIOV nics.  When I rmmod/modprobe, I
>> >> see something interesting; each nic uses 3 MSIs, and it looks like
>> >> when they shut down, each nic's 3 pirqs are not available until after
>> >> the nic is done shutting down, so it seems like closing the evtchn
>> >> isn't what makes the pirq free.
>> >>
>> >> [3697700.390188] xen:events: creating evtchn using pirq 101 irq 290
>> >> [3697700.390214] xen:events: creating evtchn using pirq 100 irq 291
>> >> [3697700.390228] xen:events: creating evtchn using pirq 99 irq 292
>> >> [3697700.392789] ixgbevf 0000:00:03.0: NIC Link is Up 10 Gbps
>> >> [3697700.406167] xen:events: creating evtchn using pirq 98 irq 293
>> >> [3697700.406222] xen:events: creating evtchn using pirq 97 irq 294
>> >> [3697700.406259] xen:events: creating evtchn using pirq 96 irq 295
>> >> [3697700.408345] ixgbevf 0000:00:04.0: NIC Link is Up 10 Gbps
>> >>
>> >> nic 3 uses pirq 99-101, while nic 4 uses pirq 96-98.
>> >>
>> >> [3697705.470151] xen:events: shutdown_pirq: xen_domain() == 1,
>> >> xen_pv_domain() == 0, xen_hvm_domain() == 1, xen_initial_domain() ==
>> >> 0, xen_pvh_domain() == 0
>> >>
>> >> just to be sure, a bit of dbg so I know what domain this is :-)
>> >>
>> >> [3697778.781463] xen:events: shutdown_pirq: get_free_pirq returned pirq 93
>> >> [3697778.781465] xen:events: shutdown_pirq: closing evtchn for pirq 96 irq 295
>> >> [3697778.781475] xen:events: shutdown_pirq: get_free_pirq returned pirq 92
>> >> [3697778.781489] xen:events: shutdown_pirq: get_free_pirq returned pirq 91
>> >> [3697778.781490] xen:events: shutdown_pirq: closing evtchn for pirq 97 irq 294
>> >> [3697778.781498] xen:events: shutdown_pirq: get_free_pirq returned pirq 90
>> >> [3697778.781508] xen:events: shutdown_pirq: get_free_pirq returned pirq 89
>> >> [3697778.781509] xen:events: shutdown_pirq: closing evtchn for pirq 98 irq 293
>> >> [3697778.781517] xen:events: shutdown_pirq: get_free_pirq returned pirq 88
>> >>
>> >> nic 4 is shutdown first, and closes its evtchns for pirqs 96-98; but
>> >> none of those become available for get_free_pirq.
>> >>
>> >> [3697779.005501] xen:events: shutdown_pirq: get_free_pirq returned pirq 98
>> >>
>> >> aha, now nic 4 has fully finished shutting down, and nic 3 has started
>> >> shutdown; we see those pirqs from nic 4 are now available.  So it must
>> >> not be evtchn closing that frees the pirqs.
>> >>
>> >> [3697779.005503] xen:events: shutdown_pirq: closing evtchn for pirq 99 irq 292
>> >> [3697779.005512] xen:events: shutdown_pirq: get_free_pirq returned pirq 97
>> >> [3697779.005524] xen:events: shutdown_pirq: get_free_pirq returned pirq 96
>> >> [3697779.005526] xen:events: shutdown_pirq: closing evtchn for pirq 100 irq 291
>> >> [3697779.005540] xen:events: shutdown_pirq: get_free_pirq returned pirq 87
>> >> [3697779.005611] xen:events: shutdown_pirq: get_free_pirq returned pirq 86
>> >> [3697779.005624] xen:events: shutdown_pirq: closing evtchn for pirq 101 irq 290
>> >> [3697779.005659] xen:events: shutdown_pirq: get_free_pirq returned pirq 85
>> >>
>> >>
>> >> so, since pci_disable_msix eventually calls xen_teardown_msi_irq()
>> >> which calls xen_destroy_irq(), i moved the dbg to xen_destroy_irq()
>> >> (and recompiled/rebooted) and found the pirqs have already been freed
>> >> before that is called:
>> >>
>> >> [3700084.714686] xen:events: shutdown_pirq: closing evtchn for pirq 98 irq 295
>> >> [3700084.714702] xen:events: shutdown_pirq: closing evtchn for pirq 99 irq 294
>> >> [3700084.714708] xen:events: shutdown_pirq: closing evtchn for pirq 100 irq 293
>> >> [3700084.775598] xen:events: xen_destroy_irq: get_free_pirq returned pirq 100
>> >> [3700084.775599] xen:events: xen_destroy_irq: pirq 100 irq 293
>> >> [3700084.775624] xen:events: xen_destroy_irq: get_free_pirq returned pirq 99
>> >> [3700084.775631] xen:events: xen_destroy_irq: get_free_pirq returned pirq 98
>> >> [3700084.775632] xen:events: xen_destroy_irq: pirq 99 irq 294
>> >> [3700084.775646] xen:events: xen_destroy_irq: get_free_pirq returned pirq 97
>> >> [3700084.775653] xen:events: xen_destroy_irq: get_free_pirq returned pirq 96
>> >> [3700084.775654] xen:events: xen_destroy_irq: pirq 98 irq 295
>> >> [3700084.775666] xen:events: xen_destroy_irq: get_free_pirq returned pirq 95
>> >>
>> >>
>> >> I'm still following thru the kernel code, but it's not immediately
>> >> obvious what exactly is telling the hypervisor to free the pirqs; any
>> >> idea?
>> >>
>> >> >From the hypervisor code, it seems that the pirq is "available" via
>> >> is_free_pirq():
>> >>     return !pirq || (!pirq->arch.irq && (!is_hvm_domain(d) ||
>> >>         pirq->arch.hvm.emuirq == IRQ_UNBOUND));
>> >>
>> >> when the evtchn is closed, it does:
>> >>         if ( is_hvm_domain(d1) && domain_pirq_to_irq(d1, pirq->pirq) > 0 )
>> >>             unmap_domain_pirq_emuirq(d1, pirq->pirq);
>> >>
>> >> and that call to unmap_domain_pirq_emuirq does:
>> >>         info->arch.hvm.emuirq = IRQ_UNBOUND;
>> >>
>> >> so, the only thing left is to clear pirq->arch.irq,but the only place
>> >> I can find that does that is clear_domain_irq_pirq(), which is only
>> >> called from pirq_guest_unbind() and unmap_domain_pirq(), but I'm not
>> >> seeing where either of those would be called when all the kernel is
>> >> doing is disabling a pci device.
>> >
>> > Thanks for the info. I think I know what causes the pirq to be unmapped:
>> > when Linux disables msi or msix on the device, using the regular pci
>> > config space based method, QEMU (which emulates the PCI config space)
>> > tells Xen to unmap the pirq.
>>
>> aha, via a XEN_DOMCTL_unbind_pt_irq, maybe?  Well that makes more sense then.
>>
>> >
>> > If that's the case, and if it isn't possible for xen_hvm_setup_msi_irqs
>> > to be called a second time without msis being disabled first, then I
>> > think we can revert the patch.
>>
>> It doesn't seem possible to call it twice from a correctly-behaved
>> driver, but in case of a driver bug that does try to enable msi/msix
>> multiple times without disabling, __pci_enable_msix() only does
>> WARN_ON(!!dev->msix_enabled), and __pci_enable_msi_range() only does
>> WARN_ON(!!dev->msi_enabled); they both will continue.  Maybe that
>> should be changed to warn and also return error, to prevent
>> re-configuring msi/msix if already configured?  Or, maybe the warning
>> is enough - the worst thing that reverting the patch does is use extra
>> pirqs, right?
>
> I think the warning is enough.  Can you confirm that with
> af42b8d12f8adec6711cb824549a0edac6a4ae8f reverted, also
>
> ifconfig eth0 down; ifconfig eth0 up
>
> still work as expected, no warnings?

yes, with the patch that started this thread - which essentially
reverts af42b8d12f8adec6711cb824549a0edac6a4ae8f - there are no
warnings and ifconfig down ; ifconfig up work as expected.

>
>
> It looks like the patch that changed hypervisor (QEMU actually) behavior
> is:
>
> commit c976437c7dba9c7444fb41df45468968aaa326ad
> Author: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Date:   Wed May 7 13:41:48 2014 +0000
>
>     qemu-xen: free all the pirqs for msi/msix when driver unload
>
> From this commit onward, QEMU started unmapping pirqs when MSIs are
> disabled. c976437c7dba9c7444fb41df45468968aaa326ad is present in 4.8,
> 4.7, 4.6, 4.5. The newest release without the commit is Xen 4.4.
>
> If we revert af42b8d12f8adec6711cb824549a0edac6a4ae8f, we fix the bug on
> all Xen versions from 4.5 onward, but we break the behavior on Xen 4.4
> and older. Given that Xen 4.4 is out of support, I think we should go
> ahead with it.  Opinions?
