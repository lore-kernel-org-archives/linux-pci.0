Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752227AbdI1RxK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Sep 2017 13:53:10 -0400
Date: Thu, 28 Sep 2017 12:53:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: Re: alpha runtime warnings due to commit 0e4c2eeb758 ("alpha/PCI:
 Replace pci_fixup_irqs() call with host ...")
Message-ID: <20170928175306.GX15970@bhelgaas-glaptop.roam.corp.google.com>
References: <32ec730f-c1b0-5584-cd35-f8a809122b96@roeck-us.net>
 <20170919091232.GA19596@red-moon>
 <20170919180233.GA7018@roeck-us.net>
 <20170920113104.GA18275@red-moon>
 <20170927103034.GA13763@red-moon>
 <20170927195502.GA11925@bhelgaas-glaptop.roam.corp.google.com>
 <20170928092532.GA23071@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170928092532.GA23071@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 28, 2017 at 10:25:33AM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 27, 2017 at 02:55:02PM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 27, 2017 at 11:30:34AM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Sep 20, 2017 at 12:31:04PM +0100, Lorenzo Pieralisi wrote:
> > > > On Tue, Sep 19, 2017 at 11:02:33AM -0700, Guenter Roeck wrote:
> > > > > On Tue, Sep 19, 2017 at 10:12:32AM +0100, Lorenzo Pieralisi wrote:
> > > > > > On Mon, Sep 18, 2017 at 07:00:55PM -0700, Guenter Roeck wrote:

> > > > > > > I see the following runtime warnings in mainline when running alpha images in qemu.
> > > > > > > 
> > > > > > > 
> > > > > > > Floppy drive(s): fd0 is 2.88M
> > > > > > > ide0: disabled, no IRQ
> > > > > > > ide0: failed to initialize IDE interface
> > > > > > > ide0: disabling port
> > > > > > > cmd64x 0000:00:02.0: IDE controller (0x1095:0x0646 rev 0x07)
> > > > > > > CMD64x_IDE 0000:00:02.0: BAR 0: can't reserve [io  0x8050-0x8057]
> > > > > > > cmd64x 0000:00:02.0: can't reserve resources
> > > > > > > CMD64x_IDE: probe of 0000:00:02.0 failed with error -16
> > > > > > > ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
> > > > > > > ------------[ cut here ]------------
> > > > > > > WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x94/0xd0
> > > > > > > sysfs: cannot create duplicate filename '/class/ide_port/ide0'
> > > > > > > ...
> > > > > > > 
> > > > > > > Trace:
> > > > > > > [<fffffc00003308a0>] __warn+0x160/0x190
> > > > > > > [<fffffc000048c9f4>] sysfs_warn_dup+0x94/0xd0
> > > > > > > [<fffffc0000330928>] warn_slowpath_fmt+0x58/0x70
> > > > > > > [<fffffc000048c9f4>] sysfs_warn_dup+0x94/0xd0
> > > > > > > [<fffffc0000486d40>] kernfs_path_from_node+0x30/0x60
> > > > > > > [<fffffc00004874ac>] kernfs_put+0x16c/0x2c0
> > > > > > > [<fffffc00004874ac>] kernfs_put+0x16c/0x2c0
> > > > > > > [<fffffc000048d010>] sysfs_do_create_link_sd.isra.2+0x100/0x120
> > > > > > > [<fffffc00005b9d64>] device_add+0x2a4/0x7c0
> > > > > > > [<fffffc00005ba5cc>] device_create_groups_vargs+0x14c/0x170
> > > > > > > [<fffffc00005ba518>] device_create_groups_vargs+0x98/0x170
> > > > > > > [<fffffc00005ba690>] device_create+0x50/0x70
> > > > > > > [<fffffc00005df36c>] ide_host_register+0x48c/0xa00
> > > > > > > [<fffffc00005df330>] ide_host_register+0x450/0xa00
> > > > > > > [<fffffc00005ba2a0>] device_register+0x20/0x50
> > > > > > > [<fffffc00005df330>] ide_host_register+0x450/0xa00
> > > > > > > [<fffffc00005df944>] ide_host_add+0x64/0xe0
> > > > > > > [<fffffc000079b41c>] kobject_uevent_env+0x16c/0x710
> > > > > > > [<fffffc0000310288>] do_one_initcall+0x68/0x260
> > > > > > > [<fffffc00007b13bc>] kernel_init+0x1c/0x1a0
> > > > > > > [<fffffc00007b13a0>] kernel_init+0x0/0x1a0
> > > > > > > [<fffffc0000311868>] ret_from_kernel_thread+0x18/0x20
> > > > > > > [<fffffc00007b13a0>] kernel_init+0x0/0x1a0
> > > > > > > 
> > > > > > > ---[ end trace 24a70433c3e4d374 ]---
> > > > > > > ide0: disabling port
> > > > > > > 
> > > > > > > [ multiple times ]
> > > > > > > 
> > > > > > > A complete log is available at http://kerneltests.org/builders/qemu-alpha-master.
> > > > > > > 
> > > > > > > Prior to the offending commit, the kernel log looks as follows.
> > > > > > > 
> > > > > > > ...
> > > > > > > Uniform Multi-Platform E-IDE driver
> > > > > > > cmd64x 0000:00:02.0: IDE controller (0x1095:0x0646 rev 0x07)
> > > > > > > cmd64x 0000:00:02.0: IDE port disabled
> > > > > > > cmd64x 0000:00:02.0: 100% native mode on irq 28
> > > > > > > PCI: Setting latency timer of device 0000:00:02.0 to 64
> > > > > > >     ide0: BM-DMA at 0x8040-0x8047
> > > > > > > Floppy drive(s): fd0 is 2.88M
> > > > > > > ide0 at 0x8050-0x8057,0x8062 on irq 28 (serialized)
> > > > > > > ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
> > > > > > > ide1 at 0x1f0-0x1f7,0x3f6 on irq 14
> > > > > > > ide2 at 0x170-0x177,0x376 on irq 15
> > > > > > > ide-gd driver 1.18
> > > > > > > ide-cd driver 5.00
> > > > > > > ...
> > > > > > > 
> > > > > > > Reverting the commit is not possible due to context changes.
> > > > > > > 
> > > > > > > Bisect log is attached.
> > > > > > 
> > > > > > Ok thanks. Can you please check if the diff below fixes the issue ?
> > > > > > 
> > > > > It does. Feel free to add
> > > > > 
> > > > > Tested-by: Guenter Roeck <linux@roeck-us.net>
> > > > > 
> > > > > to the actual patch.
> > > > > 
> > > > > > I think the problem is that now we allocate the IRQ at device_probe
> > > > > > instead of device_add time, if the patch below fixes the issue the
> > > > > > question is whether we want to move pci_assign_irq() to pci_device_add()
> > > > > > for ALL PCI devices or just fix this for IDE subsytem.
> > > > > > 
> > > > > 
> > > > > That I can not answer ...
> > > > 
> > > > It is not a clean-cut answer. Moving pci_assign_irq() from
> > > > 
> > > > pci_device_probe()
> > > > 
> > > > to
> > > > 
> > > > pci_device_add()
> > > > 
> > > > would fix this issue too and just map/swizzle() irqs for ALL PCI devices
> > > > earlier (even ones that are not even probed); it should have no side
> > > > effects (famous last words) and would be a cleaner fix.
> > 
> > Hmmm, this is ugly.  I *think* this is related to ide_pci_init_two().
> > We already call pci_assign_irq() from pci_device_probe(), where we try
> > to bind one device to a driver.  But ide_pci_init_two() deals with
> > *two* devices: the one pci_device_probe() is trying to bind, and
> > another random one found via pci_get_slot().  We have not called
> > pci_assign_irq() for this second device.
> > 
> > That breaks the model the PCI core expects, where we call the driver
> > probe method for device X, and that method deals only with device X.
> > 
> > We can fix this by doing the pci_assign_irq() either in the PCI core's
> > device add path or in the driver's probe path (ide_pci_init_two(), as
> > in the patch below).  Doing it in the PCI core is sort of ugly because
> > there's no obvious reason why we should map/swizzle the IRQ if there's
> > no driver.
> > 
> > Doing it in the driver is also sort of ugly because this is something
> > that should be confined to the core (pci_assign_irq() probably should
> > be declared in drivers/pci/pci.h so it's not available outside the
> > core).
> > 
> > I think the patch below means we call pci_assign_irq() *twice* on the
> > device we're binding: once from pci_device_probe() and again from
> > do_ide_setup_pci_device().  And I guess we might call it twice for the
> > second device, too: once from do_ide_setup_pci_device() and again if
> > pci_device_probe() tries to bind it.  It's probably idempotent, but it
> > does seem a little ugly.
> > 
> > I guess I agree that calling pci_assign_irq() from pci_device_add() is
> > the lesser evil.  That will do it unnecessarily in cases where a
> > device doesn't have a driver, but it should be safe.  It sets
> > pdev->irq but probably doesn't touch the device itself.
> 
> I will do that, actually this would reinstate the exact boot stage at
> which pci_fixup_irqs() was called (except that pci_assign_irq() does
> that on a per host-bridge basis and in core code) because
> pci_fixup_irqs() was called after enumeration before PCI devices were
> added (ie before calling pci_bus_add_devices()), it *should* be safe.
> 
> > We do more IRQ setup at pci_enable_device()-time (or probe-time for
> > arm64) via acpi_pci_irq_enable().  This also updates pdev->irq.  I'd
> > rather not do that part at device add-time, because it does things
> > like allocate and enable interrupt links, and we shouldn't do that
> > until we know we have a driver for the device.
> > 
> > But this is potentially another problem for this "second-device" thing
> > IDE does.  We've called pci_assign_irq() but not acpi_pci_irq_enable()
> > for the second device, so we may still get the wrong IRQ for it.
> 
> I have not touched the ACPI irq assignment path with my patches on
> purpose. Put it differently, PNP0A03 host bridges do not have any
> {map/swizzle}_irq() hook (yet) so pci_assign_irq() does nothing on
> them. ACPI based platforms never used pci_fixup_irqs() so I changed
> nothing on them (and I doubt I can given how complicated x86 legacy
> IRQ assignment code is in arch code).

Right.  This isn't a problem with your patches; it's just a problem
with the ide_pci_init_two() strategy of looking at dev->irq for a
device for which the core hasn't called the probe path.

Bjorn
