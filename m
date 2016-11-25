Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33277 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbcKYH0e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 02:26:34 -0500
Date: Fri, 25 Nov 2016 08:26:29 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI: Allow driver-specific data in host bridge
Message-ID: <20161125072629.GA29326@ulmo.ba.sec>
References: <20160815153647.1075-1-thierry.reding@gmail.com>
 <20160815153647.1075-2-thierry.reding@gmail.com>
 <20160819165506.GA11823@red-moon>
 <26481704.zoJheIBO1p@wuerfel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
In-Reply-To: <26481704.zoJheIBO1p@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2016 at 04:00:42PM +0200, Arnd Bergmann wrote:
> On Friday, August 19, 2016 5:55:06 PM CEST Lorenzo Pieralisi wrote:
> > >=20
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 93583b389058..ecf543014da3 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -521,16 +521,19 @@ static void pci_release_host_bridge_dev(struct =
device *dev)
> > >       kfree(bridge);
> > >  }
> > > =20
> > > -static struct pci_host_bridge *pci_alloc_host_bridge(void)
> > > +static struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> > >  {
> > >       struct pci_host_bridge *bridge;
> > > =20
> > > -     bridge =3D kzalloc(sizeof(*bridge), GFP_KERNEL);
> > > +     bridge =3D kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
> > >       if (!bridge)
> > >               return NULL;
> > > =20
> > >       INIT_LIST_HEAD(&bridge->windows);
> > > =20
> > > +     if (priv)
> > > +             bridge->private =3D &bridge[1];
> >=20
> > How about making private a zero length array ?
>=20
> Right, the member can actually be removed here if we want to, this
> was just meant as a shorthand so we can avoid the cast or function
> call in device drivers. I think either way makes sense.
>=20
> Also, someone commented on a related issue in the previous version, and I
> recommended to align it to ARCH_SLAB_MINALIGN. This might be done more
> easily with the zero-length array using
>=20
> struct pci_host_bridge {
> 	...
>=20
> 	unsigned long private[0] __attribute__((aligned(ARCH_SLAB_MINALIGN)));
> };
>=20
> Without this, we need a bit more computation, like
> =09
> 	bridge =3D kzalloc(ALIGN(sizeof(*bridge), ARCH_SLAB_MINALIGN) + priv, GF=
P_KERNEL);
> 	bridge->private =3D (void *)bridge + ALIGN(sizeof(*bridge);
>=20
> or
>=20
> static inline void *pci_bridge_private(struct pci_host_bridge *bridge)
> {
> 	return (void *)bridge + ALIGN(sizeof(*bridge);
> }
> static inline struct pci_host_bridge *pci_bridge_from_private(void *priv)
> {
> 	return priv - ALIGN(sizeof(*bridge);
> }
>=20
> The alignment is needed if the private structure contains any data that
> we may want to transfer using DMA.

Looks like I never replied to this, though I seem to remember that I
did...

My question is: why would we want the private structure to be aligned?
Surely if somebody has data in the private structure that needs to be
transferred using DMA then they need to make sure that that field will
be properly aligned. Aligning the private structure itself won't ensure
that, right?

Anyway, it seems like there's very little contentious about this other
than the minor issue of how to get at the private data. I'd like to make
progress on this because we're now three generations into 64-bit with
Tegra and still missing PCI support on all of them.

Thierry

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYN+ehAAoJEN0jrNd/PrOhgK8QAKQPAHvaZVwjb6IfHwOU8pjB
C9pgJF5EzPUNoUbx/YivVQPqIsT9/9JRbgausTHZwcn4GzteN7jjdD9DPfSS4UM0
Qzo+3cbCj7zWAWfhQOdeTMjPpknqKrEJgwwAr75sBgaqhNt6eXfphLKEbI8hNfaJ
bMoyMNUIcua07JP3ICSP9P8a4alLnMQYgsLrcG6RI7OAntLqmu5SRw/l0s5N9jpG
pzJE6keaFXr4J6esUZQZ6dzqRv6rZn13YaTnVpyi2raaoENlay8UATI8h9NT5knj
gQgvE9OfH7I6l5wynwFaTXpkJVMM84H756cULiuRGefO2eSZHwrGk9aCp9+uouxq
vluC/n4ajCR8hFMMm/Mzj6yFqK0XXg9jIXEEz105t69jenU+DcLYYr4HVvgJhv5t
MDfNhNLIS3fYD270N1NepHlFpX426dM0k7lT2YidTfG7uqh+hgQGnKvLAHpqS+1K
GMHki5l0hR/9+d/lB7vF15VYTyjRK+br57t500hMglPEML/roVV37X/8J+DJZl3T
DL4Nw6D94lfOQHXeWUfkh5wO4WmQg8yUNZuz01Sz8xwMbxMwDV/wHCL7Y+dcPdo6
up1X4puO+prnVUfKxm49bLRBQ+wZ9x8C/rwn3Tp8J7tS50sXuM0iLc62YxSNrJ+q
pVbEpV10CwklP2Bi7MB6
=Yo1I
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
