Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:44492 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbdLNPO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 10:14:56 -0500
Date: Thu, 14 Dec 2017 16:14:52 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com
Subject: Re: [PATCH V3 02/12] PCI: tegra: Move REFCLK pad settings out of
 phy_power_on()
Message-ID: <20171214151452.GD13733@ulmo>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-3-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
In-Reply-To: <1509371843-22931-3-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 07:27:13PM +0530, Manikanta Maddireddy wrote:
> In Tegra186 PHY programming is done by BPMP-FW, so PHY calls are skipped
> in driver. REFCLK pad settings are independent of PHY and should be
> programmed by driver. So move REFCLK pad settings out of phy_power_on().
> These pad settings improve REFCLK peak to peak amplitude.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V3:
> * Corrected commit log
> V2:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

As far as I can tell, this is a bugfix that can and should be applied
independently of the rest of the series.

Acked-by: Thierry Reding <treding@nvidia.com>

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloylWkACgkQ3SOs138+
s6HMWA//QN60ISDgsJRjiTEDN+l1ewn0xE/72sjep8mRINcMJ1VbsxEURPyrijjY
r9rpTEN7OIluzvT1eATyUTlsA8LYDwc5+GpoqqBZjVUTxXxwKkS87HGayzaPtcUd
t3vZ9UN5iH8heKazjxsFkg9MFACWVuYdLaw0kYFxtuD2Ckxgi2BjoNxeQCo9pBHh
DqUZF1AaVMS4HAWST93XPtbS0sE4VCVv/afV7lcEyFjFzf6helCfp2HL0kJWUq02
4h63hPCzYf+N5p5KY3VGSP9wk/mDFuxbNTaMJQxsk5Uds8c6sp9fR2tXk6IdNs0u
qK80r5gvMQkdTLuYqZkqUFDew8ZjR3t//cgXuQ9ieVjshoGnmHCbOQSpPMx8yA/Z
Mh9eNYcYyO00Cy7ztbI3J9Kqz3kTZtfIbfAV9g798fCuqUJJfYeeDcgK5zUSzhej
AsH12O4z/stN94zswtwn1Ig3XBbPO4pVilDan+t4f8cHJy9oyWomC0dNyoN14rEf
4WDuS2ya+wsTHNT21MPOCoJ+fTjHeOzU8X4Sx+fi2ahdhGTghEoKfCEKGjBMk1CL
QVJMC+3uu1DriN/+Rvqs7p5/nWIDlEUtnY9oss84R6xKEUTM0Q6vea6iySs4ePag
yl71r1DzRYmUjugGjVJnByYDFgsHdNnm5FCuMEu5fPbfMG+O1Uk=
=WHxC
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
