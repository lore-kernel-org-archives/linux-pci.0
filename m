Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44659 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964797AbeBMNHr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Feb 2018 08:07:47 -0500
Date: Tue, 13 Feb 2018 14:07:43 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH V7  4/4] PCI: tegra: Add power management support
Message-ID: <20180213130743.GF6764@ulmo>
References: <1517289851-14111-1-git-send-email-mmaddireddy@nvidia.com>
 <1517289851-14111-5-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
In-Reply-To: <1517289851-14111-5-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 10:54:11AM +0530, Manikanta Maddireddy wrote:
> Tegra186 powergate driver is implemented as power domain driver, power
> partition ungate/gate are registered as power_on/power_off callback
> functions. There are no direct functions to power gate/ungate host
> controller in Tegra186. Host controller driver should add "power-domains"
> property in device tree and implement runtime suspend and resume
> callback functons. Power gate and ungate is taken care by power domain
> driver when host controller driver calls pm_runtime_put_sync and
> pm_runtime_get_sync respectively.
>=20
> Register suspend_noirq & resume_noirq callback functions to allow PCIe to
> come up after resume from RAM. Both runtime and noirq pm ops share same
> callback functions.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * no change in this patch
> V3:
> * no change in this patch
> V4:
> * no change in this patch
> V5:
> * Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
> rebased on linux-next
> V6:
> * no change in this patch
> V7:
> * memory & irq alloc and AFI programming for MSI are split in two functio=
ns
>=20
>  drivers/pci/host/pci-tegra.c | 178 +++++++++++++++++++++++++++----------=
------
>  1 file changed, 111 insertions(+), 67 deletions(-)

Looks good to me:

Acked-by: Thierry Reding <treding@nvidia.com>

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqC4x8ACgkQ3SOs138+
s6G0ExAAsimmUxWHPmIdJzVfqPDh+PhG5ShmEr95sDeLCvYBG8p3GKH/1qR0qMDp
8wDr7CYJWnVNnkR7f6psL0cTddqzH3y+2DcduqM7h3P6vfumXeXSXJkMPcMw55QA
lQrT9rsMAqtrRDyx89w+YOWTQZ0W2Lyjab/6lYn7JnhtLS0Ro+8wAsutT7mJGqEN
4746mDcDLrOPB50ussbX+sUxSnnDz6NeYp+ryP4gr6KUMblKWZsIF1OSg2RNy7PZ
avC1lO2pTiPQmBg5yOq0vmyZlAOI5mEPeHtmWugpXzIFJoMNXWxy06UP5gAl4671
o1bWNVOABYKfv9/eS7FE0WLvIC7a4HPwgjSY32j6nhKPKZZHwhSqI6lh4esG6QXe
JLZ+ivLClbwvqRwTLmetsHRXKoOF4bY9LIGtAO7nS4x7A0ooxR0FJW2EI2tNy6Rz
FrWVezC165efhREVMfYuNy2lCx7RfhkQ/eCUnC3aPvBy+OWIMYPYF6I1EiyADoKq
ub8fF1nw6gmjQ5lV5p41J/pWKEDRinJsNmDZ71JG4BjpJgC2CrqezgT+QfVxhnY/
gjLTFVejoJdEdMei4g+oihyTkteFzV0EshFQb9aj0aE2t+Lcrk/aJkGqFkhooWiF
1YunszS351qT83u6DDNaAUJGgQrPK2hjyptTW3bYGTYcwT2ql/8=
=B3rU
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
