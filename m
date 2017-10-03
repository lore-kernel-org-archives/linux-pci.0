Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 Oct 2017 14:11:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] ide: add missing hwif->portdev freeing on hwif_init()
 failure
Message-ID: <20171003191108.GA25517@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20171003111849epcas1p3335e2bc56e5aafdeadc340301284b2b8@epcas1p3.samsung.com>
 <1640481.zjlggixLin@amdc3058>
 <20171003175742.GC27400@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171003175742.GC27400@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 03, 2017 at 12:57:42PM -0500, Bjorn Helgaas wrote:
> [+cc linux-pci for real]
> 
> My plan is to take these two additional fixes via the PCI tree, along
> with Lorenzo's patch to add a pci_assign_irq() call in
> ide_scan_pcidev(), since they're all related.
> 
> On Tue, Oct 03, 2017 at 01:18:47PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Recent pci_assign_irq() changes uncovered a problem with missing
> > freeing of ide_port class instance on hwif_init() failure in 
> > ide_host_register():
> > 
> > ide0: disabled, no IRQ
> > ide0: failed to initialize IDE interface
> > ide0: disabling port
> > cmd64x 0000:00:02.0: IDE controller (0x1095:0x0646 rev 0x07)
> > CMD64x_IDE 0000:00:02.0: BAR 0: can't reserve [io  0x8050-0x8057]
> > cmd64x 0000:00:02.0: can't reserve resources
> > CMD64x_IDE: probe of 0000:00:02.0 failed with error -16
> > ide_generic: please use "probe_mask=0x3f" module parameter for probing
> > all legacy ISA IDE ports
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x94/0xd0
> > sysfs: cannot create duplicate filename '/class/ide_port/ide0'
> > ...
> > 
> > Trace:
> > [<fffffc00003308a0>] __warn+0x160/0x190
> > [<fffffc000048c9f4>] sysfs_warn_dup+0x94/0xd0
> > [<fffffc0000330928>] warn_slowpath_fmt+0x58/0x70
> > [<fffffc000048c9f4>] sysfs_warn_dup+0x94/0xd0
> > [<fffffc0000486d40>] kernfs_path_from_node+0x30/0x60
> > [<fffffc00004874ac>] kernfs_put+0x16c/0x2c0
> > [<fffffc00004874ac>] kernfs_put+0x16c/0x2c0
> > [<fffffc000048d010>] sysfs_do_create_link_sd.isra.2+0x100/0x120
> > [<fffffc00005b9d64>] device_add+0x2a4/0x7c0
> > [<fffffc00005ba5cc>] device_create_groups_vargs+0x14c/0x170
> > [<fffffc00005ba518>] device_create_groups_vargs+0x98/0x170
> > [<fffffc00005ba690>] device_create+0x50/0x70
> > [<fffffc00005df36c>] ide_host_register+0x48c/0xa00
> > [<fffffc00005df330>] ide_host_register+0x450/0xa00
> > [<fffffc00005ba2a0>] device_register+0x20/0x50
> > [<fffffc00005df330>] ide_host_register+0x450/0xa00
> > [<fffffc00005df944>] ide_host_add+0x64/0xe0
> > [<fffffc000079b41c>] kobject_uevent_env+0x16c/0x710
> > [<fffffc0000310288>] do_one_initcall+0x68/0x260
> > [<fffffc00007b13bc>] kernel_init+0x1c/0x1a0
> > [<fffffc00007b13a0>] kernel_init+0x0/0x1a0
> > [<fffffc0000311868>] ret_from_kernel_thread+0x18/0x20
> > [<fffffc00007b13a0>] kernel_init+0x0/0x1a0
> > 
> > ---[ end trace 24a70433c3e4d374 ]---
> > ide0: disabling port
> > 
> > Fix the problem by adding missing code to ide_host_register().
> > 
> > Link: http://lkml.kernel.org/r/32ec730f-c1b0-5584-cd35-f8a809122b96@roeck-us.net
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Matt Turner <mattst88@gmail.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied with Guenter's tested-by to for-linus for v4.14, thanks!

> > ---
> > This should fix sysfs warning and probing of ide_generic driver
> > driven ports in case of hwif_init() failure (i.e. no IRQ issue
> > when pci_assign_irq() fix is not present).
> > 
> > v2:
> > - Fixed typo in the patch description: pci_assing_irq() -> pci_assign_irq().
> > 
> >  drivers/ide/ide-probe.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > Index: b/drivers/ide/ide-probe.c
> > ===================================================================
> > --- a/drivers/ide/ide-probe.c	2017-10-02 15:08:16.658662459 +0200
> > +++ b/drivers/ide/ide-probe.c	2017-10-03 11:59:36.867189557 +0200
> > @@ -1451,6 +1451,7 @@ int ide_host_register(struct ide_host *h
> >  		if (hwif_init(hwif) == 0) {
> >  			printk(KERN_INFO "%s: failed to initialize IDE "
> >  					 "interface\n", hwif->name);
> > +			device_unregister(hwif->portdev);
> >  			device_unregister(&hwif->gendev);
> >  			ide_disable_port(hwif);
> >  			continue;
> > 
