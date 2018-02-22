Return-Path: <linux-kernel-owner@vger.kernel.org>
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] microblaze: Use generic pci_mmap_resource_range()
To: David Woodhouse <dwmw@amazon.co.uk>, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1519045283-22350-1-git-send-email-dwmw@amazon.co.uk>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <82d28f04-f196-d608-cd37-d28a9fc1bcae@monstr.eu>
Date: Thu, 22 Feb 2018 15:26:19 +0100
MIME-Version: 1.0
In-Reply-To: <1519045283-22350-1-git-send-email-dwmw@amazon.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9iHJX5OJH7uahLZINhvu45qCCJRyJ4kSq"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9iHJX5OJH7uahLZINhvu45qCCJRyJ4kSq
Content-Type: multipart/mixed; boundary="n9ncCsB8SIakI1XiMcgMUinWCEJbnMVff";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: David Woodhouse <dwmw@amazon.co.uk>, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Message-ID: <82d28f04-f196-d608-cd37-d28a9fc1bcae@monstr.eu>
Subject: Re: [PATCH] microblaze: Use generic pci_mmap_resource_range()
References: <1519045283-22350-1-git-send-email-dwmw@amazon.co.uk>
In-Reply-To: <1519045283-22350-1-git-send-email-dwmw@amazon.co.uk>

--n9ncCsB8SIakI1XiMcgMUinWCEJbnMVff
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.2.2018 14:01, David Woodhouse wrote:
> Commit f719582435 ("PCI: Add pci_mmap_resource_range() and use it for
> ARM64") added this generic function with the intent of using it
> everywhere and ultimately killing the old arch-specific implementations=
=2E
>=20
> Let's get on with that eradication...
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/microblaze/include/asm/pci.h |  7 +--
>  arch/microblaze/pci/pci-common.c  | 99 ++++---------------------------=
--------
>  2 files changed, 13 insertions(+), 93 deletions(-)

Good to see patches for these files.

Applied.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--n9ncCsB8SIakI1XiMcgMUinWCEJbnMVff--

--9iHJX5OJH7uahLZINhvu45qCCJRyJ4kSq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqO0wsACgkQykllyylKDCGEXgCdGetE968BONjONgDznAUfJ/dk
Y1sAn3+rSC3ryYigKcplFnxMd93WFU7y
=fknL
-----END PGP SIGNATURE-----

--9iHJX5OJH7uahLZINhvu45qCCJRyJ4kSq--
