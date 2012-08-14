Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62326 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab2HNFiQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 01:38:16 -0400
Date: Tue, 14 Aug 2012 07:37:55 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/10] PCI: Keep pci_fixup_irqs() around after init
Message-ID: <20120814053755.GA16181@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-2-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo5YDwstHv7B7LEbDQmnHnuVsMA2ibTFNLkiCKmkkeE4Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
In-Reply-To: <CAErSpo5YDwstHv7B7LEbDQmnHnuVsMA2ibTFNLkiCKmkkeE4Zw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2012 at 10:06:38PM -0700, Bjorn Helgaas wrote:
> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > When using deferred driver probing, PCI host controller drivers may
> > actually require this function after the init stage.
>=20
> Yes, this is a bug.  Actually, there's still another bug here: if we
> hot-add a device, we won't do pdev_fixup_irq() for it.  But your
> change is worthwhile even without fixing that other bug.
>=20
> Normally I would include this in my PCI tree since it's under
> drivers/pci.  That would make it easier for somebody to fix the
> hotplug problem in this cycle.  Would having it in my PCI tree make
> things harder for you?

No, not at all.

> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thierry

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQKeQzAAoJEN0jrNd/PrOhdCsQAKrXlGD327UeqNjOhCM4H1PV
47jmcum0n17F0hQBaAx9smVXX8Sx+ifUYYGs3sv305iQ0p7om19IPLBggzqkVhk4
CYFKb21kj/OxnibFTchbxfDaK0rUEFI5X2o0cc/QzIe0RFIN2hsh7PRuxPB9wP1d
WE1EoGpOTwPr5wCxm4WhUWQZUMJ/AOVpEp9hS/ugwcwoKXfEHMTCRCRCpJIpXovD
TZnMSzpEiB4cwUrpwzcrQ9dn/5r3I3f2+Orol7sVBmEeTZJPlcaBz+atQ/RHInA8
S4fV37mG9pnv2Hiin34JF3RSO/TS0R1kRZQpHfIxfxnisFQM6yJmwaX5VOwE8JMJ
6TZLEdMsOsjpnAdVAx0ZO1oCxsiYvPWe3zUg73xWazd47N1J26qZreqlSy2af1ej
goWf0WsiFMC3MGfmrj/XwzI+A49suk82iqC9MzL2OJUCIwonxzVDiJC9hyCHkVbw
CPy5ivFV/wMlmiR0jXZXWibhq1R0uoNCKSBtnT4ZRnCnIGmC5zvFlku0Ve/3txuM
mJ40ERby1RNJes76eryRxy3vw2cCyoKMNLs0JX7xXzvw31yqk3sxOTb1pw1vTEJF
en9l32MtpaGGUeE/4I+6fZ5ICWtS0HdFcsZG8rVJBFgkuBXpmIIR/XED273LAK6Z
YuaARHxYHR63nMSmaQhK
=sqZj
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
