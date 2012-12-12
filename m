Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46884 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab2LLNmb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2012 08:42:31 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so364946bkw.19
        for <linux-pci@vger.kernel.org>; Wed, 12 Dec 2012 05:42:30 -0800 (PST)
Message-ID: <8AA592B1E5D146039EE6F0A5AA33A8BA@alyakaslap>
From: "Alex Lyakas" <alex@zadarastorage.com>
To: "Alex Williamson" <alex.williamson@redhat.com>
Cc: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Yair Hershko" <yair@zadarastorage.com>,
	"Shyam Kaushik" <shyam@zadarastorage.com>
References: <190FFE9600054603A543CCDA4408AC89@alyakaslap> <CAOcd+r28ot-060WQhUPkuM1Bt7t-_jOggAZKNSJxurNYVs2b-w@mail.gmail.com> <1353536723.1809.4.camel@bling.home> <F764A8A9BBE247FEA862ED33F77A04A1@alyakaslap> <1353960253.1809.128.camel@bling.home> <A5D6C5E3D7774E62AA482C886483DA6D@alyakaslap> <1354204570.14547.14.camel@ul30vt.home> <9C253052ADFC40D9A0BC9979549506A6@alyakaslap> <1355172358.3224.157.camel@bling.home>
In-Reply-To: <1355172358.3224.157.camel@bling.home>
Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL
Date: Wed, 12 Dec 2012 15:42:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,
The kernel am using is stock Ubuntu-Precise (as I mentioned) 
3.2.0-29-generic #46.

I debugged deeper in pci_enable_msix() path, and I believe I have tracked 
down the source of the different errors I am seeing. The issue I see is that 
pci_find_capability() *sometimes* fails to find PCI_CAP_ID_MSIX capability. 
I tracked this down to __pci_find_next_cap_ttl() not being able to find the 
needed cap and returns 0.

This leads to three different errors I saw:

Case 1: pci_enable_msix() calls pci_msi_check_device(dev, nvec, 
PCI_CAP_ID_MSIX), which calls pci_find_capability() and further returns 
EINVAL

Case 2: pci_enable_msix() calls pci_msix_table_size(), which calls 
pci_find_capability(dev, PCI_CAP_ID_MSIX), which returns 0. As a result, 
pci_msix_table_size() returns 0. Then the following code:
nr_entries = pci_msix_table_size(dev);
if (nvec > nr_entries)
    return nr_entries;
causes pci_enable_msix() to return 0 to the caller, so now the caller thinks 
that pci_enable_msix() succeeded! However, IRQs were not assigned, so 
further call to request_threaded_irq() fails.
(This looks like a kernel bug.)

Case 3: pci_enable_msix() calls msix_capability_init(), which calls 
pci_find_capability(dev, PCI_CAP_ID_MSIX), which fails and returns pos==0.
So now msix_capability_init() does not check the return value and proceeds 
with setting things up, and eventually fails in call to msix_map_region() => 
ioremap_nocache(), which returns NULL. So msix_capability_init() returns 
ENOMEM and further pci_enable_msix() returns ENOMEM.
(So this is another kernel bug of not checking return value of 
pci_find_capability(dev, PCI_CAP_ID_MSIX).)

So bottom line is that different failures I saw stem from the same issue of 
(sometimes) not finding PCI_CAP_ID_MSIX. It always happens on the second 
call to KVM_ASSIGN_DEV_IRQ. Why are two calls required? For example, the 
below trace shows the first call succeeding and setting up interrupts 
properly, and the second call failing:

kernel: [ 4851.332462] kvm-7636: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918
kernel: [ 4851.333553] pci-stub 0000:03:12.6: irq 257 for MSI/MSI-X
kernel: [ 4851.333573] pci-stub 0000:03:12.6: irq 258 for MSI/MSI-X
kernel: [ 4851.333591] pci-stub 0000:03:12.6: irq 259 for MSI/MSI-X
kernel: [ 4851.333600] kvm-7636: assigned_device_enable_host_msix(): call 
request_threaded_irq() assigned_dev_id=918 #0: [v=257 e=0]
kernel: [ 4851.333845] kvm-7636: assigned_device_enable_host_msix(): call 
request_threaded_irq() assigned_dev_id=918 #1: [v=258 e=1]
kernel: [ 4851.334055] kvm-7636: assigned_device_enable_host_msix(): call 
request_threaded_irq() assigned_dev_id=918 #2: [v=259 e=2]
kernel: [ 4851.334241] kvm-7636: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918 OK
kernel: [ 4851.396339] kvm-7636: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918
kernel: [ 4851.396353] kvm-???: pci_find_capability 
__pci_find_next_cap(devfn=150 pos=0) dev=0000:03:12.6 returned 0
kernel: [ 4851.412754] kvm-???: msix_map_region ioremap_nocache(0x100000, 
nr_entries=2048 PCI_MSIX_ENTRY_SIZE=16 dev=0000:03:12.6 pos=0 NULL
kernel: [ 4851.429672] kvm-???: msix_capability_init 
msix_map_region(dev=0000:03:12.6, pos=0 control=32767) failed NULL
kernel: [ 4851.438726] kvm-???: pci_enable_msix(0000:03:12.6) 
msix_capability_init failed, err=-12
kernel: [ 4851.465439] kvm-7636: assigned_device_enable_host_msix() 
pci_enable_msix() failed assigned_dev_id=918 irq_name=kvm:0000:03:12.6 
err=-12
kernel: [ 4851.484072] kvm-7636: assigned_device_enable_host_msix() 
assigned_dev_id=918 #0: [v=0 e=0]
kernel: [ 4851.484076] kvm-7636: assigned_device_enable_host_msix() 
assigned_dev_id=918 #1: [v=0 e=1]
kernel: [ 4851.484081] kvm-7636: assigned_device_enable_host_msix() 
assigned_dev_id=918 #2: [v=0 e=2]
kernel: [ 4851.484086] kvm-7636: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918 
r=-12

Do you think the issue is the second KVM call, or the issue is the HW not 
reporting the capability sometimes?

Looking at the latest 3.7 kernel code sources, I see that all relevant 
functions (pci_enable_msix, pci_find_capability and msix_capability_init) 
would behave the same way WRT to pci_find_capability() call. And anyways, 
moving to upstream kernel is not an option for me at this point.

Please let me know what do you think the next step would be.

Thanks,
Alex.


-----Original Message----- 
From: Alex Williamson
Sent: 10 December, 2012 10:45 PM
To: Alex Lyakas
Cc: kvm@vger.kernel.org ; linux-pci@vger.kernel.org ; Yair Hershko ; Shyam 
Kaushik
Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL

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
> [151186.561093] kvm-1923: kvm_vm_ioctl_set_msix_nr assigned_dev_id=918 
> r=-22
>
> I attach the full printouts from these two reproductions (kvm-XXX, XXX 
> being
> current->pid).
>
> BTW, these errnos seem pretty random; I think if I try to repro this 
> again,
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

