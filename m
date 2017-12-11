Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46467 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdLKKyj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Dec 2017 05:54:39 -0500
Date: Mon, 11 Dec 2017 11:54:31 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Vidya Sagar <vidyas@nvidia.com>, treding@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 0/2] Tegra PCIe end point config space map code
 refactoring
Message-ID: <20171211105431.GI10671@ulmo>
References: <1512410030-21038-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KrHCbChajFcK0yQE"
In-Reply-To: <1512410030-21038-1-git-send-email-vidyas@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--KrHCbChajFcK0yQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 11:23:48PM +0530, Vidya Sagar wrote:
> PCIe host controller in Tegra SoCs has 1GB of aperture available
> for mapping end points config space, IO and BARs. In that, currently
> 256MB is being reserved for mapping end points configuration space
> which leaves less memory space available for mapping end points BARs
> on some of the platforms.
> This patch series attempts to map only 4K space from 1GB aperture to
> access end points configuration space.
>=20
> Currently, this change can benefit T20 and T186 in saving (i.e. repurposed
> to use for BAR mapping) physical space as well as kernel virtual mapping =
space,
> it saves only kernel virtual address space in T30, T124, T132 and T210.
>=20
> NOTE: Since T186 PCIe DT entry is not yet present in main line (it is cur=
rently
> merged to 'for-4.15/arm64/dt' branch), nothing gets broken with this chan=
ge for T186.
> For older platforms (T20, T30, T124, T132, T210), this change works fine =
without any
> DT modifications
>=20
> Testing Done on T124, T210 & T186:
>  Enumeration and basic functionality of immediate devices
>  Enumeration of devices behind a PCIe switch
>  Complete 4K configuration space access
>=20
> Vidya Sagar (2):
>   PCI: tegra: refactor config space mapping code
>   ARM64: tegra: limit PCIe config space mapping to 4K for T186
>=20
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi |   8 +-
>  drivers/pci/host/pci-tegra.c             | 125 ++++++++++---------------=
------
>  2 files changed, 44 insertions(+), 89 deletions(-)

Hi Bjorn,

there's a bunch of PCI related patches for Tegra floating around on the
lists. I'm wondering if you'd be okay if I pick those up into the Tegra
tree after they've been reviewed and send you a pull request later on
(say around v4.15-rc6). That would allow me to get things cooking in
linux-next for a bit and get broader testing in addition to the
flexibility to patch things up if they break.

Thierry

--KrHCbChajFcK0yQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlouY+QACgkQ3SOs138+
s6Gv/A/+I3RDNHLScnSYOD6XgtW2jtMYkMSXhFht/Xx6+3BJ4/lgxLLrhQ/QScel
ZgaO7nEsHsHKBTiaINm5DiFWMLrQMfp2txF0UKwbcmcfmElZmkdK/rXCUm0ALMCh
wu5f8jN3E0Pwn4bUBjFVz2apeSDC6F0jOb3UR3wjsRv6MkdfakP+yVVCdy0ljyzs
+AofdrBvQC7a75pERFC6vYlXqYoUjbN+puTQWMOn7/knXYlRJcqra4sgPdme7YS4
YgOujKoxlhDg0PQqNYmJwDnx52KKaRt9JXjLSuBkwMcJ8p5xHVAq7lkzsue2xbHJ
jNvQKs0/J3+rxUo/Y2t2lPW6nyzL465EPPVeCYhp8ABDi3mPdhQvFclw9mgfxIpE
mfx71HA3VaHDCDgwK6C02TWU2jvZaG6Ub4uRYAwyjo/slial6mASttspME8Id80I
ClDBJZ1UXkTmBDqTlNbfT5GFCfZM6RaGG2b9Mf0fHPFEi/LAyBy8P/eP34DZOh45
Rd7suNsd0sDUdrYjPfGnZoiF0K0gvT10Uz+BLBkVVhI8/HrpbXM01OzZouSEd8vh
9fXwcdTziKaYMsTppx/v0a1O2RUMFBv2sW+JHKsU9+QF18lTYLbKWoi1eqflZRNX
CbCBEXIfC3Vo7ZPbPxnSHbCQgad3VihPBAUsmcycHBa3YhJs7Jo=
=T1P+
-----END PGP SIGNATURE-----

--KrHCbChajFcK0yQE--
