Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62920 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2FLFlq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 01:41:46 -0400
Date: Tue, 12 Jun 2012 07:41:31 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 06/10] ARM: tegra: pcie: Add MSI support
Message-ID: <20120612054131.GA4040@avionic-0098.adnet.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
 <4FD660F9.7030807@wwwdotorg.org>
 <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
 <4FD6D4C6.2080201@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
In-Reply-To: <4FD6D4C6.2080201@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 06/11/2012 11:07 PM, Thierry Reding wrote:
> > * Stephen Warren wrote:
> >> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> >>> This commit adds support for message signaled interrupts to the
> >>> Tegra PCIe controller. Based on code by Krishna Kishore
> >>> <kthota@nvidia.com>.
> ...
> >> Why allocate pcie->msi separately; why not include the fields
> >> directly into struct tegra_pcie_info *pcie?
> ...
> > Second, and more importantly, this will keep the size of struct=20
> > tegra_pcie_info smaller if PCI_MSI is not selected because there is
> > just one unused pointer instead of five unused fields.
>=20
> Well, you can always ifdef out the structure fields too, right?

Not if you use the IS_ENABLED() macro. It's supposed to increase compile
coverage for a trade-off in memory usage because like in this case some
fields may be unused.

I find this very convenient because it prevents situations where build
errors don't show up until somebody uses the code in an unusual
configuration. For developers this makes it really easy because they don't
have to test every possible permutation of configuration options.

Thierry

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/W1osACgkQZ+BJyKLjJp+fMQCeKraIbJ59jPXjIRfBrQRzJUaH
EDwAn1b4QFBcDFBZQNTaDokBi6/S2N+L
=ohNf
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
