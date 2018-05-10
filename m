Return-Path: <SRS0=w04b=H5=intel.com=jeffrey.t.kirsher@kernel.org>
Return-Path: <SRS0=w04b=H5=intel.com=jeffrey.t.kirsher@kernel.org>
Message-ID: <ea4c716024a30ed834b1121adb8c2cb1deff2c97.camel@intel.com>
Subject: Re: [PATCH v6 5/5] PCI: Remove unused pcie_get_minimum_link()
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To: Bjorn Helgaas <helgaas@kernel.org>, Ganesh Goudar
 <ganeshgr@chelsio.com>,  Michael Chan <michael.chan@broadcom.com>, Ariel
 Elior <ariel.elior@cavium.com>
Cc: linux-pci@vger.kernel.org, everest-linux-l2@cavium.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tal Gilboa <talgi@mellanox.com>, Tariq Toukan
 <tariqt@mellanox.com>, Jacob Keller <jacob.e.keller@intel.com>, Jakub
 Kicinski <kubakici@wp.pl>
Date: Thu, 10 May 2018 13:34:47 -0700
In-Reply-To: <20180510163357.GB190385@bhelgaas-glaptop.roam.corp.google.com>
References: 
	<152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
	 <152537764322.62474.552711932384023140.stgit@bhelgaas-glaptop.roam.corp.google.com>
	 <20180510163357.GB190385@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-ezjtuMDbw9aM3nX0qUyk"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


--=-ezjtuMDbw9aM3nX0qUyk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-05-10 at 11:33 -0500, Bjorn Helgaas wrote:
> On Thu, May 03, 2018 at 03:00:43PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >=20
> > In some cases pcie_get_minimum_link() returned misleading
> > information
> > because it found the slowest link and the narrowest link without
> > considering the total bandwidth of the link.
> >=20
> > For example, consider a path with these two links:
> >=20
> >    - 16.0 GT/s  x1 link  (16.0 * 10^9 * 128 / 130) *  1 / 8 =3D 1969
> > MB/s
> >    -  2.5 GT/s x16 link  ( 2.5 * 10^9 *   8 /  10) * 16 / 8 =3D 4000
> > MB/s
> >=20
> > The available bandwidth of the path is limited by the 16 GT/s link
> > to about
> > 1969 MB/s, but pcie_get_minimum_link() returned 2.5 GT/s x1, which
> > corresponds to only 250 MB/s.
> >=20
> > Callers should use pcie_print_link_status() instead, or
> > pcie_bandwidth_available() if they need more detailed information.
> >=20
> > Remove pcie_get_minimum_link() since there are no callers left.
> >=20
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Hi Jeff,
>=20
> I got your note that you applied this to dev-queue.  I assume that
> means you also applied the preceding patches that removed all the
> users.  I got a note about ixgbe, but not the others, so I'm just
> double-checking.

I did initially apply it, but realized that I would have to apply the
earlier patches as well, which did not pertain to the Intel wired LAN
drivers.  So I have removed this patch from queue and will only be
testing the ixgbe patch of the series, which Andrew has already tested
and responded to.
--=-ezjtuMDbw9aM3nX0qUyk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlr0rOcACgkQ5W/vlVpL
7c42xBAAlFSF0qz3Go3dVfEzbDD1YlmobU8AzSTOONIuP3aFmggcNMR0pX+uoHLb
QdqhMeh6/I3wUUpMX+eV0wF39hj6WOMAHOJiORU8SLa0SFRGiLzXnzKHprdIDTiJ
isdNzJ/EkrogVu5QsuOMYA5O3bCc37SfwSSoaTJJU4w7MS1UvUjfwT2ZWT1bqxoI
cM1UKUF+FKVv6QvgUf1JuLqpFtauyfJTy8/EnqPMPtkodxrp8F7dpui+NXt1gUM1
WbwW25ZqRcCsvMEFAC7Jf0YrRgnkkn/KUrNqBzL3LdgEbmeVcdWnrVqWHXlUplYJ
Qt/x5NQ1E0uh4B5A3CeUVuuUHaZI3MPK1/MffHR1ja4NyI19o2KEAGPgmrajOEcK
TFrKFyYCZOHO9flhVOUzbA6vReaz5ELELNwlNiS//4Qazp/YI/2u03a8LHQuSal/
2aUkA+qYfTNzTvkupp52kCnStE1qB2mwu/10cxUAg2tqtq9ZiOoNbjs/JuQw6NWJ
QP8waunF2r7r9+5fn1+X3tpDzoL65uZXwLQP92pEX9xlVYQcOIx9wf9ZCF/zHAGo
VtUbNCtGwJnp1EypI9/PiGmFKHwnsOjhqAg2+yAJxuKlIeDtnVZRE9c/OXR++6aI
1ROAd/ODYha5ssWy+0hygaaZNrEPaF7G/k5ARPne4Yzo5c2geiQ=
=9ryB
-----END PGP SIGNATURE-----

--=-ezjtuMDbw9aM3nX0qUyk--
