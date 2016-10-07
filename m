Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34506 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbcJGRYd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2016 13:24:33 -0400
Date: Fri, 7 Oct 2016 19:24:29 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexandre Courbot <gnurou@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] PCI: tegra: Remove unused platform data
Message-ID: <20161007172429.GD10399@ulmo.ba.sec>
References: <20161007162615.23718.84354.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161007162650.23718.2297.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
In-Reply-To: <20161007162650.23718.2297.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2016 at 11:26:50AM -0500, Bjorn Helgaas wrote:
> The tegra driver never uses the platform drvdata pointer, so don't
> bother setting it.  No functional change intended.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-tegra.c |    1 -
>  1 file changed, 1 deletion(-)

This would get used again when this driver can become a module (or at
least unloadable). But anyway, it is unused *now*, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJX99pNAAoJEN0jrNd/PrOhrvwP/RHYG/TcLzpoRRkiRqRv7PMl
boYlRO0XOoef3PQsHEmirJr2JEPPWCA24OKQELUTpE7hHw6SUwQbqFPZxlxUZqjM
TUCuQBPfLGgiK2W7tvAQNyTwWOWCyRVwW1Oj2CsF8PwmGnouPeROqkWWUBiDb1jY
X5js7jfgjCxZgBO71V2zaVWddZgYfASIoh6CH9sHxkbxJBygYBXEeMa9XhHDNUAB
F2BwJudPHnXD+8C/mdrXfH09Z2FHSSu/IDqwrdQJ/pvUlnjTzUnf8roQ/I9AN5h0
8A2Pj+4cG3wIQ8kwkEoSq5ZbEkra4zA1h95EZgoaooC+G1mjxMgCQy7WALGfYXyg
rqL5+St7d3r9LaEzUKsVE3yOR26h5FRlFelvkxQRzGPCXleXhcUBrr9ssj4VBzVV
vOcHkgn6rp9LdwU3OhpdAkBy4m1ROm5mcQgmyVH4sfFDmmCsbHIFnJAqGhl3tBKl
j0Ti/Aea4UV2OADi16Yd3yx3wMr0UL3ngQaXaeYhuVcMdTTwI/ZnZe4ZQBwT3B41
6uAsuc5qghxuTFptm3IkC6ZBAyXo+nbMv7EZ9EWgEZCXWcAAffaNwrLOiLIzZZUw
mLrRULezhyrCkcHf/d+QQyPzf7CK/tN7/ss5HTkXHAZm7+S50EGqdsVhBm5AWK2J
XjuAumZeGSIoKd9JQJl/
=jKSN
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
