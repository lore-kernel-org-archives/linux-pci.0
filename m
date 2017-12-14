Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35613 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbdLNQCE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 11:02:04 -0500
Date: Thu, 14 Dec 2017 17:02:00 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com
Subject: Re: [PATCH V3 11/12] PCI: tegra: Increase the deskew retry time
Message-ID: <20171214160200.GL13733@ulmo>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-12-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NPWyolIJAVLYbHY6"
In-Reply-To: <1509371843-22931-12-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--NPWyolIJAVLYbHY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 07:27:22PM +0530, Manikanta Maddireddy wrote:
> Some times Gen2 to Gen1 link speed switching fails due to instability in
> deskew logic on lane0 in Tegra210. Increase the deskew retry time to
> resolve this issue.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V3:
> * no change in this patch
> V2:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 3993e9221c96..b29329226e3d 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -224,6 +224,10 @@
>  #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
>  #define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
> =20
> +#define RP_VEND_CTL0	0xf44
> +#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
> +#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH	(0x9 << 12)
> +
>  #define RP_VEND_CTL1	0xf48
>  #define  RP_VEND_CTL1_ERPT	(1 << 13)
> =20
> @@ -318,6 +322,7 @@ struct tegra_pcie_soc {
>  	bool program_ectl_settings;
>  	bool update_clamp_threshold;
>  	bool raw_violation_fixup;
> +	bool program_deskew_time;
>  };
> =20
>  static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
> @@ -2216,6 +2221,16 @@ static void tegra_pcie_apply_sw_fixup(struct tegra=
_pcie_port *port)
>  		value |=3D RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
>  		writel(value, port->base + RP_VEND_XP);
>  	}
> +
> +	/* Tune deskew retry time to take care of Gen2 -> Gen1
> +	 * link speed change error in corner cases
> +	 */

Wrong block comment style. With that fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--NPWyolIJAVLYbHY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloyoHgACgkQ3SOs138+
s6EgPA/+JaCCu5eHSpac5xMhgrbFQf3ynFrgPZHuIHKPHHLK4q2aTqfPgsw95miM
2ieVIdJXFpJx0v9rCZVVCIjLTiTzf7bVqmcbheYjntDa8lImtnyxDtp/n1J6kyu8
ER1P9Frl5NfWRWFKABAe4+iE0XYHXnDEC1XgH6nRtRFDDtJPxcOKst9HGfowxxtN
oOsHjdhmTx4v/8feYawkjpe8Yd5X6TQq6WeNxqGjvD28v6c9EOAPnoJsol0S1cz4
gXfUbt58X7AcXcbmtrGOd2+ZKCrquxltzdMNLJEhxODaZdHdnaQqshEdRsvCxJDJ
b//49DBxCPaUDBK279H5kRVq9sBOioD4Lo4qzBnC3z+NgPe06jaBLhY314CY7cM6
uacmpHW6cPQfhpGwn4nFfEwcKvAjKulu7V3iFhoKklrwnqqV6yubhhZFwPhQ58xm
pobGRcRkZI4Uv1GPlfNyXf7oA4Mgy48vXBYrdcRfKmhmp68eWLcC0DKZy+t/X0+1
f+bJlmH/NIyK6ssz+x4aLkg5nu01yH7/x1kyxe3BJXgdl/E/dqnlldHg9oMIZcut
Ssosu3sNZJxfkdywFUTv2MEpNNu5WignJlMSXYB8b6Y1qZ3FloHRHB4nb/fu4pQC
F8UpIAP2lo1aIL2PPUBNoiJ9RmEpPhNb5oRcr2YyNMEbjsp0HPY=
=1wAV
-----END PGP SIGNATURE-----

--NPWyolIJAVLYbHY6--
