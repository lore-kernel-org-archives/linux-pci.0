Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46786 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753478AbdLNQO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 11:14:57 -0500
Date: Thu, 14 Dec 2017 17:14:54 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com
Subject: Re: [PATCH V3 12/12] PCI: tegra: Update flow control threshold in
 Tegra210
Message-ID: <20171214161454.GN13733@ulmo>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-13-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0aF+6pWUK5w8WdCh"
In-Reply-To: <1509371843-22931-13-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--0aF+6pWUK5w8WdCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 07:27:23PM +0530, Manikanta Maddireddy wrote:
> Recommended update FC threshold in Tegra210 is 0x60 for best performance
> of x1 link. Setting this to 0x60 provides the best balance between number
> of UpdateFC and read data sent over the link.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V3:
> * changed soc parameter name
> V2:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index b29329226e3d..812d32cfdd0e 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -223,6 +223,7 @@
>  #define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
>  #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
>  #define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
> +#define  RP_VEND_XP_UPDATE_FC_THRESHOLD_T210	(0x60 << 18)
> =20
>  #define RP_VEND_CTL0	0xf44
>  #define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
> @@ -323,6 +324,7 @@ struct tegra_pcie_soc {
>  	bool update_clamp_threshold;
>  	bool raw_violation_fixup;
>  	bool program_deskew_time;
> +	bool update_fc_threshold;
>  };

I agree with Lorenzo here that the threshold value should be a separate
field in struct tegra_pcie_soc.

Thierry

--0aF+6pWUK5w8WdCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloyo34ACgkQ3SOs138+
s6Gf0g//Wq8k8pIUrDn3dj8VHfRQCOV1ZX1t08yrQ5X8DQLeeIYXl1wBTxnqHiSa
duBkY+ewzKuN/HEp3ctN/at7Zq/H03pPLOKGmPgtcRSy/smOjgO+qVUel1RbDQwb
jE1kkQqrevCfs9kz3ngdhsVwYBM2DjSKa/AjUIaVMN5Gg4ROgEf/xBT8jNtFzsjk
SCjsZxGsRNKjnhSBzFd9mPdMM9RODPhW84ABq9X0tUsqglVw/7PdqwhGDItDSqct
ifnnTNFFu5lKf4zdUBl9An5FXkCc4maHw+B/FpJSW+N1R7ufpiz3hqRu2pDNBvU4
oxAEw+xnxnu/PM6HczqCuerLW39G3SBUufjyfMfSLfXPXtgKDYIF9oN2cBGEMpdR
tPoLlcqIuO4w18Rr7vVb6T/Gff2HbyAT0lrRgMVUT0vVKgnXZQi8C7dNcxWq0uV9
TpSOireA9uIG9seyzNJTlF+y+5Kk12Xl7V1+W3RgfWiJnWyc3liCNxZ8GGfOa5E+
a4Ub1BWcNZ1xmeptO/BcZu9+rgZG4BpLJg0Vp4o+JjCGJQxWkjJCiBYIHnkNdnsf
LR3xxWR3J7ZL7FVRYm8qvxvd1JihxA1f1zutzFwIgLaHMDbI+RG4qYHeq14L+OvB
dmxdU4Bug5Wy3i99R59Oc2QcubzC+KWDsVbRqlqCGfWD8xv9WuU=
=e5b3
-----END PGP SIGNATURE-----

--0aF+6pWUK5w8WdCh--
