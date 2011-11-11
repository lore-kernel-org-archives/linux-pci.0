Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:56529 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756484Ab1KKRts (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2011 12:49:48 -0500
Date: Fri, 11 Nov 2011 09:50:09 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] pciehp: Handle push button event asynchronously
Message-ID: <20111111095009.163e4275@jbarnes-desktop>
In-Reply-To: <4EB7C782.7060101@jp.fujitsu.com>
References: <4EB7C703.6020504@jp.fujitsu.com>
	<4EB7C782.7060101@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/gT2gTTUm_1NQNwGrtld+5kj"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/gT2gTTUm_1NQNwGrtld+5kj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Nov 2011 20:56:50 +0900
Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:

> Use non-ordered workqueue for attention button events.
>=20
> Attention button events on each slot can be handled asynchronously. So
> we should use non-ordered workqueue. This patch also removes ordered
> workqueue in pciehp as a result.
>=20
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

Applied these two to -next, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/gT2gTTUm_1NQNwGrtld+5kj
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJOvWBRAAoJEIEoDkX4Qk9hKGYQALXyzHCY6aM3oZWWSP2lHgfu
TzZzs0x+jty40BLGhOQnYiXg0Nl5QawUwQG9JM7lMqk8xDBvoBO1Em7c4T4QcBBA
FL/mNDbMMYyo1RVRaTIIVLnyTwI+c3Mmo4o8YrL4UOndBnxMw1w/l1CkwMxtrNU9
qpZT69CaCGiGBkrIGsSbRMqb4BrLvIOBlAY9qZ0xrY5vFyK0cAEq0+A1cvEW0duj
ftaW7tzYGyhhN9AiWEA+LtajuwciljPQllDi1bxMRMjGaj95gyQuBZR1SK43HJDs
uTc00I2Iqam1v7VNrlAkQk0xf5WAKIegClgZuAvVBZoO7InufzVqO/Yj9ZyCZBsT
kX39WFZDGHJO6COzNHYVYE7vaTf5mF/ZgrYhO4Z5O1U8RXU5F9b4nt6cRyZLDv6D
bSa5TaNrmayQL073xeVF15iE7QTS4eM6DeAhp+cIocj1Qn7qc+VZ4CdI1CWOm6Tl
aFRmDif8L+qYEtlmGFpYjuINLjhMwjlHPq8iF1CkId/0tv9iytvFw9HIjzNcpZji
lx2V63goavfomsVO4UCOA2p/BQDJh4sPcaSk9klD9YQ8cwNsuQ5UbRWnTdubA0G9
/7meK3IDZrIDayC7UjVe59DXOg6H35PyIOOdRcgEUeIA0JLddUXorJfh2JQz2mfE
oFZYeaQFrYJE3iqCT4m3
=OLtb
-----END PGP SIGNATURE-----

--Sig_/gT2gTTUm_1NQNwGrtld+5kj--
