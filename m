Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55651 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934717AbbLQNdP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 08:33:15 -0500
Date: Thu, 17 Dec 2015 14:33:08 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI: rcar: Add Gen2 PHY setup to pcie-rcar
Message-ID: <20151217133308.GB20372@katana>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
 <1450358557-28376-5-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
In-Reply-To: <1450358557-28376-5-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	rcar_pci_write_reg(pcie, 0x000f0030, GEN2_PCIEPHYADDR);
> +	rcar_pci_write_reg(pcie, 0x00381203, GEN2_PCIEPHYDATA);
> +	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
> +	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
> +
> +	rcar_pci_write_reg(pcie, 0x000f0054, GEN2_PCIEPHYADDR);
> +	/* The following value is for DC connection, no termination resistor */
> +	rcar_pci_write_reg(pcie, 0x13802007, GEN2_PCIEPHYDATA);
> +	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
> +	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);

I'd vote for a comment saying where these magic values come from, i.e.
which manual, which chapter, etc...


--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcrmUAAoJEBQN5MwUoCm2zbAQAKf6ScYmjRKEg5cPcmkU8WfB
aB6qMRD2Dz0F//h6dja5kSRF/OCIpeUALpW8NJgL9fCG49F9gd0Syv/VfWSVn9jf
vvVlxoLcf2YsJ7s8QXFz6twkTNi675tmvoI7JDt88OnH7U8vBK/TUy1rxMKZo+ti
VIgVg1IJ/qJhUbPS1rzTbD4XBneaZDRkO87mYfxNTmlipWKzBtkIr30NlsOtuaEX
V/a1tgIsEMMxzMF0/Q7Mzc4yqX3RSXMOOq7SS5ljywLfO/Dc7yQ88f6TnCZAENa4
s3wp4GIQJXlxTAVOde4pKvcG2vPGDl9NFv1fsz0NgNw8F7lU1cyf+tIYDyZuGhXe
65QRflJR33TMdiRpp8QLP0VPCs/IcqMO4m/JBFQpT2AA8imPHUiWaTtzGZt8cG3Y
KzSag1lZLu3Vrdl4WjNSfHtifMtrR1sUaoiV3oWn3CPnzKMAWSLn37atq8XJIVRL
4BQXjkCm3FxBFBxdbMPmvhjDUxIutVSBm/JhYQwcKJDS3VqdUPLd5uFOOqMG/F0w
WmHAjFghAuSRcuna5HmHuw6AxKuJZg5JDYCgRMCHAUrA/4JXeK5OO4YT4xMELqge
1cXsz5gHdI08tSy73yl9FD+g0LKVdy191nMd6wlDWVXx/xu9a5dToA+OgXmmRkIm
zpW5u/8DM3Jezi14QhIJ
=Ygd9
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
