Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jscinoz.so ([43.229.62.214]:54484 "EHLO mail.jscinoz.so"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755926AbcCVIGh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Mar 2016 04:06:37 -0400
Subject: Re: Thunderbolt 3 (Skylake / Alpine Ridge) hotplug
To: Lukas Wunner <lukas@wunner.de>
References: <56D0085B.60402@jscinoz.so> <20160315172909.GF19974@localhost>
 <20160316132228.GB28222@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Martin Andersson <martin.andersson@purplescout.se>
From: Jack Coulter <jscinoz@jscinoz.so>
Message-ID: <56F0FD01.2030400@jscinoz.so>
Date: Tue, 22 Mar 2016 19:06:25 +1100
MIME-Version: 1.0
In-Reply-To: <20160316132228.GB28222@wunner.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XToG3dNb3VFJhCjrpR380WXLboVvoQhOk"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XToG3dNb3VFJhCjrpR380WXLboVvoQhOk
Content-Type: multipart/mixed; boundary="sxt8PfR2KamC5CJb6a7P28rI0FSgFDVGu"
From: Jack Coulter <jscinoz@jscinoz.so>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Martin Andersson <martin.andersson@purplescout.se>
Message-ID: <56F0FD01.2030400@jscinoz.so>
Subject: Re: Thunderbolt 3 (Skylake / Alpine Ridge) hotplug
References: <56D0085B.60402@jscinoz.so> <20160315172909.GF19974@localhost>
 <20160316132228.GB28222@wunner.de>
In-Reply-To: <20160316132228.GB28222@wunner.de>

--sxt8PfR2KamC5CJb6a7P28rI0FSgFDVGu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Lukas,

> Try booting with: pcie_hp=3Dnomsi

I gave this a shot but unfortunately resulted in no change in behaviour
- the device is still not detected if it is connected after boot, and
nothing shows in dmesg upon connection.


Kind regards,
Jack



--sxt8PfR2KamC5CJb6a7P28rI0FSgFDVGu--

--XToG3dNb3VFJhCjrpR380WXLboVvoQhOk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8P0FAAoJEP0XuxcIDSnP7N0P/12+grEygPKciEYCOd1eJKWn
ioyY8ygRqa1GVzMpJJITijKHvJoDCMapKpQN/BYOveI5onyOJy+ZPR34Yh1yyWJ/
6H6eDsd6BbCApmzOXs1Odhdup14M4584DYhsyIM4iDHVRmq1XVqmfE20TBtPr4iV
isbi3DV4gtvBQ/2SjE1BYm3VkJoNNfDIROTXL85RNBiq6hSIczSBYhgPQSB9HAtR
4BP0Zb+xapLRybSn1riQVAFdkiV0DrJf10kOJt5KAJBM+p+7E6BGvZTSTNVjXc7y
dnElo7U5LTXhepTmpj2MKMwTRxs1p/07vn9ZRNDB6htmhmXS7toGZQMsCS66bLIa
TljA9x8aM0JuNkH9nQsZmS2cLYmW5Ck1oWyyueSab1x/uK78UJwGP7RYqR5ymzL4
Jbqjew6q3TTDI6ejyL3JQppgT6Y/QeHAST4RMVmPee/AmVkUCFonO4RLsjz7F1Sw
SxQ9oJ06nx7AgBS1Xp9VLv/65vWbE83xlAXq0d36pIjHi/ks7/9NX8SEl9KFREle
+lWxBiP3s80fTkoIGQJs2OVgSgPh3HQqJNt4O8qRV6NOvqYyuk8YZ6o3O7wyS8Po
T9aJlz2bA1j+LP+9uxpwX9iMi0vEdVfjs4C3S7QxS/4LLwQ6egq/h1uEMH7zMPCE
RNu12lzzA0A6CyHAei4S
=uaO3
-----END PGP SIGNATURE-----

--XToG3dNb3VFJhCjrpR380WXLboVvoQhOk--
