Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2965 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056AbbIWTQ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 15:16:28 -0400
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"myron.stowe@redhat.com" <myron.stowe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Relax function 0 VPD test and relocate
Date: Wed, 23 Sep 2015 19:16:25 +0000
Message-ID: <A0E9F02A-1141-45E6-A143-BB09B0408D60@intel.com>
References: <20150916041858.26694.97435.stgit@gimli.home>
In-Reply-To: <20150916041858.26694.97435.stgit@gimli.home>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_B0F41D7B-5F9F-46A4-AA94-BEAB798F2FDA";
	protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Apple-Mail=_B0F41D7B-5F9F-46A4-AA94-BEAB798F2FDA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Sep 15, 2015, at 9:24 PM, Alex Williamson =
<alex.williamson@redhat.com> wrote:
>=20
> When we quirk a device with PCI_DEV_FLAGS_VPD_REF_F0 we're expecting
> to find a device where all the functions are identical.  If we don't
> find that, we don't make VPD accessible through pci_vpd_ops.  That
> means that if we quirk devices we shouldn't, we filter them out by
> hiding VPD entirely rather than allowing default access.  Instead, we
> can flip this around to only quirk devices that match a slightly more
> rigorous test in the quirk, allowing regular access for anything else.
>=20
> Tests for the multifunction flag are removed since a) function 0 and
> the function under test are clearly a multifunction device if we're
> scanning a non-zero function in the same slot and b) at this point the
> flag is only set in the device under test if the multifunction bit is
> set in the PCI HEADER, which is a point of interpretation for the PCI
> spec.
>=20
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>=20
> This is potentially another stable candiate since we're continuing to
> iterate on 932c435caba8, but since we don't actually know of a device
> where VPD is blocked (we don't think my Skylake example actually
> supports VPD), I'm not including it.  I would support it if requested
> though.

This looks good to me. I can't really test the cases it addresses, but =
it seems reasonable.
Acked-by: Mark Rustad <mark.d.rustad@intel.com>

--
Mark Rustad, Networking Division, Intel Corporation


--Apple-Mail=_B0F41D7B-5F9F-46A4-AA94-BEAB798F2FDA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCAAGBQJWAvqJAAoJEDwO/+eO4+5utVgP/2x1tvOrBJN2iY6L1cQsRx5e
sBg+MitY3UdGTZuP7sv+3y1bxpc2xDjoMYzPxYNS1UEV3XEdJ1OWaypbC4VYWMVz
EsPuchliGTU7nM2IEFWmtX5ycWH2L8OEeMb+CnTTqMpos1bep7cHtYugaqU4JhLx
nmHUOZyyZTKDdQBUrGGwa+bbl21mEAZw67exulCT/nRehwueTTF3SCmup5xGJ2ZO
uL1nen4dLR07oMUzmDoth7500R+hLofdJUVjyizum2CUp16hm6t0akJ+fvgm4paL
vkpCOvGhMzeNc3xsFD2sg+mx4qWtWRig3ylTS97UrxuCIoDVBbOP7Rb49FIsQI6M
agSKpF05SY3C+1KRMJdDWZwNVhxF8U3vQSRDJ5qAykEg3XtM5o/6qllZ3HIuirZX
fswxjZMbQD0Z/cQ7HMj4PAawo5UPz/QKOLID9n+aSS2nE0nHhmqd8VWaxtlhZy9r
6LjeS7CXUG+RXJwv4djErWJg0j733BPKBiMlu7cDGQIUFmRbEEqfZ6F8LgpRxOyY
tirieitBV+sEjxHEAdlYkuEXSFTZWCBbqJ4mcJII3E7uA5jOrCeV9d/7qd9bU7Cv
g5xwqF5QeKvnB35HRx41ZX+XXRDO+ZxueRFLFta2u4JR2V4U/P/1tba17YT/fTWo
u3AIlgvPQGkDYpHau6R5
=MtxU
-----END PGP SIGNATURE-----

--Apple-Mail=_B0F41D7B-5F9F-46A4-AA94-BEAB798F2FDA--
