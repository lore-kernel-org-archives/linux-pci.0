Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab2LJUp7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Dec 2012 15:45:59 -0500
Message-ID: <1355172358.3224.157.camel@bling.home>
Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL
From: Alex Williamson <alex.williamson@redhat.com>
To: Alex Lyakas <alex@zadarastorage.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	Yair Hershko <yair@zadarastorage.com>,
	Shyam Kaushik <shyam@zadarastorage.com>
Date: Mon, 10 Dec 2012 13:45:58 -0700
In-Reply-To: <9C253052ADFC40D9A0BC9979549506A6@alyakaslap>
References: <190FFE9600054603A543CCDA4408AC89@alyakaslap>
	 <CAOcd+r28ot-060WQhUPkuM1Bt7t-_jOggAZKNSJxurNYVs2b-w@mail.gmail.com>
	 <1353536723.1809.4.camel@bling.home>
	 <F764A8A9BBE247FEA862ED33F77A04A1@alyakaslap>
	 <1353960253.1809.128.camel@bling.home>
	 <A5D6C5E3D7774E62AA482C886483DA6D@alyakaslap>
	 <1354204570.14547.14.camel@ul30vt.home>
	 <9C253052ADFC40D9A0BC9979549506A6@alyakaslap>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2012-12-08 at 14:14 +0200, Alex Lyakas wrote:
> Hi Alex,
> first of all, I apologize for not reporting things properly. The "vector" 
> values that I see passed to request_threaded_irq() are not zeros. They are 
> unique IRQ values as you mentioned. I do not, however, see the 
> disabling-and-reenabling sequence as you wrote.

The disabling-reenabling is an artifact of the new code to handle
runtime vector updates, which enables CPU affinity of vectors and guests
that behave slightly different, like FreeBSD.  This is a good reminder
that you're running an old version of qemu and should probably update to
the latest release for debugging.

>  The usual sequence for me is 
> calling KVM_ASSIGN_DEV_IRQ twice for the same assigned_dev-id:
> 
> [ 2423.990404] kvm-32353: KVM_ASSIGN_DEV_IRQ assigned_dev_id=946
> [ 2423.991585] kvm-32353: assigned_device_enable_host_msix(): call 
> request_threaded_irq() assigned_dev_id=946 #0: [v=158 e=0]
> [ 2423.991810] kvm-32353: assigned_device_enable_host_msix(): call 
> request_threaded_irq() assigned_dev_id=946 #1: [v=159 e=1]
> [ 2423.991869] kvm-32353: assigned_device_enable_host_msix(): call 
> request_threaded_irq() assigned_dev_id=946 #2: [v=160 e=2]
> [ 2424.054320] kvm-32353: KVM_ASSIGN_DEV_IRQ assigned_dev_id=946
> [ 2424.055337] kvm-32353: assigned_device_enable_host_msix(): call 
> request_threaded_irq() assigned_dev_id=946 #0: [v=158 e=0]
> [ 2424.055516] kvm-32353: assigned_device_enable_host_msix(): call 
> request_threaded_irq() assigned_dev_id=946 #1: [v=159 e=1]
> [ 2424.055673] kvm-32353: assigned_device_enable_host_msix(): call 
> request_threaded_irq() assigned_dev_id=946 #2: [v=160 e=2]
> 
> As you requested, I specified the intremap=off option to the kernel (saw 
> that nointremap is deprecated), and reproduced. I had to set the 
> allow_unsafe_assigned_interrupts parameter of kvm.ko module.

Yep, sorry I forgot to mention that.  What kernel are you trying all of
this on?  If it's not a recent upstream kernel, please verify on that.

> With irqbalance running, I saw that pci_enable_msix() does not report 
> failure, but does not set up the interrupt verctor, and further call to 
> request_threaded_irq() fails with EBUSY:
> 
> [ 2425.292444] kvm-32353: KVM_ASSIGN_DEV_IRQ assigned_dev_id=913
> [ 2425.292458] kvm-32353: assigned_device_enable_host_msix(): call 
> request_threaded_irq() assigned_dev_id=913 #0: [v=0 e=0]
> [ 2425.292753] kvm-32353: assigned_device_enable_host_msix() 
> request_threaded_irq(vector=0) failed assigned_dev_id=913 
> irq_name=kvm:0000:03:12.1 err=-16
> Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.294434] kvm-32353: 
> KVM_ASSIGN_DEV_IRQ assigned_dev_id=913 r=-16
> 
> Then I turned irqbalance off, and reproduced again; this time 
> pci_enable_msix() returns EINVAL (-22). I printed out the vector numbers 
> after pci_enable_msix() failure, and they are all zeros:
> 
> [151186.446688] kvm-1923: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918
> [151186.446705] kvm-1923: assigned_device_enable_host_msix() 
> pci_enable_msix() failed assigned_dev_id=918 irq_name=kvm:0000:03:12.6 
> err=-22
> [151186.484409] kvm-1923: assigned_device_enable_host_msix() 
> assigned_dev_id=918 #0: [v=0 e=0]
> [151186.484413] kvm-1923: assigned_device_enable_host_msix() 
> assigned_dev_id=918 #1: [v=0 e=1]
> [151186.484416] kvm-1923: assigned_device_enable_host_msix() 
> assigned_dev_id=918 #2: [v=0 e=2]
> [151186.484419] kvm-1923: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918 r=-22
> [151186.522328] kvm-1923: kvm_vm_ioctl_set_msix_nr assigned_dev_id=918 
> already entries_nr=3
> [151186.561093] kvm-1923: kvm_vm_ioctl_set_msix_nr assigned_dev_id=918 r=-22
> 
> I attach the full printouts from these two reproductions (kvm-XXX, XXX being 
> current->pid).
> 
> BTW, these errnos seem pretty random; I think if I try to repro this again, 
> I might get different errnos.
> 
> Please let me know whether you have any suggestions on how to debug this 
> further.

So you have two failure modes.  In one case pci_enable_msix returns
success and in the other it returns failure, but in both cases the
vectors are all zero.  I think the next step is to try to reproduce on
current upstream kernel and qemu.  If those still generate similar
failures instrument the pci_enable_msix path to pinpoint where it's
going wrong.  Thanks,

Alex

