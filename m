Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11632 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab2LSXjU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Dec 2012 18:39:20 -0500
Message-ID: <1355960358.10845.5.camel@ul30vt.home>
Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL
From: Alex Williamson <alex.williamson@redhat.com>
To: Alex Lyakas <alex@zadarastorage.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	Yair Hershko <yair@zadarastorage.com>,
	Shyam Kaushik <shyam@zadarastorage.com>
Date: Wed, 19 Dec 2012 16:39:18 -0700
In-Reply-To: <E9DA84A0509F4CD08E82BAD96C65374F@alyakaslap>
References: <190FFE9600054603A543CCDA4408AC89@alyakaslap>
	 <CAOcd+r28ot-060WQhUPkuM1Bt7t-_jOggAZKNSJxurNYVs2b-w@mail.gmail.com>
	 <1353536723.1809.4.camel@bling.home>
	 <F764A8A9BBE247FEA862ED33F77A04A1@alyakaslap>
	 <1353960253.1809.128.camel@bling.home>
	 <A5D6C5E3D7774E62AA482C886483DA6D@alyakaslap>
	 <1354204570.14547.14.camel@ul30vt.home>
	 <9C253052ADFC40D9A0BC9979549506A6@alyakaslap>
	 <1355172358.3224.157.camel@bling.home>
	 <8AA592B1E5D146039EE6F0A5AA33A8BA@alyakaslap>
	 <1355343043.3224.266.camel@bling.home>
	 <E9DA84A0509F4CD08E82BAD96C65374F@alyakaslap>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2012-12-18 at 16:46 +0200, Alex Lyakas wrote:
> Hi Alex,
> 
> Thank you for helping me debug this issue. Some additional repros showed 
> that sometimes HW reports only PCI_CAP_ID_SLOTID and PCI_CAP_ID_EXP, and 
> sometimes it does not report any capability at all. At this point, I am 
> unable to install all the required components for reproduction on kernel 
> 3.7. What information should I look for in dmseg? My only way out for now, 
> it to stick an ugly retry call to pci_enable_msix() in case it fails, or 
> returns 0 but does not set up the IRQs.

It should not be difficult to replace the Ubuntu kernel with stock
upstream unless some other proprietary drivers are contributing to the
problem.  Please send the entire host dmesg after encountering an error.

> I would also like to piggy-back on this message for another question to you. 
> You added code to kvm_iommu_map_guest() that checks whether the IOMMU unit 
> supports interrupt remapping. And if not, the code refuses to attach the PCI 
> device, unless allow_unsafe_assigned_interrupts is set.
> As it turns out some of our servers report ecap=0xf020fe for which 
> ecap_ir_support(iommu->ecap)) is true, and some report ecap=0xf020f6, for 
> which ecap_ir_support(iommu->ecap)) is false (the difference is in bit #4). 
> All servers are exactly the same, with minor differences in firmware 
> versions. On your opinion, this also indicates some race in the kernel when 
> fetching the ecap, or somehow the servers have different IOMMU units?

There's often a BIOS switch to enable interrupt remapping, I'd check
there first.  Thanks,

Alex

> -----Original Message----- 
> From: Alex Williamson
> Sent: 12 December, 2012 10:10 PM
> To: Alex Lyakas
> Cc: kvm@vger.kernel.org ; linux-pci@vger.kernel.org ; Yair Hershko ; Shyam 
> Kaushik
> Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL
> 
> On Wed, 2012-12-12 at 15:42 +0200, Alex Lyakas wrote:
> > Hi Alex,
> > The kernel am using is stock Ubuntu-Precise (as I mentioned)
> > 3.2.0-29-generic #46.
> >
> > I debugged deeper in pci_enable_msix() path, and I believe I have tracked
> > down the source of the different errors I am seeing. The issue I see is 
> > that
> > pci_find_capability() *sometimes* fails to find PCI_CAP_ID_MSIX 
> > capability.
> > I tracked this down to __pci_find_next_cap_ttl() not being able to find 
> > the
> > needed cap and returns 0.
> 
> Hmm, perhaps a config space access race?  Everything seems properly
> locked on my kernel.
> 
> > This leads to three different errors I saw:
> >
> > Case 1: pci_enable_msix() calls pci_msi_check_device(dev, nvec,
> > PCI_CAP_ID_MSIX), which calls pci_find_capability() and further returns
> > EINVAL
> >
> > Case 2: pci_enable_msix() calls pci_msix_table_size(), which calls
> > pci_find_capability(dev, PCI_CAP_ID_MSIX), which returns 0. As a result,
> > pci_msix_table_size() returns 0. Then the following code:
> > nr_entries = pci_msix_table_size(dev);
> > if (nvec > nr_entries)
> >     return nr_entries;
> > causes pci_enable_msix() to return 0 to the caller, so now the caller 
> > thinks
> > that pci_enable_msix() succeeded! However, IRQs were not assigned, so
> > further call to request_threaded_irq() fails.
> > (This looks like a kernel bug.)
> >
> > Case 3: pci_enable_msix() calls msix_capability_init(), which calls
> > pci_find_capability(dev, PCI_CAP_ID_MSIX), which fails and returns pos==0.
> > So now msix_capability_init() does not check the return value and proceeds
> > with setting things up, and eventually fails in call to msix_map_region() 
> > =>
> > ioremap_nocache(), which returns NULL. So msix_capability_init() returns
> > ENOMEM and further pci_enable_msix() returns ENOMEM.
> > (So this is another kernel bug of not checking return value of
> > pci_find_capability(dev, PCI_CAP_ID_MSIX).)
> 
> Case 1 is the one we expect to hit.  Case 2 & 3 only happen on this path
> if pci_find_capability returns non-deterministic results, so their
> behavior may be reasonable.
> 
> > So bottom line is that different failures I saw stem from the same issue 
> > of
> > (sometimes) not finding PCI_CAP_ID_MSIX. It always happens on the second
> > call to KVM_ASSIGN_DEV_IRQ. Why are two calls required? For example, the
> > below trace shows the first call succeeding and setting up interrupts
> > properly, and the second call failing:
> >
> > kernel: [ 4851.332462] kvm-7636: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918
> > kernel: [ 4851.333553] pci-stub 0000:03:12.6: irq 257 for MSI/MSI-X
> > kernel: [ 4851.333573] pci-stub 0000:03:12.6: irq 258 for MSI/MSI-X
> > kernel: [ 4851.333591] pci-stub 0000:03:12.6: irq 259 for MSI/MSI-X
> > kernel: [ 4851.333600] kvm-7636: assigned_device_enable_host_msix(): call
> > request_threaded_irq() assigned_dev_id=918 #0: [v=257 e=0]
> > kernel: [ 4851.333845] kvm-7636: assigned_device_enable_host_msix(): call
> > request_threaded_irq() assigned_dev_id=918 #1: [v=258 e=1]
> > kernel: [ 4851.334055] kvm-7636: assigned_device_enable_host_msix(): call
> > request_threaded_irq() assigned_dev_id=918 #2: [v=259 e=2]
> > kernel: [ 4851.334241] kvm-7636: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918 OK
> > kernel: [ 4851.396339] kvm-7636: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918
> > kernel: [ 4851.396353] kvm-???: pci_find_capability
> > __pci_find_next_cap(devfn=150 pos=0) dev=0000:03:12.6 returned 0
> > kernel: [ 4851.412754] kvm-???: msix_map_region ioremap_nocache(0x100000,
> > nr_entries=2048 PCI_MSIX_ENTRY_SIZE=16 dev=0000:03:12.6 pos=0 NULL
> > kernel: [ 4851.429672] kvm-???: msix_capability_init
> > msix_map_region(dev=0000:03:12.6, pos=0 control=32767) failed NULL
> > kernel: [ 4851.438726] kvm-???: pci_enable_msix(0000:03:12.6)
> > msix_capability_init failed, err=-12
> > kernel: [ 4851.465439] kvm-7636: assigned_device_enable_host_msix()
> > pci_enable_msix() failed assigned_dev_id=918 irq_name=kvm:0000:03:12.6
> > err=-12
> > kernel: [ 4851.484072] kvm-7636: assigned_device_enable_host_msix()
> > assigned_dev_id=918 #0: [v=0 e=0]
> > kernel: [ 4851.484076] kvm-7636: assigned_device_enable_host_msix()
> > assigned_dev_id=918 #1: [v=0 e=1]
> > kernel: [ 4851.484081] kvm-7636: assigned_device_enable_host_msix()
> > assigned_dev_id=918 #2: [v=0 e=2]
> > kernel: [ 4851.484086] kvm-7636: KVM_ASSIGN_DEV_IRQ assigned_dev_id=918
> > r=-12
> 
> It's hard to say why it gets setup twice without a trace from qemu.  It
> could be that the guest temporarily disabled MSI-X support and
> re-enabled it, which causes a teardown and re-setup in the host.
> 
> > Do you think the issue is the second KVM call, or the issue is the HW not
> > reporting the capability sometimes?
> 
> The issue is not the second KVM call, nor do I expect that the HW is
> actually failing to return the capability.  I suspect it's a race where
> some concurrent access to PCI config space is moving the window register
> while pci_find_capability is walking config space.  dmesg on the host
> would probably tell us which config access mechanism you're using.
> 
> > Looking at the latest 3.7 kernel code sources, I see that all relevant
> > functions (pci_enable_msix, pci_find_capability and msix_capability_init)
> > would behave the same way WRT to pci_find_capability() call. And anyways,
> > moving to upstream kernel is not an option for me at this point.
> 
> You've shown that you're getting a different result out of those
> functions, but not why, so it's a bit premature to ignore the fact that
> the problem may already be fixed in one of the past 5 kernel release.
> If it is fixed, the patch(es) can be identified and backported to your
> distro kernel.  If it's not fixed, at least we're all looking at the
> same source code.
> 
> > Please let me know what do you think the next step would be.
> 
> dmesg + try v3.7.  I don't think you need to try upstream qemu-kvm at
> this point since you've identified suspicious behavior that userspace
> shouldn't be able to cause.  Otherwise check locking around the PCI
> config accesses that you're using and make sure that userspace accesses
> through pci-sysfs aren't bypassing anything.  Thanks,
> 
> Alex
> 



