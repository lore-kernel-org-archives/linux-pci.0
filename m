Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57075 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935334Ab3DIIWu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2013 04:22:50 -0400
Date: Tue, 9 Apr 2013 10:22:33 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [RFCv1 08/11] PCI: Introduce new MSI chip infrastructure
Message-ID: <20130409082232.GC27255@avionic-0098.mockup.avionic-design.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
 <20130409081119.GA30736@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
In-Reply-To: <20130409081119.GA30736@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2013 at 09:11:19AM +0100, Andrew Murray wrote:
[...]
> Also I believe pci_alloc_child_bus function would need to be changed to add
> "b->msi = msi" to inherit msi_chip for child buses in the above patch?

The patch already does:

	child->msi = parent->msi;

in pci_alloc_child_bus(), the same way that ops is inherited. I have
admittedly only tested this code on Tegra, but I don't see why that
wouldn't be enough. Or maybe I haven't understood your question?

Thierry

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRY8/IAAoJEN0jrNd/PrOhbekQAKkjrnRsOfVv4qKeB1sc+W1S
ptqQkqHoA1NoNWFyOIffRpVKoI3CqCbxiIW5nssN1N3pOkAmhYgWdJWDfVefY5ir
UzZXk7KKBrbDXfFSUOeoFLAC2ZwU96uL5VB260KDRw79x4ptw9g2lTGC2ksqjGmb
KjycUQFD4KbG24AC9TOsDby7BBmP3tqjqQJMlc1zBThJSdhqEV+3heb2VRXYrBHK
BD7+HDXKaZ/ysmanFprJPiTN8SSVQn+F2Q4bYZT0KpyRelJHyhbeDLHM/BuevEwA
cLOrKqdsog6kuesxNdztrqfB/R+gv8RtgLkkHDtFNAUnZtcjM8ZJneWpUFtYGXwO
Ta6FveIFCa9DHH6KfBNprV3zqwJwhLQZQuEogdNw0kcl/pmCO10chStKZ82Lq9eR
FSs2kRY4mHsPv8SXnsIAPZxyWGY9lda6shXBD17pnPIQ57IeCWHxgetA/CYaPlX+
szYGOS28iHfwdQ7mvUu+znhMBRDisbKb3y15dR8YwUluZwnU7+9Nj5aLBD8q4cLt
eDJCv2uQr0GSYRjwIk2hpFY32IZzfd41QaUSMk3G5zhI6OOGheRwkD1d+q1E1dv6
vTa7gQ0r3BCPrMk0hzH56rzlzdQUJT9LvqjVG3epUbNMopjwIVMrXCOxpsmTJ1D2
hUzr3i0oJebiI8QiCmh+
=SRPZ
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
