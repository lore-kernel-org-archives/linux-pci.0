Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:38067 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932126Ab1LETW5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 14:22:57 -0500
Date: Mon, 5 Dec 2011 11:25:30 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ingo Molnar <mingo@elte.hu>,
	Andreas Herrmann <andreas.herrmann3@amd.com>,
	linux-pci@vger.kernel.org
Subject: Re: [herrmann.der.user@googlemail.com: [PATCH] x86, amd: Kill
 misleading message about enablement of IO access to PCI ECS]
Message-ID: <20111205112530.7cbf403e@jbarnes-desktop>
In-Reply-To: <20111205171228.GH25909@elte.hu>
References: <20111205171228.GH25909@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/qeTD9A_d7JDLLwzocEowbEt"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/qeTD9A_d7JDLLwzocEowbEt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Yep, thanks.  Applied.

Jesse

On Mon, 5 Dec 2011 18:12:28 +0100
Ingo Molnar <mingo@elte.hu> wrote:

>=20
> i think this would be yours? Wrong Cc:s it appears.
>=20
>=20
> I suspect the original 24d9b70b commit should have gone via the=20
> PCI tree too ...
>=20
> Thanks,
>=20
> 	Ingo
>=20
> ----- Forwarded message from Andreas Herrmann <herrmann.der.user@googlema=
il.com> -----
>=20
> Date: Fri, 2 Dec 2011 08:27:53 +0100
> From: Andreas Herrmann <herrmann.der.user@googlemail.com>
> To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H=
. Peter Anvin"
> 	<hpa@zytor.com>
> Cc: linux-kernel@vger.kernel.org, Robert Richter <robert.richter@amd.com>=
, Jan Beulich
> 	<jbeulich@novell.com>, Borislav Petkov <borislav.petkov@amd.com>, Frank =
Arnold
> 	<frank.arnold@amd.com>
> Subject: [PATCH] x86, amd: Kill misleading message about enablement of IO=
 access to PCI ECS
>=20
> From: Andreas Herrmann <andreas.herrmann3@amd.com>
>=20
> Commit 24d9b70b8c679264756a6980e668b96b3f964826 (x86: Use PCI method
> for enabling AMD extended config space before MSR method) added a
> message when IO access to PCI ECS was enabled via access to the NB_CFG
> PCI register.  This can lead to a bogus message like
>=20
> [    0.365177] Extended Config Space enabled on 0 nodes
>=20
> which is misleading because IO ECS access is subsequently enabled for
> AMD CPUs (that support this) by modifying the corresponding NB_CFG
> MSR.
>=20
> Furthermore it's not "Extended Config Space" that is enabled by this
> register setting. It's the IO access that is enabled for extended
> configruation space.
>=20
> IMHO the ambiguous message needs to be cancelled.
>=20
> Cc: Jan Beulich <jbeulich@novell.com>
> Cc: Robert Richter <robert.richter@amd.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  arch/x86/pci/amd_bus.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
> index 026e493..7b7a897 100644
> --- a/arch/x86/pci/amd_bus.c
> +++ b/arch/x86/pci/amd_bus.c
> @@ -403,7 +403,6 @@ static void __init pci_enable_pci_io_ecs(void)
>  			++n;
>  		}
>  	}
> -	pr_info("Extended Config Space enabled on %u nodes\n", n);
>  #endif
>  }
> =20


--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/qeTD9A_d7JDLLwzocEowbEt
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3RqqAAoJEIEoDkX4Qk9herYQAMB9d3y0XGopACEi7yGwzxYe
xVTA6K6P8yL4XUkjJyXOVRitBS8gyLfObgXu7YzQtRz0Cs4q5lSG/6UBcyanQ0vI
jB8/OtT4NZTrZh1ArtfEcVYetfuUpXtoCGHkop989LkPh4cQcemvY76wj7pj/yD1
6LK++drVAw1M4qT2ZW/5zcP9IsY33DKrV0jGMQsF7lgG2Fd+mQzJ+5NJv9D1QX/b
nBfeUrjqBgdmgwo7VQAwbZw0tDHiRIwLF0rY5xTx2x96fUI5EFn8WFghE3bPaaX3
m2tX7nAACaXI+o3mgWN47FFiNaKjLLQlJQ+Tk5TWDqjlyDRbUGdwf38uN3/+BH6T
TTPasFMWyY/OzOBirJS5hNyOsBuWu82aJ60s7xbCehVDPsIc0qMEZJXhJXuXIa50
89/MBOMWXHr7Qi9OHg77gj0vcCE/UFJy9vYywijij/iMkj2983y3ODhmHqmxFzOP
DgwSrtB367gNzIUhnxj0qieHxYlrXGZIpUFuhd0lBbt3vvQS//8GaWhJP+mUZ4Df
H2dmya8/du1yQ+nqLmFR9B9Xva3NO9tV+fn7W4MpXhEqfAKEo9o9ERazlVcrN1ay
ZqK6pNUbXFDraRNyS8L+GKFNrQxdee8ZSn3t3HpsIZTEbh6FBImzbutazv1w93MF
wlhL2qflMqsnD0JrW2QY
=HjbO
-----END PGP SIGNATURE-----

--Sig_/qeTD9A_d7JDLLwzocEowbEt--
