Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61599 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab2IRGeA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 02:34:00 -0400
Date: Tue, 18 Sep 2012 08:33:49 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
Message-ID: <20120918063349.GD1459@avionic-0098.mockup.avionic-design.de>
References: <50294BCA.1070807@wwwdotorg.org>
 <CAErSpo7og1XgOSv_mFCQ=hP7pq0j3gXWh2QFL2wBJjz7kcAq=g@mail.gmail.com>
 <502AA96B.2050709@wwwdotorg.org>
 <20120814195834.GA10431@avionic-0098.mockup.avionic-design.de>
 <CAErSpo4Bm_Ryx=OK+svjqAwD4N8v0vrheLVdc-N1ijx8i_-N3w@mail.gmail.com>
 <502AD82F.3080702@wwwdotorg.org>
 <502AE485.8060307@wwwdotorg.org>
 <504A848B.1090703@wwwdotorg.org>
 <20120908000430.GF13739@n2100.arm.linux.org.uk>
 <CAErSpo42AME4nJqdVk9cC2EcTfu96r+yxmmOB=hXNi6jh-c+XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
In-Reply-To: <CAErSpo42AME4nJqdVk9cC2EcTfu96r+yxmmOB=hXNi6jh-c+XA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 08, 2012 at 11:51:00AM -0600, Bjorn Helgaas wrote:
> On Fri, Sep 7, 2012 at 6:04 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Sep 07, 2012 at 05:34:35PM -0600, Stephen Warren wrote:
> >> I guess it's a pretty basic premise of the current PCI code that all t=
he
> >> PCI scanning happens well before any device drivers are registered,
> >> which in turn means that device_add() doesn't trigger the device's
> >> probe() until much later, after all the fixups and resource assignments
> >> are done?
> >
> > Are you saying that the PCI layer is again screwed up after all my
> > hard work several years ago to ensure that PCI devices are properly
> > setup _before_ they're made available to the PCI drivers then?  That
> > was around the time I was looking at Cardbus stuff, ensuring that that
> > worked with the same guarantees.
> >
> > Not amused.
> >
> > What is wrong with the "probe devices, apply fixups, setup resources,
> > apply more fixups, publish" process that it's had to be yet again
> > broken?
>=20
> It seems that there are some bugs in the PCI layer, no doubt
> introduced after all your hard work.  We'll do our best to fix them.
>=20
> The particular issue of pci_fixup_irqs() has been on my list for a
> while, and we talked about it at the recent PCI mini-summit.  It's
> clearly broken that we do this with for_each_pci_dev() once at
> boot-time because that does nothing for hot-added devices.  It's also
> broken that it is called after device_add() because the core shouldn't
> touch the device after it's available to drivers.
>=20
> This should get fixed reasonably soon, probably not in v3.6, but
> hopefully in v3.7.  It's not completely trivial because many arches
> have the same problem, and we need to fix all of them.

Has there been any progress on this? I've read the PCI mini summit notes
that you posted a while ago but it doesn't mention the pci_fixup_irqs()
issue. Was there some decision as to how this should be solved? If I
understand correctly this should solve the issue that Stephen has been
seeing with bogus interrupt assignments, so we'll need this to fix PCIe
on Tegra. Is there anything I can do to help move this forward?

Thierry

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQWBXNAAoJEN0jrNd/PrOhaJsQAJq1UZX2eVo+oQBZvgOV6EDj
enFywiSSt9qULoUADWrUNuJHTvmQMjwwEHruj6K/q3HIZefWQYyz0U5CDHcHcEEo
Oq0JzCovAA+Yi3XC4AtrNNnm8QG5bhGhAF2m8hwkQjwxzV/3nlRfASbI9XrDVouL
YkE7mkwutmn7K9mmmD6+ZJfpS9kCGu8kBGFa4EhOgK4a1RlqfHuxp29f7hL3IPON
xC0Kbl/FwVFoG6t/DpwS+Cm23ASs1S7SyoQoxF6FM334cmk8KsqYjA5cC47oYVuD
h0Z3H408Qv1ELzh0EIEi6JHRebmMm0CmpVa3zvwdtyd9dQPDV7Y3il8DGqbHNst3
kKpiSo/OJSeOfwjm8Ke4Q553bU00qXsYjAXLt9X7evEjJaLVInpvGbSoyOLrFkST
dDhlOMfe8FbuneXFZ52jVdglX0IxleOdIvdDQbE0I046UMCfQbfVdrDnfVlbaGJm
Ip8Om9g5mn9dz2t2k88pYlHAxaSikIBaB6y/rqMLls5Xvartemet1+aDI4CH3XS/
CyCcoLX+A3Hr8zF+ET915Le+OLW2iFRpoKYF1T3LSrhoeapIxoKqBrILJ6ZMFlk9
So0w8QFYkIapaYzIYEFzeqOi4PwLdDEajBgcvz+2OyQds+ZuezuFpjYIA+Uio1Y5
ZxDhcAjjyGeFYW0LKhXu
=Zo7u
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
