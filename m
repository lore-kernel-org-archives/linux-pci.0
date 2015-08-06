Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59660 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbbHFRxt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 13:53:49 -0400
Date: Thu, 6 Aug 2015 18:53:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@xilinx.com>
Cc: kernel-build-reports@lists.linaro.org,
	linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
	linux-pci@vger.kernel.org
Message-ID: <20150806175322.GB20873@sirena.org.uk>
References: <E1ZNIul-0007IF-Ev@optimist>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A/AdVN8FDkvpDdxN"
In-Reply-To: <E1ZNIul-0007IF-Ev@optimist>
Subject: Re: next-20150806 build: 2 failures 52 warnings (next-20150806)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--A/AdVN8FDkvpDdxN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2015 at 12:00:47PM +0100, Build bot for Mark Brown wrote:

Today's linux-next fails to build an ARM allmodconfig due to:

> ../drivers/pci/host/pcie-xilinx.c:235:3: error: implicit declaration of function 'msi_desc_to_pci_sys_data' [-Werror=implicit-function-declaration]

msi_desc_to_pci_sys_data doesn't appear to exist anywhere else in
current -next, the usage was introduced by e39758e0ea769e632e (PCI: Use
helper functions to access fields in struct msi_desc) at which time it
looks like it did exist but I can't immediately see where it was removed.

--A/AdVN8FDkvpDdxN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVw58RAAoJECTWi3JdVIfQSNAH/2++6pgRoyaBNUvxPLZeFza+
UeW4WWSRIPsW6Bmrh3Y5weeN5npLKO2ZwiUdAfsDPsDvOlbGWWDdIvVibF5xpf8V
lHc0ihPgPMuzJTNHjzETwXV+4mUDdkUv0FsWxgwzhv0bhe9w9z8uznEY5XiIxs5A
Ptuvo8cvqRNwHIUoln64SWd3zMOSois/EXqX/+UcmUjKMMzQ4csk6BOjQZgPneGt
ZnMPQgp8O8e2lSPDIne+O2+3c2U9j34FRsi6/SQAExG4z91Ti2JaVoZzx4kVh0H2
krcql/myy6/k783zuOTkvqEdG5cdGb7j2KrNoumfQtve9jbMns604ExWagIEcls=
=n1TH
-----END PGP SIGNATURE-----

--A/AdVN8FDkvpDdxN--
