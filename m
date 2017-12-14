Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43866 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbdLNPfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 10:35:01 -0500
Date: Thu, 14 Dec 2017 16:34:57 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com
Subject: Re: [PATCH V3 08/12] PCI: tegra: Wait for DLLP to finish before
 entering L1 or L2
Message-ID: <20171214153457.GI13733@ulmo>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-9-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
In-Reply-To: <1509371843-22931-9-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 07:27:19PM +0530, Manikanta Maddireddy wrote:
> Set required bit to have LTSSM wait for DLLP to finish before entering L1
> or L2. This avoids truncation of PM messages which results in receiver
> errors.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V3:
> * no change in this patch
> V2:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index c264037112cb..34740a7033f7 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -219,6 +219,9 @@
>  #define RP_VEND_CTL1	0xf48
>  #define  RP_VEND_CTL1_ERPT	(1 << 13)
> =20
> +#define RP_VEND_XP_BIST	0xf4c
> +#define  RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE	(1 << 28)
> +
>  #define RP_VEND_CTL2 0x00000fa8
>  #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
> =20
> @@ -2162,6 +2165,13 @@ static void tegra_pcie_apply_sw_fixup(struct tegra=
_pcie_port *port)
>  	value |=3D RP_VEND_XP_OPPORTUNISTIC_ACK;
>  	value |=3D RP_VEND_XP_OPPORTUNISTIC_UPDATEFC;
>  	writel(value, port->base + RP_VEND_XP);
> +
> +	/* LTSSM will wait for DLLP to finish before entering L1 or L2,
> +	 * to avoid truncation of PM messages which results in receiver errors
> +	 */

Block comment style, please.

I'm still not sure if tegra_pcie_apply_sw_fixup() is a good name for
this, even it's now becoming clear why you have a separate function.

These aren't really SW fixups, are they? Why not stash these into the
tegra_pcie_enable_rp_features() function?

Thierry

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloymiEACgkQ3SOs138+
s6G2oRAAopHtydsO4MboU9HbMYFCLWLyGnwhKxsHRpAw6g6ueBJF++78s+ttAL+1
Ey7kvONOn7bvni+cCiOu1Ed/2IzwVvm3xSm9IP0aAZBX8DdpipO1NGP0iVwNDOzI
HIiGNrzzdCEmeSdgT7QnQi2ZfYWvkOtk9vsBpe4rP1GEhQOxM5Wgtrfc3kX6AzVi
QX8yynWM0By16Q6Gt7c9ApO9I+X6rD0YU+YLneWkckSBzVN0FPNHjGqBC2PMiN8I
dtyCbSLJ/yUdQat03qCP42TSv1n3/W9KvRFo1ViH5tPqnZpi9pv04/kaZIfSxLYE
rNuXZVl39K7CJBHTRv1el5d2Z2Ps20Che5ix7RLH3BIZDWUWPADWmvCfmi/EZi5+
zSliArG9OGiEI2ZlGFXnjdjVAuEwTXJiSxIEY4kAzDzPrqF5Jinff71EfR3f6fpk
ExA2fYDRSnNZ25m2HftUozgTeiQr7nrpz46Uma1+Y8jMX2vBj2NDKhY3t7KnvKK8
paRC8g+jewS+i+K/TK5iAMvCwfAW0Yr/145uB2vopBpLryvkaDeGFlZI2Fw7NbqG
VgoP7AXrsj1Qrm+W9ZyypJJmfJcu+ZBOvkL/7HJdbwu9zdwINJoZVhLBQiX/bDt+
WvxoTE3TPgrYdU6c7UnXcLh83x45Hy0/BaTkjvkoATzussl2g7w=
=BuIX
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--
