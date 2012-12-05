Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2636 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341Ab2LEWFe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Dec 2012 17:05:34 -0500
Message-ID: <1354745132.2355.98.camel@jtkirshe-mobl>
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
Date: Wed, 05 Dec 2012 14:05:32 -0800
In-Reply-To: <20121205205755.13851.77284.stgit@bhelgaas.mtv.corp.google.com>
References: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
	 <20121205205755.13851.77284.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-2pjvvtxpgy2QV9QVilXh"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-2pjvvtxpgy2QV9QVilXh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-12-05 at 13:57 -0700, Bjorn Helgaas wrote:
> Use the standard #defines for PCIe Capability ASPM fields.
>=20
> Previously we used PCIE_LINK_STATE_L0S and PCIE_LINK_STATE_L1
> directly, but
> these are defined for the Linux ASPM interfaces, e.g.,
> pci_disable_link_state(), and only coincidentally match the actual
> register
> bits.  PCIE_LINK_STATE_CLKPM, also part of that interface, does not
> match
> the register bit.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: Jesse Brandeburg <jesse.brandeburg@intel.com>
> CC: Bruce Allan <bruce.w.allan@intel.com>
> CC: Carolyn Wyborny <carolyn.wyborny@intel.com>
> CC: Don Skidmore <donald.c.skidmore@intel.com>
> CC: Greg Rose <gregory.v.rose@intel.com>
> CC: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>
> CC: Alex Duyck <alexander.h.duyck@intel.com>
> CC: John Ronciak <john.ronciak@intel.com>
> CC: e1000-devel@lists.sourceforge.net
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)=20

Thanks I will add this patch to my queue for e1000e.  Since this is
patch 7 of 12, are there PCI dependent patches in the series that need
to be applied before?

--=-2pjvvtxpgy2QV9QVilXh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQv8UsAAoJEOVv75VaS+3Ov98P/1KnBmfLz02iWZ2G4CJ5tfMo
ZeL4U3jU3mrL3MXJWJ0+2NS3Mfn9NyBdEsqCLv81DS5dBz8rHctfX/ZuKVxSz/F2
HICI936Xtxox/LuUsMGtxNOl+Lhx+Rb5xr3p7OG5Eb1cjoQ4FnL4+iIlZoWjohvJ
T3yDyVY04nAhZ5LPsvqIQ0BvFP23qMLbghzYXXPmd5RZkbDNlQ61OGUQpWm+Qoae
yzktJ5DU2Tf27xrEsq65S/x1sF7MpT/xQ7BJygOaeUm/SWnWd3nGQh90tfAPKzcA
Z0CfhihzhxjjwjtD0aRJay6qp+S3WhS95oaUNctPzXT/tHC+BDH+PdC8qbTkvFms
v1osFFGuonpcGFACo2zNtqUpFjBOJigXYg1eBIdvEDkLzNYx3/pOtlNv8Jppli2l
mWPtA85NzMQPcIIWBX635mdSUSaAACmR/dIe6qnUb+WbOKpIG2hGsmSdYK6zmRZi
1ZRa3mlAlbA24GTiYHH0jGbx288dln1xTIu51C/28kVgyw/jmLeF1vFB1cvMWxYL
zxD0O80a449V548OcPNoTceV7pydxVMKVKFeqOsJgDYX8+GZF6bYtks1YRZZk6qg
PgEPF4zCX9y6OnE36Id8FuMlJm70g8kCoWHHyD/458NGtF02DbuNpI+BfWc6GVFO
cvIVYQwZb1Lzq10yTvbZ
=zS52
-----END PGP SIGNATURE-----

--=-2pjvvtxpgy2QV9QVilXh--

