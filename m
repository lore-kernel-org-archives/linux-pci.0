Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:37773 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754005Ab2B0UWq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2012 15:22:46 -0500
Date: Mon, 27 Feb 2012 12:22:40 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ingo Molnar <mingo@elte.hu>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	linux-pci@vger.kernel.org, andreas.herrmann3@amd.com
Subject: Re: [andreas.herrmann3@amd.com: [PATCH 1/2] x86/amd: Restore
 early_fill_mp_bus_to_node]
Message-ID: <20120227122240.778bcc5b@jbarnes-desktop>
In-Reply-To: <20120227094406.GB10078@elte.hu>
References: <20120227094406.GB10078@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/fkms5APvTCBRa2IRXtyFMmF"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/fkms5APvTCBRa2IRXtyFMmF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2012 10:44:06 +0100
Ingo Molnar <mingo@elte.hu> wrote:

>=20
> Yours?
>=20
> ----- Forwarded message from Andreas Herrmann <andreas.herrmann3@amd.com>=
 -----
>=20
> Date: Fri, 24 Feb 2012 16:19:12 +0100
> From: Andreas Herrmann <andreas.herrmann3@amd.com>
> To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H=
. Peter Anvin"
> 	<hpa@zytor.com>
> CC: linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] x86/amd: Restore early_fill_mp_bus_to_node
>=20
>=20
> Once upon a time this function was overloaded with quirky stuff to fix
> resource detection on systems w/ _CRS defects (seems that some Sun and
> HP systems were affected).
>=20
> See commit 30a18d6c3f1e774de656ebd8ff219d53e2ba4029
> (x86: multi pci root bus with different io resource range, on 64-bit)
>=20
> Restore the old function and thus decouple it from the quirk that is
> CPU family specific (e.g. it won't work on AMD family 15h CPUs). BTW,
> I assume that the _CRS stuff is working on current systems.
>=20
> This is required to properly initilize the numa_node information of
> PCI busses and associated devices.
>=20
> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  arch/x86/pci/amd_bus.c |   84 +++++++++++++++++++++++++++++++-----------=
-----

ISTR this function getting things wrong on some Nehalem based systems,
and assigning all IO devices to node 0, resulting in bad NIC
performance.

Jesse, are things working ok now?  Care to test this patch to make sure
it doesn't regress anything on one of the previously affected systems?

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/fkms5APvTCBRa2IRXtyFMmF
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPS+YQAAoJEIEoDkX4Qk9hqY0P/AiM8nd5lqfxrHlLtFwSbUxd
4thnkgxjZMVPKV/tUbE63scMEb/wM2p5OYRIdCW121hRhWcczwPDEz8DMoXnSMWm
nFJDs/b6cXq/DMg0pdNR/DF6iXZn4XsoNgVVFFycp08oD0FEthgMbRcj1uaRsz1w
/Hv1lysJAa3xYsQQA/M6pQuDfQjZ5GdaOwpro0pKSwcCPqFApp5ua6Aap/LXPoqF
hNqE2TnbCWaExz/LANI2VPmDIqKVYb2PrryIrVOUsnazOM76LkA/Ey6WdafcnYjK
v/Bh/dWNv5eQzxBmIrk1KJIPaXy4BgDgbLq7iwXsUS2N16bLSB1kN1/kzeGftm61
ieR3UJtnZaicJC2tFMXt5DQ3L35TLEmdSVoQi8QVDjCfmqEqM5ZJmPNffjMES1t9
/0PY4eXL1wX1+Ko8cx2XiGE1egWj/uD2cDJonLaOfv8EKSK0mdqLN31Omli5VYhV
YgbdJWjYausp0t2NlPuHHujJ5Auwx7FDn7MJlEx8u9o97bjrh5h00ExmFU3o/tOr
ShYR8rlDTzyyLNLIlao9VsJ9kZmZriCPPb06y2k1P6r9AOKKoQ3dtvxCh+FuuyTP
YK7thnIrNx9BKI0W/BL6QoL+vgD3raV8gN9/fnM4Z8iB9REsz8ejjLRms+BGMqni
rrZDA5e/uLXLmlVTHgQP
=S5xX
-----END PGP SIGNATURE-----

--Sig_/fkms5APvTCBRa2IRXtyFMmF--
