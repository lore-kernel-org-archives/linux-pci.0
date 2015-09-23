Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45252 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694AbbIWTL2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 15:11:28 -0400
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"myron.stowe@redhat.com" <myron.stowe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix devfn for VPD access through function 0
Date: Wed, 23 Sep 2015 19:11:19 +0000
Message-ID: <409211CA-FEAB-4CB6-B418-CBF9FA50DB6A@intel.com>
References: <20150915171216.7049.58119.stgit@gimli.home>
In-Reply-To: <20150915171216.7049.58119.stgit@gimli.home>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_1C680143-7EEE-49FD-B33B-845B452A5FE9";
	protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Apple-Mail=_1C680143-7EEE-49FD-B33B-845B452A5FE9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On Sep 15, 2015, at 10:17 AM, Alex Williamson =
<alex.williamson@redhat.com> wrote:
>=20
> Commit 932c435caba8 ("PCI: Add dev_flags bit to access VPD through
> function 0") passes PCI_SLOT(devfn) for the devfn parameter of
> pci_get_slot().  Generally this works because we're fairly well
> guaranteed that a PCIe device is at slot address 0, but for the
> general case, including conventional PCI, it's incorrect.  We need
> to get the slot and then convert it back into a devfn.
>=20
> Fixes: 932c435caba8 ("PCI: Add dev_flags bit to access VPD through =
function 0")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>=20
> Since the original patch and quirk was marked for stable and applies
> to all Intel NICs, regardless of the bus type, I assume this needs to
> chase it or VPD might disappear on e1000/e100 if it currently exists.

This looks good to me.
Acked-by: Mark Rustad <mark.d.rustad@intel.com>

--
Mark Rustad, Networking Division, Intel Corporation


--Apple-Mail=_1C680143-7EEE-49FD-B33B-845B452A5FE9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCAAGBQJWAvlWAAoJEDwO/+eO4+5uM2gQAIh1SfENjAcIsBr2g5eu3Hs6
f1HfjSPjlPD7xCZLDJ2qRtLRb1h0FtA+Z+bZ2Uq2gXu1A9AscnRi+N8usBMtop3j
J3rBO5i2rYwN/1sGpsOTLKYUgN/tasqLpqkEgeF2huFK9uSI/qmdwbvPd4EN8OoU
Q3eEOk5ynBAy/tOQSiYZQgEZ7xwdrFHOXJD7Xfy3XUorGu5UJ5MzlD8nl8AFRO5L
BLpDMDdhLo3kOSo8x6qoiRq2NfZP/T0e+lTxqBJ9uIVWfcsQDrXJtbIIs6iG13dM
b4MPvq9/h56BS3BnkMrHrDXSqNrTflvNtrLaHlbdsirqF90ZvZHVzgZeEYbDSvm9
YQWk9/JHu7wEnPhq0exae89+x3TmgInIk4kZwwMvMTmxWhDeATwdvchUugrhL0zE
yRCqqxlXatDrEdWiBzL8tTS0GK0NP7tphRuy32ONucBqXGDLLSaa8u9/WkpTInXE
OUjcjq5SV2qIQEXg/8+DI6nJMesCi4guq/kgxXfdG8p5rFKauE2Fkz/qaQ7weoaf
kubanTe2/m874gD8YxsY2y4Y17kNA7PgerYkIWy2weG0QM5ZDuR7OgDY/apRJQWD
BhmJ0xDQqc92fdSts2n7x42a5OncGIA3ZWOJ/o/7MoxAaEJcavnjKWuuCQARJmpe
LwBiFEoS2ciTQ/3USShZ
=MhfJ
-----END PGP SIGNATURE-----

--Apple-Mail=_1C680143-7EEE-49FD-B33B-845B452A5FE9--
