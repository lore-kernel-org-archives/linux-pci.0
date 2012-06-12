Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58524 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab2FLHZe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 03:25:34 -0400
Date: Tue, 12 Jun 2012 09:24:44 +0200
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
Subject: Re: [PATCH v2 05/10] ARM: tegra: Rewrite PCIe support as a driver
Message-ID: <20120612072444.GA8577@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-6-git-send-email-thierry.reding@avionic-design.de>
 <4FD65E98.4070200@wwwdotorg.org>
 <20120612064124.GF4040@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
In-Reply-To: <20120612064124.GF4040@avionic-0098.adnet.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Thierry Reding wrote:
> AFAICT the even partitioning of the non-prefetchable and prefetchable
> memory regions is arbitrary and it could potentially be useful to make
> it configurable via the DT.

So it turns out that this isn't true. But apart from the comments in the
driver I couldn't find any reference to how the prefetch and non-prefetch
ranges are partitioned. Judging by the code for Tegra2 this is evenly
partitioned among ports 0 and 1 but it would be interesting to know this is
done on Tegra3. Is there any way you can find out?

It'd also be nice if some better documentation for the PCIe controller could
be made available. The Tegra2 TRM doesn't contain any of the AFI or PADS
registers and while the Tegra3 TRM documents more registers, their offsets
are completely missing.

Thierry

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEUEARECAAYFAk/W7rwACgkQZ+BJyKLjJp85+QCgmN07XBNfzBalb+sQaSasq/jt
7h0AmNrMJIwLUYh+l6BAWLPvMxOVeNg=
=iyKb
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
