Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36214 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbcCGI22 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2016 03:28:28 -0500
Date: Mon, 7 Mar 2016 09:28:23 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] PCI: tegra: Support per-lane PHYs
Message-ID: <20160307082823.GA31189@ulmo.nvidia.com>
References: <1455029465-9211-1-git-send-email-thierry.reding@gmail.com>
 <1455904860-29090-1-git-send-email-thierry.reding@gmail.com>
 <56CCA250.2010403@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
In-Reply-To: <56CCA250.2010403@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2016 at 11:17:52AM -0700, Stephen Warren wrote:
> On 02/19/2016 11:01 AM, Thierry Reding wrote:
[...]
> >diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>=20
> >@@ -883,14 +904,24 @@ static int tegra_pcie_enable_controller(struct teg=
ra_pcie *pcie)
>=20
> >+	if (of_get_property(pcie->dev->of_node, "phys", NULL) =3D=3D NULL) {
>=20
> Rather than re-parsing DT to determine this, thus duplicating the logic,
> can't the code store some flag in tegra_pcie_phys_get() indicating which
> path was taken, and that flag used here? Perhaps that flag could be based=
 on
> whether pcie->phy is set, although the else block here implies that
> particular solution won't work.

We could derive this by iterating over all ports and check whether each
of them has its ->phys field set to !NULL. However, keeping track of it
via a separate boolean seems to me like the less obfuscated version, so
I've implemented that instead.

Thanks,
Thierry

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW3TukAAoJEN0jrNd/PrOhHu4P/Rp1BHDg6EA0ONbXqKxpLuqD
wLP+wRxMUt/1ts+9x0A1wqHVyE3eYxMJvZXPDahbSMsbJH6klBFJ8QlsLbXKgYMk
Z5Y6YxJX10E/vhUrx9pUf3KvOJSQlZi9hog1Cn+EPlCzmh7EsDmgi6nJMhiW/9eI
uSVpvQknv5x05/Z/yXwCvZAM0mtODZ8Hb+2Nx50k0wtNEZHO7zMV/QO76alwPj1o
TcK+jVvCG7RVrjmV7koM88v7HRhq+cebM3Ak7UUoE3CO3wXeT/PShk+6n2uLW0Fi
iKhqeKyNu4j1F+yp6x0fNM45bktEgs77ZXK+GuFolP3CkWPrxpqpt+BieA29n+rt
wvyoTjVhd0ZGyzShyNM+nwgM8AHC+EZLW67HFx1okpW3OZmdj8ZOPXS5y+BYNzY7
u0C4i6h2Jn/8H1VBv5V3zJ92eIWC6+rhzhAQxF9oJjNBZ6UsUgwl4XzlPz7x1RA4
fCENTayok902L6N07GN7bjcmf+lgzAKLhxFM8jDjK0pLBeAAQ+gro466sbhVNJdi
+OfsYMMEpkaN/gJDCkLK7+qfsvQGT61WJ96CHWQFjfULiU4I8HJn7UPJ9ZxRMMDZ
0CZVNDA7x/qrIhw77dxSWpuhI+6EboZf8xpH2TjtZaZYE9S2zY5NS2bxLa8UhbM9
v4MxBMKaP6ohifOSmEvy
=2+Pd
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
