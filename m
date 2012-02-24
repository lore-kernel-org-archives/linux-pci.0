Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy5-pub.bluehost.com ([67.222.38.55]:53531 "HELO
	oproxy5-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757933Ab2BXR1L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 12:27:11 -0500
Date: Fri, 24 Feb 2012 09:27:06 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Olof Johansson (olof@lixom.net)" <olof@lixom.net>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Stephen Warren <swarren@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: PCIe device tree support
Message-ID: <20120224092706.7e33aa9c@jbarnes-desktop>
In-Reply-To: <CAHM4w1k1_Yp56tpfPqDxT1WHQWRB5xe_Zs-BEj+n5rVmuyAJiw@mail.gmail.com>
References: <20120220191804.GA14499@avionic-0098.adnet.avionic-design.de>
	<74CDBE0F657A3D45AFBB94109FB122FF17BD8BC302@HQMAIL01.nvidia.com>
	<20120222082449.GA15157@avionic-0098.adnet.avionic-design.de>
	<CAErSpo4TfpGmx+HZ1ZnZwj3ZP_cQMCzkMT+6JK6ztYp2zWJcxw@mail.gmail.com>
	<20120223060355.GA21091@avionic-0098.mockup.avionic-design.de>
	<CAErSpo7wSB-uCjV4YeA-fUOHPtugn4ASXScN3MndVybfkk8mOw@mail.gmail.com>
	<20120224065921.GA28932@avionic-0098.mockup.avionic-design.de>
	<CAHM4w1k1_Yp56tpfPqDxT1WHQWRB5xe_Zs-BEj+n5rVmuyAJiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/0=enSNm_SVC5ZIPyz_6SiHr"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/0=enSNm_SVC5ZIPyz_6SiHr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Feb 2012 22:46:06 +0530
Pratyush Anand <pratyush.anand@gmail.com> wrote:

> I too had similar query.
> I have written a PCIe host driver for SPEAr platform (ARM Arch).
> This driver is registered on paltform bus.
> It is for Designware IP, so I believe that most of its part
> can be re-usaable for other person.
>  have kept common and SPEAr specific part separately.
> But,  I am not sure about its best location.
> I believe best would have been to keep in driver/pci/pcie/hosts/.
> But it uses pci_common_init function which is specific to ARM platform.
> So it limits option to arch/arm.
> But, if I keep it in arch/arm/mach-spear13xx/ , then it will limit others
> from using synopsys specific code.
>=20
> What do you suggest?

Maybe arch/arm/pci until there are non-ARM users of the IP?  In fact,
you may want to put off moving it to arch/arm/pci until you have
someone to share it with.  Premature sharing is like premature
optimization after all...

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/0=enSNm_SVC5ZIPyz_6SiHr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPR8hqAAoJEIEoDkX4Qk9hTrkP/iIuyuocVUwQ4GkGQ1gkhn5/
F+VKDZj1mzWKteHFCfYRJ4tidNfDvA074rTkDNfTS0qcb67hoEuQxGWtUtrmoT4b
m98dR45Jp743khocK4qmozAcIxysOz6OCBFXQoHHoYaEXnoyqvFyCjUH9rdnP5hU
/zZ8GAGnHE2w2u/M2HPBrqEj1B5wyM98hVSuJMux3YYSA9F3fZDnm2L0eB0rPZ40
Id+/IdaUF/cBQgQt7Lxsf5srWCn/xHS5iCB4y0aDuoCBa5R/oFDaYB2cN7rlfg9S
ZYYPHd3fRNe5c2/NdajhiTTiMp18jHEFJAakbQpVtIMYYSzmAe/+N1B14qH5dJN3
mKuYDlnBmh16fuGGBCTBk6/eF/lmyPFt2jM1rv+cIkk5xGILnGvxLztYhUkSyKLa
hib9uy0Uk8HERmW0qkcZus88XkpG4KdS8aI/3TjUtYYxhwwu0id3qSIQzKaLsWFM
SnLgE+g58wdf6aqKustVNQcCDby1cuEzDDMl5gqnX0eYS5IMakJBEjCiHYTf9NKy
+wahk7q0lK+zuESJXv8IL/GqtWCHSidBde1VebUf3MI1JFzRAlb4BPNnHvTlT9rA
do+ozaPY+o9EZCcK451Y+pDfeeLucFJd8Cr8UWqmN1tBz1ktFrZolK1hv/Nne98q
rDmheVxrQpD9OBVIfTkn
=eMkZ
-----END PGP SIGNATURE-----

--Sig_/0=enSNm_SVC5ZIPyz_6SiHr--
