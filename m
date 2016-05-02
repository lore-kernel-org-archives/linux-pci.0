Return-Path: <thierry.reding@gmail.com>
Return-Path: <thierry.reding@gmail.com>
Date: Mon, 2 May 2016 09:19:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, catalin.marinas@arm.com,
	linux-pci@vger.kernel.org, will.deacon@arm.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com,
	robert.richter@caviumnetworks.com, msalter@redhat.com,
	Liviu.Dudau@arm.com, jchandra@broadcom.com,
	linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
	Suravee.Suthikulpanit@amd.com
Subject: Re: [PATCH 3/3] [RFC] pci: tegra: use new pci_register_host interface
Message-ID: <20160502071912.GC27465@ulmo.ba.sec>
References: <1461970899-4150603-1-git-send-email-arnd@arndb.de>
 <1461970899-4150603-4-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
In-Reply-To: <1461970899-4150603-4-git-send-email-arnd@arndb.de>
List-ID: <linux-pci.vger.kernel.org>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 30, 2016 at 01:01:39AM +0200, Arnd Bergmann wrote:
> Tegra is one of the remaining platforms that still use the
> traditional pci_common_init_dev() interface for probing PCI
> host bridges.
>=20
> This demonstrates how to convert it to the pci_register_host
> interface I just added in a previous patch. This leads to
> a more linear probe sequence that can handle errors better
> because we avoid callbacks into the driver, and it makes
> the driver architecture independent.
>=20
> As a side note, I should mention that I noticed this driver
> does not register any IORESOURCE_IO resource with the bus,
> but instead registers the I/O port window as a memory
> resource, which is surely a bug.

How's that? I thought pci_add_resource_offset() was exactly what was
registering the I/O resource, using the resource's flags to determine
what type to register. Do we have to use a different API to register an
I/O resource in particular?

Overall this change looks really good. How do you want to proceed with
the series? Would it be helpful if I picked up this patch and submit it
to Bjorn for v4.8, provided that the core changes make it in?

Thierry

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXJv9wAAoJEN0jrNd/PrOhkwIP/iWiHB2wgy6L3RP6jUxjLofm
vxb389mLLzr3BeME9CCSiQFpLDhJIzJTMZXbQSfE4+LUyPEFjQzZO3dnNOwZ2+Sg
RIIES8iUyBdCHun+C76XjmaZMe+/X0abCoZTXfHIQolxPb/Ca271tuxYrGC7SFMY
V5tT8rASK3PzsqmOTCHiS8R0s3/7ih7wShavtlGDUj3VGZkzwu23naRreaNuflrk
WjSVOY2dL6/oPCfNqN9Xgv0XqYBBmUNqOxoZeQNmV+csqIt2fBy4Pj4QRUtb0UFt
1xxnma3alikX3dAXzI5iFpfSF9sHnoWoKe1lIEp57j/wGi35cN9tZHz3Yr/EQewI
nSclXcEDO4d+sfQsARlj5mYpRUBYLaH4MKvPP5kfRmCH7f5rcgIRzNpNiKsJ4+NB
h+V/oG3wpDL5/4TTsKHImiP5mfC2RIGJ0nkTkz2+zZoKmgi2iUfN7fyVCFzf5Dkc
rddJVT6YOa5O2HjWbhfT2WMmEMCPw770FEe2CrMqxXku3ssoH48Aqj2+/IazjQYe
w0Bus0TJ9tXYBDYo9FP1syoCh79s3NX4RtGtFdUP9PPTqs45R2A7qHBU7lfkWSHv
lTxkx9NSB+ixEg7rHhHUqdU1wCIc/bvOpXxRXtHVxUr96lZr1782XAfu5LcKp+Na
agYSz3nX99Sh++A07KX7
=h7Kf
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
