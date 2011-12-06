Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:34545 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751866Ab1LFTdu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2011 14:33:50 -0500
Date: Tue, 6 Dec 2011 11:33:42 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "P. Christeas" <xrg@linux.gr>
Cc: Matthew Garrett <mjg@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] kconfig: English typo in pci/pcie/Kconfig
Message-ID: <20111206113342.420e819f@jbarnes-desktop>
In-Reply-To: <201112062048.37576.xrg@linux.gr>
References: <201112062048.37576.xrg@linux.gr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/7nsbWBhH9hNHy+m/ixr.sT."; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/7nsbWBhH9hNHy+m/ixr.sT.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Dec 2011 20:48:35 +0200
"P. Christeas" <xrg@linux.gr> wrote:

> Just fix this help text.
>=20
> Signed-off-by: P. Christeas <xrg@linux.gr>
> ---
>  drivers/pci/pcie/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index dc29348..72962cc 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -39,7 +39,7 @@ config PCIEASPM
>  	  Power Management) and Clock Power Management. ASPM supports
>  	  state L0/L0s/L1.
> =20
> -	  ASPM is initially set up the the firmware. With this option enabled,
> +	  ASPM is initially set up by the firmware. With this option enabled,
>  	  Linux can modify this state in order to disable ASPM on known-bad
>  	  hardware or configurations and enable it when known-safe.
> =20

Pushed to linux-next, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/7nsbWBhH9hNHy+m/ixr.sT.
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3m4WAAoJEIEoDkX4Qk9hGzAQAIOCusQLUkPF0hSTF8q2RQbO
xA9J+fyQXC7AfIO64jumLHGUE+89JbKgX2AwWFRcgtN0Xrrw2nrw56fGsIhh6xx4
wLRR4OndG3+HZ7NKDkgBMxCZ42bD02WjN0lxUXUg+l50L8ifTA++/8IxrDuOATun
Cs+sGfe43OIx7B1BxY7C+ZdqxQUltmOvRc0nFvrwmcpBHlrcNMFvZEJ9XbZgxnBP
6CbX0BIGSoc2t7dns3dpbJvbX283j1f1ftmGe1gUstlJroSU0aiYVZebcS0ZyHCM
vBZwi44aM2V7zw5Jusgfu954aUN2+HRYEJb618CI8003E/hD5if2hpEvsLeFGKX4
tRmnwyKRtjJ5RRxTcgvLIrPKrS4+fu1YIRLWJaInwBNkGW3vZwUHd89cZgluJI0B
j50uGI3An1gkHmicqzt4iPBMyQpcPiwNF2C4er8a/dTMMh1T2j2jjRVHI+DFkBV8
89lvJ3QO0STeUoEfRsrvilN1JrhoOYgRTrMVvkzS1llfr88C1wHaaoxsfqQ7olIF
vfchIpGHmkTiy8Zy+vbG+nIUIHsTrzFPfGZOzsawGlI8xwupbaGWU+hj9/QlbXca
Ree5G9YWbd2OavSS8g4tMJ+dNwniyYPgmaDWA8N0d0GH7fO4lLk5DlcRyNWuBlag
kwhlrxutdCB7BKUeAsVh
=1PBL
-----END PGP SIGNATURE-----

--Sig_/7nsbWBhH9hNHy+m/ixr.sT.--
