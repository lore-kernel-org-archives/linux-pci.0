Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 29 Sep 2017 15:19:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: Fix legacy IRQ assignment execution stage
Message-ID: <20170929201946.GC31210@bhelgaas-glaptop.roam.corp.google.com>
References: <1506598627-8985-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20170928223719.GY15970@bhelgaas-glaptop.roam.corp.google.com>
 <20170929160226.GA17398@red-moon> <20170929171958.GA18114@red-moon>
MIME-Version: 1.0
In-Reply-To: <20170929171958.GA18114@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 Matt Turner <mattst88@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Guenter Roeck <linux@roeck-us.net>, Richard Henderson <rth@twiddle.net>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 29, 2017 at 06:19:58PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Sep 29, 2017 at 05:02:26PM +0100, Lorenzo Pieralisi wrote:
> > On Thu, Sep 28, 2017 at 05:37:19PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Sep 28, 2017 at 12:37:07PM +0100, Lorenzo Pieralisi wrote:
> > > > Through struct pci_host_bridge->{map/swizzle}_irq() hooks is now
> > > > possible to define IRQ mapping functions on a per PCI host bridge basis.
> > > > 
> > > > Actual IRQ allocation is carried out by the pci_assign_irq() function in
> > > > pci_device_probe() - to make sure a device is assigned an IRQ only if it
> > > > is probed (ie match a driver); it retrieves a struct pci_host_bridge*
> > > > for a given PCI device and through {map/swizzle}_irq() hooks it carries
> > > > out the PCI IRQ allocation.
> > > > 
> > > > As it turned out, some legacy drivers (eg IDE layer) require that a
> > > > device allocates IRQ as soon as it is added so that its actual IRQ
> > > > settings are available early in the boot process. With current code
> > > > calling pci_assign_irq() in pci_device_probe() IDE IRQ probing fails
> > > > for some drivers:
> > > 
> > > I think the patch is fine, but I don't understand the changelog.  I
> > > want to know specifically what the dependency on dev->irq is.  "Early
> > > in the boot process" is pretty vague.
> > > 
> > > I *thought* we were doing something like this:
> > > 
> > >   pci_device_probe(dev1)
> > >     pci_assign_irq(dev1)
> > >       ...
> > >         ide_pci_init_two(dev1, dev2, ...)
> > >           do_ide_setup_pci_device(dev1)
> > >             pciirq = dev1->irq                # this one is fine
> > >           do_ide_setup_pci_device(dev2)
> > >             pciirq = dev2->irq                # not fine
> > > 
> > > where the problem is that we haven't called pci_assign_irq(dev2), so
> > > dev2->irq hasn't been set.
> > > 
> > > But that doesn't match the data because we should be coming through
> > > cmd64x_init_one(), which calls ide_pci_init_one(), so we shouldn't
> > > have a dev2 in this path.
> > 
> > I *think* I understand what's going on here, the key is:
> > 
> > ide_scan_pcibus()
> > 
> > and CONFIG_IDEPCI_PCIBUS_ORDER
> > 
> > I still have to replicate it but I suspect that
> > do_ide_setup_pci_device() for dev1 finds an unallocated IRQ (ie dev->irq
> > == 0) because the probing did NOT happen via pci_device_probe(), ie
> > pci_device_probe() was not called for the dev1, the cmd64x probe
> > routine is called straight from ide_scan_pcidev().
> > 
> > I am struggling to understand the logic behind:
> > 
> > ide_pci_register_driver() and ide_scan_pcibus()
> > 
> > and the sequence wrt PCI bus probing but I think that's the problem
> > and that's why moving pci_assign_irq() to pci_device_add() will
> > sort this out, adding pci_assign_irq() in ide_scan_pcidev() will
> > solve the problem too (patch below).
> > 
> > Needless to say, ide_scan_pcibus() relies on pre_init global variable
> > to make sure ide_pci_register_driver() chooses the "right" way of
> > registering a driver, see:
> > 
> > __ide_pci_register_driver()
> > 
> > Patch here to verify my assumption in case Guenter has a chance to
> > run it if I do not beat him to it:
> 
> That's what's happening unfortunately.
> 
> We end up probing twice (both fails):
> 
> (1)
> 
> ->ide_scan_pcidev()
>   ->d->probe()
>      ->cmd64x_init_one()
>        ->ide_pci_init_one()
>          ->ide_pci_init_two()
>            [...]
>            -> ide_host_register() !! Fails in hwif_init(), no IRQ
> 
> (2) ->pci_device_probe()
>      ->cmd64x_init_one()
>        ->ide_pci_init_one()
>          ->ide_pci_init_two()
> 	   [...]
> 	   -> ide_pci_enable() !! Fails with -EBUSY,
> 	   pci_request_selected_regions() can't reserve already reserved
> 	   regions (ie step (1) did not unwind resource reservation)
> 
> That's my reading and patch patch below fixes it and given that
> IDE created its own PCI bus probing layer may be a more appropriate
> kludge than forcing us to move pci_assign_irq() to pci_device_add()
> for all PCI devices, please let me know what's your preferred solution.

Oh, this is lovely :(  I wonder what other things this breaks.

This IDE probing path misses the IRQ assignment, the "initialize the
driver on the device's node" stuff, the PM code, the IOV autoprobe
checks, the ACPI IRQ init in pcibios_alloc_irq(), etc.  Ugh.

I think your solution below is the best one so far.  It's still hacky
because the whole ide_scan_pcibus() is a hack, but at least this fixes
it at the point where we need it, so it's obvious why it's there and
it's clear that if we could ever get rid of ide_scan_pcibus(), we
could get rid of this pci_assign_irq() call as well.

> With fix below (1) still tries to re-probe cmd64x through
> pci_device_probe() but the device has already a driver attached
> to it so second probe stops before calling the cmd64x probe routine.
> 
> I hope Guenter can give it a go too to confirm my findings.
> 
> Lorenzo
> 
> > -- >8 --
> > diff --git a/drivers/ide/ide-scan-pci.c b/drivers/ide/ide-scan-pci.c
> > index 86aa88a..86b570a 100644
> > --- a/drivers/ide/ide-scan-pci.c
> > +++ b/drivers/ide/ide-scan-pci.c
> > @@ -56,6 +56,8 @@ static int __init ide_scan_pcidev(struct pci_dev *dev)
> >  {
> >  	struct list_head *l;
> >  	struct pci_driver *d;
> > +	int ret;
> > +
> >  
> >  	list_for_each(l, &ide_pci_drivers) {
> >  		d = list_entry(l, struct pci_driver, node);
> > @@ -63,10 +65,14 @@ static int __init ide_scan_pcidev(struct pci_dev *dev)
> >  			const struct pci_device_id *id =
> >  				pci_match_id(d->id_table, dev);
> >  
> > -			if (id != NULL && d->probe(dev, id) >= 0) {
> > -				dev->driver = d;
> > -				pci_dev_get(dev);
> > -				return 1;
> > +			if (id != NULL) {
> > +				pci_assign_irq(dev);
> > +				ret = d->probe(dev, id);
> > +				if (ret >= 0) {
> > +					dev->driver = d;
> > +					pci_dev_get(dev);
> > +					return 1;
> > +				}
> >  			}
> >  		}
> >  	}

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
