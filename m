Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35257 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbbLNIY3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 03:24:29 -0500
Date: Mon, 14 Dec 2015 09:24:25 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	=?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Simon Horman <horms@verge.net.au>, linux-tegra@vger.kernel.org,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	rfi@lists.rocketboards.org, Ley Foon Tan <lftan@altera.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 00/10] drivers/pci: avoid module_init in non-modular
 host/pci*
Message-ID: <20151214082425.GA3766@ulmo.nvidia.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <CAMuHMdXr=ErCO3R2LB+wBJh3JSiFkH5q3-FLSTOwdGT87fXz3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
In-Reply-To: <CAMuHMdXr=ErCO3R2LB+wBJh3JSiFkH5q3-FLSTOwdGT87fXz3A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14, 2015 at 09:19:30AM +0100, Geert Uytterhoeven wrote:
> Hi Paul,
>=20
> On Sun, Dec 13, 2015 at 2:41 AM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > This series of commits is a slice of a larger project to ensure
> > people don't have dead code for module removal in non-modular
> > drivers.  Overall there was roughly 5k lines of dead code in the
> > kernel due to this.  So far we've fixed several areas, like tty,
> > x86, net, etc. and we continue to work on other areas.
> >
> > There are several reasons to not use module_init for code that can
> > never be built as a module, but the big ones are:
> >
> >  (1) it is easy to accidentally code up unused module_exit and remove c=
ode
> >  (2) it can be misleading when reading the source, thinking it can be
> >       modular when the Makefile and/or Kconfig prohibit it
> >  (3) it requires the include of the module.h header file which in turn
> >      includes nearly everything else.
> >
> > Here we convert some module_init() calls into device_initcall() and del=
ete
> > any module_exit and remove code that gets orphaned in the process, for
> > an overall net code reduction, which is always welcome.
> >
> > The use of device_initcall ensures that the init function ordering
> > remains unchanged, but one could argue that PCI host code might be more
> > appropriate to be handled under subsys_initcall.  Fortunately we can
> > revisit making this extra change at a later date if desired; it does
> > not need to happen now, and we reduce the risk of introducing
> > regressions at this point in time by separating the two changes.
> >
> > Over half of the drivers changed here already explicitly disallowed any
> > unbind operations.  For the rest we make them the same, since there is
> > not really any sensible use case to unbind any built-in bus support that
> > I can think of.
>=20
> Personally, I think all of these should become tristate, so distro kernels
> don't have to build in PCI(e) support for all SoCs. multi_v7_defconfig ke=
rnels
> are becoming too big.
>=20
> That does not preclude making these modules un-unloadable, though.

Most of these can't be made tristate as-is, because they use symbols
that aren't exported. Many of those symbols can easily be exported, so
its just a matter of getting the respective patches merged. I disagree
with making the modules non-unloadable, though. I have a local branch
with changes necessary to unload the host controller driver and it
works just fine.

Thierry

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWbny5AAoJEN0jrNd/PrOhFc8P/3B0v2I3mtu5JPGks9rMHDg7
hBIO+Z6udAWYauSpxfmx47NmuhE+LiwqEC/oE4pmnAT9VLje/j6nr0qcA6Qzlcq7
5+yavwLfNfq9p/9T1KwzF0lLRE0CDwDuPnsjd0QVmoVcJz29fmbB+8LruoYglMg1
LHWK6wULJwMAZipIMYSvcEB9R/DeOMGc2AX3WhXihjH/Zlq73ttnx4wyQfhS10Yv
97RlOpXyfubIThaGXRgPYNrUo6qVcoiRIBeW6d9eROD0A9FJj/yWeBbxLJRIooHC
MNADvxriWj21Bcyd8t0Nem1+g/fLSJLBy9+KZY9qsc3zI3kRP+k7JfWzjYU+838v
HlxtnSFg21C2626jJmviT2DfKYIZa1IwuoNdcZAhTZ/dr/OBPiHXT7IZml5fp+gJ
bdH371kc7zIEewvVtk4VToMnmAOrnYBmKpJtPWhUdO7BV0knNAg2ahXDe6ZIUbTC
09dF1LoK9Ol26dWH+Edn1JxPewBiCe7+ICFAcRBtBI9UijFWoVN2ORu3872grx0x
tcf3Xvcrbe9ZffQo2xoUkGPzXSe3USLKJ4w+jEq9zeLdJxS6YVAFm3L6PtW2iORc
iatpEaEFyWZ/n563pV5ycLRcy+ZvGBGPBW0CzSw7hVzLIRK6vbKBYyHB2dap1Czf
oMMTl4hBU+q/+R9w8/MQ
=TDuz
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
