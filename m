Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44832 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025AbcAFIuc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jan 2016 03:50:32 -0500
Date: Wed, 6 Jan 2016 09:50:24 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: rcar: Add runtime PM support to pcie-rcar
Message-ID: <20160106085024.GE1525@katana>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
 <1451998831-27705-4-git-send-email-phil.edworthy@renesas.com>
 <20160106083500.GB1525@katana>
 <CAMuHMdUZq=8j8sTAu4SiDu+HuJkqciCx9uy-L5TQUGVbNc-Yaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
In-Reply-To: <CAMuHMdUZq=8j8sTAu4SiDu+HuJkqciCx9uy-L5TQUGVbNc-Yaw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 06, 2016 at 09:45:46AM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Wed, Jan 6, 2016 at 9:35 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> +err_pm_put:
> >> +     pm_runtime_put(pcie->dev);
> >> +
> >> +err_pm_disable:
> >> +     pm_runtime_disable(pcie->dev);
> >
> > What about put/disable in the remove part?
>=20
> Which remove part? (been there, done that ;-)

:D Sorry for the noise then!

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWjNVQAAoJEBQN5MwUoCm2FxEP/3xZRDopqzZX8z+6UCyyoZOl
bT/3F29MZ8BIi4S5Bi9c27qDF6r9LCpMmUaASRinaVI1dK2PQbfVeTlOJo6U1t/N
QmOf2t/HuWYArGlxPbhmNGfwVTfl+vN5vk4XxulFOux2kywJuUoV5Yc/l2IcYNYm
dPHG7lmbRwDzgJ9UZwOCNiRL32RwIk1IhRaNAcWrAx6nNyV3V8GHslP0R62iWTBM
p4i9UfxLg41N1K9t20dKG9NzqddChpWbkaIW0RCH7mabPViJoll8guhl1myTiLuF
0iRN9hClmBgEEBG9NuOllguYKiUJ+1tgosm1jjjXF0JwR+rn6yW2X/+46Ne4+myv
thvPg7A36vy10PnOwFa4bDMclgnnpz1m0ikWoMQKsAp7LbC2GhknfkV9+gpwezyH
wOyHfw/DCrO55n+ViIC7qvCvv6JGyRFhfFBgv1ndCcz9qgVGtCpy2q4UN98PkJtC
YDYOI9bE1ep/StD+IWU6SDuRTn4igeyTWSjVufctZY1UK5rh9Ns6t2gCa0LGx/Ll
P3JJXM+cOFxDes5UqaTd0UfuwKbq8S/CAi0R2VBvstKhZ+pmQoKvTNsJLiPFt2G0
E5l9Xqzu+thdLQoKza97Hzwy/kn1KUVEzhAD9cr5m52jhxIeKqlB/8boD8PQpOZI
GZGIHYTHI2P0d8zObrVe
=xaYa
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
