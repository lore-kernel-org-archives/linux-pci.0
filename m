Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:45070 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934693Ab3FUKZb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 06:25:31 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so3263300bkc.6
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2013 03:25:29 -0700 (PDT)
Date: Fri, 21 Jun 2013 12:25:27 +0200
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
Subject: Re: [PATCHv3 09/11] pci: mvebu: add support for MSI
Message-ID: <20130621102526.GG12441@manwe>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-10-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
In-Reply-To: <1371660979-21588-10-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 06:56:17PM +0200, Thomas Petazzoni wrote:
> This commit adds support for Message Signaled Interrupts in the
> Marvell PCIe host controller. The work is very simple: it simply gets
> a reference to the msi_chip associated to the PCIe controller thanks
> to the msi-parent DT property, and stores this reference in the
> pci_bus structure. This is enough to let the Linux PCI core use the
> functions of msi_chip to setup and teardown MSIs.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxCoWAAoJEN0jrNd/PrOhUTUP/idqAeuU8crEuXlyeAKEa6Va
K5RjXXo/caYCsp/Hfvd7LM6qGQWL3Sihu908dEC0nAJa+TM3V7dOBjixFWA3ejV4
flxY0ccfdqd+BXTRVg2gHrvywZmz+DuHvQhqInjpaK2h/GbBN/qih4dKtHbws15x
plpFs//2lYDW2GIpUObVTq3I3bMsH0Fo90WZayjB1YasGwolWer74KHEvhEOjW6q
HWwjNY34QGvBKyQKmVBuPBMJlI6OhRxIZBvh4JJNSEydwLv5XWDuoxB4OPuN5BQY
KK+KN+7RXC9U7o0t+Fj0MvRz7I3yzlrU5TKpsmXGOApE5SDvKqfQ+ykqer1l60LK
NnOnOf0PpC68jMT68lUw033hh6Pah5E12BezpmzZ8C7gQpCIjdE3NEujjnA7/UxP
xQJIsNGLgK2zCMEjCmUCKwYErjhl41ak+Wdmf+w7lZRIBnmkouZEY4GljWnOLK0y
U6kYLaGEPAHmUVSJcpV4Q1hBUswzXUSxcc2qBHDPRxbiJNLlFS1Y+vd1vLSvxJjY
Idsub6zHd3Gik/GQp/Kqfh8k+GA5LS0AzthcXEhhOX9nrAaSSK4B1SSNarJywMiX
n6RrfwMf1ZDVGh80GD6I7AXT/uFDHdm/ok+6NSgFrhFGZXAH7ELe4TKeiuI8rdNf
GvscNWkWetTO3ofcryxb
=pK6d
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--
