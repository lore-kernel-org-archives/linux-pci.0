Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60720 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbHGJuc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Aug 2015 05:50:32 -0400
Date: Fri, 7 Aug 2015 10:49:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@xilinx.com>,
	kernel-build-reports@lists.linaro.org,
	linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
	linux-pci@vger.kernel.org
Message-ID: <20150807094957.GK20873@sirena.org.uk>
References: <E1ZNIul-0007IF-Ev@optimist>
 <20150806175322.GB20873@sirena.org.uk>
 <20150807073954.3d19fc69@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZoLk6gR8DhOZikwD"
In-Reply-To: <20150807073954.3d19fc69@canb.auug.org.au>
Subject: Re: next-20150806 build: 2 failures 52 warnings (next-20150806)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ZoLk6gR8DhOZikwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2015 at 07:39:54AM +1000, Stephen Rothwell wrote:
> On Thu, 6 Aug 2015 18:53:22 +0100 Mark Brown <broonie@kernel.org> wrote:

> > msi_desc_to_pci_sys_data doesn't appear to exist anywhere else in
> > current -next, the usage was introduced by e39758e0ea769e632e (PCI: Use
> > helper functions to access fields in struct msi_desc) at which time it
> > looks like it did exist but I can't immediately see where it was removed.

> Actually, it is a typo ... all other uses are spelt msi_desc_to_pci_sysdata.

Oh, that explains why it was so difficult to see where it was broken.
All the spinlock breakage for the past week masked other things so it
looked like it'd been added then later broken :/

--ZoLk6gR8DhOZikwD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxH9BAAoJECTWi3JdVIfQuCcH/2mdJ1aksGK0TtUsySnNjya7
GOm0PmBghkkxAKgahjbCoADv+PNs3No8UOIBtAjOOCgImtkMvdSZoYGcHEqnqPug
lDGgsGiHVdVwK9ybVDhspYE3uHUhR4murGkemuXAdiQSJvMGb7pPuEenK3B7Nvr5
3KVibKx3nQPCKKFRSDaQ4SJIEcory014rLk1kBRXxEFfSGdAbn2v+aY0k+7pWoX0
7wpNvopKqStC0nfjyNfVyJBiM8gBwjh/TEWYsBVG0PZwRWaJ0ENrsvG3iAJeNwOT
B28M2iKkJ3hSUr368yuKcbFAqw+HBXMZIGArN+A1a9iezqJm2SRw597Ek0S9svM=
=txXb
-----END PGP SIGNATURE-----

--ZoLk6gR8DhOZikwD--
