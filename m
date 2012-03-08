Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50482 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab2CHShh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 13:37:37 -0500
Date: Thu, 8 Mar 2012 19:37:31 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 06/11] PCI: Keep pci_fixup_irqs() around after init
Message-ID: <20120308183731.GA25254@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-7-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo6hbWjteESST1+O2WzbtmZq6hC-pnUB4o3MAXWG-EgU+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
In-Reply-To: <CAErSpo6hbWjteESST1+O2WzbtmZq6hC-pnUB4o3MAXWG-EgU+g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Bjorn Helgaas wrote:
> Hmm, your patch looks OK as far as it goes, but the implementation of
> pci_fixup_irqs() as a call-once-at-boot-time thing with a loop through
> all the PCI devices we've found so far looks completely broken with
> regard to hotplug.
>=20
> Who does the swizzle for devices hot-added after boot?

Perhaps I should have mentioned this in the commit message, but the patch
isn't actually used in a hotplug scenario. In fact, the code is still run
once at boot time, only very late. Grant's deferred probing allows the
PCIe controller driver to postpone initialization until all the devices
that it depends on (regulators) have been probed. This has the side-effect
that the probing actually takes place *after* code and data annotated with
__init have already been freed.

Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9Y/GsACgkQZ+BJyKLjJp8qLACfYNrcwrYDwS7KUKwaRVj+cS6S
pU8AmgM4GdvwiXkJqH4QTT/CljdHZjbS
=DeUC
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
