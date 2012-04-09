Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:40491 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757215Ab2DIPQs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2012 11:16:48 -0400
Date: Mon, 9 Apr 2012 08:16:43 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Chunhe Lan <b25806@freescale.com>
Cc: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: PCIe: Fix uninitialized variable 'cap_mask'
Message-ID: <20120409081643.18ecfbc2@jbarnes-desktop>
In-Reply-To: <4F8252C0.9060002@freescale.com>
References: <1331104586-5720-1-git-send-email-Chunhe.Lan@freescale.com>
	<4F8252C0.9060002@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/c6U+_cykfW_bPlIfUTaaZc4"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/c6U+_cykfW_bPlIfUTaaZc4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Apr 2012 11:08:48 +0800
Chunhe Lan <b25806@freescale.com> wrote:

>=20
>=20
> Chunhe Lan wrote:
> > Get rid of these:
> >
> > drivers/pci/pcie/portdrv_core.c: In function 'pcie_port_device_register=
':
> > drivers/pci/pcie/portdrv_core.c:275:16: warning: 'cap_mask' may be used
> > uninitialized in this function [-Wuninitialized]
> > drivers/pci/pcie/portdrv_core.c:240:6: note: 'cap_mask' was declared he=
re
> >
> > In some cases, 'cap_mask' may be not set in pcie_port_platform_notify,
> > holding a garbage value.
> >
> > Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> > ---
> >  drivers/pci/pcie/portdrv_core.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv=
_core.c
> > index 595654a..751b464 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -237,7 +237,7 @@ static int get_port_device_capability(struct pci_de=
v *dev)
> >  	int services =3D 0, pos;
> >  	u16 reg16;
> >  	u32 reg32;
> > -	int cap_mask;
> > +	int cap_mask =3D 0;
> >  	int err;
> > =20
> >  	if (pcie_ports_disabled)
> >  =20
> Hello Jesse Barnes,
>=20
>   Have you any comment about this patch?
>   It locates at http://article.gmane.org/gmane.linux.kernel.pci/14062
>=20
>   If it has not question, can you merge it to your git tree?

Yeah patch looks fine, bounce it over to Bjorn if you want it applied.

I didn't check where it gets used though, and whether 0xffffffff would
be a better default mask value or not.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/c6U+_cykfW_bPlIfUTaaZc4
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPgv1bAAoJEIEoDkX4Qk9hF/EQAIJjTgN3lhU9wrm/dqW6uXnI
hJsFCI1pZvvZNdn4eq/eYurl8t/uxxATrD1xmHo5MvZu1uRm0Cogi+K6eP2NSHTY
PLa7yLM2Eg5EKwTOUSSOa+X5xgQ+RhA0LglEdIP5ZrmlVbnoFv6o7XAoa0KF4wcA
85WvCyVSu/eNRi9woyGG39OCmiMH3bVldcKaJkCTC2GKjH8j3WjVbCNPGBPuSnPT
PpAf9ucq0HRakgMgtTOUOkZcMUb35mtsiIc7qPYUkGf4EYMANIE/x8zsRIqGTk4d
CE94xG4pUy0nSJ+JeGfTXp4buauvdaCCnbhWx5erOvP13hb7sU5rkAfTOAGwytWG
l8tafUX+E9uL8PWALZMtFwiXAFgBmVF+GsgC0b4v3cbNxzT98dTuKsYlk3uRa6fL
DhbRq2BScAPNi5fFXJXayXdqd9VbzB9uJiRQEU9V2ow8pXDgiIqJJRw5B8P6xZS9
MdlfSU+cAGwIQyp0AuMIHzKsJ45nK5yvufT/w2GdWwx6vstHsK8nvfcHLJlJcRFr
jGZQogTqZknU8zhRwfFl4BlCUtv4PPoSacjlm+LfUln/goeJJRHd8rnRFf3+ePGv
oywtkwSvcvX4xFv4fXifZfrgDwQN2d5mzLw3b7DeOBSYJEMzE8Zg/vmqQKuw05DE
+saFbXnUTdAwmpd7f44l
=juOK
-----END PGP SIGNATURE-----

--Sig_/c6U+_cykfW_bPlIfUTaaZc4--
