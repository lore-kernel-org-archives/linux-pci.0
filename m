Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33874 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbbLNIPu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 03:15:50 -0500
Date: Mon, 14 Dec 2015 09:15:45 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 06/10] drivers/pci: make host/pci-tegra.c explicitly
 non-modular
Message-ID: <20151214081545.GB10055@ulmo.nvidia.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <1449970917-12633-7-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
In-Reply-To: <1449970917-12633-7-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 12, 2015 at 08:41:53PM -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>=20
> drivers/pci/host/Kconfig:config PCI_TEGRA
> drivers/pci/host/Kconfig:       bool "NVIDIA Tegra PCIe controller"
>=20
> ...meaning that it currently is not being built as a module by anyone.
>=20
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>=20
> We don't have to disallow a driver unbind, since that is already
> done for us in this driver.
>=20
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
>=20
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>=20
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/pci/host/pci-tegra.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

I'd rather not do this. There is work underway to make it possible to
turn PCI host drivers into modules. I have a local tree with the
necessary changes and, though I suspect it might take a few releases to
get everything merged, I think we'll get there eventually.

Thierry

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWbnqxAAoJEN0jrNd/PrOhRQQP/jJM5GR+zJ2XfllEyito5A1H
NH4ZkqIkEe5EQSgxWBw+Ijh4I9wOsvsJ6I2tc2AkypYtqhzW3gYO235+dY5J70+H
YhK5Xw0HhMGadAZBO9N1nnV76hCGGdev4rU2PE7c/l6+DsgrEfVNW996mhUtHMG9
sByIDu41+yK0dKaIFLEAJQ6TkYCi7wnN5miIgvO5eshUXlMBxk8o0PwUTWP/mPFx
bOF9EXVmtJcprumuvdTUYrsD7/YWv3f8hlLpJ1IdKyyVxsW2g05F+dRgeUrhibkh
8WFIn+JC3sQIa2rFo+kEAkzSp+zbp93pHYFkPGs0hwqQoLFFAhDmcd3y0XESbPNa
JTGWFxWkQzIgVG1NvEKj+ZVoWUXwP+Oid7YvdHuMoLq0TW6wjpV22M2FKPNS4NHE
Jh6jrF1MHloLL4TJQutTuMiRRx2LguUA5tlXGo2rdFhtY80ivmXfAUGMmyRR2gYQ
QMeAX8Qi2q2176sIs5o+8G3J7uI6pVzBdyVU2hKLUnpuvSxVWxC5MrY9EPnq2aWm
7Ox1zrrdwMzwPQTbPeZ8LUbWKbSK6Y/ZKWg8Teo77YowzrnwvlbkSm9NuaKhwQ7s
3oOioG1iwKzlb02eFg9RFDToKRfJAcXlfj05zEeGLzpnUkcQ4ozU+YT6xfWZmr4L
93tc7AF6CQj2MY3wsLHy
=/vf4
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
