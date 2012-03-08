Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50864 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756738Ab2CHPoJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 10:44:09 -0500
Date: Thu, 8 Mar 2012 16:43:59 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Rob Herring <robherring2@gmail.com>
Cc: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 00/11] ARM: tegra: Add PCIe device tree support
Message-ID: <20120308154359.GA544@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <4F58CE9D.3070605@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
In-Reply-To: <4F58CE9D.3070605@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Rob Herring wrote:
> There is a whole bunch of PCI DT code sitting in the powerpc tree that
> probably needs to be moved to common location and used here.
>=20
> This looks way too simple to be what's needed if I compare to PCI
> bindings in powerpc dts files.

My particular setup may be much simpler than the average PowerPC machine. T=
he
patchset is only what I need to get PCIe running on the platform, which has
an FPGA connected to the Tegra via PCIe. For instance there is no legacy
interrupt support (only MSI), so interrupt remapping is not required. I also
know that OF nodes are not properly hooked up with the PCI devices yet, whi=
ch
I will need, among other things, to provide platform data for an SPI flash
connected to an SPI master implemented within the FPGA. I also haven't look=
ed
at specifying the memory ranges via the device tree.

So quite a lot may still be missing, but does that prevent any of this from
being added to mainline? Things can be added on an as-needed basis, can't
they?

Thierry

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9Y078ACgkQZ+BJyKLjJp9sGgCfTbY0+6cn/DT17IdqAu4BGFre
5pEAn2EOzwyLrmdsqCYnvHfH+jgNwgWQ
=oemR
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
