Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60551 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab2K2ImK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2012 03:42:10 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so6100429bkw.19
        for <linux-pci@vger.kernel.org>; Thu, 29 Nov 2012 00:42:09 -0800 (PST)
Message-ID: <A5D6C5E3D7774E62AA482C886483DA6D@alyakaslap>
From: "Alex Lyakas" <alex@zadarastorage.com>
To: "Alex Williamson" <alex.williamson@redhat.com>
Cc: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Yair Hershko" <yair@zadarastorage.com>,
	"Shyam Kaushik" <shyam@zadarastorage.com>
References: <190FFE9600054603A543CCDA4408AC89@alyakaslap> <CAOcd+r28ot-060WQhUPkuM1Bt7t-_jOggAZKNSJxurNYVs2b-w@mail.gmail.com> <1353536723.1809.4.camel@bling.home> <F764A8A9BBE247FEA862ED33F77A04A1@alyakaslap> <1353960253.1809.128.camel@bling.home>
In-Reply-To: <1353960253.1809.128.camel@bling.home>
Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL
Date: Thu, 29 Nov 2012 10:42:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,
did I understand correctly that "vector" value with which the call to 
request_threaded_irq() is made is *not* supposed to be zero? Because in my 
case, it is always zero, and still the failure I observe is not happening 
always. Usually, 3 unique (non-zero) IRQ numbers are assigned to each 
attached PCI device of each KVM VM.
I will try to repro this like you suggested and let you know.

Thanks for your help,
Alex.


-----Original Message----- 
From: Alex Williamson
Sent: 26 November, 2012 10:04 PM
To: Alex Lyakas
Cc: kvm@vger.kernel.org
Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL

On Thu, 2012-11-22 at 10:52 +0200, Alex Lyakas wrote:
> Hi Alex,
> thanks for your response.
>
> I printed out the "vector" and "entry" values of dev->host_msix_entries[i]
> within assigned_device_enable_host_msix() before call to
> request_threaded_irq(). I see that they are all 0s:
> kernel: [ 3332.610980] kvm-8095: KVM_ASSIGN_DEV_IRQ assigned_dev_id=924
> kernel: [ 3332.610985] kvm-8095: assigned_device_enable_host_msix()
> assigned_dev_id=924 #0: [v=0 e=0]
> kernel: [ 3332.610989] kvm-8095: assigned_device_enable_host_msix()
> assigned_dev_id=924 #1: [v=0 e=1]
> kernel: [ 3332.610992] kvm-8095: assigned_device_enable_host_msix()
> assigned_dev_id=924 #2: [v=0 e=2]
>
> So I don't really understand how they all ask for irq=0; I must be missing
> something. Is there any other explanation of request_threaded_irq() to
> return EBUSY? From the code I don't see that there is.

The vectors all being zero sounds like an indication that
pci_enable_msix() didn't actually work.  Each of those should be a
unique vector.   Does booting the host with "nointremap" perhaps make a
difference?  Maybe we can isolate the problem to the interrupt remapper
code.

> This issue is reproducible and is not going to go away by itself. Working
> around it is also problematic. We thought to check whether all IRQs are
> properly attached after QEMU sets the vm state to "running". However, vm
> state is set to "running" before IRQ attachments are performed; we 
> debugged
> this and found out that they are done from a different thread, from a 
> stack
> trace like this:
> kvm_assign_irq()
> assigned_dev_update_msix()
> assigned_dev_pci_write_config()
> pci_host_config_write_common()
> pci_data_write()
> pci_host_data_write()
> memory_region_write_accessor()
> access_with_adjusted_size()
> memory_region_iorange_write()
> ioport_writew_thunk()
> ioport_write()
> cpu_outw()
> kvm_handle_io()
> kvm_cpu_exec()
> qemu_kvm_cpu_thread_fn()
>
> So looks like this is performed on-demand (on first IO), so no reliable
> point to check that IRQs are attached properly.

Correct, MSI-X is setup when the guest enables MSI-X on the device,
which is likely a long way into guest boot.  There's no guarantee that
the guest ever enables MSI-X, so there's no association to whether the
guest is "running".

>  Another issue that in KVM
> code the return value of pci_host_config_write_common() is not checked, so
> there is no way to report a failure.

A common problem in qemu, imho

> Is there any way you think you can help me debug this further?

It seems like pci_enable_msix is still failing, but perhaps silently
without irqbalance.  We need to figure out where and why.  Isolating it
to the interrupt remapper with "nointremap" might give us some clues
(this is an Intel VT-d system, right?).  Thanks,

Alex


> -----Original Message----- 
> From: Alex Williamson
> Sent: 22 November, 2012 12:25 AM
> To: Alex Lyakas
> Cc: kvm@vger.kernel.org
> Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL
>
> On Wed, 2012-11-21 at 16:19 +0200, Alex Lyakas wrote:
> > Hi,
> > I was advised to turn off irqbalance and reproduced this issue, but
> > the failure is in a different place now. Now request_threaded_irq()
> > fails with EBUSY.
> > According to the code, this can only happen on the path:
> > request_threaded_irq() -> __setup_irq()
> > Now in setup irq, the only place where EBUSY can show up for us is here:
> > ...
> > raw_spin_lock_irqsave(&desc->lock, flags);
> > old_ptr = &desc->action;
> > old = *old_ptr;
> > if (old) {
> > /*
> > * Can't share interrupts unless both agree to and are
> > * the same type (level, edge, polarity). So both flag
> > * fields must have IRQF_SHARED set and the bits which
> > * set the trigger type must match. Also all must
> > * agree on ONESHOT.
> > */
> > if (!((old->flags & new->flags) & IRQF_SHARED) ||
> >     ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK) ||
> >     ((old->flags ^ new->flags) & IRQF_ONESHOT)) {
> > old_name = old->name;
> > goto mismatch;
> > }
> >
> > /* All handlers must agree on per-cpuness */
> > if ((old->flags & IRQF_PERCPU) !=
> >     (new->flags & IRQF_PERCPU))
> > goto mismatch;
> >
> > KVM calls request_threaded_irq() with flags==0, so can it be that
> > different KVM processes request the same IRQ?
>
> Shouldn't be possible, irqs are allocated from a bitmap protected by a
> mutex, see __irq_alloc_descs
>
> >  How different KVM
> > processes spawned simultaneously agree between them on IRQ numbers?
>
> They don't, MSI/X vectors are not currently share-able.  Can you show
> that you're actually getting duplicate irq vectors?  Thanks,
>
> Alex
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



