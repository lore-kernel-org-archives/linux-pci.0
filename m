Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:39976 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214AbbKGN76 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 7 Nov 2015 08:59:58 -0500
Date: Sat, 7 Nov 2015 14:59:51 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
Message-ID: <20151107135951.GD21726@katana>
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
In-Reply-To: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2015 at 09:28:19AM +0000, Phil Edworthy wrote:
> The OF node passed to irq_domain_add_linear() should be a
> pointer to interrupt controller's device tree node, or NULL,
> but not the PCI controller's node.
>=20
> This fixes an oops in msi_domain_alloc_irqs() when it tries
> to call msi_check().
>=20
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Was this the MSI problem you were talking about?


--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWPgPXAAoJEBQN5MwUoCm2gFgP/j8ZdlaKNF7ELXJzjiL0MS04
/t297zuot0yngIsHYD4/lcpZ9T0mcSTdsFAWcJ4GldGUEHWxsrh/Dy4QZP1a9l+b
bPPdFwZOFE5hZRMWAXv2LX+YyMCXeoHufnHs/UM6Ofs3i+gwVlAEP2ARc8MkffZt
yjTBg3sr+iJTCk+8i0rEhkyFPo7WINvzZnLr9Sibe7wOUXEnupeSSGiMuKUKRWbz
K2OnJr6x35APIxjxySyaphdmMfzt4Uzy3r9JPDc5zoXVoNpSqY7aZvWSDGYjfo97
mwdEttUV+s05/Z/LGNJigRrJQ5sAg96PbYoliSa7n1JFePgjwAvu4U7Q7FUGyFNN
IL0LhFK8YqFoBXy8cLmfXcx024PdVxuqabsUQ4HgqWJ5ScZVZ4G5BQoenFe57Sy/
N31hPd85twTo6TXd0PS6c1e5VIWoNNclWhSI0R3JivH8DS4kDXOXt9+sHuNg3l+w
DdNQRzSF6r1ZtnQGrRZhw9kXrLc8mFVPvYa2s9uzzvrsAD/ByIaWc2/3JtVCdO13
jIRC3z7CvIGFU+sus/mf6OxiFI/zgC/Sptj5eAT9XF/QPKlJrSeVNHy2Nt/9+mBO
KIy79VngjJSJTIulZG8+1ohcqDQ+8IuEbGLZUtJzmNFk5x7qPevdiO/WDFID8Ebr
sbWzmylX0ulDFm/y5cMk
=mGqx
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
