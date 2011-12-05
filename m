Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:39161 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932126Ab1LET0U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 14:26:20 -0500
Date: Mon, 5 Dec 2011 11:28:54 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Jan Beulich" <JBeulich@suse.com>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/IO-APIC: allow PCI_IOAPIC to be user configurable
 on x86
Message-ID: <20111205112854.10aceb75@jbarnes-desktop>
In-Reply-To: <4ED49EEA0200007800063F75@nat28.tlf.novell.com>
References: <4ED49EEA0200007800063F75@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/FXOfgPchDg2cS1Izg09G7ka"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/FXOfgPchDg2cS1Izg09G7ka
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Nov 2011 07:59:22 +0000
"Jan Beulich" <JBeulich@suse.com> wrote:

> This adjusts PCI_IOAPIC to be user configurable (possibly as a module)
> on x86, since the base architecture code for adding IO-APICs
> dynamically isn't there yet (and hence having the code present
> everywhere is pretty pointless).
>=20
> To make this consistent, a MODULE_DEVICE_TABLE() declaration gets
> added, the class specifications get corrected (by properly using
> PCI_DEVICE_CLASS() intended for purposes like this), and the probe and
> remove functions get their sections adjusted.
>=20
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
>=20

Oooh, fancy.  Should go through the x86 tree though since the APIC code
is really x86 specific (and they're the experts in that anyway).

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/FXOfgPchDg2cS1Izg09G7ka
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3Rt2AAoJEIEoDkX4Qk9hhGEP/2SIZ74Udvx0Vr778y2/toUe
NMB1thbk33Vs1jk1vdAANRkEJe/95B3aUY8eopTgcmAQIyh1qDmR5PS6io0Dl473
syaqxPt05DQPdoQnZMfe0CD6woh+ygxXhBL49bHiuoQvAIT0NFcxUxZHgABhzykD
eTQVf5sdx94QOgONJg+1MCtwLVMZIbec0XEMrD6psn3qvgyRklK38xxE64IKqdYh
Z9fltbKwqGzD69hRUYApS6jtNIt/Zu4fF2of04lAuxg9OrWCWoeAKeh0Kv++ibMQ
GpI1JHSfRviCEiG/Lv8Biqs7cfBnWaeNr1aPlMBVTrm+qzk5iFZ/FhMTPlnug0e1
a4narAzftr1fkb9kMW3g6j9y8L9tSsOD1lkA0/j7Q4DsqLxqARSDmZE5AVSu7MSS
x0IQyPbjLYBlUvE4axKscC/70gIHqzoiqumf5f7vNAyobdK9Lc9++84+400vkRIc
+iq4rI4DmtqQ2q11PUKIVI+vzajOVeiUwvL8ru0DWMntmsbJ65DPGxzItZZO3oPl
yBWP+k12ZYriyMdL4curwjxIqLv+0rMdkk9m2NWplLI7PylAzFOh0wmnOc9a/I2b
ip1+nzIBrZr8oA74zWlI+ulIlSc7tWetwFT1Um3V6fAoC5GW38NSER2dwOxzWudH
0nuyd7N57Wf8iVoOde9O
=0UKT
-----END PGP SIGNATURE-----

--Sig_/FXOfgPchDg2cS1Izg09G7ka--
