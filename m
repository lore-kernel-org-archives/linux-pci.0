Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:37581 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225Ab2LHMOp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 8 Dec 2012 07:14:45 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so817109wgb.1
        for <linux-pci@vger.kernel.org>; Sat, 08 Dec 2012 04:14:44 -0800 (PST)
Message-ID: <9C253052ADFC40D9A0BC9979549506A6@alyakaslap>
From: "Alex Lyakas" <alex@zadarastorage.com>
To: "Alex Williamson" <alex.williamson@redhat.com>
Cc: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Yair Hershko" <yair@zadarastorage.com>,
	"Shyam Kaushik" <shyam@zadarastorage.com>
References: <190FFE9600054603A543CCDA4408AC89@alyakaslap> <CAOcd+r28ot-060WQhUPkuM1Bt7t-_jOggAZKNSJxurNYVs2b-w@mail.gmail.com> <1353536723.1809.4.camel@bling.home> <F764A8A9BBE247FEA862ED33F77A04A1@alyakaslap> <1353960253.1809.128.camel@bling.home> <A5D6C5E3D7774E62AA482C886483DA6D@alyakaslap> <1354204570.14547.14.camel@ul30vt.home>
In-Reply-To: <1354204570.14547.14.camel@ul30vt.home>
Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL
Date: Sat, 8 Dec 2012 14:14:51 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000F_01CDD54E.63458C00"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01CDD54E.63458C00
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Alex,
first of all, I apologize for not reporting things properly. The "vector" 
values that I see passed to request_threaded_irq() are not zeros. They are 
unique IRQ values as you mentioned. I do not, however, see the 
disabling-and-reenabling sequence as you wrote. The usual sequence for me is 
calling KVM_ASSIGN_DEV_IRQ twice for the same assigned_dev-id:

[ 2423.990404] kvm-32353: KVM_ASSIGN_DEV_IRQ assigned_dev_id=946
[ 2423.991585] kvm-32353: assigned_device_enable_host_msix(): call 
request_threaded_irq() assigned_dev_id=946 #0: [v=158 e=0]
[ 2423.991810] kvm-32353: assigned_device_enable_host_msix(): call 
request_threaded_irq() assigned_dev_id=946 #1: [v=159 e=1]
[ 2423.991869] kvm-32353: assigned_device_enable_host_msix(): call 
request_threaded_irq() assigned_dev_id=946 #2: [v=160 e=2]
[ 2424.054320] kvm-32353: KVM_ASSIGN_DEV_IRQ assigned_dev_id=946
[ 2424.055337] kvm-32353: assigned_device_enable_host_msix(): call 
request_threaded_irq() assigned_dev_id=946 #0: [v=158 e=0]
[ 2424.055516] kvm-32353: assigned_device_enable_host_msix(): call 
request_threaded_irq() assigned_dev_id=946 #1: [v=159 e=1]
[ 2424.055673] kvm-32353: assigned_device_enable_host_msix(): call 
request_threaded_irq() assigned_dev_id=946 #2: [v=160 e=2]

As you requested, I specified the intremap=off option to the kernel (saw 
that nointremap is deprecated), and reproduced. I had to set the 
allow_unsafe_assigned_interrupts parameter of kvm.ko module.

With irqbalance running, I saw that pci_enable_msix() does not report 
failure, but does not set up the interrupt verctor, and further call to 
request_threaded_irq() fails with EBUSY:

[ 2425.292444] kvm-32353: KVM_ASSIGN_DEV_IRQ assigned_dev_id=913
[ 2425.292458] kvm-32353: assigned_device_enable_host_msix(): call 
request_threaded_irq() assigned_dev_id=913 #0: [v=0 e=0]
[ 2425.292753] kvm-32353: assigned_device_enable_host_msix() 
request_threaded_irq(vector=0) failed assigned_dev_id=913 
irq_name=kvm:0000:03:12.1 err=-16
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.294434] kvm-32353: 
KVM_ASSIGN_DEV_IRQ assigned_dev_id=913 r=-16

Then I turned irqbalance off, and reproduced again; this time 
pci_enable_msix() returns EINVAL (-22). I printed out the vector numbers 
after pci_enable_msix() failure, and they are all zeros:

[151186.446688] kvm-1923: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918
[151186.446705] kvm-1923: assigned_device_enable_host_msix() 
pci_enable_msix() failed assigned_dev_id=918 irq_name=kvm:0000:03:12.6 
err=-22
[151186.484409] kvm-1923: assigned_device_enable_host_msix() 
assigned_dev_id=918 #0: [v=0 e=0]
[151186.484413] kvm-1923: assigned_device_enable_host_msix() 
assigned_dev_id=918 #1: [v=0 e=1]
[151186.484416] kvm-1923: assigned_device_enable_host_msix() 
assigned_dev_id=918 #2: [v=0 e=2]
[151186.484419] kvm-1923: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918 r=-22
[151186.522328] kvm-1923: kvm_vm_ioctl_set_msix_nr assigned_dev_id=918 
already entries_nr=3
[151186.561093] kvm-1923: kvm_vm_ioctl_set_msix_nr assigned_dev_id=918 r=-22

I attach the full printouts from these two reproductions (kvm-XXX, XXX being 
current->pid).

BTW, these errnos seem pretty random; I think if I try to repro this again, 
I might get different errnos.

Please let me know whether you have any suggestions on how to debug this 
further.

Thanks for your help,
Alex.


-----Original Message----- 
From: Alex Williamson
Sent: 29 November, 2012 5:56 PM
To: Alex Lyakas
Cc: kvm@vger.kernel.org ; linux-pci@vger.kernel.org ; Yair Hershko ; Shyam 
Kaushik
Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL

On Thu, 2012-11-29 at 10:42 +0200, Alex Lyakas wrote:
> Hi Alex,
> did I understand correctly that "vector" value with which the call to
> request_threaded_irq() is made is *not* supposed to be zero? Because in my
> case, it is always zero, and still the failure I observe is not happening
> always. Usually, 3 unique (non-zero) IRQ numbers are assigned to each
> attached PCI device of each KVM VM.
> I will try to repro this like you suggested and let you know.

pci_enable_msix should be setting vectors for all the host_msix_entries.
That non-zero vector is the first parameter to request_threaded_irq.  If
I put a printk in the loop installing the interrupt handler, I get:

assigned_device_enable_host_msix entry 0, vector 44
assigned_device_enable_host_msix entry 0, vector 44
assigned_device_enable_host_msix entry 1, vector 45
assigned_device_enable_host_msix entry 0, vector 44
assigned_device_enable_host_msix entry 1, vector 45
assigned_device_enable_host_msix entry 2, vector 103

So we enable MSI-X with only one vector enabled, then a second vector
gets enabled and we disable and re-enable with two, and so on with
three.  This is for an assigned e1000e device.  Thanks,

Alex

------=_NextPart_000_000F_01CDD54E.63458C00
Content-Type: text/plain;
	format=flowed;
	name="nointremap_noirqbalance.txt";
	reply-type=original
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="nointremap_noirqbalance.txt"

Dec  8 12:59:13 ubuntu-sata-21 kernel: [151185.488251] kvm-1923:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D921
Dec  8 12:59:13 ubuntu-sata-21 kernel: [151185.489215] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D921 #0: [v=3D143 e=3D0]
Dec  8 12:59:13 ubuntu-sata-21 kernel: [151185.489449] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D921 #1: [v=3D144 e=3D1]
Dec  8 12:59:13 ubuntu-sata-21 kernel: [151185.489741] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D921 #2: [v=3D145 e=3D2]
Dec  8 12:59:13 ubuntu-sata-21 kernel: [151185.552144] kvm-1923:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D921
Dec  8 12:59:13 ubuntu-sata-21 kernel: [151185.553223] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D921 #0: [v=3D143 e=3D0]
Dec  8 12:59:13 ubuntu-sata-21 kernel: [151185.553498] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D921 #1: [v=3D144 e=3D1]
Dec  8 12:59:13 ubuntu-sata-21 kernel: [151185.553745] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D921 #2: [v=3D145 e=3D2]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.811675] kvm-1923:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D938
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.812579] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D938 #0: [v=3D200 e=3D0]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.812837] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D938 #1: [v=3D201 e=3D1]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.813039] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D938 #2: [v=3D202 e=3D2]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.847699] kvm-1923:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D938
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.848785] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D938 #0: [v=3D200 e=3D0]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.849011] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D938 #1: [v=3D201 e=3D1]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.849280] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D938 #2: [v=3D202 e=3D2]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.943489] kvm-1923:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D943
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.944598] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D943 #0: [v=3D212 e=3D0]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.944838] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D943 #1: [v=3D213 e=3D1]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151185.945097] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D943 #2: [v=3D214 e=3D2]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.007430] kvm-1923:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D943
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.008407] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D943 #0: [v=3D212 e=3D0]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.008628] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D943 #1: [v=3D213 e=3D1]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.008902] kvm-1923:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D943 #2: [v=3D214 e=3D2]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.446688] kvm-1923:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D918
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.446705] kvm-1923:
assigned_device_enable_host_msix() pci_enable_msix() failed
assigned_dev_id=3D918 irq_name=3Dkvm:0000:03:12.6 err=3D-22
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.484409] kvm-1923:
assigned_device_enable_host_msix() assigned_dev_id=3D918 #0: [v=3D0 =
e=3D0]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.484413] kvm-1923:
assigned_device_enable_host_msix() assigned_dev_id=3D918 #1: [v=3D0 =
e=3D1]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.484416] kvm-1923:
assigned_device_enable_host_msix() assigned_dev_id=3D918 #2: [v=3D0 =
e=3D2]
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.484419] kvm-1923:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D918 r=3D-22
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.522328] kvm-1923:
kvm_vm_ioctl_set_msix_nr assigned_dev_id=3D918 already entries_nr=3D3
Dec  8 12:59:14 ubuntu-sata-21 kernel: [151186.561093] kvm-1923:
kvm_vm_ioctl_set_msix_nr assigned_dev_id=3D918 r=3D-22

------=_NextPart_000_000F_01CDD54E.63458C00
Content-Type: text/plain;
	format=flowed;
	name="nointremap.txt";
	reply-type=original
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="nointremap.txt"

Dec  6 19:36:02 ubuntu-sata-21 kernel: [ 2423.990404] kvm-32353:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D946
Dec  6 19:36:02 ubuntu-sata-21 kernel: [ 2423.991585] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D946 #0: [v=3D158 e=3D0]
Dec  6 19:36:02 ubuntu-sata-21 kernel: [ 2423.991810] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D946 #1: [v=3D159 e=3D1]
Dec  6 19:36:02 ubuntu-sata-21 kernel: [ 2423.991869] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D946 #2: [v=3D160 e=3D2]
Dec  6 19:36:02 ubuntu-sata-21 kernel: [ 2424.054320] kvm-32353:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D946
Dec  6 19:36:02 ubuntu-sata-21 kernel: [ 2424.055337] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D946 #0: [v=3D158 e=3D0]
Dec  6 19:36:02 ubuntu-sata-21 kernel: [ 2424.055516] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D946 #1: [v=3D159 e=3D1]
Dec  6 19:36:02 ubuntu-sata-21 kernel: [ 2424.055673] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D946 #2: [v=3D160 e=3D2]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.292444] kvm-32353:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D913
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.292458] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D913 #0: [v=3D0 e=3D0]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.292753] kvm-32353:
assigned_device_enable_host_msix() request_threaded_irq(vector=3D0) =
failed
assigned_dev_id=3D913 irq_name=3Dkvm:0000:03:12.1 err=3D-16
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.294434] kvm-32353:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D913 r=3D-16
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.295384] kvm-32353:
kvm_vm_ioctl_set_msix_nr assigned_dev_id=3D913 already entries_nr=3D3
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.296442] kvm-32353:
kvm_vm_ioctl_set_msix_nr assigned_dev_id=3D913 r=3D-22
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.400256] kvm-32353:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D945
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.401259] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D945 #0: [v=3D191 e=3D0]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.401551] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D945 #1: [v=3D192 e=3D1]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.401727] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D945 #2: [v=3D193 e=3D2]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.448243] kvm-32353:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D945
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.449254] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D945 #0: [v=3D191 e=3D0]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.449469] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D945 #1: [v=3D192 e=3D1]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.449752] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D945 #2: [v=3D193 e=3D2]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.583978] kvm-32353:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D896
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.584959] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D896 #0: [v=3D236 e=3D0]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.585201] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D896 #1: [v=3D237 e=3D1]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.585362] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D896 #2: [v=3D238 e=3D2]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.647911] kvm-32353:
KVM_ASSIGN_DEV_IRQ assigned_dev_id=3D896
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.648903] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D896 #0: [v=3D236 e=3D0]
Dec  6 19:36:04 ubuntu-sata-21 kernel: [ 2425.649214] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D896 #1: [v=3D237 e=3D1]
Dec  6 19:36:05 ubuntu-sata-21 kernel: [ 2425.649398] kvm-32353:
assigned_device_enable_host_msix(): call request_threaded_irq()
assigned_dev_id=3D896 #2: [v=3D238 e=3D2]

------=_NextPart_000_000F_01CDD54E.63458C00--

