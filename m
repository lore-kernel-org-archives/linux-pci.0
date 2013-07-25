Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:53404 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757335Ab3GYSta (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 14:49:30 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf3so823013bkc.7
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 11:49:29 -0700 (PDT)
Date: Thu, 25 Jul 2013 11:49:21 -0700
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
Message-ID: <20130725184920.GC18584@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E4167B.4000208@wwwdotorg.org>
 <20130716104347.045a612a@skate>
 <20130716131547.GC12062@titan.lakedaemon.net>
 <20130716153911.423cc408@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
In-Reply-To: <20130716153911.423cc408@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2013 at 03:39:11PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
>=20
> On Tue, 16 Jul 2013 09:15:47 -0400, Jason Cooper wrote:
>=20
> > > A quick diagram of the dependencies, best viewed with a fixed-size fo=
nt
> > > mailer.
> > >=20
> > > kernel/irq/irqdomain    drivers/pci        arch/arm/kernel
> > >      patch 1           patch 2, 3, 4           patch 8
> > >         ||                  ||                   ||
> > >         ||                  \/                   \/
> > >         ||               drivers/of   =3D=3D> drivers/pci/host
> > >         ||                patch 5           patch 10
> > >         ||                  ||
> > >         \\__________________//
> > >                   ||
> > >                   \/
> > >             drivers/irqchip
> > >               patch 6, 7
> >=20
> > Well, that got more complicated.  :(  No cookie for you.
>=20
> Yeah, sorry about this. I'm not sure how to handle that differently.
>=20
> > > Patches 9 and 11 are DT patches, so they are not mentioned in this
> > > diagram.
> > >=20
> > > Normally tegra would require 1, 2, 3, 4, 5 and 8, so ideally, with
> > > the respective maintainers ACKs, Jason Cooper could take them in a
> > > specific topic stable branch that would not be rebased, on top of whi=
ch
> > > both the Marvell work and Tegra work could be done.
> >=20
> > After my recent discussions with tglx, here's my proposal:
> >=20
> > - rmk creates a dedicated topic branch with patch 8
> >=20
> > - Bjorn creates a dedicated topic branch based on rmk's with 2, 3, 4, 5,
> >   and 10
> >=20
> > - tglx creates a dedicated topic branch based on Bjorn's with 1, 6, 7
>=20
> I am wondering if this merge strategy isn't too complicated to work
> nicely. Would it be easier if one person took all of those patches in a
> stable topic branch, with the ACKs from the proper maintainers?
>=20
> But anyway, as long as things get merged, I don't really mind what
> merge strategy is used, so I'll trust on what will be the best option
> on this.
>=20
> Thanks a lot for taking care of this!

Hi Thomas, Jason,

I've talked this over with Stephen and he'd be willing to create the
stable branch with patches 2, 4 and 8. That could serve as the basis
for both Tegra and Marvell.

Given that there are no cross-dependencies for any of the other patches
(that I'm aware of) it would probably be easier to take them through the
Marvell tree if Bjorn and Thomas (tglx) agree to Ack the patches.

Thierry

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR8XMwAAoJEN0jrNd/PrOhyscP/3yMkIYTObpoGCkQA7Ox2AX7
4lKZuEDdVP5osmhF7eFcXY8FhFNLmh+eC1GkntQ4MuRDQtNYaPxGtyd/GfBt7Vgq
DcWzHnXDlPPLOZKHZTBaLHwHTO788cL2rBsx90Yl7ct5iWDmMZzADyOS/UyTxfsQ
E7F9MVa3w5rklZd21HQLQWSQCeIrvQhCz4jk+94+YOFEqEfTeRgGpzadsHwnl/wH
LwCzL9vGxacb65WAGIYeZZuwTQqk/1MWjlkZhzckpKKN7nCfmxuKvkmzL1PGWgL+
FbTXDKr8LzjkEPPT0VCQg6mkzmYGbnu5UisPp7359590Q0rh+td/DfLnl2ZZQWro
UQOq9qr2zQIAmiU6jljps9j2K2KSYFDxlSeyqW/JQDC6oxPSLODcjsxB+ghb9rTL
uxvFJV4F/4kMUDvzEYOZkW5eV9ZB7WWeul4tkEf8EW/zNnrZig3vACYvlnYhjS5U
gUqkPRFRlh7gmw8aX57GxgC3/7ZURJVH1MoIdFPX+kaCRq8u0T8+gPR/6JuPb0uy
P8r3OiDxV8jS25zMyYCjjDONzqEahPIVApsZ/gU1q76k2Sa+xEOCOjWxipEn8XJD
weFI42ArnWGW3rwe7pH00Q4KB5w9GRFwaCSCojF62Rwdygt8ihK+VUrTyDRR6c5g
26LPRIDlxx0jKxjX4Dzc
=/zh8
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
