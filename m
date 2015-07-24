Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33733 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbbGXITa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2015 04:19:30 -0400
Received: by pdbnt7 with SMTP id nt7so10269068pdb.0
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2015 01:19:29 -0700 (PDT)
Date: Fri, 24 Jul 2015 16:19:17 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Richard Zhu <Richard.Zhu@freescale.com>
Subject: Re: [PATCH 1/4] PCI: imx6: Mark the msi cascade handler
 IRQF_NO_THREAD
Message-ID: <20150724081917.GC29472@pek-khao-d1.corp.ad.wrs.com>
References: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
 <1437715776-2243-2-git-send-email-haokexin@gmail.com>
 <1437724859.3071.40.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
In-Reply-To: <1437724859.3071.40.camel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2015 at 10:00:59AM +0200, Lucas Stach wrote:
> Hi Kevin,
>=20
> Am Freitag, den 24.07.2015, 13:29 +0800 schrieb Kevin Hao:
> > The cascade handler must run in hard interrupt context, otherwise
> > it will cause the following kernel warning if we force threading
> > of all the interrupt handlers via kernel command parameter
> > "threadirqs":
>=20
> The change looks good, but there are a few other designware drivers that
> use the same logic to trigger the cascaded MSI handler. Can you please
> make sure to change them, too?

I have made the same change for the following drivers:
Kevin Hao (4):
  PCI: imx6: Mark the msi cascade handler IRQF_NO_THREAD
  PCI: dra7xx: Mark the msi cascade handler IRQF_NO_THREAD
  PCI: exynos: Mark the msi cascade handler IRQF_NO_THREAD
  PCI: spear: Mark the msi cascade handler IRQF_NO_THREAD

 drivers/pci/host/pci-dra7xx.c     | 3 ++-
 drivers/pci/host/pci-exynos.c     | 3 ++-
 drivers/pci/host/pci-imx6.c       | 3 ++-
 drivers/pci/host/pcie-spear13xx.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

Did I miss something?

Thanks,
Kevin

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVsfUFAAoJEJNY7TDerrFxHbgH/2mjO6nqswZBvPQFrS+phqWS
j9B+lQ1gJiWrvmbhsJxMuaZ6RF7KDSwzjhRb2SXesvrVQoaKhH7m0CyLi4jPwgkO
A01gv3qPrj5aMkSYUpjXvrWdJjFDZTxKLgqZsRU1AqKigu6Wl5o4Oo4d0h0wOqLL
kTcuIUtt62gneAuha9tlb5J3UTWhtjc4WBFc4Qb8RnNzUSk0YxuxxSjzzQJfgapS
cT7gZkQ7K5P8FuPbCqNcFUW9L04UdP/ZV2BeA3sWTBhyl3bAguyaWG3eYgop7VnY
8Q0wiKhVflQU/JGuPIH6xLKDMqqqJI/KVdub68ZlDo/cF+GjxcEVxT9SpRncb7I=
=Cejr
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
