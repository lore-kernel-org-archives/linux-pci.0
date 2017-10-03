Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 Oct 2017 14:17:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH v2] drivers/ide/pci: Fix legacy IRQ assignment
Message-ID: <20171003191759.GC25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1506941567-10762-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506941567-10762-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 02, 2017 at 11:52:47AM +0100, Lorenzo Pieralisi wrote:
> Through struct pci_host_bridge->{map/swizzle}_irq() hooks is now
> possible to define IRQ mapping functions on a per PCI host bridge basis.
> 
> Actual IRQ allocation is carried out by the pci_assign_irq() function in
> pci_device_probe() - to make sure a device is assigned an IRQ only if it
> is probed (ie match a driver); it retrieves a struct pci_host_bridge*
> for a given PCI device and through {map/swizzle}_irq() it carries out
> the PCI IRQ allocation.
> 
> The code conversion to struct pci_host_bridge {map/swizzle}_irq() hooks
> and pci_assign_irq() to deal with legacy IRQs in
> 
> commit 30fdfb929e82 ("PCI: Add a call to pci_assign_irq() in
> pci_device_probe()")
> 
> did not take into account that the IDE subsystem relies on a special
> purpose IDE PCI layer, configured by CONFIG_IDEPCI_PCIBUS_ORDER to force
> devices probe ordering by sidestepping the core PCI bus layer entirely
> (and therefore pci_device_probe()) by executing the registered IDE PCI
> drivers probe routines (ie registered with ide_pci_register_driver())
> through ide_scan_pcidev().
> 
> Since this IDE PCI specific probe mechanism bypasses the PCI core
> code generic probing (ie pci_device_probe()) it also misses the
> pci_assign_irq() call (among other PCI initialization functions);
> this triggers IDE PCI devices initialization failures caused
> by the missing IRQ allocation:
> 
> ide0: disabled, no IRQ
> ide0: failed to initialize IDE interface
> ide0: disabling port
> cmd64x 0000:00:02.0: IDE controller (0x1095:0x0646 rev 0x07)
> CMD64x_IDE 0000:00:02.0: BAR 0: can't reserve [io  0x8050-0x8057]
> cmd64x 0000:00:02.0: can't reserve resources
> CMD64x_IDE: probe of 0000:00:02.0 failed with error -16
> ide_generic: please use "probe_mask=0x3f" module parameter for probing
> all legacy ISA IDE ports
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x94/0xd0
> sysfs: cannot create duplicate filename '/class/ide_port/ide0'
> ...
> 
> Trace:
> [<fffffc00003308a0>] __warn+0x160/0x190
> [<fffffc000048c9f4>] sysfs_warn_dup+0x94/0xd0
> [<fffffc0000330928>] warn_slowpath_fmt+0x58/0x70
> [<fffffc000048c9f4>] sysfs_warn_dup+0x94/0xd0
> [<fffffc0000486d40>] kernfs_path_from_node+0x30/0x60
> [<fffffc00004874ac>] kernfs_put+0x16c/0x2c0
> [<fffffc00004874ac>] kernfs_put+0x16c/0x2c0
> [<fffffc000048d010>] sysfs_do_create_link_sd.isra.2+0x100/0x120
> [<fffffc00005b9d64>] device_add+0x2a4/0x7c0
> [<fffffc00005ba5cc>] device_create_groups_vargs+0x14c/0x170
> [<fffffc00005ba518>] device_create_groups_vargs+0x98/0x170
> [<fffffc00005ba690>] device_create+0x50/0x70
> [<fffffc00005df36c>] ide_host_register+0x48c/0xa00
> [<fffffc00005df330>] ide_host_register+0x450/0xa00
> [<fffffc00005ba2a0>] device_register+0x20/0x50
> [<fffffc00005df330>] ide_host_register+0x450/0xa00
> [<fffffc00005df944>] ide_host_add+0x64/0xe0
> [<fffffc000079b41c>] kobject_uevent_env+0x16c/0x710
> [<fffffc0000310288>] do_one_initcall+0x68/0x260
> [<fffffc00007b13bc>] kernel_init+0x1c/0x1a0
> [<fffffc00007b13a0>] kernel_init+0x0/0x1a0
> [<fffffc0000311868>] ret_from_kernel_thread+0x18/0x20
> [<fffffc00007b13a0>] kernel_init+0x0/0x1a0
> 
> ---[ end trace 24a70433c3e4d374 ]---
> ide0: disabling port
> 
> Fix the IRQ allocation issue by adding a pci_assign_irq() call in the
> ide_scan_pcidev() function before probing the IDE PCI drivers, so that
> IRQs for a given PCI device are allocated for the IDE PCI drivers to
> use them for device configuration.
> 
> Fixes: 30fdfb929e82 ("PCI: Add a call to pci_assign_irq() in pci_device_probe()")
> Link: http://lkml.kernel.org/r/32ec730f-c1b0-5584-cd35-f8a809122b96@roeck-us.net
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Matt Turner <mattst88@gmail.com>

Applied with Guenter's tested-by, Bartlomiej's reviewed-by, and
David's ack to for-linus for v4.14, thanks!

I edited the changelog as follows (so Google can find this
discussion):

  ide: fix IRQ assignment for PCI bus order probing
  
  We used to assign IRQs for all devices at boot-time, before any drivers
  claimed devices.  The following commits:
  
    30fdfb929e82 ("PCI: Add a call to pci_assign_irq() in pci_device_probe()")
    0e4c2eeb758a ("alpha/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks")
  
  changed this so we now call pci_assign_irq() from pci_device_probe() when
  we call a driver's probe method.
  
  The ide_scan_pcibus() path (enabled by CONFIG_IDEPCI_PCIBUS_ORDER) bypasses
  pci_device_probe() so it can guarantee devices are claimed in order of PCI
  bus address.  It calls the driver's probe method directly, so it misses the
  pci_assign_irq() call (and other PCI initialization functions), which
  causes failures like this:


> ---
> v1->v2
> 
> - Moved fix from PCI core code to IDE subsystem following further
>   debugging and mailing list discussions
> - Rebased against v4.14-rc3
> 
>  drivers/ide/ide-scan-pci.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ide/ide-scan-pci.c b/drivers/ide/ide-scan-pci.c
> index 86aa88a..acf8748 100644
> --- a/drivers/ide/ide-scan-pci.c
> +++ b/drivers/ide/ide-scan-pci.c
> @@ -56,6 +56,7 @@ static int __init ide_scan_pcidev(struct pci_dev *dev)
>  {
>  	struct list_head *l;
>  	struct pci_driver *d;
> +	int ret;
>  
>  	list_for_each(l, &ide_pci_drivers) {
>  		d = list_entry(l, struct pci_driver, node);
> @@ -63,10 +64,14 @@ static int __init ide_scan_pcidev(struct pci_dev *dev)
>  			const struct pci_device_id *id =
>  				pci_match_id(d->id_table, dev);
>  
> -			if (id != NULL && d->probe(dev, id) >= 0) {
> -				dev->driver = d;
> -				pci_dev_get(dev);
> -				return 1;
> +			if (id != NULL) {
> +				pci_assign_irq(dev);
> +				ret = d->probe(dev, id);
> +				if (ret >= 0) {
> +					dev->driver = d;
> +					pci_dev_get(dev);
> +					return 1;
> +				}
>  			}
>  		}
>  	}
> -- 
> 2.4.12
> 
