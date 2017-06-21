Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 21 Jun 2017 11:04:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <20170621100440.vcaxagg4yjca2cv4@sirena.org.uk>
References: <E1dNcMp-0005RN-1w@optimist>
MIME-Version: 1.0
In-Reply-To: <E1dNcMp-0005RN-1w@optimist>
Subject: Re: next-20170621 build: 1 failures 7 warnings (next-20170621)
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
Content-Type: multipart/mixed; boundary="===============6041666503269359164=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


--===============6041666503269359164==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h7r4ugs5xtkgfvxs"
Content-Disposition: inline


--h7r4ugs5xtkgfvxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2017 at 10:56:07AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]

caused by eaf3023b0498a (PCI: mediatek: Add MediaTek PCIe host
controller support).

--h7r4ugs5xtkgfvxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllKRLcACgkQJNaLcl1U
h9A55gf9GWoU0Nl57Ta9i1zMX0Fzhlxsrusbd6tN8qkFLcZRjDb1i7ifDVmhezQ4
nQ7p49Al+wdQhIVMmwUk2WyOW5JDsqwCZg0j0Oy7VGUmP0LHLtDZ946WhpQeFrrn
w5IRyQEMx9v+UfvvZ81tW6AGXNhsJpbDR6WJ7sVXmjQWTJ8QgZlhimEBHXzaGSDI
dDQjQ6oVB0AGeLuUkIhpA4cu0aDwNUI9bkjJyPnNTv+ubrKPbBl9jfbo+zD9pmG4
aCZRfc6igcfxOlKxHnBZpWEYFn9eRGLv4AUT+qc7WGdbvXS2FS0C8OZ3Q3ZGpPux
G4XWNut79PaDJMlOY0rJZN6yJWbk8Q==
=wUFQ
-----END PGP SIGNATURE-----

--h7r4ugs5xtkgfvxs--


--===============6041666503269359164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6041666503269359164==--
