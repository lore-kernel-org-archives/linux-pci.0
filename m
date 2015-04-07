Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34942 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbbDGAbm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Apr 2015 20:31:42 -0400
Received: by pddn5 with SMTP id n5so60481731pdd.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Apr 2015 17:31:41 -0700 (PDT)
Message-ID: <1428366696.22268.28.camel@axtens.net>
Subject: Re: [PATCH v2 04/19] powerpc: Create
 pci_controller_ops.dma_dev_setup and shim
From: Daniel Axtens <dja@axtens.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, wangyijing@huawei.com,
	linux-pci@vger.kernel.org
Date: Tue, 07 Apr 2015 10:31:36 +1000
In-Reply-To: <5500778.Q4t9Fg7Irn@wuerfel>
References: <1427778057-9505-1-git-send-email-dja@axtens.net>
	 <1427778057-9505-5-git-send-email-dja@axtens.net>
	 <5500778.Q4t9Fg7Irn@wuerfel>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-TVh8S7fVsFWscyQVZw4D"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-TVh8S7fVsFWscyQVZw4D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please see https://patchwork.ozlabs.org/patch/431333/ for related work.
>=20
I'm familiar with that patch series - I've been helping Yijing get it up
to speed on PowerPC.


> I think it would be better not to introduce another architecture-specific
> pci host bridge operations structure, but instead consolidate into
> the one that is already there. We are also adding a generic way to set up
> PCI DMA, so it would seems reasonable to hook into that place.
I see what you're getting at, and I agree that we want to move towards
generic operations.=20

However, I think this should go in as is at this point, for two main
reasons:

1) This is a good midpoint that makes it easier to move to a generic
structure. Our arch specific stuff is quirky and difficult. This patch
series does a lot to reduce the complexity, and would make it very easy
to move these ops into a generic structure at some future point.=20

2) Trying to go generic at this point risks making the change set so
complex and wide ranging that it will really struggle to get in. For
example, Yijing's patch set, despite not changing any of the quirky
stuff in PowerPC, is already quite long, and will require agreement from
a lot of people before it can go in.

Much as I would like to have everything as generic as possible, if we
were to try to do the whole job in one go, it'd become a big, difficult,
messy patch set, and would be less likely to happen than if we were to
do it in two steps.

Regards,
Daniel



--=-TVh8S7fVsFWscyQVZw4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVIyVoAAoJEPC3R3P2I92FTlwP/3Qk6njMhm/gy6E4+DVQ39Az
JiXZQwdZ1ltTJDiDqSHLm3wPwRk/i/r4kGzX+dPCTVapMZTeyx4uKFGYqAkO5hnU
bdsoL8GXS9zHFwItRUewoXAQOti7lQ4Zn4BKw4G0ir6dp3q1wlh1twc6d9jZ6c30
4OLTpnvvO0BXnLoDjSse64pKO/YlKPgSM2oXE2Nec9Pm6zG+JKUgcGiD+6vbfh+h
RqRg42Epw8RMWSF099Mc3UGxwrWz/SJkIiXRUq9MOgcLZjolKx+UE160YUAHC/Ni
8PUE62k+wTYiqejTROVcgEwTth717j0UNy4sr0THBztghmH7Xf3qOGMhlL9GbFhf
5qpglbnNj+NfTS1sBycY8KguZsJ58Zj3eA9cq7InSso6+mfE46nYXlD55RmdwgHB
aez4RfkLLzZ8GebzEPsmXX2KYnYqEtOYMba/Tx79r3FXjOj2xZCqtVursDZgb00y
0X0iNogP2YBDCKIfYflu783W4Nn3asxojehVOzGDr5Fg+ZCQMIKalrfdsKHVjLv1
PpKROQ5ITcVooyvwdPdwfK30iyV4axpn5wblMOXuDptLt1AF1pLHUI4a8RQJfVP/
EGvu+lIVneJqhMMeaCVLqOq0R+5Qy3CO+OFeBOxmBMgyAxPlVuSiV5WWvpgpdeP+
KD4XPEjZ5H5rQemoTUN6
=kHEb
-----END PGP SIGNATURE-----

--=-TVh8S7fVsFWscyQVZw4D--

