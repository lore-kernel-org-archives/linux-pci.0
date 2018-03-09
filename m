Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751102AbeCIPHh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 10:07:37 -0500
Date: Fri, 9 Mar 2018 15:07:27 +0000
From: James Hogan <jhogan@kernel.org>
To: Jim Quinlan <jim2101024@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4 1/8] SOC: brcmstb: add memory API
Message-ID: <20180309150727.GH24558@saruman>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-2-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
In-Reply-To: <1516058925-46522-2-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 06:28:38PM -0500, Jim Quinlan wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
>=20
> This commit adds a memory API suitable for ascertaining the sizes of
> each of the N memory controllers in a Broadcom STB chip.  Its first
> user will be the Broadcom STB PCIe root complex driver, which needs
> to know these sizes to properly set up DMA mappings for inbound
> regions.
>=20
> We cannot use memblock here or anything like what Linux provides
> because it collapses adjacent regions within a larger block, and here
> we actually need per-memory controller addresses and sizes, which is
> why we resort to manual DT parsing.
>=20
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>=20
> Conflicts:
> 	drivers/soc/bcm/brcmstb/Makefile

That can go.

> +++ b/drivers/soc/bcm/brcmstb/memory.c
=2E..
> +/* Macro to help extract property data */
> +#define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(*(u32*)(b + offs)))

Checkpatch complains about missing whitespace after u32.

Cheers
James

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqioy4ACgkQbAtpk944
dnrGpQ/6A4EcwZ+zoSJZpxuuicPoZib7aq0pGu8F/Ld2nf+Tr48Slxw3kPhcCzc7
HXPBL24yqKGrJ7jFbqrDnWCLkjTg7zsjokCbehiLzQI66LUsRolxGCLMYQz6XfvN
noL4iAQ+mRx9qfhpRomyHXA3xcb3DS+TL0o6TxztDgiF5PGz+Iu9AlaYKQ4Zq0cd
xuEIGfbJo3fivLDU20H/KyuSY3B3Bg1ayXqtBZSQmxgac1Hkyldjee5Spe8bG0j2
aOUOZRfJY49FjYQ7wW2itTywSE1RpLTHBfqxpYrrQifSB69Ztwl9H0GqWD0PehjI
uiKHInsJxqYMNQXMssZxMj4vuHq31v+QbD6jNoinnNrmoctjT8dPaSo6h6t051HE
a0saFvpCEJrOqozZ6PQgJQPSg9Mz95+YUFMmNApBzKfYCw0TNuPHH5vupy9A9LWD
D1uAyAatlj5Qb8dU0kBXKXCVPu1Ikq4Jbgq/WMkcUh2WTTD4+2T6uKdS+JSnd08X
RjevevlDWxgSMJ4DzPoQgZbswKiq/A6Dewg/4hx9O8BnamQ/Sj4pbRThTcdWsNqj
9xC/Gt6QPJQop/pdz0m+Q0ML1lQRNwe1YbUcwt0cMGlVuNzkN45lM7T3HGbz6nXW
8kjCKcG+L9tMJ/4zywyXKUqb+EAjBMgp1OWJobxtG9r+wwLYHzs=
=TGmj
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
