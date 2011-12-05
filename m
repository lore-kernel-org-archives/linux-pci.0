Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:55992 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755113Ab1LES32 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 13:29:28 -0500
Date: Mon, 5 Dec 2011 10:32:02 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/1]PCI: defer enablement of SRIOV BARS
Message-ID: <20111205103202.29faf6e1@jbarnes-desktop>
In-Reply-To: <20111106023310.GA2383@ram-ThinkPad-T61>
References: <20111006210320.GA14959@us.ibm.com>
	<CAErSpo7b_6_AaZXW9XBx5p3-0PZJk-1jeCork__KePdzCS89OA@mail.gmail.com>
	<1317970100.29415.305.camel@pasglop>
	<CAErSpo58okGsDW4dOK4i0g_RUejkuQa=iw2uQ5HAJJZCwFtsbw@mail.gmail.com>
	<20111007232516.GF2980@ram-ThinkPad-T61>
	<1318057168.29415.333.camel@pasglop>
	<20111008075353.GK2980@ram-ThinkPad-T61>
	<1318060793.29415.347.camel@pasglop>
	<20111102140325.004b9dad@jbarnes-desktop>
	<20111103013014.GB393@ram-ThinkPad-T61>
	<20111106023310.GA2383@ram-ThinkPad-T61>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/4Yccy_+1EUL0_Q0kZAGP0g1"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/4Yccy_+1EUL0_Q0kZAGP0g1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Nov 2011 10:33:10 +0800
Ram Pai <linuxram@us.ibm.com> wrote:

>   All the PCI BARs of a device are enabled when the device is enabled usi=
ng
>   pci_enable_device().  This unnecessarily enables SRIOV BARs of the devi=
ce.
>=20
>   On some platforms, which do not support SRIOV as yet, the pci_enable_de=
vice()
>   fails to enable the device if its SRIOV BARs are not allocated resources
>   correctly.
>=20
>   The following patch fixes the above problem. The SRIOV BARs are now ena=
bled
>   when IOV capability of the device is enabled in sriov_enable().
>=20
>   NOTE: Note, there is subtle change in the pci_enable_device() API.
>   Any driver that depends on SRIOV BARS to be enabled in pci_enable_devic=
e()
>   can fail.
>=20
>   The patch has been touch tested on power and x86 platform.
>=20
>   Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---

Applied to my for-linus branch, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/4Yccy_+1EUL0_Q0kZAGP0g1
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3Q4iAAoJEIEoDkX4Qk9hiCkP/A5XJSGJWNx9+zK52LYnJkHJ
h6vDplEY9PLCzAcDXjUipPAno4iePwUKFlxiIr+8EkZojEZYWW4Aj111MLNcv2Cc
mWe+N3d6eO+zmRq0OxNsvNjrSPz8ki7AgW4rkJ0KGFMj6nEAPw09v6iXXNypy3Az
hX5ep5ezmlJ1iiLd0zWGlPybV5Z+YYgZHNr4tpxE5cBs4HeccKESe07/zaBRU+Wd
CmE7i5R825D1DXjD4dKmMIlAZqDriAvLOVp6UiZm2dmmz6mqnQxesdkIzHy5Y7ZM
ao2NZoyrh5NPr/TyDyjDCZJNRG08+FmmhvIwMMaoin0N466WGKFHyKFE22gBHc6W
BezckNykMbAqOQXMKGbaLRfy51wo+xYSm5y3fKL6oX5c/2QcE+HTil662/hocKj7
Bfsp/9cQUwMcw05g317zehbU1Orp4atSz0/T0zTGGtk67kGYaytwJlzmBWJToWNR
Kf6uAfC7QpqEsYee3/3F+wLZLfXY97tB+V8QM8HxvixFZbkpkrZCPz76aMSyWVb6
2eaWgop94e45mYMK2OiG2kBudbVZbTBP0SG0lp0bkad4nMcYozPph2xd5gcqYZuB
nQTtGFBjf+4+3Y/mV16jWLBQ7UaTGlGKsWvCBkLIgvfwzRGDTxbtt1Aj24z91Eou
h8MtrnJWHBOMbwubhp0P
=5W60
-----END PGP SIGNATURE-----

--Sig_/4Yccy_+1EUL0_Q0kZAGP0g1--
