Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61632 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaLJMQo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Dec 2014 07:16:44 -0500
Date: Wed, 10 Dec 2014 13:16:39 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra: remove bogus bridge setup fixup
Message-ID: <20141210121637.GB23558@ulmo.nvidia.com>
References: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de>
 <1415907457-3147-3-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
In-Reply-To: <1415907457-3147-3-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 08:37:37PM +0100, Lucas Stach wrote:
> The bridge setup is already done by generic code
> while scanning the buses. Do not duplicate (or potentially
> alter) this setup as a fixup.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pci-tegra.c | 13 -------------
>  1 file changed, 13 deletions(-)

I've been carrying the same patch locally for a while now, I thought I
had sent it out long ago, but I can't find any record of that, so I
probably didn't. Anyway:

Reviewed-by: Thierry Reding <treding@nvidia.com>
Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUiDmlAAoJEN0jrNd/PrOhouwQAIuTW9BdJCL8bHG6EmzDBMGk
gQJLfXuMAaL7Gojlwgfw2eOMC4/dvgaOfEnaibUr71expWYImeoAqo1HZaf6NWmU
K3nUNiI8GxvS0/VS4hy6boP0CYiG8IV0LRClHq2umx6omGIVera+g059D1D9UgZA
+mHR1HU3N5UKJzZCnNNrblFwMhsjuEp4nqgwerXw5zK397a6ky9MSSoXMFmLa4VM
HVB1V0I3kcgtLofL2TLX21Nt5xRfJjmMM5c8J4PHDI/dXfl0D4yfBJEPNlrEYwO3
r/nBKo67Oq2nvNEbVwSjUF7U/xMY0xXpe99ML7tE35tXqcZr3dApyPpoquS/+NWp
vbI2Ha+iXOWhEftMy4Rs0g52dBKKbrDXACj7wwnZuQuLSgiulbbXk/Su/+RlfXTb
9WYZLEbca7VYdtTXOco0mSdg4tkBvis4zEfhCJwril6/4Ef4mvWYEo0AYKs/Hxbx
HucYa/xhleiPSGhAGRrnrSaLrkiqHfM94cLjXUkPf0nBYwGnEmQLGmI/Gm4Lu674
ydV27JsFtJ7bFVxixtKPyhpHUGgbDZKn/2P8CcEKk4wccBdKFLipIwFhR9NJ30Jy
qc5qUOkSvtuvTdCcmN2BUTxtnYcGNm5WVXX4BLMGFHfWvceIqP9SYDlEJJ8d4WgJ
THxCh7Rb4jvCUyk+5lPP
=aTTh
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
