Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61344 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732AbbIXSfc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 14:35:32 -0400
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"myron.stowe@redhat.com" <myron.stowe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix devfn for VPD access through function 0
Date: Thu, 24 Sep 2015 18:35:30 +0000
Message-ID: <A7D02BC2-8C65-4089-82C4-09EA16C7C0AB@intel.com>
References: <20150915171216.7049.58119.stgit@gimli.home>
 <20150924182755.GC3648@localhost>
In-Reply-To: <20150924182755.GC3648@localhost>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_F7A640EC-860D-4C77-981E-17829212F40A";
	protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Apple-Mail=_F7A640EC-860D-4C77-981E-17829212F40A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On Sep 24, 2015, at 11:27 AM, Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>=20
> Applied to for-linus for v4.3 with acks from Myron & Mark, thanks!
>=20
> I removed the stable tag because 932c435caba8 first appeared in
> v4.3-rc1, so it shouldn't appear in any stable kernels yet.  Right?

I have seen the patch in some stable code reviews already. I know it was =
deferred from one, but I see it in the changelogs for 4.1.8 and 4.2.1. I =
have lost track if it is in any others.

--
Mark Rustad, Networking Division, Intel Corporation


--Apple-Mail=_F7A640EC-860D-4C77-981E-17829212F40A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCAAGBQJWBEJyAAoJEDwO/+eO4+5uIMcP/iCKspNNQ55WxHnWahr1q3C1
6hVevKShXu9HjafytGE7SqszM8Vzw/tNWZC2n7JCxnyA9DSrJLh/RqKz9cWRtZi0
+T29RL9YOMZlBvtj2VCFLt6KmMB+74wiXhrOcLLcA0kBNGs8IcT8HZahhFIGnzpc
x6DgNVJKQYkBJKSheEvVT2aiS2OD/hAJE5FnkTD2IFRIgoGE3NtX1aEEidDWCduW
eckZC/7cghlqQm2eC903wiDkx27PFwdfhkJLohQHdsU6fZG5ygCMtqbVssPc0AGY
dzyhJizfZwepOm/GAr2eJgkOgKpQvzNEp7vIlqd9WRiPDldEdP9XplJKExQG1t8v
7gxb95divyOFxzLTndA5TEkfDUiFEFYt1Oi1yTboKib7UYi8GeUeWxC8FkA90rhq
P9+jeCbS0yuL59yVhl1Mppkz6Jie2Ct/yk1AMqi0yIvIfdDlKaC8bDJ8g7AXc8qI
wKEScMiAamQXOzNIqnzUiGxBX/SCugkTjaHtBSyRfBecxu0GVkR/ZOoVgu3pL073
1vU8S6zNqxorP5XQ2oke2Hua3J+B5NyYNZGTObGD5Pu5d8935eSlD+DA8oBwrye/
/+Ozk3bEY81cYavdw6YDSG9W8t3wCxrHsSvG1PJa0C2LBIpFlESsTbTKfet9wHLL
s4EAXMxNhYKhIseBcL2r
=JbYN
-----END PGP SIGNATURE-----

--Apple-Mail=_F7A640EC-860D-4C77-981E-17829212F40A--
