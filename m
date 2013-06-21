Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:39327 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3FUKYu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 06:24:50 -0400
Received: by mail-bk0-f52.google.com with SMTP id d7so3267097bkh.39
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2013 03:24:49 -0700 (PDT)
Date: Fri, 21 Jun 2013 12:24:46 +0200
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
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv3 08/11] arm: mvebu: the MPIC now provides MSI controller
 features
Message-ID: <20130621102445.GF12441@manwe>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-9-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
In-Reply-To: <1371660979-21588-9-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 06:56:16PM +0200, Thomas Petazzoni wrote:
> Adds the 'msi-controller' property to the main interrupt controller
> Device Tree node, to indicate that it can now behave as a MSI
> controller.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxCntAAoJEN0jrNd/PrOhRrQP/0vmPJoVefkWfpwqqW6tycXp
juZmzKh64n4HteohJpvy0ML2jP81SCsm+HhGhz+Plxo9lyr/tSNnVVl6Lj9pUvjD
uNAzB1ESBh+K179AqjtAQl3zgSoUU91q+xInKNmccLiv+yYXVJMSN0oGvh1zrO20
ztfNQwc7wOo+iAcl8BExqWrGF8JIVA+Ocsbyzj9pD3PVie/hX19HQ5/rgh+JS6rz
cyX4n5Ypj5Zcn7dcmOMPIMCRHrvMnxTa5UvTyNlwR2sjIfBUlq3qE4pSO4wmJmm5
MOPrdVTMzO6lCiwJdBf987JAGnRT+6XIZIEs+xRC3DO8ZKLqsKvmkMjqDxikmgyg
UI+bzIU3KfM1YVA+ZqwqaRfq9ncEgY5sp0LqZzTcfznA/Thu/sW33wk+tX8R/MP0
CXQoNfmKGxRZR1o/sU7Ua1Oxe2Pt06B2sfqZswAVvQiXz5wyKbrJ3wEJuzpATjyO
Ce2vpoolGh3G1FnuMeZgi2SMx3GWztH0JQtAmltWtb5h3qkQXHe3z8oIV/Bp9V7U
S30oQxgWJZaEdvMXHnK37RqJhoIRe5qBj/ad+jvT+Iz/tOV9ujLOzw0Y0po751Id
myHkYp7KHxD9dpKM1ywRRCkAFGdVatkn8B06qzVRHxHlpiyGJ43/aiGvZ7KDR77/
f5jmI1yNAXZ9NYeZHulf
=0Daz
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
