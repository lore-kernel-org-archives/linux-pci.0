Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:39382 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938551AbcJ2OBx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Oct 2016 10:01:53 -0400
Date: Sat, 29 Oct 2016 15:01:36 +0100
From: James Le Cuirot <chewi@gentoo.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>,
        <bhelgaas@google.com>, Joao Pinto <jpmpinto@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PCI: designware: check for iATU unroll support after
 initializing host
Message-ID: <20161029150136.29fa4b7f@symphony.aura-online.co.uk>
In-Reply-To: <1476482095-26289-1-git-send-email-niklass@axis.com>
References: <1476482095-26289-1-git-send-email-niklass@axis.com>
In-Reply-To: <1476482095-26289-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/ERpXAt=pJSGFSS_FdNGHc2."; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/ERpXAt=pJSGFSS_FdNGHc2.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Oct 2016 23:54:55 +0200
Niklas Cassel <niklas.cassel@axis.com> wrote:

> From: Niklas Cassel <niklas.cassel@axis.com>
>=20
> dw_pcie_iatu_unroll_enabled reads a dbi_base register.
> Reading any dbi_base register before pp->ops->host_init has been
> called causes "imprecise external abort" on platforms like ARTPEC-6,
> where the PCIe module is disabled at boot and first enabled in
> pp->ops->host_init. Move dw_pcie_iatu_unroll_enabled to
> dw_pcie_setup_rc, since it is after pp->ops->host_init, but before
> pp->iatu_unroll_enabled is actually used.
>=20
> Fixes: a0601a470537 ("PCI: designware: Add iATU Unroll feature")
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Tested-by: James Le Cuirot <chewi@gentoo.org>

My Utilite Pro was failing to boot and this fixed it so thanks.

> ---
>  drivers/pci/host/pcie-designware.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/host/pcie-designware.c
> b/drivers/pci/host/pcie-designware.c index 035f50c03281..bed19994c1e9
> 100644 --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -637,8 +637,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
> =20
> -	pp->iatu_unroll_enabled =3D dw_pcie_iatu_unroll_enabled(pp);
> -
>  	if (pp->ops->host_init)
>  		pp->ops->host_init(pp);
> =20
> @@ -809,6 +807,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>  	u32 val;
> =20
> +	/* get iATU unroll support */
> +	pp->iatu_unroll_enabled =3D dw_pcie_iatu_unroll_enabled(pp);
> +	dev_dbg(pp->dev, "iATU unroll: %s\n",
> +		pp->iatu_unroll_enabled ? "enabled" : "disabled");
> +
>  	/* set the number of lanes */
>  	val =3D dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
>  	val &=3D ~PORT_LINK_MODE_MASK;

--Sig_/ERpXAt=pJSGFSS_FdNGHc2.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQJ8BAEBCgBmBQJYFKvAXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQ1MjhERTZCRDg2OTFBNDM5MUZEQTJFRDQy
MUM2MzIxMjlDNkQ3REU0AAoJECHGMhKcbX3kVgkP/3q8w5Se6gl9x+w6umprWFqs
9jekmA6M2sqKF663jc15dXN8rgeam7cPKxruL+SvAO8QkaVtgqgleD8JRzy4wEXY
ajnVD1/h4V7piFyg1JhXO3JIS+lXj6bfIoPUXT9WKoZmf54u6YqxxRKNVizNGaW8
hAeV5937cZfa8YV7KRAAeD4hG3/EWpgj16DtbhnD2gRzhd8X1ubqJaqFoSIUZ6uT
WOa5qS5wIKzI9jZDRZe/BM6pI4x498Vp5Qdc1onUq4onZxCa6+hdofViOCawHVTT
ggJLmxUrkOOrd4SpgiWKF+87Q+JowItOQPg3ellAC0a0CGcieJnN/RJ43YqTKYd+
MsbNwSaJgYkDptnoW9cxnxQbI+UwLO3fjwwLaPCHeh09qIRG2ucp28HCn1Mz+DQb
qx0ACty/dSex7BbUVrVuXsNk0DFLJZT5Y0J4UFUtoaagyG5vXtv9+pIRyNRJn9lk
QGR3hF9cO3PWdi9wS7Df2mcTxn8P57nU11h5LSOiFkoIxUBTIYvqL0jzH/eXWcN5
3K10cjsNiz6MARvqCp5N1Kqgzn12d9tZBnuELrKRuKENqjWWhkOtW7C73gM9Ko+A
ga4l2sT/V1DJfSG2qeeYux4BRHlWgNQgo0eFyC33pGVkfuBhI/zfUwRq6C37kAON
a5y2qDw0uMcjps08tsVt
=ufCu
-----END PGP SIGNATURE-----

--Sig_/ERpXAt=pJSGFSS_FdNGHc2.--
