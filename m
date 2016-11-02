Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11767 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756600AbcKBRs3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2016 13:48:29 -0400
Date: Wed, 2 Nov 2016 18:45:53 +0100
From: Thierry Reding <treding@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        "Zhou Wang" <wangzhou1@hisilicon.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        "Greg Ungerer" <gerg@uclinux.org>
Subject: Re: [PATCH] PCI: Warn on possible RW1C corruption for sub-32 bit
 config writes
Message-ID: <20161102174552.GC29955@ulmo.ba.sec>
References: <20161031213902.6340.96123.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20161031213902.6340.96123.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2016 at 04:39:02PM -0500, Bjorn Helgaas wrote:
> Hardware that supports only 32-bit config writes is not spec-compliant.=

> For example, if software performs a 16-bit write, we must do a 32-bit r=
ead,
> merge in the 16 bits we intend to write, followed by a 32-bit write.  I=
f
> the 16 bits we *don't* intend to write happen to have any RW1C (write-o=
ne-
> to-clear) bits set, we just inadvertently cleared something we shouldn'=
t
> have.
>=20
> Add a rate-limited warning when we do sub-32 bit config writes.  Remove=

> similar probe-time warnings from some of the affected host bridge drive=
rs.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/access.c             |   17 +++++++++++++++--
>  drivers/pci/host/pcie-hisi.c     |    2 --
>  drivers/pci/host/pcie-rockchip.c |    3 ---
>  3 files changed, 15 insertions(+), 7 deletions(-)

Yeah, this is a good idea:

Acked-by: Thierry Reding <treding@nvidia.com>

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYGiZQAAoJEN0jrNd/PrOhtxIP/3zA4sqyzm3mbPP2lquQvqS6
HoktgXUczAO63adAuZgJ9UblUjp6Xp5C1Bu1NmlKItymBLyYDJb2OIW9L0fySBMt
DEraMAsKQGTT9CIMYirT7jHeqG+vj9N3JvdaKBnCZxb/J6ga65DQWkedVnDm6xva
+otle8QdvIQkuiG4QiNU/F/mQcZ3CG4QWax3h1hQuS9Ynk9oVMRK5UJYw5Y0Ug+z
4EpqB4neYgR0avEunsoqAgJeXxCHavaIdHS7DBrfaMvd6+/Mv0d7FNgIe1eXcxWt
QvFgVPYTacK58mcGikJ30f+4sKAs/5LunDygsZHFFgiLo9ehyiApNWoCUzJyx3Zp
/ZkkcewpSV0xPTEq0JNCTnBruZMLQ7RJQPRCHyBM8tLLNpzXBXXBBhP+6pH2TGUv
BP7YGt0HXOcTtGrbClU8UXUPhQ3omnAfwrIZc0qQ7AAnCM7EzL5lDmjlZi0TQRX/
2bGEM9Sboz0KAwx7UodnjlgJrsyuRsY+kvfLI/5Owzlt1Ft9GHVymEo6gmCly53H
NVfh3XzO3AYIICa9/SN7LpLQK9J4J3FHrDF2Cy5de2SyYXfqEuJd0n9LwZur5Kzh
1wtEyxGMj6fwFVCIHdLFKDwc7O/JCX0SNUCuMtWkn4aj3QsiDRB0Uw6NTqa04tb5
F7ZlmPA8M+vnXTMhiykO
=tUC6
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
