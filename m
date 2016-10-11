Return-Path: <flyos@mailoo.org>
Return-Path: <flyos@mailoo.org>
From: Pierre de Villemereuil <flyos@mailoo.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
Date: Wed, 12 Oct 2016 09:27:06 +1300
Message-ID: <1592720.zmCgj0tZJa@flyosflip>
In-Reply-To: <Pine.LNX.4.44L0.1610111117040.1827-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1610111117040.1827-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

Hi!

I'm sorry, I'm not savvy enough to know what to do with this (I know=20
basics on how to code and compile, but I'm no dev). Could someone=20
guide me through it?

I gather this patch needs to be applied to some kernel module code=20
which needs to be compiled and reloaded into my current kernel,=20
right?

Sorry to let you down...

Cheers,
Pierre.

Le mardi 11 octobre 2016, 11:18:28 NZDT Alan Stern a =C3=A9crit :
> On Sat, 8 Oct 2016, Lukas Wunner wrote:
> > The PCI core already calls pm_runtime_get_sync() before invoking=20
the
> > ->probe hook of a driver (see local_pci_probe()).  Drivers need=20
to
> > explicitly release a runtime ref to allow their device to=20
suspend.
> >=20
> > For xhci-pci, this seems to happen in usb_hcd_pci_probe():
> > 	if (pci_dev_run_wake(dev))
> > =09
> > 		pm_runtime_put_noidle(&dev->dev);
> >=20
> > So you could either modify the if-condition if you want to=20
change the
> > behaviour for XHCI devices only, or if you want to change it in=20
general,
> >=20
> > add something like this to pci_dev_run_wake():
> > 	/* PME capable in principle, but not from the intended sleep=20
state */
> > 	if (dev->pme_support && !pci_pme_capable(dev,=20
pci_target_state(dev)))
> > =09
> > 		return false;
> >=20
> > I've briefly looked over the callers of pci_dev_run_wake() and=20
the above
> > seems safe but you should double-check them.
>=20
> That seems like a good suggestion.  The patch is below; Pierre,=20
can you
> test it?  This should remove the need to set the USB autosuspend=20
module
> parameter to -1.
>=20
> Alan Stern
>=20
>=20
>=20
> Index: usb-4.x/drivers/pci/pci.c
>=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-4.x.orig/drivers/pci/pci.c
> +++ usb-4.x/drivers/pci/pci.c
> @@ -2064,6 +2064,10 @@ bool pci_dev_run_wake(struct pci_dev *de
>  	if (!dev->pme_support)
>  		return false;
>=20
> +	/* PME-capable in principle, but not from the intended sleep=20
state */
> +	if (!pci_pme_capable(dev, pci_target_state(dev)))
> +		return false;
> +
>  	while (bus->parent) {
>  		struct pci_dev *bridge =3D bus->self;
