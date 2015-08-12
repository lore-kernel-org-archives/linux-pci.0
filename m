Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35690 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932755AbbHLBZp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 21:25:45 -0400
Received: by pdrg1 with SMTP id g1so1250039pdr.2
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 18:25:45 -0700 (PDT)
Date: Wed, 12 Aug 2015 09:25:34 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] PCI: imx6: Mark the msi cascade handler
 IRQF_NO_THREAD
Message-ID: <20150812012534.GC30310@pek-khao-d1.corp.ad.wrs.com>
References: <1437715776-2243-1-git-send-email-haokexin@gmail.com>
 <1437715776-2243-2-git-send-email-haokexin@gmail.com>
 <20150810232615.GD13982@google.com>
 <20150811080352.GB30310@pek-khao-d1.corp.ad.wrs.com>
 <20150811200728.GE13982@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
In-Reply-To: <20150811200728.GE13982@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2015 at 03:07:28PM -0500, Bjorn Helgaas wrote:
> OK, you're going to have to help me out a bit.  There are too many
> dots here, and I can't get them all connected.
>=20
> Is it a general rule that handlers that call generic_handle_irq() must
> use IRQF_NO_THREAD?

Yes.

>  I'm trying to figure out how the writer of a
> driver like imx6 is supposed to know to use IRQF_NO_THREAD.
>=20
> This patch fixes an error in the driver, so the changelog should say
> exactly what the error is.  I don't completely understand the lockdep
> output, but I think this will be along the lines of:
>=20
>   Path A disables IRQs in F1 and acquires desc->lock in F2.
>   Path B acquires desc->lock in F3 with IRQs enabled.
>   Path B may be interrupted after acquiring desc->lock, and
>   we may deadlock if we try to acquire desc->lock again in path A.
>=20
> Can you sketch this out in the changelog, squash the other driver
> patches into this one, and post a v2?

Sure.

Thanks,
Kevin

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyqCOAAoJEJNY7TDerrFxivAH/2MZ2DHlsef+0JzMnSxpYdrL
BV+ueo1U+Aux9dZOapHqcO3uU/Zqnp9aJkVlE3Vqr32X6per+wKMiE5IcXY8u8KZ
gydqOVPmX+1egGyAJ0bFUAG8mo52eOhjzCPK0kN19XxCVefRSGTd+NVnQfubNJmE
+3Xn3N3PRenWDiEhe4ePc2T+phQRqFX6IGW70uH+RjXF48QhyKoU1KBBWd05aphC
8nBHc5ohrDrhi1QsJt9f0oroKcCwCEyWmaOAJcQCGqk/QBe6LgJpMWY93sf+WXUo
1ni/+b2BmNST9c0xQmckfG6DMsOLdmLEIxufy5AnQ1xMgFQRQESsQEhfGkuSuAY=
=EwbU
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
