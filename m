Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56583 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab3CHTMz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2013 14:12:55 -0500
Date: Fri, 8 Mar 2013 20:12:27 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Rob Herring <robherring2@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
References: <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <20130308165228.GB4094@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2013 at 09:52:28AM -0700, Jason Gunthorpe wrote:
> On Fri, Mar 08, 2013 at 08:14:44AM +0100, Thierry Reding wrote:
> > On Thu, Mar 07, 2013 at 06:05:33PM -0600, Rob Herring wrote:
> > > On 03/07/2013 02:47 PM, Thierry Reding wrote:
> > [...]
> > > > In a nutshell (since some of the context isn't quoted anymore) the
> > > > problem that we're trying to solve is that some of the embedded SoCs
> > > > require per-root-port registers for configuration. The PCI DT
> > > > specification doesn't make any provisions for this. A few alternati=
ves
> > > > have been discussed so far:
> > >=20
> > > I'm not sure I follow. This is different than the host controller
> > > registers? Why would this not just be multiple entries in the reg pro=
perty?
> >=20
> > Well the register regions are per root-port. On Tegra20 there's 2 of
> > them, Tegra30 has 3 and if I understand correctly Marvell can have up to
> > 10 (!). Adding all of them to the reg property of the host controller
> > could work but it needs some way to match the reg entry to the root port
> > similar to option 1 below.
>=20
> Thomas just posted an implementation like this, please see:
>=20
> http://www.spinics.net/lists/arm-kernel/msg228749.html

Oh well. I don't like it, but if that's the way it has to be, then so be
it. Any reason why the reg-names can't match the root port's node name
so that it can be used directly instead of going through hoops to
construct a string from extra parameters? Like below:

	pcie-controller {
		regs =3D <...>;
		reg-names =3D ..., "pcie@1,0", "pcie@2,0";

		pcie@1,0 {
			...
		};

		pcie@2,0 {
			...
		};
	};

Thierry

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJROjgbAAoJEN0jrNd/PrOh9O8P/38Vyb0eQCMWUe2d4wjdiEa1
mUJnYiREQ2+2eyUpPajFIAqcLC4v/jHmfWT5nv/phTRT3J01IroK1ZTJr6VoXvza
0mJ+fXcy05jwxSZW7Epjfi99fXWluCv6VA4ZSfgA6OgwA67szE9t6rRQHCg/4RAH
cfPQ9GlaEYQ0fCZItxyWDBOSNXYUBAPbQmH1diaKrh7IFtZR2aMkRicLwB6L16Fn
+Czt20CygpyAjc7NyWLvdPxgoc9GjOGSC45rC256K6ymTOfA1HV8BeJJ4vCp94Kt
yi91Ai6EGPrFu8e0QTPd3HdcRp+D5OH5YqH5MG/hb25z5wk273qMClmUD8ZwuLWt
5Ft3Uwz60U+rK9nSOx9TEEYJea90UOyFWx/+GB1mcGbqFL7snjXlTshWb+XKpeqX
YcB8jnQA5VUoc6QMIvbxRFi6JO3nGedbrcUz3vXL1hR9XOOooV9RfUOw5c139ayC
B7itXQab1R3pqYqzUZe1ByLpERQEPCoj9IBWEDJz6EqqN0lgSQ/0/Co2oUBXritu
SvOMycNEyRSe39FvLGHEGIHga0dr8BG2OwQv9Q1WJggCSAgmnBHE2sG8cvacvUho
C4jn9j/5EqaPUl1ShlXPIrFFZpTgMSmZtmQ0jGgSaZS1WWq/0nmY8LabVrYWOBwX
SDD4ivO9V0sOmoVTJgBY
=Z9Bq
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
