Return-Path: <mathias.koehrer@etas.com>
Return-Path: <mathias.koehrer@etas.com>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] Extending kernel option pci=resource_alignment to be able
 to specify PCI device/vendor IDs
Date: Thu, 9 Jun 2016 12:40:30 +0000
Message-ID: <a6dc1dbf212c46fc99533fff0b1720cd@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

can you please comment on that?
> > > Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>
> > >
> > > ---
> > >  Documentation/kernel-parameters.txt |    2 +
> > >  drivers/pci/pci.c                   |   66 +++++++++++++++++++++++++=
-----------
> > >  2 files changed, 49 insertions(+), 19 deletions(-)
> >
> > This looks better, but wow, messy.  I'll defer to the PCI maintainer
> > and developers now, this is in their camp, not mine :)
> It looks messy as I had to change the indentation of existing code...
> A "diff -u -w" on pci.c delivers a much simpler diff:
>=20
> --- pci.c.orig	2016-05-29 16:29:24.000000000 +0000
> +++ pci.c	2016-06-08 06:08:05.000000000 +0000
> @@ -4755,6 +4755,7 @@
>  static resource_size_t pci_specified_resource_alignment(struct pci_dev *=
dev)
> {
>  	int seg, bus, slot, func, align_order, count;
> +	unsigned short vendor, device, subsystem_vendor, subsystem_device;
>  	resource_size_t align =3D 0;
>  	char *p;
>=20
> @@ -4768,6 +4769,32 @@
>  		} else {
>  			align_order =3D -1;
>  		}
> +		if (strncmp(p, "pci:", 4) =3D=3D 0) {
> +			/* PCI vendor/device (subvendor/subdevice) ids are
> specified */
> +			p +=3D 4;
> +			if (sscanf(p, "%hx:%hx:%hx:%hx%n",
> +				&vendor, &device, &subsystem_vendor,
> &subsystem_device, &count) !=3D 4) {
> +				if (sscanf(p, "%hx:%hx%n", &vendor, &device,
> &count) !=3D 2) {
> +					printk(KERN_ERR "PCI: Can't parse
> resource_alignment parameter: pci:%s\n",
> +						p);
> +					break;
> +				}
> +				subsystem_vendor =3D subsystem_device =3D 0;
> +			}
> +			p +=3D count;
> +			if ((!vendor || (vendor =3D=3D dev->vendor)) &&
> +				(!device || (device =3D=3D dev->device)) &&
> +				(!subsystem_vendor || (subsystem_vendor =3D=3D
> dev->subsystem_vendor)) &&
> +				(!subsystem_device || (subsystem_device =3D=3D
> dev->subsystem_device))) {
> +				if (align_order =3D=3D -1)
> +					align =3D PAGE_SIZE;
> +				else
> +					align =3D 1 << align_order;
> +				/* Found */
> +				break;
> +			}
> +		}
> +		else {
>  		if (sscanf(p, "%x:%x:%x.%x%n",
>  			&seg, &bus, &slot, &func, &count) !=3D 4) {
>  			seg =3D 0;
> @@ -4791,6 +4818,7 @@
>  			/* Found */
>  			break;
>  		}
> +		}
>  		if (*p !=3D ';' && *p !=3D ',') {
>  			/* End of param or invalid format */
>  			break;
>=20
>=20
Thanks
Mathias
