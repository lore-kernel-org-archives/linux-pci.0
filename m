Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:60319 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756791Ab2BXV4R (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 16:56:17 -0500
Date: Fri, 24 Feb 2012 13:56:11 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, greg@kroah.com,
	kaneshige.kenji@jp.fujitsu.com, yinghai@kernel.org
Subject: Re: [PATCH v5] Add pcie_hp=nomsi to disable MSI/MSI-X for pciehp
 driver
Message-ID: <20120224135611.2166ff46@jbarnes-desktop>
In-Reply-To: <4F47FB6B.3050509@jp.fujitsu.com>
References: <20120202160922.4564.99032.sendpatchset@dhcp-189-101.bos.redhat.com>
	<20120223123003.662cf548@jbarnes-desktop>
	<4F47FB6B.3050509@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/7hO2vU0hcThNiFQuqp+C==C"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/7hO2vU0hcThNiFQuqp+C==C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Feb 2012 16:04:43 -0500
MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com> wrote:

> On Thu, 23 Feb 2012 12:30:03 -0800,
> Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
>=20
> > On Thu, 2 Feb 2012 11:09:22 -0500
> > MUNEDA Takahiro<muneda.takahiro@jp.fujitsu.com>  wrote:
> >
> >> Not to use MSI/MSI-X for pciehp, add a kernel parameter, pcie_hp=3Dnom=
si.
> >>
> >> In my environment, while shutting down, following stack trace is shown
> >> sometimes.
> >
> > Applied, thanks guys.
> >
> > Now should we also have a platform/device blacklist to enable this
> > option automatically so people don't have to remember to use it?
>=20
> Hi Jesse,
>=20
> I agree with you.
> However, I don't have a device which *officially* has a problem
> regarding this.  I'm waiting a statement from vendor.  We should start
> after statement becomes available.

Ok, thanks Takahiro-san.  Just submit a patch if/when you get some
confirmation.

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/7hO2vU0hcThNiFQuqp+C==C
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPSAd7AAoJEIEoDkX4Qk9hJLIP+gOwWCeEN3C2QAZxzt6C80DJ
IQ4vdPZft2FcpFAKAMuEUilxEAYhScIuNNKJpKr6tx3K734q0Ey8tENnnpPc/gEi
ffVzicpxdrf6O5H1HGjlv3MJaIIl5V4xhmyK30iKCdGcdK/FO1X79tdL1AHPvwvK
qPGYcSPO7BubPFoksr6C5JRlldeI7zBOFELHHCgDVDf4RVCP/Zd/JkltmxceD0JI
llBVcEAFgR5FUPsIL/+16BgmpDq7Ig7ei3mxbGd5xmP3zAU+bebsJwL2m61rRWqS
QZ6MH/EnQYp7Twxl0ZptrSqfyUB85ZehVGEusKew1NiTEMjkQ2tYQ02uk5wfrn6V
QsfdVMo2moBFHrWm7tjmzSnVGy+/yxqA/EJq6OM1Po3MgtM/s92vuhEcOhJxLYfs
FHtg8yyh21sPEtmfsBc0YHDw1JH8Bfw/+cw91ESzCkJScvdO/mfHsstjFUdRQx8Q
CdYki4J+CPZyzbvSCHkqlTFsFx+A/IiN9JdnJ4k3HqYj7EG+6ABDKZKX/5mDPA2n
DfTvUIyedzQAK4QfG1+IX9ZUgNDyntGxYLEz1eCJYiHv6Mb0nw1BQDgAQbPMta6J
3pBSnBKeVUqcnc0Mz/5Thh6C8ZeOv0W4Zq5HDkp8jWHNovkxrzaDvsKuDdJLUcSv
vv7euZdpymrpVv2mYcGq
=MVxG
-----END PGP SIGNATURE-----

--Sig_/7hO2vU0hcThNiFQuqp+C==C--
