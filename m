Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Jan 2012 10:33:05 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Yinghai Lu <yinghai.lu@oracle.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: Disable/enable link during slot power off/on
Message-ID: <20120127103305.5fdb8de3@jbarnes-desktop>
In-Reply-To: <4F22E136.5010404@oracle.com>
References: <4ED95AD0.7090003@oracle.com>
	<20120127092622.6d8c2ae8@jbarnes-desktop>
	<4F22E136.5010404@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/zOgfkL6gxa4hgGWk1=_tJtV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/zOgfkL6gxa4hgGWk1=_tJtV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jan 2012 09:39:02 -0800
Yinghai Lu <yinghai.lu@oracle.com> wrote:
> Please you check updated versions that i sent later.
>=20
> it was changed to three patches... i sent those patchs 1/123
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git f=
or-pci-hp
>=20
> you can find other patches in=20
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git f=
or-pci2
>=20
> and
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git f=
or-pci-busn-alloc

Ok I'll see if I can dig them out of the list; note I can't pull
directly from your branches since I usually need to rewrite the
changelogs and the patches need careful review.

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/zOgfkL6gxa4hgGWk1=_tJtV
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPIu3hAAoJEIEoDkX4Qk9hiroP/0Vn0r2N5pObmyrL12gkhiB5
+t2qWgA58VusLyS3KCPG3lMrSZ+gtl2POPso0u4PPvCqr/P1LurbwjrtSIRb++fR
miXk2fyo5fPjiVS3GTyrW2gnVGP9Dbd/Gem+uQuXapRlH5Nc0DdFVs25Grbinb65
RHU8UDL+u/lskAwk3g+AGWirU0OdlXm+4b9RnY1l0mTkDAYlvjLjJWbmUcjrX9uZ
H1nxkugFPwmTlIvabZ5c4BlBMMxT7+D+9b3AvWPhMzfSVAH3ca9GAB+OnL/+/jIW
s5CSg2DevJVs5OUd36bq4IAUYmxN02mPDQSCsj42iFY/n7VWKcy/jvpXXMKcyffT
Y7GhPcV9xctf2Bpv23VR5K/QyMQ75xHIZ07Eh0pa5ZFMsAxza5kA/0f9J5oCdleG
hVc1o4M3gvbrcEI6K/mUUQLB0GqD5933Osu1UPHcxDSdkf+qyH44hWgbE7f5A24h
MK+oDzlbgo1kzjsnKjgx4TTIuOvu9HkIh7kfhurzprCWgHQTeCz2ku0yY2mQe4ua
rsHwNzyFzwaBiiVG/lhCnRL5oDrBrDEt7dY/7oKzyVE6KAjulx34Ifwv9Vy8Fupf
IWatMYzRvooH6k8rAs3Q1DM2WCoeQl8hvLmlFhPhFMsvxXGujJciYcWCiMb3KQUA
z6EoOlGNCBdsJvh7Jih1
=LBcK
-----END PGP SIGNATURE-----

--Sig_/zOgfkL6gxa4hgGWk1=_tJtV--
