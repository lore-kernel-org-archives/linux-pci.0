Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50310 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbbJ2MiE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 08:38:04 -0400
Date: Thu, 29 Oct 2015 13:37:55 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Message-ID: <20151029123755.GC2351@katana>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
In-Reply-To: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Fixes and changes to get PCIe working on ARM64 with mulitple instances.

> I've tested these on ARM (Koelsch board), and it works fine.
> I've also tested on ARM64 (Salvator-X board), but I currently have an issue

I wanted to test these patches on arm64 as well, but even after merging
pci-next, I still get:

drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_setup':
drivers/pci/host/pcie-rcar.c:380:4: error: implicit declaration of function 'pci_ioremap_io' [-Werror=implicit-function-declaration]

So, what do I miss?

> with inbound PCI accesses. I am reasonably sure that this problem is hardware
> related.

Any news if this is really HW related?

Thanks,

   Wolfram


--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMhMjAAoJEBQN5MwUoCm2oAYQAIHPhVSAZD5qIKRRl8Aa7rtv
vN6/V3/CfZsgHYmfpcb/luW8O+Nc3AN0xqgN6kOpHjvd5e62BKJ1WsU5g3k8gh8G
HT4mxsw5Fga+McNoGr4XN0qCbZzBluzVc8ZjAb7HBax8AGtRgXNC2TgDvRo/ckth
V7dAb6U3fl5feQCoXznD/S2qBjUJzi9IkpLfjL2zDf28HRgmYFC0miF8PdCvLx+x
16+WOZBtS2v3Wyh+IpppLW/36Uym/Ye3BuEnK5W4RNyDkjUjGeQl6xk2K3JqH+lN
slUflW1G0gaWevAst8DUx3qYIgDzauo+mxMMY8bz1wix5PWdeZVJLrP89SGuSpmG
yZHp/zS6+lNpErqypSr71lmhH1EIZ2ohj1d2xDClDAgP+9vVMumulbM4TMWyHMXI
wwFnj94jFIaC5fDuQxljZHC8SuATouuiSpThDVt3JI+SfqjwFbaUxKfSKhq07l3u
QgrAeC75gE7T6ekHSeJTmZqEMe93LpsUJ+L4KzI9r6QTCDioIvFDrsaRgR7ssATZ
7QtR9XE3vfiUqhfjdf1OoEilEghoV/MNV59d812kO0RKbj4CvUzwjPM3Bi9lMHzP
XzLeGCaN5qqYypUZYCmCBnIjHpREEYhmR7CmDn8Yuw/QmOmmK8iqqsBiqqP5NHFa
mYZWeenPaRTVZb7WAeuE
=dTwf
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
