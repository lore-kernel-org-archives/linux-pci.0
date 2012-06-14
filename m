Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58163 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450Ab2FNKbk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jun 2012 06:31:40 -0400
Date: Thu, 14 Jun 2012 12:31:27 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Mitch Bradley <wmb@firmworks.com>,
	Russell King <linux@arm.linux.org.uk>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120614103127.GA15904@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <201206132021.09774.arnd@arndb.de>
 <20120614083719.GC31283@avionic-0098.mockup.avionic-design.de>
 <201206141025.09325.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
In-Reply-To: <201206141025.09325.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2012 at 10:25:09AM +0000, Arnd Bergmann wrote:
> On Thursday 14 June 2012, Thierry Reding wrote:
> > >=20
> > > I believe you will need an "interrupt-map" property here, to map the =
host
> > > interrupts to the INTA-INTD lines of the attached devices.
> >
> > Legacy interrupts are something I cannot test at all because I have no
> > hardware that supports them.
>=20
> Hmm, I thought all PCIe hardware has to support them when you do not
> enable MSI. What hardware do you have then?

The TEC (Tamonten Evaluation Carrier) has an FPGA which is connected to one
of the Tegra PCIe ports and it only supports MSIs.

> > > I'm not sure whether we want to have a device_type=3D"pciex" property=
 here.
> > > powerpc and sparc seem to use that information, to distinguish a pcie
> > > bus from pci or cardbus.
> >=20
> > That'd be rather useless information given that the Tegra is unlikely to
> > support either PCI or CardBus at some point.
>=20
> But the generic code does not know that.

True. Still there's not much generic code on ARM, so maybe it'd be better to
add it along with the corresponding code?

Thierry

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/ZvX8ACgkQZ+BJyKLjJp+KwgCeLOv5FbwdhJLudBvqii4chHzR
vaUAoKwt2Eyxu3LSM44kVY6+EyAM8PB4
=YJcl
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
