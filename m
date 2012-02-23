Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy5-pub.bluehost.com ([67.222.38.55]:41047 "HELO
	oproxy5-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751346Ab2BWUaK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 15:30:10 -0500
Date: Thu, 23 Feb 2012 12:30:03 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, greg@kroah.com,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org
Subject: Re: [PATCH v5] Add pcie_hp=nomsi to disable MSI/MSI-X for pciehp
 driver
Message-ID: <20120223123003.662cf548@jbarnes-desktop>
In-Reply-To: <20120202160922.4564.99032.sendpatchset@dhcp-189-101.bos.redhat.com>
References: <20120202160922.4564.99032.sendpatchset@dhcp-189-101.bos.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/6OtdMSNa/ZFWd5J2f2AnlZ="; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/6OtdMSNa/ZFWd5J2f2AnlZ=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Feb 2012 11:09:22 -0500
MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com> wrote:

> Not to use MSI/MSI-X for pciehp, add a kernel parameter, pcie_hp=3Dnomsi.
>=20
> In my environment, while shutting down, following stack trace is shown
> sometimes.

Applied, thanks guys.

Now should we also have a platform/device blacklist to enable this
option automatically so people don't have to remember to use it?

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/6OtdMSNa/ZFWd5J2f2AnlZ=
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRqHLAAoJEIEoDkX4Qk9h3WIP/0XChkNVqQ/utwIG1j3HXViU
E8RvquiVgoZy4yvFB+JGlTFtAKHcVn1dPbGTqh9/9oBoO5giUKWHpS+hFp2ALg52
OIFymAljpw7p8MJAt6NhYbMKXK74H8gez+N/R3xi7yVrCboIbZ9Tc20lLGetPalK
4gcKLp+dwZomdm+7CZUyJMpWkghHASvq1dAJjtuLnVIszDNNIyjOc3b9RG+WV8cl
oXsSLxxI+jmrLBlSyPcrEvHJsIkto3+PZkyIz422svHArWl/07sUNNfWgmY5scDB
Jutnr1MeuNpNa7MDgiKF1fv1mGlnnxMZgqk7vj1H5vIaO5442x4lWmERgXLxpN3e
yZXeg+sitXA6LYoBuzEvrATouOvJTBVm61R72niwxUAdOB1kyM0pd7W+P3hZqFEn
ksp26pMbkdD9FkcM/yts/vYzFI3TKuamfV2cbPhq+fc3vPRPjwlKRd4UeTgB/M5f
VioDb51CcYSxy5ZmBGk3yRKmb+PCH78YZWBBk6bt15/8ojadH0b/+E7+OqdxWOwD
NnDZSdLKBd2nh5vSQN3KX/lfxsBRE8tGVWIkKDnTs8zH0kkAIaOIsnGib9iufRpD
9/auwIFXOzWJvmBjZMglaUf1kp2/SmH8nOGDK69FHiWsWrQdONMxwjXM7VDFcETh
nHdjACf2AJMDEJqpCqJP
=MT/X
-----END PGP SIGNATURE-----

--Sig_/6OtdMSNa/ZFWd5J2f2AnlZ=--
