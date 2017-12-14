Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:47091 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdLNPcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 10:32:20 -0500
Date: Thu, 14 Dec 2017 16:32:16 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com
Subject: Re: [PATCH V3 07/12] PCI: tegra: Disable AFI dynamic clock gating
Message-ID: <20171214153216.GH13733@ulmo>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-8-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
In-Reply-To: <1509371843-22931-8-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 07:27:18PM +0530, Manikanta Maddireddy wrote:
> When there are 32 outstanding writes from AFI to memory, the outstanding
> write counter overflows and indicates that there are "0" outstanding write
> transactions. This outstanding write counter is used to generate IDLE
> signal to dynamically gate the AFI clock.
>=20
> When memory controller is under heavy load, its possible that write
> completions will come back to AFI after long delay and AFI write counter
> overflows. AFI clock gets gated even when there are outstanding
> transactions towards memory controller resutling in system hang.
>=20
> Disable dynamic clock gating of AFI clock to avoid system hang.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V3:
> * no change in this patch
> V2:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 4562b0c113a8..c264037112cb 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -103,8 +103,9 @@
>  #define AFI_MSI_EN_VEC6		0xa4
>  #define AFI_MSI_EN_VEC7		0xa8
> =20
> -#define AFI_CONFIGURATION		0xac
> -#define  AFI_CONFIGURATION_EN_FPCI	(1 << 0)
> +#define AFI_CONFIGURATION			0xac
> +#define  AFI_CONFIGURATION_EN_FPCI		(1 << 0)
> +#define  AFI_CONFIGURATION_CLKEN_OVERRIDE	(1 << 31)
> =20
>  #define AFI_FPCI_ERROR_MASKS	0xb0
> =20
> @@ -1059,9 +1060,10 @@ static int tegra_pcie_enable_controller(struct teg=
ra_pcie *pcie)
>  		}
>  	}
> =20
> -	/* finally enable PCIe */
> +	/* Disable AFI dynamic clock gating and enable PCIe */
>  	value =3D afi_readl(pcie, AFI_CONFIGURATION);
> -	value |=3D AFI_CONFIGURATION_EN_FPCI;
> +	value |=3D (AFI_CONFIGURATION_EN_FPCI |
> +			AFI_CONFIGURATION_CLKEN_OVERRIDE);

I think this is cleaner (and results in a smaller diff) if you simply
put this on a new line:

	value |=3D AFI_CONFIGURATION_CLKEN_OVERRIDE;

Thierry

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloymYAACgkQ3SOs138+
s6HCvRAAvJrMlEervcZeA98DQKzDmaB7cKgrK8MLdnrpZZhVTrHKuR75+sbbpm0m
xeYbp51MxP/s5QyG99UV6u5bOMKzGHYHLzH2MNg00pWpG2tCC8Qk3CHze7NC5FkB
KRTCY/7TxzVQ/KXJql3TSCT97Vg87ND/IYHCJKLmLKPTA/WlaLYqs8Xwbgj4GczX
l5+M1Ks4ZIypg5bnn8FLNdkVq3kFF5iCBZ8i6ca/+u6o8wHq1xu/lJkKMO5Bg5c5
DbA8oBP/djXPFqyf/SOy3cs6MlBMXKMHCN7pDLPGNMyz2jd0/IhXBbyH4doSSEXY
Am9AhCSFHPSCNhzm4q3BP/9StDLBkY51elXpiRz7LffLNqJLquMw3jue46yf88r6
4mJEQwVGgkcDzRsBRsUUMHNOY+Q/Ubvz4+lMb4BU81ihViPjehNnkwaeScEClux4
ICw12YPUlCJYdM1cI1Ey2AWgi8yNkUdKqGV+d17sLdAdVxEdLrX7V6DLKchWkduh
4rUdBl/w40Iy6Ns0jmUU8VpF5C0/EjqjN7OZuvrPd2YS59WPjFnHGrlJ9VxWGkre
5ZhNsiuymAg+lXjjpGBtjjh9k+wtPe0RmaBxbOVyPRTorQIRIqTE7WNZdsgV9EaB
xMy8mN8z7CV7/S9hZyPI2beqJGCvMK8MQz0UBt9kuikOi81Vkk4=
=Euq2
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
