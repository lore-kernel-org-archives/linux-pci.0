Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 5 Dec 2011 11:54:54 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 01/34] PCI: add helpers for building PCI bus resource
 lists
Message-ID: <20111205115454.2429d34b@jbarnes-desktop>
In-Reply-To: <20111028222535.30729.73281.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
	<20111028222535.30729.73281.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/KW3pHAloar8sRfja/wCKDpJ"; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/KW3pHAloar8sRfja/wCKDpJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Oct 2011 16:25:35 -0600
Bjorn Helgaas <bhelgaas@google.com> wrote:

> We'd like to supply a list of resources when we create a new PCI bus,
> e.g., the root bus under a PCI host bridge.  These are helpers for
> constructing that list.
>=20
> These are exported because the plan is to replace this exported interface:
>     pci_scan_bus_parented()
> with this one:
>     pci_add_resource(resources, ...)
>     pci_scan_root_bus(..., resources)
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Applied this series.  Arch maintainers, please check these out and give
a shout if there's an issue.  Current bits are in my linux-next branch.

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/KW3pHAloar8sRfja/wCKDpJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3SGOAAoJEIEoDkX4Qk9hNCYQAIG/RErpLKguaMr5M3PNfR4v
KNXZhiNflUuR52JBTerQn2bczRWl8+cK9HbtfNqOI2poo48Bvqx4ky3kpIo+tFGa
brIEaNCqHetdGSCRGdvglGOYR3XdChuws8TQkzhRlf2qkqnMGkGBQxT1VNtmvyKd
4AX5GWQBZIvYIVR6z5gUrovjQ8Tp5/3CmI2Gcg2HT49Metw3QPpC3UDtzbOKdP5Y
jHKq9nMO64DtHbW2m67AtnBHR74IOjch3Jy53oE9zUQweyomJnOjlCKtCDjdq8TY
5yY5djsPVabeWRh3FEMRp2ixFwLVXnGOzDe4v0k9mhJhEnn4dghJ9ihPqiQ9MdSx
kEL8QCUYAV/KnY7KAZXkTTWfWEa5C03MdKmNzQ7opNNFGnyhLRyRJ82IIwWABMCn
GkvLqYN3cFMd1k7v+sUfBfmAe2omeQN4E+yIY0rDtnLsZhyDPErdC8E1AWJ87wHZ
JyFC1ldQFjiKJVWoO8w9EGftdGM9Bd1bb69ohkg74Soo62d4uy7KcaUQAuTlEZjb
yvPWfVjipIAUnX3dCQsyy9HcvzxrdejRIBH/ft88XusQorsO2mFdPKNiTn7ppyFR
fWIHTx2zvZWXyA4lRge1WhlHE7FJDyopzrGACOERQVk/LyMOh/PvKjQwo+6KrFuD
O5TVA3CjIyZZ7yUFPwVD
=M7yo
-----END PGP SIGNATURE-----

--Sig_/KW3pHAloar8sRfja/wCKDpJ--
