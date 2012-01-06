Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:35736 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030596Ab2AFVOk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2012 16:14:40 -0500
Date: Fri, 6 Jan 2012 13:14:36 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI : Calculate right add_size
Message-ID: <20120106131436.17cf45e6@jbarnes-desktop>
In-Reply-To: <1323247984-15281-2-git-send-email-yinghai@kernel.org>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-2-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/SAtBIQH/GozX4lB=fsAIL_F"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/SAtBIQH/GozX4lB=fsAIL_F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  7 Dec 2011 00:53:00 -0800
Yinghai Lu <yinghai@kernel.org> wrote:

> During debug one SRIOV enabled hotplug, found add_size is not passed prop=
erly.
>=20
> the device have devices under two level bridges..
>=20
>  +-[0000:80]-+-00.0-[81-8f]--
>  |           +-01.0-[90-9f]--
>  |           +-02.0-[a0-af]----00.0-[a1-a3]--+-02.0-[a2]--+-00.0  Oracle =
Corporation Device
>  |           |                               \-03.0-[a3]--+-00.0  Oracle =
Corporation Device
>=20
> so later parent bridge will not try to add big range.
> [  557.455077] pci 0000:a0:00.0: BAR 14: assigned [mem 0xf9000000-0xf93ff=
fff]
> [  557.461974] pci 0000:a0:00.0: BAR 15: assigned [mem 0xf6000000-0xf61ff=
fff pref]
> [  557.469340] pci 0000:a1:02.0: BAR 14: assigned [mem 0xf9000000-0xf91ff=
fff]
> [  557.476231] pci 0000:a1:02.0: BAR 15: assigned [mem 0xf6000000-0xf60ff=
fff pref]
> [  557.483582] pci 0000:a1:03.0: BAR 14: assigned [mem 0xf9200000-0xf93ff=
fff]
> [  557.490468] pci 0000:a1:03.0: BAR 15: assigned [mem 0xf6100000-0xf61ff=
fff pref]
> [  557.497833] pci 0000:a1:03.0: BAR 14: can't assign mem (size 0x200000)
> [  557.504378] pci 0000:a1:03.0: failed to add optional resources res=3D[=
mem 0xf9200000-0xf93fffff]
> [  557.513026] pci 0000:a1:02.0: BAR 14: can't assign mem (size 0x200000)
> [  557.519578] pci 0000:a1:02.0: failed to add optional resources res=3D[=
mem 0xf9000000-0xf91fffff]
>=20
> it turns out We did not calculate size1 properly.
>=20
> static resource_size_t calculate_memsize(resource_size_t size,
>                 resource_size_t min_size,
>                 resource_size_t size1,
>                 resource_size_t old_size,
>                 resource_size_t align)
> {
>         if (size < min_size)
>                 size =3D min_size;
>         if (old_size =3D=3D 1 )
>                 old_size =3D 0;
>         if (size < old_size)
>                 size =3D old_size;
>         size =3D ALIGN(size + size1, align);
>         return size;
> }
>=20
> We should not pass add_size with min_size in calculate_memsize.
> that will make add_size not contribute final add_size.
>=20
> Just pass add_size with size1 to calculate_memsize()
>=20
> With this change, We should have chance to remove extra addon in pci_reas=
sign_resource...

This one looks like a fairly standalone bug fix; it doesn't require
subtle changes in behavior from the later patches to work right does it?

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/SAtBIQH/GozX4lB=fsAIL_F
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJPB2Q8AAoJEIEoDkX4Qk9h+f8P/37cLsqkHaOlaiZ4vBzAGTFo
WfR3AKS++K4ISIQosHEYz7z872362XW4nX+G3jtXiVeBhBVPtUfJVrgGwJbFJ5Mp
sCmfWPaFPkZlehmMFT2+GXUgBeCz3xmUjrWO6fySwkA9IZ0/YvEvgxLfxX4Hy2xB
aoKETXB0XcoPu38N7JMn0YSotVREwYWGZiRZZHQ5+cEouJsqFvH2HEyRuwN+h+f2
tjzoKcyYfzuLlrl7nqEsjnbtfXARfK04p8Q4hSdEpwi44ktiBUUbiA6kacG0ElQB
8vEyWOUHk89qyMEFF+bnDkyMaBnt1ezv8ElVuSBAr+A362q6H6TlN86+G2320R7T
ODGy9gjAxPL9ftTpPI0DDgqtQY1/oogwQGSMYshST+WRzkeLUEnppwf1Om5/Ms76
2RkULkteHcwq/xBnndPqx0IyuP+MD8CkgQzJF3SkeAZXD0A9zMmwOhBL6iQiJ1Iq
O+BcGo4y0K4HgiEt8e752SDwFjuoB0BSMGWSOPs54ktJipQBRTS8/l7xWlZ6YCIf
XGB6gWMlZCR+aCMsPeJ0v9EHfinmZLXLd8OFfO1hIasbIBUgWjqCYdnb1PibGYTG
3+htcHUeSQfOm85yiW/67Lpu7qjwsIoNH6TzYzjeuWALf6ieOnfyGI2nZyYS7d5l
efKZlH50ep1qpZ6H/Hvg
=k4/N
-----END PGP SIGNATURE-----

--Sig_/SAtBIQH/GozX4lB=fsAIL_F--
