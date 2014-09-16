Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2958 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbaIPQIz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 16 Sep 2014 12:08:55 -0400
Message-ID: <1410883714.28911.18.camel@jtkirshe-mobl>
Subject: Re: [PATCH] pci: Parenthesize parameters in PCI_DEVID and
 PCI_VPD_LRDT_ID macros
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: bhelgaas@google.com
Cc: Megan Kamiya <megan.a.kamiya@intel.com>, linux-pci@vger.kernel.org
Date: Tue, 16 Sep 2014 09:08:34 -0700
In-Reply-To: <1409973550-29434-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1409973550-29434-1-git-send-email-jeffrey.t.kirsher@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-deyejmnFvbLFKDF1ICDz"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-deyejmnFvbLFKDF1ICDz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2014-09-05 at 20:19 -0700, Jeff Kirsher wrote:
> From: Megan Kamiya <megan.a.kamiya@intel.com>
>=20
> Add parentheses around parameters in PCI_DEVID and PCI_VPD_LRDT_ID
> macros to prevent possible expansion errors as described by the CERT
> Secure Coding Standard: PRE01-C: Use parentheses within macros around
> parameter names
>=20
> Signed-off-by: Megan Kamiya <megan.a.kamiya@intel.com>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  include/linux/pci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ping Bjorn?

>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 61978a4..cb744f3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -45,7 +45,7 @@
>   * In the interest of not exposing interfaces to user-space unnecessaril=
y,
>   * the following kernel-only defines are being added here.
>   */
> -#define PCI_DEVID(bus, devfn)  ((((u16)bus) << 8) | devfn)
> +#define PCI_DEVID(bus, devfn)  ((((u16)(bus)) << 8) | (devfn))
>  /* return bus from PCI devid =3D ((u16)bus_number) << 8) | devfn */
>  #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
> =20
> @@ -1701,7 +1701,7 @@ bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
> =20
>  #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
> -#define PCI_VPD_LRDT_ID(x)		(x | PCI_VPD_LRDT)
> +#define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
> =20
>  /* Large Resource Data Type Tag Item Names */
>  #define PCI_VPD_LTIN_ID_STRING		0x02	/* Identifier String */



--=-deyejmnFvbLFKDF1ICDz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUGGCCAAoJEOVv75VaS+3OsqoQAJhWBFOSXZoGVjL2f/bVEpP5
30yWzxvA6joNxx/rhtE1QLPC1vYJ26Qz0JeAD+NA/5gCQ045j4bXJW1LvGjUM1Bl
rqaQ0ezHCxe7dze5itt+K6IS5DlNta3xt2tRArzSBIa479aSwPO8GfbNOYODNxcG
semZidkrfs4arSG9zti32VMiaLRxWFZhQArUy37LPBqNM3v/9tMcSypM4JlIqZIZ
xW2DEjsU94Gm17AgUO2NvVnJPxBgywJfxYaIjfsWVN0kHtsPF2jjI8e8qdZuBLv+
I4feNf4q/UN+6yQC0WfxTgemuy2LzTkd1y0WyT5/oxwnc391n5s4OGmSB7AZLcix
aC1+HdAblFjIEPNlVhSkYeVMeMfBabTpVcHjvhZ1cbT8Ae7AkTWayxT/PUDfue51
ed70HNoKb4Ffw7ZFH7nffvTsDXheur2t9fyH1dcwjUL1j9DHV4FGKycwdIUPtWDf
jp/shu5PsGsXdbmB0JWsm4DnXN2P0S38fTcmXSIQlmqszd+6gD0/uCfsHoUwPat+
lO/hOY8wUKtfUzI/qNWPJxTcoq0Gqlq+XlKCXJN/tS221EAJDj3EVOY0OCLzLj1V
ATtmBz+12nfc+mtFhy4c1hxSrJnN9kO4HBfKqEnprTj9R6dusAK2HlqEGQbIslpB
BgvXGHY62NRaooiJtXyV
=mzEP
-----END PGP SIGNATURE-----

--=-deyejmnFvbLFKDF1ICDz--

