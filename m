Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy1-pub.bluehost.com ([66.147.249.253]:44309 "HELO
	oproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751560Ab2A0Rii (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2012 12:38:38 -0500
Date: Fri, 27 Jan 2012 09:38:35 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai.lu@oracle.com>
Subject: Re: [PATCH] PCI: workaround hard-wired bus number
Message-ID: <20120127093835.1d2737db@jbarnes-desktop>
In-Reply-To: <CAErSpo54EuF3ZmiHZmCvTK5vd0oHws7W+82WPYwLQ9PeL1MG6g@mail.gmail.com>
References: <1327655507-33999-1-git-send-email-trenn@suse.de>
	<CAErSpo54EuF3ZmiHZmCvTK5vd0oHws7W+82WPYwLQ9PeL1MG6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/2jF.XaLTNEalA17zRxyXtAg"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/2jF.XaLTNEalA17zRxyXtAg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jan 2012 09:26:16 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Fri, Jan 27, 2012 at 2:11 AM, Thomas Renninger <trenn@suse.de> wrote:
> > From: Yinghai Lu <yinghai.lu@oracle.com>
> >
> > Fixes PCI device detection on IBM xSeries IBM 3850 M2 / x3950 M2
> > when using ACPI resources (_CRS).
> > This is default, a manual workaround (without this patch)
> > would be pci=3Dnocrs boot param.
> >
> > Tested-by: garyhade@us.ibm.com
> > CC: trenn@suse.de
> > CC: bhelgaas@google.com
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > ---
> > =A0drivers/pci/probe.c | =A0 =A04 ++++
> > =A01 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 7cc9e2f..1e255c8 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -651,6 +651,10 @@ int __devinit pci_scan_bridge(struct pci_bus *bus,=
 struct pci_dev *dev, int max,
> > =A0 =A0 =A0 =A0dev_dbg(&dev->dev, "scanning [bus %02x-%02x] behind brid=
ge, pass %d\n",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0secondary, subordinate, pass);
> >
> > + =A0 =A0 =A0 /* some bridge primary bus is hard wired to 0 */
> > + =A0 =A0 =A0 if (!primary && (primary !=3D bus->number) && secondary &=
& subordinate)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 primary =3D bus->number;
> > +
> > =A0 =A0 =A0 =A0/* Check if setup is sensible at all */
> > =A0 =A0 =A0 =A0if (!pass &&
> > =A0 =A0 =A0 =A0 =A0 =A0(primary !=3D bus->number || secondary <=3D bus-=
>number)) {
> > --
> > 1.7.6.1
> >
>=20
> I'm not thrilled with adding a machine-specific quirk in this generic
> code path because future rework of this path will always have to
> consider and preserve it.
>=20
> I wonder whether it would be possible to set this up so we read
> PCI_PRIMARY_BUS earlier, so we could update that primary bus number in
> a quirk before getting into the rest of pci_scan_bridge().  That might
> take non-trivial rework, since the cached copy of the primary bus
> number is currently in struct pci_bus, not in struct pci_dev.  But
> that in itself is non-intuitive to me: the primary, secondary, and
> subordinate bus numbers are all in struct pci_bus, when they seem more
> like a property of the bridge device than of the bus.
>=20
> If we put something like this in mainline, I think it needs a bugzilla
> reference, preferably in bugzilla.kernel.org, where the details (DMI
> info, vendor/device ID of the bridge, etc.) will be public (there is a
> Novell bugzilla, but I don't think it's public).

Thomas or Yinghai, any references for this one just in case someone
wants to clean it up later or get testing for a related change?

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/2jF.XaLTNEalA17zRxyXtAg
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPIuEbAAoJEIEoDkX4Qk9h1FoQAIacpI0eFeeiBdVNpQ0gVZWE
neeAAbLbdXkrh9QdrNjOrqdbDx13e+a/exU8GnoovbDPeKHXy+X5qnyqvJtcwkCL
SNxUWFZSboiA1h3yAcOeJfn61GdrFXhdqorRFAuMWROpI+rSbq7J2bWxU/gCt/KC
rUOT2i1ULdeVW0MgZCGSl6gKsWydd67b/JK+o1OzidAtoNKPQTIVQD29qBLAALoU
MbLnbVCYvd88k44xHLS9/EeiEEIk/rfLHb30rknw0MUbnnhqkD5S1QZzIVxYa+Vg
TVItfZBKS37eBYLWhKbPlNLEm0dDNpYXtZdW8/xAyOVQmyfWtfMW0J3cpFTgvHwu
+350JXyZ6dEP+2AuLz9gwPDzUbsjulRJqSbNgzgs0YhV34TRzzEwvmHZETZTFHAd
Ky8d2dNlibY+QjoSOH4H43HCrJrys0n5/fKJNNumLHKRnztOndydZiJBzQtWj1NM
3MWU71YpgHcoP2nl2tixNtt05KS/3Cv69ZZ6qqeJkURgGZ8xvfLNnf/hpgVxPc84
ATxZQQtGfdlwccB7+hXM9cH5wvQTtQs5d+jKZparwSd04iMNLBLOhv+RTZY5RZoc
NKv2XUCyhAKhgt3ixPCBEwjkmaz1CzWlwMNM4VXdckvIrw+QSi73HreTpiYDGll8
H02zy3NakQ7ucVTZoBbs
=2BzZ
-----END PGP SIGNATURE-----

--Sig_/2jF.XaLTNEalA17zRxyXtAg--
