Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:50515 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab3HZILi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2013 04:11:38 -0400
Date: Mon, 26 Aug 2013 10:11:06 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lucas Stach <dev@lynxeye.de>
Cc: Jay Agarwal <jagarwal@nvidia.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Tegra PCIe system hangs
Message-ID: <20130826081105.GD31726@ulmo>
References: <1377450840.1622.15.camel@tellur>
 <1377474634.1622.17.camel@tellur>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
In-Reply-To: <1377474634.1622.17.camel@tellur>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2013 at 01:50:34AM +0200, Lucas Stach wrote:
> Ok, turn out this seems to be an issue with legacy PCI interrupts.
> Nouveau wasn't really using MSI interrupts, switching them on seems to
> fix the stability issue.
>=20
> Still I would be interested in the root cause and would like to see this
> documented somewhere.

Hi Lucas,

Thanks for reporting. It's quite possible that there is a general issue
with legacy interrupts since I haven't tested that much. I'll see if I
can reproduce the lockups when using legacy interrupts on any of my
setups.

Thanks,
Thierry

>=20
> Thanks,
> Lucas
>=20
> Am Sonntag, den 25.08.2013, 19:14 +0200 schrieb Lucas Stach:
> > Hi all,
> >=20
> > I've been experimenting with the Nouveau driver on Tegra for a few days
> > now and made some promising progress. The one thing that keeps throwing
> > me back is that I get seemingly random system lockups, which are not
> > recoverable.
> >=20
> > I think this could be the same issue that was reported by Jay Agarwal
> > earlier. (Message-id:
> > <C79B248886DD134989C8FF6B096A91AB91B603D82B@BGMAIL01.nvidia.com>)
> > I also found a WAR for a system hang issue in the NVidia downstream
> > kernel [1], but when tried on upstream it had no effect on the issue.
> >=20
> > I'm reasonably sure that this is not driver software related, as I've
> > already hunted down most of the caching issues and acceleration seems to
> > work at this point. So either this is a random HW hang, or there is some
> > software condition I'm not aware of.
> >=20
> > I'm running a NV92 connected to the NVidia Beaver board. Kernel is
> > next-20130809 with the PCIe series + the LP2 workaround applied.
> >=20
> > Could you please investigate if there are any other known errata for the
> > Tegra PCIe controller, which could hang the entire system?
> >=20
> > Thanks,
> > Lucas
> >=20
> > [1]
> > http://nv-tegra.nvidia.com/gitweb/?p=3Dlinux-2.6.git;a=3Dblobdiff;f=3Da=
rch/arm/mach-tegra/pcie.c;h=3D9fab5de016cfd3cd2ebd8176da5bdbedfac73cd8;hp=
=3D44749685e2bf822665c9345aec45151b8d2447c4;hb=3Dc5d1bcfb7249b291453a801221=
48155a00e5456a;hpb=3D704125ef90e12bc41de057001cc96d81d7cc0376
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-tegra" =
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSGw2ZAAoJEN0jrNd/PrOhrGsP/R04SWYx+tfpM5Khzi2/Bi4s
KBaKHPPghskcjkDVMtB74hloPU554/3vQ2qXSQ7Nk9wy2pmJ61p5fW71n7PpjNyc
GQNKC7zDt09rMFtqziLxg/aWjy4k89EBWC195sxKODPM2bInZqnFX0moOPwCwRty
AU/2p+sGA/g4wE7Y+nJ2EIlWDYuBStWFnnABoZPC9A75JFqHQsZgPd6XM9DntNrR
YN6fTdf+Lsmvh4/etpSKriGVkv25zbbaeBazAsM1JaW7mIHLH7Df9XSw7OWn4OiO
wa+rcpNnZtRUrAMH2DoZQV8ecDxVJJkVbTLYc8Km/QxbFjhTeDRzFo3YDCAIV2Zq
SYpxqR86eoMndJyy1msz+se8hgwwJB6UUVhDLYNPMPdaMFoHe1XssKlw9hfw4hD6
tdsPiE7HyDONg++sabFZt+TwxJITDdTs01dfmBJ7ADHZLGQw8FFCuukIOz67UV7o
/PNO3P7p/GDLnrOgJtdtM5rP+pnbFXJpRy7MIwv6hMAPEVKMLtwwH6p+gJhwg7zC
D9MGdcZP83f1DpT/y/ZQQvQr5bg4FRyz76VRbdnyAXvkxwb991g65/swSH7S2W1r
pL3wTupZBfY3BFdHcHONd4zF0TBqMz62lKu48aSdtUm7o6dm5ghVt7MlRHE+qENK
DQyP1I+mzC+CPtDdfGcC
=wE0H
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
