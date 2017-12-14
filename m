Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33259 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbdLNP3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 10:29:17 -0500
Date: Thu, 14 Dec 2017 16:29:13 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com
Subject: Re: [PATCH V3 04/12] PCI: tegra: Advertise PCIe Advanced Error
 Reporting (AER) capability
Message-ID: <20171214152913.GF13733@ulmo>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-5-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
In-Reply-To: <1509371843-22931-5-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 07:27:15PM +0530, Manikanta Maddireddy wrote:
> Default root port settings hide AER capability. This patch enables the
> advertisement of AER capability by root port.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V3:
> * updated commit log
> V2:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index ed5e8acfdc32..46896aaab81d 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -187,6 +187,9 @@
>  #define RP_VEND_XP	0x00000f00
>  #define  RP_VEND_XP_DL_UP	(1 << 30)
> =20
> +#define RP_VEND_CTL1	0xf48
> +#define  RP_VEND_CTL1_ERPT	(1 << 13)
> +
>  #define RP_VEND_CTL2 0x00000fa8
>  #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
> =20
> @@ -2055,6 +2058,16 @@ static void tegra_pcie_apply_pad_settings(struct t=
egra_pcie *pcie)
>  		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
>  }
> =20
> +static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
> +{
> +	unsigned long value;
> +
> +	/* Enable AER capability */
> +	value =3D readl(port->base + RP_VEND_CTL1);
> +	value |=3D RP_VEND_CTL1_ERPT;
> +	writel(value, port->base + RP_VEND_CTL1);
> +}
> +
>  /*
>   * FIXME: If there are no PCIe cards attached, then calling this function
>   * can result in the increase of the bootup time as there are big timeout
> @@ -2120,6 +2133,7 @@ static void tegra_pcie_enable_ports(struct tegra_pc=
ie *pcie)
>  			 port->index, port->lanes);
> =20
>  		tegra_pcie_port_enable(port);
> +		tegra_pcie_enable_rp_features(port);

Same as for patch 5: move this into tegra_pcie_port_enable()?

Thierry

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloymMkACgkQ3SOs138+
s6G2IQ/7BTWfnyY6zcb/ukTLQsFMA3VK1P+eDHYQ4k2vbITad+8dO7MAJf2uADvT
vGk+F8skYqGJaPnTQp1urH3+WiUyHyOXYlhJ/VeJ9hzG1gsWpOK7LhSi8N/T0oXc
NAgHcrb0q2hgPNq1cpYguS8sE+X4AytyGkp6dv9Wr2u2snZBfq0ohdWjtWHkjzb2
eyQWhnL1LeIhlj7fFMvUw5vO4Z933BGFXNVW9++v/bW3BLFYDcf4TtYJGPcjaDNu
qklQ8ibBjNQ/aPSe32y5q/gCCf4tYBECJOMzwT45POvo2ESXLzUkjZofzHIb1Ack
CjsYdQSV/KOQF8skA1OA2ELNYyGj8kiGBKuqMdQAWLk7hNj4flGRDSXZowxVYDEL
j8FDDp20+6MixcSQYqZIczDTNyLgdJgEr/TBtLzuNr0cHImNAay7nzOalS4VWseg
Uskl11nTk09TRI+Q4j8+DcByIjgAAiTRf2J2a0EkKeLdnq8gf6qqzD0bfTpUBkSy
nV+oR5K+MCC55xAznK02Mjos6pBCpgtjh/WQgsl/vABgKxBQYcYIZ1xiKSZ45gK7
yB6pw0rcwW4vfeVt8omIbXs9nZmhJdpf9wDsbByMpwNS3vdLVeUNLp3IX0w2mMTK
nma6Z4M8TxTF7KL/JPTLgjnykXeeOGrNbOssOypRSpml1/YJQc8=
=MfJ5
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
