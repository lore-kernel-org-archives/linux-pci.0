Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33366 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936228AbcJGRWC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2016 13:22:02 -0400
Date: Fri, 7 Oct 2016 19:21:58 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexandre Courbot <gnurou@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI: tegra: Swap order of afi_writel() reg/val
 arguments
Message-ID: <20161007172158.GA10399@ulmo.ba.sec>
References: <20161007162615.23718.84354.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161007162624.23718.46538.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
In-Reply-To: <20161007162624.23718.46538.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2016 at 11:26:24AM -0500, Bjorn Helgaas wrote:
> Swap order of afi_writel() arguments to match the "dev, pos, val"
> order used by pci_write_config_word() and other drivers.  No functional
> change intended.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-tegra.c |  133 +++++++++++++++++++++---------------=
------
>  1 file changed, 66 insertions(+), 67 deletions(-)

Most Tegra drivers that I'm aware of follow the (value, offset) style of
the writel() function. But this is your turf, so if you prefer this for
consistency:

Acked-by: Thierry Reding <treding@nvidia.com>

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJX99m0AAoJEN0jrNd/PrOhtbsQALdJ7UeoMLvHx0mbR6uGCBnu
rnw+6pCdz20Z9aPdr7tc0Ia283JQMLETyxIwjDe2yp8FBvkbfDo5Tfc0wlGcj82u
zCWNiQ6FoK0lEp3Ubvwqk7a4TyKkEcwqbH3dgUJTcQIzxPRrjPevQt4626WWXVIZ
55urtK6vQYeQt8OTGtG5tkoi/SC0jLpjoN0P2QTeN2OPBOBIWWyOXu9RyjJYPWa8
eQoN/R4ZMb0UT45xclZ7TzDvuaBxQM3goISDDe3hCWtpSW/HKmWoBJ9p7lXf8vAG
rcLQ4R+InrHroJ2ckU+y6vqEX9DMY2gkZkggZIjoCoEXIroJwgfp133MuzMwWpiT
Mr8KiUwKfVRaSXe1iwLLtqJ5op9doVmF9EpJgHw5c80YiIqAfhD1XYviT5CK13La
j1DRfPE/T49QgzYM8sHM/T9d08zJFzWTZ0owlzwh6dTCfT4dfEXsVhu/m5j8DWk8
0Xw9GaeIja8hZ8Lm+sy06qqz2EGHtADZZPAL/WReXrYTbwsIMi5FJtguvsPhoUrp
Zb3ymP0r2MPkHnpnEdblMtNR19oDwEy6ulFNh9DiKZeolF6QqforENJTliHiVrMv
+qZv8jZUb9j3YBQudI2jkwJiJwLWaInj/h9CvA6BAxGLdjY87R4RkrS7/4gq+zuR
ZONkEFKa1d0wuKeinRz9
=n3ej
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
