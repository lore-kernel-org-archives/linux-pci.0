Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:48836 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab3HMHn4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2013 03:43:56 -0400
Date: Tue, 13 Aug 2013 09:43:52 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH V4] ARM: tegra: disable LP2 cpuidle state if PCIe is
 enabled
Message-ID: <20130813074351.GB9316@ulmo>
References: <1376323204-25952-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
In-Reply-To: <1376323204-25952-1-git-send-email-swarren@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2013 at 10:00:04AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Tegra20 HW appears to have a bug such that PCIe device interrupts,
> whether they are legacy IRQs or MSI, are lost when LP2 is enabled. To
> work around this, simply disable LP2 if any PCIe devices with interrupts
> are present. Detect this via the IRQ domain map operation. This is
> slightly over-conservative; if a device with an interrupt is present but
> the driver does not actually use them, LP2 will still be disabled.
> However, this is a reasonable trade-off which enables a simpler
> workaround.
>=20
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Tested-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> v4: Add missing tegra-cpuidle.h, re-write commit description. Add acks.
>=20
> v3: Only disable LP2 if a PCIe device that requests an interrupt is
> actually present. This prevents the loss of power-saving when the WAR
> isn't required.

Great, looks good to me and I see that you've applied it to your tree
already. This has been in the works for (literally!) years and it's
quite a relief to see it finally merged.

Thanks a lot!

Thierry

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSCeO3AAoJEN0jrNd/PrOhKE8P/0hBJ6YDJVdzP9eZi7v0RgFh
0QYvk8KyC8IQs7xf/aDVO0qC14ZzyjjfQ9dPg3GDCpkY6EyWDdA7DYOxbDQdQocu
OmfPBYOk+QjTIG4usEhlh6MzXg+Q46bd8W5+jRWhVSQx5UpoCI4VFPy4+daFv1f1
Zw9cWgpRT2gonRdBS6DF6z1kUlMRQOIVFTMbR+4Zp/w3S3Z1l5mGs96nAbWEeqKo
XjombBElG00QgiRgUFSkW/nz8TEK+hJTy9872RymhQIsdfk2Vjmr197KuA1HkSO6
qkj5G6UGi6p9TBryTXBhoBsyWHswK16qRZGSetNPtwg4jDqVcxcR3YFJ4AusZXlF
OyGy2jAAtHc34oKzWKaEtZQhd3zhe6xYF2BA0urwnrO+zOUZ8Ec5kNQHpGbMFuMp
+hF87rIYcRxtTq+BOAN/8xtgsWLW0yUGbsigW4ogH7pkPVb2Anb6Zce2bGrRLbn8
AQRgcdVaC0MeJWElC3TTFeFS1PDGbvcfj0aJw3Fx9xOnboPHcgMd5zWkuV7VtQ+H
xM9IMZ8VgIkEIp1wSCnNUIIIMUMaWnNSvQq7de8CMLlYWPN+zQEOg5d2mTGMDJeq
xXfvtACOFaDdMRmaJhaUQ44FcWFaFVzZzXch9fPVwjd+qC3vV2+v2YtiouGt49qB
h3FJ3eRRMp21qL/Eq3e2
=IMZn
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
