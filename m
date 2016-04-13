Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34164 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbcDMQXu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 12:23:50 -0400
Date: Wed, 13 Apr 2016 18:23:45 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
Message-ID: <20160413162345.GC30129@ulmo.ba.sec>
References: <1460131994-24493-1-git-send-email-thierry.reding@gmail.com>
 <570BE129.40907@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
In-Reply-To: <570BE129.40907@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2016 at 11:38:49AM -0600, Stephen Warren wrote:
> On 04/08/2016 10:13 AM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Changes to the pad controller device tree binding have required that
> > each lane be associated with a separate PHY. Update the PCI host bridge
> > device tree binding to allow each root port to define the list of PHYs
> > required to drive the lanes associated with it.
>=20
> I think the feedback I gave on v3 still applies here (I'm talking about t=
he
> comments on the patch, not the commit description).
>=20
> http://www.spinics.net/lists/linux-pci/msg49718.html

Apologies, I had missed those when going over review comments. I think
I've addressed all of them now, or provided rationale for why the code
and binding are the way they are.

I'll be sending out a v5 soon, hopefully that will have addressed any
outstanding concerns.

Thierry

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDnKRAAoJEN0jrNd/PrOhCKUQALhHG7ZwR4O8o40CFexq1sKx
Oit9kQaM9s5922COpyFYEQp26URX7iBUSj9UjIx34JLGXcy6n2O+HPoOljQiNCc1
kLqnWDNMUwIXL6TRZBheRStKzJlbiQqCP8PfhaL1putSGecTBJ7fPAN7lCviDfcQ
keKh6ryelZy3FEAzl5O7iVzU8mkcdewdKzuBnIkwWSZUOHw0N9g3Itux198FRy6C
kTxuTsrBAOLcxhaG8Oh7zQkl7p2SIhnY48djkRrfiUurydW2lA7S2PNf88uJUe5C
xzaCTQTqBspks2N0CeSYVG78j1oKpiyMjQV0w5iOT6d3g7tMQB6V0SefHDMEZlNh
sNP0pEWhgBy25vV11H5K4od7O1B5rKG6KcVk6RCGUQ03Z1BfYHchTQMW3UG90c6z
2CRydCJZxeaXdEnuwvY9yifHRIxAtb6hjvefDahYR1eA4/R8BBN0czrmrh0A0fAH
0QQdERZSBJmFM7CalGm8gI3pJR0fgJtN+4dbIOUIhdULNzVBpxs7xjazuOkiVO83
eM0qguohR0IJMli13NEWGJL16MAtylX/3lORiNC/3D2RhmWisf8/x/Y+m/E5/nsG
3Zy6Gh3O6ZOidgiw9iJEk5loQbOwaa45uRBdLk+yXLaHI9YGHDq0FL+1IhFW5V3J
sDwsGIWXVfc9BddYAXXo
=f4aV
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
