Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51592 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbbJ2Qjj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 12:39:39 -0400
Date: Thu, 29 Oct 2015 17:39:31 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Message-ID: <20151029163930.GC22218@katana>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151029123755.GC2351@katana>
 <PS1PR06MB118061CA5128E4C1A2C70A18F5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
In-Reply-To: <PS1PR06MB118061CA5128E4C1A2C70A18F5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Ouch, my bad. I have been working with our out-of-tree BSP for the Salvator-X board on
> http://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git,  rcar-3.0.2 tag along
> with some patches from colleagues. I hadn't noticed this patch:

Thanks! Any plans for pushing this upstream? We will have the build error
otherwise...

> > Any news if this is really HW related?
> I found out that the PCIe controller HW only supports 32-bit AXI bus addresses, so it
> works fine if you limit the available memory. The driver will need some work to use
> the IPMMU at some point.

Ah, okay.

Can you send the dts patches, too? I checked the BSP this time, but to
no avail...


--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMkvCAAoJEBQN5MwUoCm2vjUP+QGx8CpUw/4SiJxSa1cahXhk
O6HBCiUjUYv8FBeVMUpcSfuguE/EvlyGZbaVZqsDx6YfjrkZGFzHVI3KVXKXo4TF
b7AF+ZkaZQHDt0wuazmP9TKUhy9ST349G0OWF2ckApU8PbnO6XSJ8plbRm6G+VM2
kFtM9hBhGw1VtPxMXGrxeHniS6xedkVx3MaBkXU3hiYv2txSdBZpx1T/nPcZg0pw
9e6sc0h2uNEUYp8oyrttEP2cSpl902BIiO5oGCI/Wdd76s5naME/mr7qpZw1RU7k
4t241GhtaBlzRzuY2f93bOIQH5u+67+Ir4u+nHNPN3Zzy+9+hMj0xw+eSjouSXBg
MBuQc6wUh9YHS8/bElFQtMVagbe0G4CRD75jaM/XKFtyo4fQDZvFQIqpPA9wBx2b
u8BU3+Ff15Kdp1U7UJtwFObpWFcfubxSx5uktcBQ6U8I1FFRgPIHEWvPCL3Afq87
iWIVswlr5AlvQXqEplPBd8IjFpW910KMDId0fh+Qzp/6xTslxKLqMHIQ/ZHD2IKu
DQR9ciJOGkn09kN54F2U4YyfzNkYSfTyeCRZI84eVDso0MT7n3o24mTOkr0rY04/
FLVdhy1zJ1meaLqk9GE/UYpgIwOzqTuOQ9xQ2OW8UGoObl2I4yxQfO3ajXJtvJmR
J6KdjeFqeXe5hMJCVhJL
=G+mP
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
