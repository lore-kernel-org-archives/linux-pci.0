Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49298 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932073Ab2LEWYn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Dec 2012 17:24:43 -0500
Message-ID: <1354746272.2355.102.camel@jtkirshe-mobl>
Subject: Re: [PATCH 07/12] e1000e: Use standard #defines for PCIe Capability
 ASPM fields
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Alex Duyck <alexander.h.duyck@intel.com>,
	e1000-devel@lists.sourceforge.net,
	Don Skidmore <donald.c.skidmore@intel.com>,
	Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>,
	Bruce Allan <bruce.w.allan@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	John Ronciak <john.ronciak@intel.com>,
	Carolyn Wyborny <carolyn.wyborny@intel.com>
Date: Wed, 05 Dec 2012 14:24:32 -0800
In-Reply-To: <CAErSpo5EfAY7BTNFtq3DWggDhBisBPGhevOsZXa19jRLT4+b6Q@mail.gmail.com>
References: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
	 <20121205205755.13851.77284.stgit@bhelgaas.mtv.corp.google.com>
	 <1354745132.2355.98.camel@jtkirshe-mobl>
	 <CAErSpo5EfAY7BTNFtq3DWggDhBisBPGhevOsZXa19jRLT4+b6Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-qOD9q+9BgGcMC9bmwAAe"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-qOD9q+9BgGcMC9bmwAAe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-12-05 at 15:07 -0700, Bjorn Helgaas wrote:
> On Wed, Dec 5, 2012 at 3:05 PM, Jeff Kirsher
> <jeffrey.t.kirsher@intel.com> wrote:
> > On Wed, 2012-12-05 at 13:57 -0700, Bjorn Helgaas wrote:
> >> Use the standard #defines for PCIe Capability ASPM fields.
> >>
> >> Previously we used PCIE_LINK_STATE_L0S and PCIE_LINK_STATE_L1
> >> directly, but
> >> these are defined for the Linux ASPM interfaces, e.g.,
> >> pci_disable_link_state(), and only coincidentally match the actual
> >> register
> >> bits.  PCIE_LINK_STATE_CLKPM, also part of that interface, does not
> >> match
> >> the register bit.
> >>
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> >> CC: Jesse Brandeburg <jesse.brandeburg@intel.com>
> >> CC: Bruce Allan <bruce.w.allan@intel.com>
> >> CC: Carolyn Wyborny <carolyn.wyborny@intel.com>
> >> CC: Don Skidmore <donald.c.skidmore@intel.com>
> >> CC: Greg Rose <gregory.v.rose@intel.com>
> >> CC: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>
> >> CC: Alex Duyck <alexander.h.duyck@intel.com>
> >> CC: John Ronciak <john.ronciak@intel.com>
> >> CC: e1000-devel@lists.sourceforge.net
> >> ---
> >>  drivers/net/ethernet/intel/e1000e/netdev.c |   11 +++++++++--
> >>  1 files changed, 9 insertions(+), 2 deletions(-)
> >
> > Thanks I will add this patch to my queue for e1000e.  Since this is
> > patch 7 of 12, are there PCI dependent patches in the series that need
> > to be applied before?
>=20
> Yes.  It does depend on a previous patch that adds the #defines to
> include/uapi/linux/pci_regs.h
> (http://marc.info/?l=3Dlinux-pci&m=3D135474107109010&w=3D2).
>=20
> I plan to merge that during the v3.8 merge window, so you can merge it
> after that.  Or, if it won't cause you conflicts, I can include the
> e1000e change in my PCI tree.
>=20
> Bjorn

yeah, it does not apply cleanly (because of patches currently in the
queue from Bruce).  So I will take care of pushing your e1000e patch
through Dave's tree.

--=-qOD9q+9BgGcMC9bmwAAe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQv8mgAAoJEOVv75VaS+3Ob2gP/Riculxsp/lioAB9lZbjWpOF
eXp0ZJesce0z0zvciumAtksGuBoVa5E41ZUoroQ1sYMD5/MU7v892yUGOQ70Y+cD
wm8q68OrucfsocXx2Ft4y/qdDp5UyFT9+196ZaTHNgZA4ZR8pn/MRmDIpc5JZBPR
rPRu3b5u4C14DzXV1hsozpqMUuGNii8hrJ2S34g01TQIAs1PjWbwRx0ZGv9K1aox
4mSy91iY+Ams9dq09tTh0x4JrX2X/rBiRj5EWe40n/pf6nLinS/rSDOccpYH0F+v
cXzosPAdAJ50nWad2HtKRLiMotCXxOCMuyeE9YlRxyAiGdcT9www+Kc+he13SKuc
T1A05WhdP4Gv6KpcMKsG6cQUMLgM3/52JTRiFoAEl0Mwa9Uyy4b3+DL+yT8Q2Omx
+O9KfGoakGvtoAG4ONKBbjmnXX2szzrWbOK/kLG7tHfQxtL7o1vFSNVRjrGmMNBL
zk7oTGHyOzMO5T//5fGKW3JS/kmqf9nelVXH2N8jhwLiry47ha6rUA1KjVFZIlVb
nrNVrVSZnnk/t7CIHj4wnRUlMzSYZ8wg9E+st68jSE5D0fSrw/k5Te/D6YcViqNG
mNDhAoge5khMgFgKuZEHarGhfQov0zkkbSwdVsdU851rJBpUUP07g4/ZllwwVbVL
hY52oXVl0DuIsi1XB/1S
=Vp9z
-----END PGP SIGNATURE-----

--=-qOD9q+9BgGcMC9bmwAAe--

