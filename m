Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59980 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab2HPHr3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 03:47:29 -0400
Date: Thu, 16 Aug 2012 09:47:16 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120816074716.GB17917@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <201208152025.25252.arnd@arndb.de>
 <20120816045539.GA17067@avionic-0098.mockup.avionic-design.de>
 <201208160703.50364.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
In-Reply-To: <201208160703.50364.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2012 at 07:03:50AM +0000, Arnd Bergmann wrote:
> On Thursday 16 August 2012, Thierry Reding wrote:
> > At least for the config space this is incorrect. There's a single region
> > to access the configuration space for all devices below the PCIe
> > controller. So it is shared by both (Tegra20) or all three (Tegra30)
> > root ports.
> >=20
> > I'm not sure about PCI domains. Do you have any good pointers as to
> > where I could read up on them? If they need special hardware support,
> > then I think Tegra doesn't support them either. At least I haven't come
> > across any mention of domains while going through the, admittedly some-
> > what sparse on PCIe, Tegra documentation.
>=20
> I was referring to the same thing here: if you had a separate config
> space for each root port, they would by definition be separate PCI
> domain. So you don't have them.

I see, that makes sense. Thanks for explaining.

Thierry

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLKWEAAoJEN0jrNd/PrOhQsoQAKg1R4z8SJDFPgExlKdQsMqf
cpKOhKyUp5q38Uy5PymdolAZakmZfcxYlFsDfykrBu8Nw4AerLhTZxwcx3Q29b0u
TEvxBYt6NNYzY9H0BJWDUHphpbwcxdKrUP+5Lgp7+/fxStOAIa89RpU2uiAz7P+t
XKLv0vj+4A0hvfu1l94vrjVCDMVtqzM/sc8cW/X6IO290JqMY3Jj23TsWJ5EbRrF
dGuZLL+qQFpqPmwQIUf+L/9qkU6OkxuCQoco5JaRbTtchb406rAT1y7S6vVc03Ny
D/pjR/tRBJWnBs+Ldd8MkFwVk8kOACdrMTYJPjSwPcK4V3/jwAq+mjClUZNHtiEF
Yhqt/adO03YILnuvvQTdReYr10obzOHcg/GRM50HwxC3spKbvjy/z1oiJyvR19K5
nkxw6vkpUob83ahByAIb5v2K3jA74/k2vbL03QhMvYl7Y6xYlbOey8JVu5zrRfQP
l8yG+W8m1NC5/VOIl//b02KkhXp31/r5PKcblxujXrl2dtDHXOP+FQv33zPNQqft
gj+YF2EFVXvQ8VxuH6G+NImX2tYCynbiM14ozzNUYtTUbqGyIci97qEvuUyMpehl
kSFkIg5N1BWNYEf2eD3aP2XUvOk0lLHhlV52EJL39I4A0LdTn9/Fy0Az6kEBYyEG
euUsJVvaWofo0+rxQvDq
=Ew59
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
