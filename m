Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34971 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbbHZJWh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Aug 2015 05:22:37 -0400
Date: Wed, 26 Aug 2015 11:21:17 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-tegra@vger.kernel.org, swarren@wwwdotorg.org
Subject: Re: [PATCH resend] PCI: tegra: use __pgprot() around static pgprot_t
 initializer
Message-ID: <20150826092115.GA26691@ulmo.nvidia.com>
References: <1440578974-26527-1-git-send-email-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
In-Reply-To: <1440578974-26527-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2015 at 10:49:34AM +0200, Ard Biesheuvel wrote:
> In order to comply with the rules that apply when STRICT_MM_TYPECHECKS
> is defined, wrap the initializer for a pgprot_t in __pgprot().
>=20
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/pci/host/pci-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV3YUJAAoJEN0jrNd/PrOhEZsP/3AB58lsE7pfIDsLEscPH1Sq
SYEPMi+3YWy1mbGra/QymeJY1csc1YlSjtTvBqDDOQFuis1o+3UKkIBmUDTu4/SQ
8UG9unhYRIuA+2T9klv396pSHRPwPDoYBC2PqJYjU4fVlgQO2BWymTDl8kfnk+Dq
o79Z2Tk4/xK93eDVc5QQ5itM+W4KrBnnuFzxHn1Y3wXkqbEBi6dS2OaEjqbT0Y12
7gJu6oR0yNURM1ppG4teucdzN+sw9RFv1Dpm1rxnBQmLdd9gwbPVlwXTYrfsenhg
kZrsN2ZPdr9A5IJQhiqWp1dkFlqIXy+Sqsp3FEnXDs7YjOTQdWqQUR7/OWPCgGqY
cRb4D6OyylJx8TVlj4UumsKcKKxWVfakkyV9gwtS1tRBkfzDzDBDcm3KmuzL6jmZ
zjT8Arbdh7DCVtW4y+USlT1aMv+PFbfCCW1earDkn5HNy+m3UGb9PSl6RfqfASr0
drQIw5HrrP0ptdqYsMcWNIs11R2i2k7hhceuQRh9PQf4wj0npD3nEAkF0u2V3a38
CB9DAOk4dciMCbe5QHDZ56zdzvYo3tKTbgOFyYaD+FeR/SPOCS8SU9cxP8IHcTZ7
V0VFy2qiOZ2oysv2UjBxMZ/pWg19qkm8QaYB2uUEDNDeoSJFkZyVIX8Jc5grRBkN
Hux9rzHbSPA+Hk209nS0
=VkiK
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
