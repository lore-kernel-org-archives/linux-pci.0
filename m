Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 2 Mar 2018 11:42:07 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/5] PCI: tegra: use seq_open_data
Message-ID: <20180302104207.GB27178@ulmo>
References: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
 <20180301233724.20440-5-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
In-Reply-To: <20180301233724.20440-5-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 12:37:24AM +0100, Rasmus Villemoes wrote:
> Simplify the code slightly by having seq_open_data do the ->private
> assignment.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/pci/host/pci-tegra.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

I had to go hunt for patch 1/5 to be able to tell if this is indeed
equivalent. It is, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqZKn8ACgkQ3SOs138+
s6EmyRAAkzu5grx2iNvsqWgE/4+9sRZ97eRSEc4muVz5vPvuNNZ0aviU4rXZ9OCi
1R73r8tc73U1LOTlHozRLIwvXiWMiv8vE9YzgUyoaj0Pllh44P0GK7PXiuPmktyo
hUMpQwxEfQNtTR18svAFb0iKexFzLUhTndAvgRwmUb9stTkfEXX0HUMYb5vOD1t5
NWbw8sO9lCUq++NUkiyKG9+mGK1M2YLAsGtbewYqqBqP0g68NPYBPHBaDzATZrvF
z61G0Y0SzUg9F1oNmkDgUghDKlDzouhWxYBRVk37sCNg2CVkW+9+Exlcwi3lSNQI
pDgykezDrCcC/sYJJ2wGQBiElrvtfGwJUJmI3eozKoDqvSI8o4r15EZozAuaAexL
CBoJy9NfQBhqbFBl0HcteEqCLdqXmmA6sIleBbadQWjW+fvGsIyfyS4lGL2Cs8Sl
qgkVe+iKhg4jRYFBTVKRbADdxxpBZ8hoty5I9ew+tcpWOWwOyjc1AZHM9n54J/IA
Poj0tJmDgbfeC4J/AnSYpYXCm+P+2YxwprTzuOdIe2N8XMkiCj8jYKWOydWzZAEW
eMHZ8vnyvmUWVgmHpo2KPo0nMGMc8KGqMAVOjbThUvh3ETvczyd+XhizMV/G9AvW
W9/Ry5co8MP/2Eder/JT6ylcjwVcnVN3MtvMB8bjn2Xw3I2hHTE=
=QeI3
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
