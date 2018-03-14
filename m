Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 14 Mar 2018 12:45:15 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: tegra: add MSI dependency
Message-ID: <20180314114515.GC8564@ulmo>
References: <20180313115218.2246372-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
In-Reply-To: <20180313115218.2246372-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 12:52:05PM +0100, Arnd Bergmann wrote:
> Building the tegra PCIe host driver without MSI results in a link
> failure:
>=20
> drivers/pci/host/pci-tegra.o:(.data+0x70): undefined reference to `pci_ms=
i_unmask_irq'
> drivers/pci/host/pci-tegra.o:(.data+0x74): undefined reference to `pci_ms=
i_mask_irq'
>=20
> This adds the same dependency that everyone else uses.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

I'm slightly concerned about the dependency. Not that I doubt its
correctness, but because it could mean that PCI_TEGRA is not visible in
the default configuration. The only reason why it is currently visible
is because PCI_MSI is selected by some symbols that also happen to be
enabled. However, what if at some point those symbols are disabled or
removed?

Some architectures make sure that PCI_MSI is enabled by selecting it,
but that's risky, isn't it, because PCI_MSI is user-visible and could
therefore easily lead to conflicts.

Enabling PCI_MSI in the arm64 defconfig would solve the issue and is
good enough for me. I've got a couple of changes to that defconfig in
the Tegra tree for v4.17-rc1, I can add a patch to enable PCI_MSI.

Unless there are any objections.

Thierry

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqpC0kACgkQ3SOs138+
s6EiHxAAn6oQjcvzOEpBboIKDTGgxt0iPDj4dJzJzYucPE38Ve+vFm+PTA+MpYZs
NWX07OLWX/AwVgRzS6sbxVxZrvtV3LxQOh0/IwDgZOGxoXgFbZ3OW8+x2PECzb4k
olgjHWcJ4wKAnAoCQ5w6p5f/3Y1aBZ2N0sjKXjTYOi7nOBCsu/qm7cxm1rtUjEhS
6frkef/D+4N3hYAQfAZNoUffy92w4YrDbFgRorOxg6RPqCRPyMdJfVf4t9GDzUkR
TLTDc92r7UDYaWKm7X+l6aTuJLl5DWO0JeikiAyTkKoXs65SkKdbkodZGtVGDiUH
x9KHYn5uTxKjX63e+gJszaFXvWGgh/Z61Ihxllz/4ObEelex5JY4SlvhZJWfr/ZD
SogLQCintL1Iw7KUx/PEkjIDdANTOrx0HWO/ysL9FkG+UICBtxt4g8vsGnTBVJpn
Z0jlKoKVYv3aMSjmMKI2CcWzH1+v+WONkJJEpuXWCYRDwc6lcZYZYTDXo7Fvrgx+
vjX2ATksyc8W+4ynBjUUKD9kil1Nckkwx+yrHZT19VordlmYNOBo9bmjhJu2DPSl
UKfnIbvEljg0mEXihk8aFWAYqR3hd0LT0gZk2PZKquhmPr4BHzToLla9Uff7iv47
luEDw7UC0esK6tn1t7oP09EjtaCnMOq30OT14Fhcz4UvnhShXX4=
=976t
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
