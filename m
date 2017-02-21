Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 21 Feb 2017 09:47:37 -0800
From: Mark Brown <broonie@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Message-ID: <20170221174737.2gf63ywzdjrh33ub@sirena.org.uk>
References: <E1cg6WK-0000gP-QT@optimist>
MIME-Version: 1.0
In-Reply-To: <E1cg6WK-0000gP-QT@optimist>
Subject: Re: next-20170221 build: 2 failures 9 warnings (next-20170221)
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-samsung-soc@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 linux-pci@vger.kernel.org, linaro-kernel@lists.linaro.org,
 linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8273445301636930773=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


--===============8273445301636930773==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eswlzpm66weyq47t"
Content-Disposition: inline


--eswlzpm66weyq47t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 21, 2017 at 09:14:04AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/pci/dwc/pci-exynos.c:132:25: error: 'struct exynos_pcie' has no member named 'pp'
> ../drivers/pci/dwc/pci-exynos.c:162:25: error: 'struct exynos_pcie' has no member named 'pp'
> ../drivers/pci/dwc/pci-exynos.c:185:25: error: 'struct exynos_pcie' has no member named 'pp'

due to b09d4ac91a3934e9 (PCI: dwc: all: Split struct pcie_port into
host-only and core structures) which replaced the struct member pp with
*pci but has missed some users.

--eswlzpm66weyq47t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlisfTgACgkQJNaLcl1U
h9CGTgf7Bki3Xo59eGN8GBpvr3Q9VNDU0R6drohgM9dmdya3htqVIHE1cGUITWN2
IAYm5wECGvM0wcadShCxaX2x1hcc1rTk1vSZ0urJFyZmsvW6i4oozU7agIf3H/kH
xKr29I/FyTeeCTPEV07qRn5WIAC2LkMr/r0BmmPsNyPHsQFd1hX1trPzlBSYcpO2
jey3fjwf3SKQil2mL4GOk14rh2oYitekUmwdkq7lMvLQg1kpX1Q2QPi95zGNiqsI
Uerq/WyorPM4LUozk4Xns4p9VZQKZZfFapDwNf8CNnHgfa64fjkAgE7D29D63WR2
OraTak9NMo7YzkQhhQ6EZy5Pl4D9TA==
=m2Kr
-----END PGP SIGNATURE-----

--eswlzpm66weyq47t--


--===============8273445301636930773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8273445301636930773==--
