Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 26 Jun 2017 12:56:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, lorenzo.pieralisi@arm.com,
 Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <20170626115653.e4xs4lk4paibuphx@sirena.org.uk>
References: <E1dPPgG-0002pe-3A@optimist>
MIME-Version: 1.0
In-Reply-To: <E1dPPgG-0002pe-3A@optimist>
Subject: Re: next-20170626 build: 1 failures 1 warnings (next-20170626)
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linaro-kernel@lists.linaro.org,
 linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-build-reports@lists.linaro.org
Content-Type: multipart/mixed; boundary="===============8844594429072918368=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


--===============8844594429072918368==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iu7yg3gbpixrsrf6"
Content-Disposition: inline


--iu7yg3gbpixrsrf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 26, 2017 at 09:47:36AM +0100, Build bot for Mark Brown wrote:

This build failure is still present in -next:

> 	arm-allmodconfig
> ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]

and we're at -rc7 now.

--iu7yg3gbpixrsrf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllQ9oQACgkQJNaLcl1U
h9BgWgf/SVn12U3lkzO9oEN9+0gaMVl/QR0XjFgFD1OnVGhd+lehjZQHsOgXf87n
XxykI6WZxFgBcLg6NYKZih3tuREKT7mKsg65/luCV0fzkVwvsbk8u/6QlPIuB1mK
urhv2qQI3QD0HWn4htaUdBBhBslh5zOEV11xWRHHDHIcDdggG4h+VuRN/cJN+Fm5
eeOe/USHTCdtIerwNNbL3qpC24EN2pdbV2OQRJVu1QC3nE819kxMG+ookwQ4rI6z
BPGLg4hU5vKfgM6OXrUrVuXJcYJAVAsIBxJBii2zGDl8r/8LttnWj1j9voNrlzYk
a7oqgI8eIaoTtHMntmGndCXAhvYmeA==
=50hA
-----END PGP SIGNATURE-----

--iu7yg3gbpixrsrf6--


--===============8844594429072918368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8844594429072918368==--
