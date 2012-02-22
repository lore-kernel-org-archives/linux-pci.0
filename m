Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52807 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab2BVIZD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2012 03:25:03 -0500
Date: Wed, 22 Feb 2012 09:24:52 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Olof Johansson (olof@lixom.net)" <olof@lixom.net>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org
Subject: Re: PCIe device tree support
Message-ID: <20120222082449.GA15157@avionic-0098.adnet.avionic-design.de>
References: <20120220191804.GA14499@avionic-0098.adnet.avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC302@HQMAIL01.nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC302@HQMAIL01.nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Adding Jesse Barnes and the linux-pci mailing list to CC.]

* Stephen Warren wrote:
> Thierry Reding wrote at Monday, February 20, 2012 12:18 PM:
> > I would like to add device tree support for the Tegra2 PCIe controller.=
 From
> > what I understand this will require the PCIe code to be rewritten as a =
proper
> > platform driver in order to be able to instantiate it via the device tr=
ee. Is
> > that correct?
>=20
> That's probably the cleanest way, yes.
>=20
> Is there a drivers/ directory for PCI/PCIe host controllers? Moving the
> code there might be nice if so, although IIRC when I asked Olof about
> that a number of months back, he said quite a few host controllers were
> in arch/...

Most PCI/PCIe host controller drivers seem to currently be in arch/. Is the=
re
a specific reason for this? Would it be acceptable to put any new drivers
below drivers/pci/?

Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9EplEACgkQZ+BJyKLjJp+jrQCePAIVtOgbog1DJ66IXJ4SVyBB
k0EAn1oXCyiApNbVtaTiXs7Bx6tMW6IS
=PICf
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
