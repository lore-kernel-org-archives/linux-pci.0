Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36075 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdH2NzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2017 09:55:21 -0400
Date: Tue, 29 Aug 2017 15:55:17 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PTR_ERR_OR_ZERO
Message-ID: <20170829135517.GA30733@ulmo>
References: <1504013940-16304-1-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
In-Reply-To: <1504013940-16304-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 07:09:00PM +0530, Himanshu Jha wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
>=20
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/pci/host/pci-tegra.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 9c40da5..90cda5b 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -1156,10 +1156,7 @@ static int tegra_pcie_resets_get(struct tegra_pcie=
 *pcie)
>  		return PTR_ERR(pcie->afi_rst);
> =20
>  	pcie->pcie_xrst =3D devm_reset_control_get_exclusive(dev, "pcie_x");
> -	if (IS_ERR(pcie->pcie_xrst))
> -		return PTR_ERR(pcie->pcie_xrst);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(pcie->pcie_xrst);
>  }

I'm not a big fan of this construct because it's a pain to undo this if
ever we need to add code to this function. But since we do have scripts
that will flag this, I guess this would pop up every now and again. The
driver is unlikely to change in this part, too, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmlckIACgkQ3SOs138+
s6FeqBAAg5EmjfG8iikm1fhxYRlpWNSIFKJFyiT8UVI4g1c8nHLDS7yMaOk3FdJx
DfhG5u42ZkVYPdn/lbXe993Xn0k+oKYZ2/PmxTZqJhzYvJRo3SgQzMS88nX/vgV7
OzCXU83vEnbXLibgzXtHJ7W7RNgcI/XsoANSXwAZy8KYTWKx8zTGPSH4ZWKTHwj5
fxDCjJROPgNc+JoLPTXA5lvdnrrdX/qYNAQDxTTs7xj2De9EUT/YALL/F2EnAkDL
0LTZWJjssUQN6rf6r4Dr1TJZADlbL5099NDsQUQ5e9DW2Cu8hdjwtmWdc/vaTtvq
Z1ABc4mQ7XW8cqwXicOoSQX7HaC0JlGnEBzjKs4Kzu9oqMZPDkOh0mJl2nJ6aOVQ
n99dATT0jy70fyOeIIUfIRhBe5bt/4uSg8cFHaUw7vANmUm1t9FXi6Qldsi9x/d9
rURQrMYv+OS5byvxFLSZBSxMtuTmQqykx9VS84UYQLeKvpHQIOWRnr8kcBgX7lIu
h8BgTiVqEzsl7Mz4/7S/4pkdQhAQEwdEqNUF5DZfW+zw6PA9mXV92rt2B+zXULYw
z45E4kCOfmZDpI55nbBgrWmtw2Jqd6sBo/3uUVD8siafldxIH5il44x2mU53Bh0W
MlXgwx2pIPkmpmSj79AwQ0UqWhZ7ggMNt38dNvakveJhiQ3U/p8=
=I926
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
