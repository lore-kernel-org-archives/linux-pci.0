Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Fri, 18 Nov 2016 11:00:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Remove service driver load/unload messages
Message-ID: <20161118100043.GA12190@wunner.de>
References: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161116221310.15842.25671.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161117134042.GA11658@wunner.de>
 <20161117204934.GC22428@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161117204934.GC22428@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 17, 2016 at 02:49:34PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 17, 2016 at 02:40:42PM +0100, Lukas Wunner wrote:
> > On Wed, Nov 16, 2016 at 04:13:10PM -0600, Bjorn Helgaas wrote:
> > > Remove the "service driver %s loaded" and unloaded messages.  I don't think
> > > these add any useful information.
> > 
> > I think those particular ones have a value to some extent because
> > they communicate for which of the port's capabilities a driver is
> > available and loaded.  For ports below a hotplug port they also
> > comunicate the steps to unbind the ports from their drivers when
> > the device is unplugged.
> 
> None of the service drivers can be modules anymore.  I think if we
> want a clue about whether a service driver is attached to a device, we
> should add something to the service driver, where we can print more
> useful information.  In general I want to move towards thinking about
> the service drivers as optional parts of the PCI core instead of
> separate "drivers."

The issue with making the port services modules was that user space
doesn't load them when they're needed.  We could have solved this in
the kernel by amending get_port_device_capability() to call
find_module() and then try_module_get() to load the module for a port
service and acquire a reference on it upon discovery of the services
supported by a probed port.  Then in pcie_port_device_remove() the
references on the loaded modules would have to be released with
module_put().

Most users just run the kernel that comes with their distro, and
distro vendors frequently use a "one size fits all" kernel package
regardless if the machine is a tiny netbook or a big-iron server.
They will enable all port services to support all configurations
and because this is all compiled in, the kernel keeps that code
resident in memory even if the port services are never used.
An uncompressed x86_64 vmlinux with the standard Debian configuration
currently clocks in at around 30 MByte...


> > E.g. when I plug in the Apple Thunderbolt Ethernet adapter I get this
> > because a new hotplug port appears below the hotplug port of the host
> > controller:
> > [  141.926865] pciehp 0000:0a:00.0:pcie204: service driver pciehp loaded
> 
> For example, for pciehp, you should already see something like this:
> 
>   pciehp 0000:80:02.0:pcie04: Slot #6 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
> 
> Is that enough?  Or maybe we don't emit this message in your case for
> some reason?

It's sufficient but I'm not sure all port services print such a
welcome message.

Thanks,

Lukas

> 
> > On unplug I get this:
> > [  202.497548] pciehp 0000:0a:00.0:pcie204: unloading service driver pciehp
> 
> I'm not sure we print anything when we remove a device; maybe we
> should.
> 
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  drivers/pci/pcie/portdrv_core.c |    3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > > index e9270b4..9698289 100644
> > > --- a/drivers/pci/pcie/portdrv_core.c
> > > +++ b/drivers/pci/pcie/portdrv_core.c
> > > @@ -499,7 +499,6 @@ static int pcie_port_probe_service(struct device *dev)
> > >  	if (status)
> > >  		return status;
> > >  
> > > -	dev_printk(KERN_DEBUG, dev, "service driver %s loaded\n", driver->name);
> > >  	get_device(dev);
> > >  	return 0;
> > >  }
> > > @@ -524,8 +523,6 @@ static int pcie_port_remove_service(struct device *dev)
> > >  	pciedev = to_pcie_device(dev);
> > >  	driver = to_service_driver(dev->driver);
> > >  	if (driver && driver->remove) {
> > > -		dev_printk(KERN_DEBUG, dev, "unloading service driver %s\n",
> > > -			driver->name);
> > >  		driver->remove(pciedev);
> > >  		put_device(dev);
> > >  	}
> > > 
