Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy1-pub.bluehost.com ([66.147.249.253]:33124 "HELO
	oproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756801Ab2BWUe5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2012 15:34:57 -0500
Date: Thu, 23 Feb 2012 12:34:53 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi <linux-acpi@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI: Move acpi_dev_run_wake to acpi core
Message-ID: <20120223123453.00645ec3@jbarnes-desktop>
In-Reply-To: <1329362677.3413.12.camel@minggr>
References: <1329362677.3413.12.camel@minggr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/97.6BOE_.X693g.G.9ObLg2"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/97.6BOE_.X693g.G.9ObLg2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Feb 2012 11:24:37 +0800
Lin Ming <ming.m.lin@intel.com> wrote:

> acpi_dev_run_wake is a generic function which can be used by
> other subsystem too. Rename it to acpi_pm_device_run_wake, to be
> consistent with acpi_pm_device_sleep_wake.
>=20
> Then move it to acpi core.
>=20

Assuming Len hasn't already picked this up, I think it can go through
the ACPI tree.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/97.6BOE_.X693g.G.9ObLg2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRqLtAAoJEIEoDkX4Qk9h9ZMQALDyarP84otxFwhcfvImeQI8
kR+80sKLha6gJre8V1YwnN4SdZ+Q/+KSiThNZWe+eKaxmUsi/mS5NoYRaUYVZSM6
FJ0BZf5YsPmIRZZdtXGk1rHUg1J2rwh1ymVZeeOl8sYD7Lh/IcsiOzq3NSkOvnMc
xV29dnOsKoMGF+0lPwV9qZtTXBBqaMsy0zs0FkFVhBMKfW9GGfISQdDntmjAxZt7
vtYxqLDZ8oQfZVskYkaaRuPhBOYpLe8tTaCP2vxlI76yVnmNgQihwSsTyvxcyfd8
liUCBkaRiTwSCHqzaEO0SKTiWJ/jkZPVGP6UDhsDn0oIOjicCc65VeGnMZwXTXKL
LRqIW/FAgNmzQmZWTbO3IqDsle3hqkloXViiVnfg2Bjbc3i/Yo8mzfGrlgrzbL2a
aEvjO4iIQ0/qEmfVCHQxb3bBIeZRuu/9+1afwpFTL+6ydxm4SPR9qGkriWQa/yQs
peX5MGwHOInS8wDJoNHuezUejfn6uNNAb9gaTPKil/dLfxTNA8xFvAtJxnGvVLMq
dyzfhNvH/DqBYncsfA8Axn3C62dp/JeM3USItBSvaJho3MIgXKtZW/COS/RDzbm8
ViR4DgD3KGUBtfyJQCGlAOgX8JT3lj372UefrBH6y0sGMG0lxJyVRTnpO3JSjFxE
OBs7D4jhZQZUobFE/Fjy
=Kr9O
-----END PGP SIGNATURE-----

--Sig_/97.6BOE_.X693g.G.9ObLg2--
