Return-Path: <SRS0=yCvU=LB=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=yCvU=LB=kernel.crashing.org=benh@kernel.org>
Message-ID: <8dafc92f9c9cefba89ec1ec9839d086540af4557.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 2/6] pci: Set pci_dev->is_added before calling
 device_add
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui
 <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Lukas
 Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov
 <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org
Date: Sat, 18 Aug 2018 13:28:15 +1000
In-Reply-To: <20180817162534.GD128050@bhelgaas-glaptop.roam.corp.google.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
	 <20180817044902.31420-3-benh@kernel.crashing.org>
	 <20180817162534.GD128050@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-17 at 11:25 -0500, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2018 at 02:48:58PM +1000, Benjamin Herrenschmidt wrote:
> > This re-fixes the bug reported by Hari Vyas <hari.vyas@broadcom.com>
> > after my revert of his commit but in a much simpler way.
> > 
> > The main issues is that is_added was being set after the driver
> > got bound and started, and thus setting it could race with other
> > changes to struct pci_dev.
> 
> The "bind driver, then set dev->added = 1" order seems to have been
> there since the beginning of dev->is_added:
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8a1bc9013a03
> 
> This patch seems reasonable, but I'm a little dubious about the
> existence of "is_added" in the first place.  As far as I can tell, the
> only other buses with something similar are the MEN Chameleon bus and
> the Intel Management Engine Interface.
> 
> The PCI uses of "is_added" don't seem *that* critical or unique to
> PCI, so I'm not 100% convinced we need it at all.  But I haven't
> looked into it enough to be able to propose an alternative.

This is a whole different conversation you are taking us into :-)

is_added is currently needed for a number of reasons, mostly relating
to partial hotplug, and historically comes from the fact that we
separated the PCI probing & tree construction from the registration
with the device-model. This of course comes from the fact that the
device model didn't actually exist yet when the PCI code was
created :-)

So let's keep things separate shall we ? I'd rather fix this correctly
now, and get rid of that pesky atomic priv_flags which I think is just
going to be a long term add to the mess rather than an improvement, and
separately we can discuss whether is_added is something that can go
away, but I suspect this will come in the form of either a deeper
rework of how we do PCI probing, or simply finding a struct device/kobj
field we can use as a hint that we've added the device already for
hotplug.

> > This fixes it by setting the flag first, which also has the
> > advantage of matching the fact that we are clearing it *after*
> > unbinding in the remove path, thus the flag is now symtetric
> > and always set while the driver code is running.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  drivers/pci/bus.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 35b7fc87eac5..48ae63673aa8 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -321,16 +321,16 @@ void pci_bus_add_device(struct pci_dev *dev)
> >  	pci_proc_attach_device(dev);
> >  	pci_bridge_d3_update(dev);
> >  
> > +	dev->is_added = 1;
> >  	dev->match_driver = true;
> >  	retval = device_attach(&dev->dev);
> >  	if (retval < 0 && retval != -EPROBE_DEFER) {
> > +		dev->is_added = 0;
> >  		pci_warn(dev, "device attach failed (%d)\n", retval);
> >  		pci_proc_detach_device(dev);
> >  		pci_remove_sysfs_dev_files(dev);
> >  		return;
> >  	}
> > -
> > -	dev->is_added = 1;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_bus_add_device);
> >  
> > -- 
> > 2.17.1
> > 
