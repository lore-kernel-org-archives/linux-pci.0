Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37099 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbbCYUl3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2015 16:41:29 -0400
Date: Wed, 25 Mar 2015 16:40:56 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michael D Labriola <mlabriol@gdeb.com>,
	xen-devel@lists.xenproject.org, Stuart Wehrly <swehrly@gdeb.com>,
	michael.d.labriola@gmail.com, Jayson A Dyke <jdyke@gdeb.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Xen-devel] 3.18 xen-pcifront regression?
Message-ID: <20150325204056.GA3649@l.oracle.com>
References: <OF77E25ED8.9CA80CE3-ON85257E12.004F7B31-85257E12.0053B9A0@gdeb.com>
 <20150324152806.GD14418@l.oracle.com>
 <20150324172702.GC2495@google.com>
 <20150325202700.GS25884@l.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150325202700.GS25884@l.oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > Thanks for the report, Michael, and sorry for the inconvenience.  I think
> > the patch below will fix it, but I don't think it's the right fix either
> > because it seems a little ad hoc to sprinkle "acpi_pci_disabled" tests
> > around like fairy dust.  I wonder if we can set things up so ACPI methods
> > would fail gracefully like they do when ACPI is disabled at compile-time.
> > 
> > I can boot with "acpi=off" on qemu just fine, and when we look up the ACPI
> > device handles, we just get NULL pointers, so everything works out even
> > without a fix like the one below.
> 
> <nods>
> > 
> > There must be something different about the way things get set up in that
> > domU kernel.  I'll try to look into that some more, but I'm going on
> > vacation for the next week, so if you learn anything before then, let me
> > know.
> 
> And I don't see where 'resume_kernel' gets called.
> 
> 
> And under my PV guest I see:
> # lspci
> 00:00.0 USB Controller: NEC Corporation Device 0194 (rev 04)
> 00:01.0 USB Controller: NEC Corporation Device 0194 (rev 03)
> 
> when the guest boots up. Hm, what kind of cards are these?
> Could you also provide the config file and the guest config please?


It helps when I boot an proper kernel (I had booted 3.16 by mistake).

With the 4.0 kernel I see this as well:

[    4.059387] pci 0000:00:00.0: reg 0x10: [mem 0xfbd00000-0xfbd01fff 64bit]
[    4.114184] BUG: unable to handle kernel paging request at 0030303e
[    4.114199] IP: [<c1379c1c>] acpi_ns_validate_handle+0x1c/0x26
[    4.114216] *pdpt = 0000000000000000 *pde = c2c2c2c2c2c2c2c2 
[    4.114230] Oops: 0000 [#1] SMP 
[    4.114241] Modules linked in:
[    4.114252] CPU: 0 PID: 22 Comm: xenwatch Not tainted 4.0.0-rc5upstream-00070-g3a88f16 #1
[    4.114268] task: dd557370 ti: dd55a000 task.ti: dd55a000 
[    4.114278] EIP: e019:[<c1379c1c>] EFLAGS: 00010246 CPU: 0
[    4.114289] EIP is at acpi_ns_validate_handle+0x1c/0x26
[    4.114299] EAX: 00000000 EBX: 0030303a ECX: 00000000 EDX: 00000000
[    4.114310] ESI: dd66e7c0 EDI: 0030303a EBP: dd55bcd8 ESP: dd55bcd4
[    4.114322]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: e021
[    4.114334] CR0: 80050033 CR2: 0030303e CR3: 019a4000 CR4: 00042660
[    4.114347] Stack:
[    4.114354]  c17ae853 dd55bd14 c137ae18 00000010 c1a602c0 dd55bcf0 c109ae9a dd55bcfc
[    4.114376]  c13a9c57 deadbeef dd55bd50 00000000 deadbeef 0030303a dd55bd78 dd55bdd0
[    4.114397]  dd55bd58 c1336d90 dd55bd40 0000007b 0000007b 000000d8 dd55bd94 dd55bd8c
[    4.114419] Call Trace:
[    4.114429]  [<c137ae18>] acpi_evaluate_object+0x6f/0x366
[    4.114443]  [<c109ae9a>] ? irq_exit+0x4a/0xc0
[    4.114456]  [<c13a9c57>] ? xen_evtchn_do_upcall+0x27/0x40
[    4.114468]  [<c1336d90>] pci_get_hp_params+0x110/0x4b0
[    4.114480]  [<c1316436>] pci_device_add+0x26/0x450
[    4.114494]  [<c10409db>] ? xen_restore_fl_direct_reloc+0x4/0x4  
[    4.115132]  [<c16509c6>] ? _raw_spin_unlock_irqrestore+0x16/0x40
[    4.115132]  [<c13171eb>] pci_scan_single_device+0x8b/0xb0
[    4.115132]  [<c1317253>] pci_scan_slot+0x43/0x100
[    4.115132]  [<c1317cfc>] pci_scan_child_bus+0x1c/0xa0   
[    4.115132]  [<c1318254>] pci_scan_bus_parented+0x64/0x90
[    4.115132]  [<c1337730>] pcifront_scan_root+0x90/0x120
[    4.115132]  [<c164b8e5>] pcifront_backend_changed+0x475/0x63c
[    4.115132]  [<c164b200>] ? kmemleak_free+0x20/0x50
[    4.115132]  [<c119ec9d>] ? kfree+0x7d/0x100
[    4.115132]  [<c13a028d>] ? __cleanup+0xfd/0x180   
[    4.115132]  [<c13ae28d>] ? xenbus_gather+0x5d/0x90
[    4.115132]  [<c13ac475>] ? xenbus_read_driver_state+0x35/0x50
[    4.115132]  [<c13af3cd>] xenbus_otherend_changed+0x7d/0x80
[    4.115132]  [<c13b0bf2>] backend_changed+0x12/0x20 
[    4.115132]  [<c13adb12>] xenwatch_thread+0x72/0x120
[    4.115132]  [<c10ccc00>] ? woken_wake_function+0x20/0x20
[    4.115132]  [<c10b10bc>] kthread+0xac/0xd0
[    4.115132]  [<c13adaa0>] ? xenbus_transaction_start+0x60/0x60
[    4.115132]  [<c1650fc1>] ret_from_kernel_thread+0x21/0x30
[    4.115132]  [<c10b1010>] ? kthread_freezable_should_stop+0x60/0x60
[    4.115132] Code: 4f b2 00 00 31 c0 83 c4 2c 5b 5e 5f 5d c3 90 55 89 e5 53 89 c3 e8 45 b0 00 00 8d 43 ff 83 f8 fd 76 07 a1 20 80 a6 c1 eb 09 31 c0 <80> 7b 04 0f 0f 44 c3 5b 5d c3 55 89 e5 53 89 c3 e8 1f b0 00 00
[    4.115132] EIP: [<c1379c1c>] acpi_ns_validate_handle+0x1c/0x26 SS:ESP e021:dd55bcd4
[    4.115132] CR2: 000000000030303e
[    4.115132] ---[ end trace 21d8bfe52b77b825 ]---
[    4.115132] Kernel panic - not syncing: Fatal exception
[    4.115132] Kernel Offset: 0x0 from 0xc1000000 (relocation range: 0xc0000000-0xedbfdfff)

The interesting thing is that under 64-bit kernels I see this:

[    3.304732] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]^M
[    3.304748] pci_bus 0000:00: root bus resource [mem 0x00000000-0xfffffffff]^M
[    3.304764] pci_bus 0000:00: root bus resource [bus 00-ff]^M
[    3.305023] pci 0000:00:00.0: [1033:0194] type 00 class 0x0c0330^M
[    3.322181] pci 0000:00:00.0: reg 0x10: [mem 0xfbd00000-0xfbd01fff 64bit]^M
[    3.377359] ACPI Exception: AE_BAD_PARAMETER, Thread 520623344 could not acquire Mutex [0x1] (20150204/utmutex-285)^M
[    3.377379] ACPI Exception: AE_BAD_PARAMETER, Thread 520623344 could not acquire Mutex [0x1] (20150204/utmutex-285)^M
[    3.379202] pci 0000:00:01.0: [1033:0194] type 00 class 0x0c0330^M
[    3.396282] pci 0000:00:01.0: reg 0x10: [mem 0xfba00000-0xfba01fff 64bit]^M
[    3.451422] ACPI Exception: AE_BAD_PARAMETER, Thread 520623344 could not acquire Mutex [0x1] (20150204/utmutex-285)^M
[    3.451440] ACPI Exception: AE_BAD_PARAMETER, Thread 520623344 could not acquire Mutex [0x1] (20150204/utmutex-285)^M
[    3.456133] pcifront pci-0: claiming resource 0000:00:00.0/0^M
[    3.456147] pcifront pci-0: claiming resource 0000:00:01.0/0^M
[    3.456461] pci 0000:00:00.0: Xen PCI mapped GSI18 to IRQ25^M


> 
> Thank you!
> 
> > 
> > Bjorn
> > 
> > 
> > commit 6678b0fb6504c890481863b4916089b41e6042bf
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Mar 24 11:12:45 2015 -0500
> > 
> >     PCI: Don't look for ACPI hotplug parameters if ACPI is disabled
> >     
> >     In a kernel with CONFIG_ACPI=y, pci_get_hp_params() evaluates ACPI methods
> >     (_HPX, _HPP, etc.) to learn how to configure devices.  If ACPI has been
> >     disabled at runtime, e.g., with "acpi=off", this causes an oops because
> >     there's no AML at all.
> >     
> >     Before 6cd33649fa83 ("PCI: Add pci_configure_device() during enumeration"),
> >     we only used pci_get_hp_params() for hot-added devices, but after it, we
> >     use it for all devices, so we're much more likely to see the oops.
> >     
> >     Don't bother looking for ACPI configuration information if ACPI has been
> >     disabled.
> >     
> >     Fixes: 6cd33649fa83 ("PCI: Add pci_configure_device() during enumeration")
> >     Reported-by: Michael D Labriola <mlabriol@gdeb.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >     CC: stable@vger.kernel.org	# v3.18+
> > 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 489063987325..c93fbe76d281 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -248,6 +248,9 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
> >  	acpi_handle handle, phandle;
> >  	struct pci_bus *pbus;
> >  
> > +	if (acpi_pci_disabled)
> > +		return -ENODEV;
> > +
> >  	handle = NULL;
> >  	for (pbus = dev->bus; pbus; pbus = pbus->parent) {
> >  		handle = acpi_pci_get_bridge_handle(pbus);
