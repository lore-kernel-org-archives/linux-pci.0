Return-Path: <mathias.koehrer@etas.com>
Return-Path: <mathias.koehrer@etas.com>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "hjk@hansjkoch.de"
	<hjk@hansjkoch.de>
Subject: Re: [PATCH] Extending kernel option pci=resource_alignment to be able
 to specify PCI device/vendor IDs
Date: Mon, 8 Aug 2016 07:39:01 +0000
Message-ID: <9224b5d57cf14c5da4979251742b838b@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

> On Tue, Jun 07, 2016 at 02:24:17PM +0000, Koehrer Mathias (ETAS/ESW5) wro=
te:
> > Some uio based PCI drivers (e.g. uio_cif) do not work if the assigned
> > PCI memory resources are not page aligned.
> > By using the kernel option "pci=3Dresource_alignment" it is possible to
> > force single PCI boards to use page alignment for their memory resource=
s.
> > However, this is fairly cumbersome if multiple of these boards are in
> > use as the specification of the cards has to be done via PCI
> > bus/slot/function number which might change e.g. by adding another boar=
d.
> > This patch extends the kernel option "pci=3Dresource_alignment" to allo=
w
> > to specify the relevant boards via PCI device/vendor (and subdevice/sub=
vendor)
> ids.
> > The specification of the devices via device/vendor is indicated by a
> > leading string "pci:" as argument to "pci=3Dresource_alignment".
> > The format of the specification is
> >   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> >
> > Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>
> >
> > ---
> >  Documentation/kernel-parameters.txt |    2 +
> >  drivers/pci/pci.c                   |   66 +++++++++++++++++++++++++--=
---------
> >  2 files changed, 49 insertions(+), 19 deletions(-)
> >
> > Index: linux-4.7-rc1/Documentation/kernel-parameters.txt
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D
> > --- linux-4.7-rc1.orig/Documentation/kernel-parameters.txt
> > +++ linux-4.7-rc1/Documentation/kernel-parameters.txt
> > @@ -2998,6 +2998,8 @@ bytes respectively. Such letter suffixes
> >  		resource_alignment=3D
> >  				Format:
> >  				[<order of
> align>@][<domain>:]<bus>:<slot>.<func>[; ...]
> > +				[<order of align>@]pci:<vendor>:<device>\
> > +						[:<subvendor>:<subdevice>][; ...]
>=20
> Can you include a little example here so we know whether to use "pci:8086=
:1234" or
> "pci:0x8086:0x1234"?
>=20
> Bjorn

I have provided an example and extended the docu (sent in  http://marc.info=
/?l=3Dlinux-pci&m=3D146657769505684&w=3D2 and http://marc.info/?l=3Dlinux-p=
ci&m=3D146918412704107&w=3D2 ).
It would be great if you could comment on the modified patch...

Thanks=20

Best regards

Mathias
