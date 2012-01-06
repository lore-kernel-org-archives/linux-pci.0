Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:45968 "HELO
	oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759212Ab2AFV6g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2012 16:58:36 -0500
Date: Fri, 6 Jan 2012 13:58:33 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: Using add_list in pcie hotplug path.
Message-ID: <20120106135833.3d026d3f@jbarnes-desktop>
In-Reply-To: <1323247984-15281-4-git-send-email-yinghai@kernel.org>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-4-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/WpQaNo4a92AGZkzoKwzRe5W"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/WpQaNo4a92AGZkzoKwzRe5W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  7 Dec 2011 00:53:02 -0800
Yinghai Lu <yinghai@kernel.org> wrote:

> We need add size for hot plug path when pluging in hotplug chassis withou=
t cards.
> -v2: change descriptions. make it can be applied after
> 	pci: Check bridge resources after resource allocation.
>=20
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

3, 4, and 5 are related right?  Do you have bug reports to reference
for the case where a chassis w/o devices is plugged in then you try to
plug in a device and it fails?  I suppose even if devices are added one
at a time and enabled the realloc will still work as long as it only
grows and doesn't move or shrink...

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/WpQaNo4a92AGZkzoKwzRe5W
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPB26JAAoJEIEoDkX4Qk9hyb8P/jHx2aCi5BOV1/KOhlC8iavb
OFnjU64C3b/4ccM3W3t7dnyMAmpBa2rG8U4vmO40HCtA6MoMZ/9SbvoiC6b3jrMY
emF7//LRjT1OQsD4bFnx/YFV407JDpeCxQKWQ+YCwenwxisNcDEXwuzZyJy0r7i3
Az+bdY4L2Hxp1dY5ns+GBT0ARg7hn/SRWP1lQ+96LQwZIv7YlWg4FRMTGjUo7Vxp
ZAIPbLZHwzNpuaL/8+n3JwRiqEcxRl63MQ8yqWiskjNOqtiVRdNgvOw87cZxl/8K
c3CPNuEXISSZHc1qgrGTel1r9Tz6P5jdSZQ7HpwI7IGj4DlLwqyPb4+o/P9saS9K
D4MDLw5l2Gay72jkJqJ53JJlb2xzr8Q4pX//8ecz0tc9vFjJ7C/YX6DsMBmniniX
yU03AScpRAq9Tp0Tu91KMRcu6iTzVuQTxbiNJG/cuLKdNzsj5bsXXf/6PyXUnfGr
cP8nYqrBbZax9v5K3xpYXUoyCvrQgj2Y0Xl/QEt+xDpThDGzBtJVBo9LUFdxwwgK
WxnQgTMQOlCUzPLivUrhif+gAx00Hv2yBwqbyBe0wUxyeJ4WhwyA8UVUbBfSZ+Ba
91dTehboJEHmZ1UfwRfdfN6TGs8VQgVLk3aZu19r+jSGlUlxZikqP6N2WHb3UuH7
b4miTYNBSQwSHq1tVfbD
=1oKP
-----END PGP SIGNATURE-----

--Sig_/WpQaNo4a92AGZkzoKwzRe5W--
