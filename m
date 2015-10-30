Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58081 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030973AbbJ3MET (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 30 Oct 2015 08:04:19 -0400
Date: Fri, 30 Oct 2015 13:04:08 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Message-ID: <20151030120408.GE25117@katana>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151029123755.GC2351@katana>
 <PS1PR06MB118061CA5128E4C1A2C70A18F5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151029163930.GC22218@katana>
 <PS1PR06MB11804B39B09D6FCAA9B3D9DCF5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151029184800.GB8992@katana>
 <PS1PR06MB11805309BF760C14F4894EAEF52F0@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
In-Reply-To: <PS1PR06MB11805309BF760C14F4894EAEF52F0@PS1PR06MB1180.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Hopefully, Geert's patch will be applied to avoid build errors in both the
> rcar-pcie and rcar-pci-gen2 (internal USB bridge) drivers. Meanwhile I'll fix
> the rcar-pcie driver properly for arm64.

Thanks for taking care.

> > What MSI problem?
> I was told that rcar pcie on v4.3-rc5 had an issue with MSI.

Okay, we'll see. I only have remote access to a Koelsch board, but my
own Salvator. And a USB3 PCIE card. That would be my primary test setup.

> > And can't you send the DTS patches as RFC so I can add some testing?
> Sure, though what tree? As I mentioned above, next doesn't have
> shmobile arm64 yet.

I use renesas-drivers:

git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git renesas-drivers-2015-10-27-v4.3-rc7

Thanks,

   Wolfram


--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWM1y4AAoJEBQN5MwUoCm2g4YP+gNg09/8VHAE4OpROqXRm5fw
Ni0FuaeMdaUH57LHy/pGWaFXzoROgqqiPC2Nou6zdNY1kD2Wkklj8mF9x5HbIi9b
VXR5BTZZ04y6mmlgIFrXi2bpN1XGnfUhwvqD9SILM9n1BFRS2IAH1XkG3qJ6XjUZ
0E7see8ffbUW6oHKLuTvJo3PcN74XOd+/3DKcPqONOa1BzhllCyCMQ+RbMSA9gNn
58ISZwFgGkM29yqfNS5tzIcWqNARR+SNZBDC1iWZ+OufKPvj4fZFAZjMBQad0Gfm
OyCMRmBP8+g8u1lXBqRaH9LFDy4xLEnnHO0UrPECL/tkENqMCkT2upew3ClEsD2M
eB7aOkUPMtjhGiMor5NqofnuifUPVFGBp3tYXN18Yz12FyytFKVrxiCBZ5EXAf6I
S7E7KS//JaCO6cZ5ousw5POQSiPFgtH4mkz8FFSoNpm+Fsde7mfhBEhr26E1wJwx
JBhoAFEU6oE+FRHnWorwv5lTWsTFp82eF/rbrr1Bz2zugo+RXnOtOcEQA5h2bhwf
eJPWDVT8U9QJppkxv3mc/nMWerPHOOE/xmZ2DYo4CRwLW0IT/GuGDG5rntlYl4Xs
4ZD0XLpDvRm54Qjq1mi+PCyd/vKFpZYVDvYlCxiBDWtNpu59Ee/Xqas+nyuH4VRY
FlBD6AfmqI0enGAs7//v
=j/UL
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
