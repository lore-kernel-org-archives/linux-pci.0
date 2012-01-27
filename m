Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:58023 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751985Ab2A0Ret (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2012 12:34:49 -0500
Date: Fri, 27 Jan 2012 09:34:46 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] x86/PCI: don't fall back to defaults if _CRS has no
 apertures
Message-ID: <20120127093446.23955111@jbarnes-desktop>
In-Reply-To: <20120118004121.1089.43631.stgit@bhelgaas.mtv.corp.google.com>
References: <20120118004027.1089.93781.stgit@bhelgaas.mtv.corp.google.com>
	<20120118004121.1089.43631.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/hvlKrr9=ngPUmIysc9x961r"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/hvlKrr9=ngPUmIysc9x961r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jan 2012 17:41:21 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> Host bridges that lead to things like the Uncore need not have any
> I/O port or MMIO apertures.  For example, in this case:
>=20
>     ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
>     PCI: root bus ff: using default resources
>     PCI host bridge to bus 0000:ff
>     pci_bus 0000:ff: root bus resource [io  0x0000-0xffff]
>     pci_bus 0000:ff: root bus resource [mem 0x00000000-0x3fffffffffff]
>=20
> we should not pretend those default resources are available on bus ff.

Applied to -next, let's see if this _CRS change breaks anything. :)

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/hvlKrr9=ngPUmIysc9x961r
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPIuA2AAoJEIEoDkX4Qk9h4MQP/iokIyX9WN4TP44TCpKI0kML
H5JJMGJNHTYRtPrRjH7lDROhYsLVsbnywQObQ7eey6IDh3dPf3xa5MJJmM5MygG8
0cVNr8Ma4YD1zo21DvHwZXam3Zb9+9wNqFoo7rwPvEpWgMmaPPX89/hdzz0XfDtX
icRNIvWBTCMeIfoU5eEYn456y79mTwidlLdLU4PQXq3x/YVOzYVcsrhGquWE1w7x
wpoeDTKD38WZZmek6cnx9BaTCp+SOOlg2yebrc6vhCiiZ8QfbKRP86bObxS9Twpr
GumyKfdZMPpgxUVljksOA+W/TEI2Egjj5MN1L/cwZz7AdPqgvcHiMVLMDdAGDkIA
BzkjxmsS3w2wU3QaxwSrVY5UqnmKB1/aXdY3eRGQwYy6IAldB1WfB//FRLiAV79W
D3+vjbALa8iht2PLoqWn/YsBQ18fKdXlbArhm63l7IokPVIvWsKJ/aCsLimbMX+U
SdyYsiQARGzYGDCeG8Z40fUdtFuOYiIAKcOf9r1fIfrTY5XIKnVxRC7t0z+Vr/Qn
+rOQY98TfSTrELhOp5hnd6a2+NtUKgpMUjsr65HS3csQR/myhsrYTPlty22VPjXJ
V+mp1xhN2S+A7e95CigNXLgqt+ac+nz1xrGALFQKiRPKuYbiMR4FBgFNdwjKGcat
irVObb8M1t1h7YPuamOD
=Mck2
-----END PGP SIGNATURE-----

--Sig_/hvlKrr9=ngPUmIysc9x961r--
