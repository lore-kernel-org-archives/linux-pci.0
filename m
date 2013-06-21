Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:53789 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3FUKXs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 06:23:48 -0400
Received: by mail-bk0-f45.google.com with SMTP id je9so3295732bkc.18
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2013 03:23:47 -0700 (PDT)
Date: Fri, 21 Jun 2013 12:23:44 +0200
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
Subject: Re: [PATCHv3 07/11] arm: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
Message-ID: <20130621102343.GE12441@manwe>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-8-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
In-Reply-To: <1371660979-21588-8-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 06:56:15PM +0200, Thomas Petazzoni wrote:
> Some PCI drivers may need to adjust the pci_bus structure after it has
> been allocated by the Linux PCI core. The PCI core allows
> architectures to implement the pcibios_add_bus() and
> pcibios_remove_bus() for this purpose. This commit therefore extends
> the hw_pci and pci_sys_data structures of the ARM PCI core to allow
> PCI drivers to register ->add_bus() and ->remove_bus() in hw_pci,
> which will get called when a bus is added or removed from the system.
>=20
> This will be used for example by the Marvell PCIe driver to connect a
> particular PCI bus with its corresponding MSI chip to handle Message
> Signaled Interrupts.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/include/asm/mach/pci.h |  4 ++++
>  arch/arm/kernel/bios32.c        | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxCmvAAoJEN0jrNd/PrOhtiwQAJjp2pfQqufQi2SHtQb4xWfq
ETq9psPScpduWrPCJeRq2XFZPeNoe7K9fXtwNnQoZ/JdWoA3zNSCekytoZ3QaQl1
buTE+gwNJqtQLAIJW87vJWTSIzuvYDs3G+LoD59ru3Nc50X2ue18gjG78wguAtb9
wTzTKOOIxUislS3nNfMyxbBqzRLMmj2HspEfSqGJ6JBmOxPFV/5bdZZkQgIj2IPh
GAPvtZZZneVCXMpMjxft0zM+eAjEgdtqYM/N/ySOU1bwi9uQ77QaNNeN3j9l1ctF
Jds8CS5kA8/MAlHiOHhT4U0ULv7s0kPFGZuiJJ/JqnPMLEyrQx/r/IWgNIN8zS52
m1YgUItHrx/++NLtzgCuAPOBeg1o1oGwkCTR5zpWba7Y4hCpBpqOEJsu41OS52p+
OovPJOqMm4YugAnE6aqfEfAwE2bdGxOX1VLL9eOBHDGwBn9yZF/RbikF9JuJTMMF
S89YN6soFoAS/j7EdFXXZnaEAS8HkMOxkYlEdTeErqQT836sX0QsP1G73rYzKKPk
FHJyPHZ5/Aszrw8EPAGUPmMeDr88WsnWTDwZ86T0+Dhbwno6G97SOiU0eIRVrHbL
XQmPBh4HmSk5uiBNaV2MpS/yAOtdvH3ZVrTJ42aPHeFBvzTX5Bg92TS4fxekphyH
VIZdLLJRgfzSyUaLlf2q
=f1ex
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
