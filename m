Return-Path: <SRS0=w04b=H5=intel.com=jeffrey.t.kirsher@kernel.org>
Return-Path: <SRS0=w04b=H5=intel.com=jeffrey.t.kirsher@kernel.org>
Message-ID: <182a863cd7502dd9d872beb5265487a4ce39453d.camel@intel.com>
Subject: Re: [PATCH v6 4/5] ixgbe: Report PCIe link properties with
 pcie_print_link_status()
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
Date: Thu, 10 May 2018 13:37:17 -0700
In-Reply-To: <152537763602.62474.15659483976051204438.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: 
	<152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
	 <152537763602.62474.15659483976051204438.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-pn319CNs1sSWaLiR7sVo"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


--=-pn319CNs1sSWaLiR7sVo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-05-03 at 15:00 -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Previously the driver used pcie_get_minimum_link() to warn when the
> NIC
> is in a slot that can't supply as much bandwidth as the NIC could
> use.
>=20
> pcie_get_minimum_link() can be misleading because it finds the
> slowest link
> and the narrowest link (which may be different links) without
> considering
> the total bandwidth of each link.  For a path with a 16 GT/s x1 link
> and a
> 2.5 GT/s x16 link, it returns 2.5 GT/s x1, which corresponds to 250
> MB/s of
> bandwidth, not the true available bandwidth of about 1969 MB/s for a
> 16 GT/s x1 link.
>=20
> Use pcie_print_link_status() to report PCIe link speed and possible
> limitations instead of implementing this in the driver itself.  This
> finds
> the slowest link in the path to the device by computing the total
> bandwidth
> of each link and compares that with the capabilities of the device.
>=20
> The dmesg change is:
>=20
>   - PCI Express bandwidth of %dGT/s available
>   - (Speed:%s, Width: x%d, Encoding Loss:%s)
>   + %u.%03u Gb/s available PCIe bandwidth (%s x%d link)
>=20
> or, if the device is capable of better performance than is available
> in the
> current slot:
>=20
>   - This is not sufficient for optimal performance of this card.
>   - For optimal performance, at least %dGT/s of bandwidth is
> required.
>   - A slot with more lanes and/or higher speed is suggested.
>   + %u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at
> %s (capable of %u.%03u Gb/s with %s x%d link)
>=20
> Note that the driver previously used dev_warn() to suggest using a
> different slot, but pcie_print_link_status() uses dev_info() because
> if the
> platform has no faster slot available, the user can't do anything
> about the
> warning and may not want to be bothered with it.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Since this is apart of a series, I am not planning to pick this up and
push to David Miller in my ixgbe updates.  This should remain in the
series so David can pick up the entire series at once.

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   47 +------------
> ------------
>  1 file changed, 1 insertion(+), 46 deletions(-)

--=-pn319CNs1sSWaLiR7sVo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlr0rX0ACgkQ5W/vlVpL
7c4B1g/9GFdyqM9Jr9tJUa4p9tx12FENwn4QFgkxMsgrgVxSMajW6xErR7SeNDB9
wjYkJa8buc6P2LQSk9Ix8xfI2ZJKU2yyrr3TqEjq0klrU80kWBhht2iwvWd/4Kvw
pcWUA4T2v2e5GpiH0SxBZMrrqHFZxt5RCc3Z/N5VViD/IvsYUcEoibA+pvdAe8QB
TTAKjA83oDUrpPuir9aPgHHoLc80taD2bIrD37yjtS9he5C4KZ/Pt7zIpHiRWbLO
HnPaiYG/TPYoOB1Zmr0EWvte0SMEzYYmTefmv/3snYEztN4ZQcxcOxH9iHsfQ6Be
EDkk2mwbNfZE/COuHAFIXF/TXi0zSsQ4O5D5Xyjh0zsimTs9n773gVHoZNaRwi71
Ev/5lY0vEQ3Z0opqE5ODpcOscDK/+AxnKVnUtwNN+WF7TYz6GG6T82xH6+KaZN8T
1cXpNbIi0gtuh/Ub6UQtSFArgvxc5TrNjpcYLhlUmogz/m0QOXy+WL+Xbz+XhWxd
fcQs+aonGvYjt7HhU4vwgZWMFkE7l1VcTUWEo4YcFY+1bv6s1DDoBLGEm5IUd4Pi
To2kYpILUoPBMsWS2z4GjjPmsuB18PH4g+i68DM7+3/koIwGss4OgO5D7uTaq59M
v8Uq2PTUobhnxQcecUjaUaTgpqKvNBfOmaITdWoHU54wJTMfRU0=
=Z8SL
-----END PGP SIGNATURE-----

--=-pn319CNs1sSWaLiR7sVo--
