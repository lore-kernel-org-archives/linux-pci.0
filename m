Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:59054 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030482Ab3FTS5M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2013 14:57:12 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik8so3086589bkc.9
        for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2013 11:57:11 -0700 (PDT)
Date: Thu, 20 Jun 2013 20:57:08 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCHv3 02/11] pci: use weak functions for MSI arch-specific
 functions
Message-ID: <20130620185707.GA8888@mithrandir>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 06:56:10PM +0200, Thomas Petazzoni wrote:
[...]
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 2c10752..4bc0c8f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -30,19 +30,35 @@ static int pci_msi_enable =3D 1;
> =20
>  /* Arch hooks */
> =20
> -#ifndef arch_msi_check_device
> -int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> +int default_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +{
> +	return -EINVAL;
> +}
> +
> +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +{
> +	return default_setup_msi_irq(dev, desc);
> +}
> +
> +void default_teardown_msi_irq(unsigned int irq)
> +{
> +}
> +
> +void __weak arch_teardown_msi_irq(unsigned int irq)
> +{
> +	return default_teardown_msi_irq(irq);
> +}
> +
> +int default_msi_check_device(struct pci_dev *dev, int nvec, int type)
>  {
>  	return 0;
>  }
> -#endif

I don't think keeping the default_*() for these three is necessary,
given that they don't do anything and therefore no architecture is
likely to call them when overriding.

Thierry

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRw1CCAAoJEN0jrNd/PrOh/5cP/RMt2Nl6st3Tjx863jrl8F1Y
vJt44uOdPmwALHxy8hzkXnGKoMcSUnlqMkVlKHejAgbvyaI8eE7IX/zYCaLw4Cwm
zg0zk13iuzXhY5qeeVCWeIcFZPm+uWHQHMcZPStHEf4toIESQdlzvCbHc2xAbBA4
JZG6FmfSckfbOFDThgwtppW7YqyhnAicRZm20kQSZbVoVhBykAS5frb+wBy9t+w4
sl84yqMO67MtQCLt2Zv2Kqa+rCXeRogJ7U0MNxX6YnbOPsIxcBYuWw8Pe6fWpNzc
1O8jwxtpPrEkjB+KuENhSjbJJ/40FN0tuDzAYfQw4nD6qmoo1+ut9VnakdfIA93F
3oyH+wUMvyxSQ1vU9EK7n+WVEyvHbAjSh4MjRMgvEZQY8KROnjIl/H2OgtmoPYXc
o/x7EprrhycgQBUz9gDsISrcM9WtnnX/lRECDXhCWWjkWmD56mI+sI7f5Mzv5Vcb
puPV6G06k5x4EofqwTQfrJQkKoq+ZnB3MFA1Pj3mekzkuPZTU3QVSmdFCRRgB2dG
MqLiYu7Y8SCRLvrsw4jhpK/m50lTOuWjSUnNtrO8pfWBba1WJHlHbM5bW3iBxhIT
PdPKQZeHfCwN/Ej6bS9rUfNdEgwyDS9WXiYAGFq5Icu3OfrxMXj2Fr848f3yZqZp
rwYybOeQWE82g+sb3t0C
=lPX3
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
