Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:45692 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3FLKmo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2013 06:42:44 -0400
Received: by mail-bk0-f52.google.com with SMTP id d7so4035034bkh.39
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2013 03:42:43 -0700 (PDT)
Date: Wed, 12 Jun 2013 12:42:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support
Message-ID: <20130612104207.GE30841@mithrandir>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
In-Reply-To: <1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2013 at 06:41:24PM +0200, Thomas Petazzoni wrote:
[...]
> @@ -292,6 +454,8 @@ static int __init armada_370_xp_mpic_of_init(struct d=
evice_node *node,
> =20
>  #endif
> =20
> +	armada_370_xp_msi_init(node);
> +

So I see that you don't have access to the original platform device
here, but you could use of_find_device_by_node() to obtain it and pass
that into armada_370_xp_msi_init() in order to set the msi_chip.dev
field. Or you could do the lookup in armada_370_xp_msi_init() if you
don't need it for anything else in armada_370_xp_mpic_of_init().

Doing the above will also allow you to use devm_kzalloc() as Grant
suggested in his reply.

Thierry

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuFB/AAoJEN0jrNd/PrOhpz0P/0oc1AYHytXH3HOCEjJwxSZa
oqAL4SrUQu/OlGkj96Pd4vbF5daqjKu0CeuHq+tdXWM4itLQo3otaHT+xOqrGbuX
7gMagqwrnv0avpYdTm8Vn9Sswp1r6MFsQ+/FMEEriBr7LjZITeP1nJWEti16anNJ
JuXkNaquwrDlJRgbwMcJn8HJTxFxgvnFonMssQXSyiRWJr8PqObba0oGn3by+fI0
Ypm8RoHr6JqnRrkIdVM6fYk3eBSazpL6FXCqWh5VYp1Z0aKoi6HabTMfDXInLeh3
BSi3IvKaY2Gy9NpMXbjfY5bbJX0Ww3GY1M2HLElKHEyBzHEZnJ6GunfJPytK6KqT
1aKQXU8rc85jZHIGPXIwmr/SfzcLin/+UY4IrtIMCYvbqElogF6aNsi3q9Ab9ajp
dTSqPT9W5QrIl3+nKQx1Ysy3/qOCvynsH1sr9O3AGxfEaFiWY/SAKTh9pr18by+5
1yrvWLubE5PSbvi3UaVVzd8Lukruw2DQNczaGGzRHcWtYP/eBZYVIwRxUHhx3VHK
F4tFBZ3p1KLg0RECtypjre5eH+W7ndl9+OoLVnZCyLjsrk+rBxaB5bW0V66hFdz0
Ep1DpMwkKWmxje7uX8mwzepcy3ISa2XzdD+EOJJw1G4MwGv4CP+liF55lmOnTmh+
6GJofWd2RRqc/yhmK7/E
=tEyE
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
