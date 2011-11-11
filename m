Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:55659 "HELO
	oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752021Ab1KKSBZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2011 13:01:25 -0500
Date: Fri, 11 Nov 2011 10:01:43 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/1]PCI: defer enablement of SRIOV BARS
Message-ID: <20111111100143.545ead31@jbarnes-desktop>
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
 boundary="Sig_/Ylr4Qjn8jRvf/g0d9HD48VX"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/Ylr4Qjn8jRvf/g0d9HD48VX
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

I think this is a good direction, but I'd like to get a tested-by or
two from people using SR-IOV...

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/Ylr4Qjn8jRvf/g0d9HD48VX
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJOvWMHAAoJEIEoDkX4Qk9hS38QAIhK6FrFhC41jVVFu8qW7k6x
Pq/nmZ/ztQeD2NjOX0dUFOuoJnrVkeXcaMZknERqGMAZCLkoRN3vS38iBskJEmiR
QyzZJKZ/XnEfH1mAMiBub2jgRLA1LX14Cp0h+E5PFMxHCFSo5x+3dUvd/cfp1hVq
L93pPRvRwd7tm2+op8U73lCvYjGMNuXbsxGasJQDD+WuxcOQDCwxDllIIWy0VCPE
0t9SaCRsTlsstEDK5mOGa56mgbhYhCgo+uK2vRBeG1IRK3wSYH1qU1ENKY4wNqfG
tjgMIG9+GX5lJQynFgLD6hI5iYXGSEVYwUNOWBIYfYOvrcpuc636P68FLPjqSm4J
ajP6Y+uYyA37ItEN9JvwsXe7YXN6yNw7u4HUUtYsYlC/CTjS2JGtVXi7YYny4Ojq
LC8nCocooAIh7aW+KalmJxoUAxZu/IEqNm74SF1NYFVBSIfSwcjxGihXNpjTmjWZ
VLDYMhsu8MYBUYkkjqpBq5yP9z8uCyyi5GUxBVm/lHSbd5CzrZGQOIkGHZU8c4nT
j8RlrSUgGaPTyITR02tMQXeUTbDRgmFNzd5ngHdg1n+zWWJg+cq/EIp22L1xoMpG
M5RyNhCJKvF4E+bdXdgNpzJARUwMnoBHo/15u0IIYmUbV+kF2EvGw3UVa6gb4Z85
th+sPFU/HAYSBUJAKv0x
=+fBm
-----END PGP SIGNATURE-----

--Sig_/Ylr4Qjn8jRvf/g0d9HD48VX--
