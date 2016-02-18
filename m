Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Feb 2016 15:24:09 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Restrict build to 32-bit ARM
Message-ID: <20160218142409.GA4678@ulmo.nvidia.com>
References: <1455802330-17565-1-git-send-email-thierry.reding@gmail.com>
 <5051836.EUN3ennYNm@wuerfel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <5051836.EUN3ennYNm@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2016 at 03:06:23PM +0100, Arnd Bergmann wrote:
> On Thursday 18 February 2016 14:32:10 Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > This driver uses PCI glue that is only available on 32-bit ARM. This
> > used to work fine as long as ARCH_MVEBU and ARCH_DOVE were exclusively
> > 32-bit, but that's changed now, with ARCH_MVEBU also being available
> > on 64-bit ARM.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Looks fine as a temporary workaround, but I think what we really want to
> do here is to remove the dependency, as the new ARM64 platforms are going
> to need this driver anyway.

Agreed. I've been meaning to do just that for Tegra as well, but the
conversion is somewhat more involved and this is currently breaking the
linux-next builds, so a quick fix, even if temporary, is warranted in my
opinion.

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWxdQGAAoJEN0jrNd/PrOhtKkQAJ/LdHf+YABXdStz47pw/yU4
SFl8zD0hcnJS2asG/8JN9QVBNo0hOji9rW5OcraGbt5WboctYy0SM/H8qNzik+Qb
M2Sxms7SnpBSPsn7HUJioSOwpCArOr/2KFEwt3+zqaiSzvzir3K8Qwi70LorpXPB
RO2XJUYPB+Lj6zx33BrqzuEuuBuGUALjCGHiu+32dIKzbhl8RhBDvYszEbmfurW9
KCrDsmvFmKyJ31/MS24C3m7LM28S3lgFF6Aq1xDRCExCUMt4LTZB3TCFwu6o9bnM
SzmVj6rJp9qDzG4F4S4wv5HbgfQbXPqpVu6cmEhvP3EwLX4Kr6wQgFIUCiF8PCBd
oUE51F0Ht2E5EAv7BFq8azQ6ezbGd8mrQJMBrNgbhE2SG/WMevTi91c+aA1feeeu
dcAPqybwR23cXnL9vocjn/CmwI6GEJnksk5ANocOzdqvptiWvB2y1Cse5Gr6doq4
j057HsvcuKpjW/uzq1qYbXgyEr4AKawOifyzt3XinXAktPPJWwvh2iXLOLZ1IE7y
1hwk4auh7qIh76znlvfp/WNTA0G0P3jQ21KvM3WvvjEc63TS0FvaJDMa4V3nee6x
PshjYROaNF+aUqgtTy+jaWpChywjPH0Pnx75NkxrZDoL9HZBZyxkfmbIEyOm9w/Y
d8TlfGaqvhAwGYJ+9yYX
=zLj5
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
