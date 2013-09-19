Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:57374 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab3ISLaD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Sep 2013 07:30:03 -0400
Received: by mail-bk0-f47.google.com with SMTP id mx12so3295863bkb.20
        for <linux-pci@vger.kernel.org>; Thu, 19 Sep 2013 04:30:01 -0700 (PDT)
Date: Thu, 19 Sep 2013 13:28:49 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Stephen Warren' <swarren@nvidia.com>
Subject: Re: [PATCH 1/3] PCI: tegra: add missing __iomem annotation
Message-ID: <20130919112848.GD10852@ulmo>
References: <000201ceaf9b$098780b0$1c968210$%han@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
In-Reply-To: <000201ceaf9b$098780b0$1c968210$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2013 at 06:32:45PM +0900, Jingoo Han wrote:
> Added missing __iomem annotation in order to fix the following
> sparse warnings:
>=20
> drivers/pci/host/pci-tegra.c:411:41: warning: incorrect type in return ex=
pression (different address spaces)
> drivers/pci/host/pci-tegra.c:411:41:    expected void [noderef] <asn:2>*
> drivers/pci/host/pci-tegra.c:411:41:    got void *addr
> drivers/pci/host/pci-tegra.c:419:25: warning: incorrect type in return ex=
pression (different address spaces)
> drivers/pci/host/pci-tegra.c:419:25:    expected void [noderef] <asn:2>*
> drivers/pci/host/pci-tegra.c:419:25:    got void *addr
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pci/host/pci-tegra.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I can carry this in a local tree or if somebody else wants to take it:

Acked-by: Thierry Reding <treding@nvidia.com>

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOt/wAAoJEN0jrNd/PrOh6XAP/3t1N7Ygrl0+kJoTp0c/GGLu
UF7iSLJfxHcBL/AbmZPv5slYjCStYfispaltHfWtpyoMqPWNW17QGzggqdmFiJoD
55haxA1jTNaVbJH3WSFN9AFwyIqY8cKLYBYvTeZUD8/ncbw1vkDOTtJMSrYHkNY5
xpEQcCpYZktSJAnAJoYSUkr9K4Zv4duTZ7qsoKlslT5uH+E9R1MTfCaI5h/TC7d8
7EKtzzgf/ORAHN4jbnKfEQVDK6mbeBOl8jVEocGjVdt4XGoV3mfDa+PH4C456dtX
olbmEBg13pXYwRm70XSEntjIgDrvvL6Q/cKG8Sd3Gu+MQInnOr2IOJqceU2K6s0n
BAteS7sH4fDqUAPPDSjl40kJd5lnvRFaaLnY7ooHdCLQ/MhBQ+7nfneeCwXQHqs3
fe6876s8/FXZgBRrbDP0DUDyHmcRmA6JPTZawDnUJ61ew/XwhzlxRkuEN7y57r12
nOaw1+lwcp7lXoT7r+i6NFZXZ5m0qai7/NY2hU8QyHCN9gAoG45nMqzFdOrvq1tx
J1RVBfKHSfWj7eP8JNuK3VrWmYcdhNmoUbQJg08+l1wXXVAiSAAx7dP/IGoArWJa
h7NDQ3sGSkm+AD0VwFsBiIQmmQnJH89RcGUZVj6eFhRiDcH1aoAgDzG1068ezGBS
KgfCiyuuEiBRS326PiFg
=FH0D
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
