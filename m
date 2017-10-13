Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50797 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbdJMQiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2017 12:38:11 -0400
Date: Fri, 13 Oct 2017 18:38:08 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        mperttunen@nvidia.com
Subject: Re: [PATCH V2 2/4] PCI: tegra: Add Tegra186 PCIe support
Message-ID: <20171013163808.GB8761@ulmo>
References: <1506513517-25870-1-git-send-email-mmaddireddy@nvidia.com>
 <1506513517-25870-3-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
In-Reply-To: <1506513517-25870-3-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 05:28:35PM +0530, Manikanta Maddireddy wrote:
> UPHY programming is performed by BPMP, PHY enable calls are
> not required for Tegra186 PCIe. Power partition ungate is
> done by BPMP powergate driver.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Tested-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> V2: Add soc->program_uphy check for phy_exit call
>  drivers/pci/host/pci-tegra.c | 132 +++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 108 insertions(+), 24 deletions(-)

This works, excellent!

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlng6/AACgkQ3SOs138+
s6G/9Q/+Mqtt6TeRw54xtAsCf7NlK5K/Tj+pxVpoMxBhF2jdiTdT0aT5cYqQxd42
OgjDFgJ6RFjBl6sCDMNl9BAKqxI7g9iTpoIa88dmPNt/Wd/cLEd0gpyllysEjeF7
tybyVNL6Ij/OBep8sCz5WJZjRhTQqjYKzyoJqEV7F51p3cjC0MQEtNGw76zzymse
CA1g+J4fxNh6pUgGZ8qB5x1DOL9Om8gyC/p2ZcDSNPTWGqMA//iSXxO7BHZ8jA0s
9NKaWRmgEqhcPUiKzbslVa44dAFXDixpNgIEGW2R0noTpuKzWEeRGkqdgyoOJEfq
mThzOlmdwxJeo7YiSEI3upcpzlOI8D0JIIBuhsT6NQu5ig1RC1ScpENPpGq8A1Ts
2sCTnBZnWvE3p5wMav1Wb9UZbyxG2okdk6wWQJFc8cUtkKCZddJfCp0MScbOS9js
wiCNB3M0pJtsQdnb1fjlJA+qFgolC3QNRbqETCgBID64nNsBUU3NdMJTg90oauVd
MgGFS7oAh0gsYjloQUjWTfl9gJh7b0D/kcJZQyMRPx9D9FkhAyhWxXdmUYylJqJV
ZxvgPlNWnJo6tDpgGGwy92QeXvzZR+UXsBijsA2dCwsGJ+S94UB0z93VIk4VkAfR
aYKxtNCF60mD92s7PTNmROUXKJhXSdAcrUxhcKmJOx1zXzQ8QAg=
=Rqcm
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
