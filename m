Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:33247 "HELO
	oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756606Ab2ADR2L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2012 12:28:11 -0500
Date: Wed, 4 Jan 2012 09:28:04 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 09/34] arm/PCI: convert to pci_scan_root_bus() for
 correct root bus resources
Message-ID: <20120104092804.686d17d3@jbarnes-desktop>
In-Reply-To: <CAErSpo4MEYHUVsHywnRfYFU18Ly=48gFRZJK_35v=WMj0HHqHw@mail.gmail.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
	<20111028222616.30729.96687.stgit@bhelgaas.mtv.corp.google.com>
	<CAErSpo4MEYHUVsHywnRfYFU18Ly=48gFRZJK_35v=WMj0HHqHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/+4_6H_bowoh+IbGhEEpWUpC"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/+4_6H_bowoh+IbGhEEpWUpC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Dec 2011 18:10:43 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> Working through this with a cross-compiler, I found a build bug in
> this patch.  Updated patch and incremental patch (from commit
> 9a1d98b3a0d8621 in your linux-next branch) attached.
>=20
> My cross-compiler can only build about half of the ARM configs, but
> better than nothing, I guess.

Merged this into the existing ARM patch, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/+4_6H_bowoh+IbGhEEpWUpC
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPBIwkAAoJEIEoDkX4Qk9h1JwP/jvvIUYx9/UFx2xOY0A1ozPO
q/HkkCR4XVRi11wWlILhBF/fJuGVkGO4/aR+hCbDe583bGt0AzahwwFYYLs/bVgA
xCskeRvZJVEXshz5jMoGfJHrmDyLv3XCkkL/nljP3yd+EbLMYcoUCGysb+dyGxqJ
X+4z3GVtfYPMJS2wRTotTqExhswNvBaR4SXyC4MW/s76Lt+8vb73DWSQ13XooJUK
wKSoXlNUfpWr0CMuKVcouJIXsTgoNI6+TCLN8xjo5FzxHOZHNo+os8SHozbMfXMH
O3PeLNgpn/T+df6Vd4sp4HP6xNmt2Tj5E0ZhqxY/nzHadYfSVGtvg2Dksnng3d71
GL9b+Rp5tJlqAklyZcKHRp4+e+ukMSCunVddPKah2Y8IzzNYvIkyHvdq5363jqlf
0HAaufwS5tkA5fbkhgplyN9u7kQ8eX6CCjLS//A+aFOVmStkAAcTIMqJL72zRPdD
/G4N5DXtKbMQFrJ8fL8DKecHXBrotype4Ip0gE9HcirTAs///5NUH83f01NgEH8c
Ajny7iHslqtyGkBOAtQ9BCj3+FwqQqnz9cX9MhrzffF9OKZl5+XQAtoXfG4mfhjh
rP52/t3L5qj3g4AcF3rFFjO99KYqIqayyZ504z9ZbPYQB28zr3IVmtcymvJfd9aC
PUyyO8IquPotpMF9zyA0
=GVXY
-----END PGP SIGNATURE-----

--Sig_/+4_6H_bowoh+IbGhEEpWUpC--
