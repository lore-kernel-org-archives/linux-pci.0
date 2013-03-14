Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63567 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3CNVJo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 17:09:44 -0400
Date: Thu, 14 Mar 2013 22:09:26 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Mitch Bradley <wmb@firmworks.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130314210926.GA9098@avionic-0098.mockup.avionic-design.de>
References: <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
 <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
 <20130313222102.GA28336@obsidianresearch.com>
 <20130314090120.GA2224@avionic-0098.mockup.avionic-design.de>
 <20130314172555.GA14048@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
In-Reply-To: <20130314172555.GA14048@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2013 at 11:25:55AM -0600, Jason Gunthorpe wrote:
[...]
> I'm assuming 0x80000000, 0xa0000000 and 0xb0000000 are real CPU physical
> addresses?
>=20
> Then it should probably look like:
>=20
> ranges =3D <0x82000000 0 0x80000000  0x80000000  0 0x00001000   /* port 0=
 registers */
> 	  0x82000000 0 0x80001000  0x80001000  0 0x00001000   /* port 1 register=
s */
> 	  0x81000000 0          0  0x82000000  0 0x00010000   /* downstream I/O =
*/
> 	  0x82000000 0 0xa0000000  0xa0000000  0 0x10000000   /* non-prefetchabl=
e memory */
> 	  0xc2000000 0 0xb0000000  0xb0000000  0 0x10000000>; /* prefetchable me=
mory */
>=20
> Which says 'access to CPU address 0xa0000000 produces a PCI-E memory TLP =
with
> address 0xa0000000' - this is the 'normal' case, I assume that is what
> happens on tegra?
>=20
> It also says 'access to CPU address 0x82000000 produces a PCI-E IO TLP
> with address 0' - this translation is something Linux typically
> expects..

Both of the above paragraphs are true. However accesses to the windows
at 0x80000000 and 0x80001000 don't generate memory TLPs but type 0
configuration space TLPs.

So my first instinct was to make the first cell of the first two entries
0, but that doesn't work, since the OF core expects to find either
memory or I/O spaces. ss =3D=3D 2 isn't quite right here.

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQjyGAAoJEN0jrNd/PrOhSaIQAIY91SVCtiEHKtCja91PItQ9
0fTNCdoXmJ4HYHjhT4jjYZnnsw36X7Jy+s86oybWOCJ1gI3DM7mF+wEh8awLperC
1XPiT2/pTrQRRvySDwT2yielJw1EYlHGA2eZs9Ig5dy+Po38qyyF0q5so8fPLTqI
XHoKxi0DBfhvDbgLdHr3H7xr7noa+xE9zwm3d+FOed/3J3IL26OpYbI6cOD1ZM7E
ufgqaUD9kknt8w23ihuYJ3DFUIjL/HxlMENiIXXxqS35TdPYrWY5JcZgfTcMrlEd
vdjTIXVTP8IsuEbfFZed98Fnl9DRh1auGnNheVrgyrJWSs2njVQFOwIvVMj7Nv2r
4QsS2gk8lrMocM0HHkUG8tNYTHej6sM9mxJte4etBosrVuCL22PGARW/WeekRRcu
25FCxjNpPKEOorqoSvjTxSgC0T3dOSB1NqfwMy80KBGSBuAugm5DPIngfW2kEV7P
PeQqvds0OM7KOLYu5ReF9qfmYpPYkek+54iMnBHeMHCZrqtuSiWQdW8FNvJgRmPu
vIU3QiXSQZ1DU09U6jKBCHRsD67p/HDJjuobIO7R45OHC4f2xg6e8zF1qCc9QYhS
6sm6zVJjt1izV3bjlbAzyrQcT3HVNsax843mu9oA3Dh9SqfhPI+ZgKxyjOUYPgmm
etbw6SWMYsA377g0Vlr+
=G+g2
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
