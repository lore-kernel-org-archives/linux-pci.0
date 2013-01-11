Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61985 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab3AKEHB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jan 2013 23:07:01 -0500
Date: Fri, 11 Jan 2013 05:06:55 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/14] of/pci: Add of_pci_get_devfn() function
Message-ID: <20130111040655.GD28094@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-3-git-send-email-thierry.reding@avionic-design.de>
 <50EF5847.7040507@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
In-Reply-To: <50EF5847.7040507@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2013 at 05:09:43PM -0700, Stephen Warren wrote:
> On 01/09/2013 01:43 PM, Thierry Reding wrote:
> > This function can be used to parse the device and function number from a
> > standard 5-cell PCI resource. PCI_SLOT() and PCI_FUNC() can be used on
> > the returned value obtain the device and function numbers respectively.
>=20
> > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>=20
> >  static inline int __of_pci_pci_compare(struct device_node *node,
> >  				       unsigned int devfn)
> >  {
> > +	int err;
> > =20
> > +	err =3D of_pci_get_devfn(node);
> > +	if (err < 0)
> >  		return 0;
> > +
> > +	return devfn =3D=3D err;
>=20
> I know this is really picky, but calling that "err" when it's hopefully
> not an error but rather a PCI device/function ID seems a little obscure.
> Perhaps node_devfn? I assume that fact that devfn is unsigned and err is
> signed won't be an issue.

Maybe renaming the devfn parameter to data and using devfn for the local
variable would be more obvious.

The signedness shouldn't be problematic. devfn is an 8-bit unsigned
integer and sign mismatch is excluded by the error return already.

Thierry

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ74/fAAoJEN0jrNd/PrOhAEYQAI9f4VBCP9UlXhPUsbUDVeg9
inXaGyOPQwrpQ7YN1Ngo0dNXr8qILTiQHI9oDn3uOLoMRWmhrNzF4/9DH2s0Zpr8
pQz7Ol3u3KVvWYum7+sLjkQybz1DiZkKRNo2T/+3F3rzvY3kjlW1hV/vmv3yevZh
RLqjaglQnpsMYTTWvT+oc52SSd8+s61vKbm/jkB2yRpVafnAHpnkollTkgAAbp2V
8c0Gz9ojQm/MdUrvNScMHCd8jb8q0lF/Tq9QXIlJ+Y5nsyQDScnOu0kVAPGOLBmm
8IMyBSUBXAzmBrWo4bVFPEvyPV651C+v4fIW+ZymOQsnREFOhWHKTjGY5KdfJdLW
96WTH5taw6nTPr3ylzjc/vGQQclzBEbIaVVX1iOf96RM7SMXM2bTAnzrUiSr/kT7
NDh7mhb5xlo0aEgHNKA3xykOPsUuW4KwD3G99MuDGdwKESle6V66gCqLxJnXhQmS
8r8T5sCxNI0J8+HcFGb/szjeZAf7nu8l2FrpS2IXcHIHjdUhjgVmO3Gha4IENp4I
IJ0SSf7kSvEIdCj7dVwxLkOt9JD4NGjWVeJhwEKpCpXGUdtwW4Ac2a0vGcGmmLcG
9Je9cKu60WRxKioJz5qF0Ft5XesESI83WraYD/W97bTWu0oWyo3karN5X/SgHTx+
xXNlVGsf0SBFtGkSjt72
=iENp
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
