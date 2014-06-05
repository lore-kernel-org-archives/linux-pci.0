Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14883 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbaFEVjh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jun 2014 17:39:37 -0400
Date: Thu, 5 Jun 2014 23:36:49 +0200
From: Thierry Reding <treding@nvidia.com>
To: Vidya Sagar <vidyas@nvidia.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Krishna Thota <kthota@nvidia.com>
Subject: Re: Query regarding ASPM in PCIe
Message-ID: <20140605213649.GA22251@ulmo.nvidia.com>
References: <113ACA888B71994BB56E5CF3704953486D6CE1E20E@BGMAIL02.nvidia.com>
MIME-Version: 1.0
In-Reply-To: <113ACA888B71994BB56E5CF3704953486D6CE1E20E@BGMAIL02.nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vidya,

when posting to public mailing lists it's customary to wrap your lines
at around 78 characters. Also can you convert the call graph pptx into
something more standard like PDF to make it easier for people to view?

Thierry

On Thu, Jun 05, 2014 at 03:57:23PM +0200, Vidya Sagar wrote:
> Hi,
> My understanding about ASPM feature is that, when CONFIG_PCIEASPM_POWER=
SAVE is enabled, PCI subsystem enables ASPM - L0s, L1 features based on l=
atency calculations respectively.
> But in the latest code, though CONFIG_PCIEASPM_POWERSAVE is enabled, AS=
PM on eligible devices is not enabled.
>=20
> irrespective of what CONFIG_PCIEASPM_* is (DEFAULT / POWERSAVE / PERFOR=
MANCE), if 'echo powersave > /sys/modules/pcie_aspm/parameters/policy' is=
=20executed, ASPM states are enabled in all eligible devices and is worki=
ng as well.
>=20
> after having gone through the code, here is my understanding (I tried t=
o depict the code flow in the attached PPT)
> pcie_config_aspm_link() is the API that actually enables link entry to =
L0s and L1 by writing the link control register in the configuration spac=
e of the devices.
> at top level, pci_enable_device() is the one that calls pcie_config_asp=
m_link() API which does the job ( ofcourse, pcie_aspm_set_policy() also c=
alls it but only when the aforementioned sysfs entry is modified... and p=
cie_aspm_init_link_state() also calls.. again only if it is *not* in powe=
rsave mode ... for stability reasons...!)
>=20
> the issue is surfacing here because.. in pci_set_power_state() there is=
=20this condition..
>=20
> /* Check if we're already there */
> if (dev->current_state =3D=3D state)
>     return 0;
>=20
> because of which control returns from there and never comes to the end =
where the call pcie_aspm_powersave_config_link() is present.
> My understanding is that with the above condition, ASPM never gets enab=
led by default (unless we sysfs entry is explicitly written).
> Can you please confirm my understanding ? if this is the case indeed, I=
'll work on pushing a patch to fix this.
>=20
> Thanks,
> Sagar
>=20



-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkOLxAAoJEN0jrNd/PrOhaeQP/iueCJH0FadIfIrU3KVXaT4D
DV2MR+YJhkBdrNaEai5xOdcizVBbMgo4k+4j1JzPKNR2pLBmqTveUYJ1aQRMOtKN
7D91m3N/CR7Xc+aXokw+CuPicsfy9V5EIqrleNXxZMUd0G2qSqnB3bgTJ8NmWb/S
0pePLVMynzO782HLk15BgVm3EqhLAUwUuiVWsLjnLl3oDH5GKDRYhreKwAfD6Zif
9PUC+uUHSPYICvr0fV6S/uWl/Spi1FneUAo9zTU8bdOuryX0OIZ4Np2/EBj1DAQt
q3q58KDnE37GwRuv6c4sP6MFyG23s7wJLSll3G/dTxe/JlP5uZT1bPo3aNqkLyJz
w2qrjrzzot+8sYpbYXvj+gxg2fBNkr9SQzIbSFCRWt0R0XCcwwkrJJ5ttv4xHsRg
tNYCL0d23uZBEHmxEHROiBzU1QaBern9ADD7hy5pPZFBy/leeONPSX8EMm7BGg07
fOzUcTHJg+U11DF1FSpUT+aMb8k/Cgcv/qyV2qnaiQBHd+7hJU+Su02fd//aWMCi
7T9BywFxagHMYJNEY5ut5/WShZCb6mTtUYA6n8LxtnIs69pC7RtofLoagfbnpQCi
IV5r413BnlHitQdAPvD34UYJlNco7A1wNu7U3GZo3RedFm+3kPFFptp4t/Tr1PIR
GBg4Lgr4PXLR1BBxj+iK
=s2bC
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
