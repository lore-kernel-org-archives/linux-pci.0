Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:42067 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab3G2MbH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2013 08:31:07 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk14so356501bkc.29
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2013 05:31:05 -0700 (PDT)
Date: Mon, 29 Jul 2013 14:31:03 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv5 08/11] ARM: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
Message-ID: <20130729123102.GG23152@manwe>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130725165659.GB27802@dhcp-172-17-186-34.nvidia.com>
 <20130726224607.GZ24642@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
In-Reply-To: <20130726224607.GZ24642@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 11:46:07PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 25, 2013 at 09:57:00AM -0700, Thierry Reding wrote:
> > On Mon, Jul 15, 2013 at 01:52:44PM +0200, Thomas Petazzoni wrote:
> > > Some PCI drivers may need to adjust the pci_bus structure after it has
> > > been allocated by the Linux PCI core. The PCI core allows
> > > architectures to implement the pcibios_add_bus() and
> > > pcibios_remove_bus() for this purpose. This commit therefore extends
> > > the hw_pci and pci_sys_data structures of the ARM PCI core to allow
> > > PCI drivers to register ->add_bus() and ->remove_bus() in hw_pci,
> > > which will get called when a bus is added or removed from the system.
> > >=20
> > > This will be used for example by the Marvell PCIe driver to connect a
> > > particular PCI bus with its corresponding MSI chip to handle Message
> > > Signaled Interrupts.
> > >=20
> > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
> > > ---
> > >  arch/arm/include/asm/mach/pci.h |  4 ++++
> > >  arch/arm/kernel/bios32.c        | 16 ++++++++++++++++
> > >  2 files changed, 20 insertions(+)
> >=20
> > Hi Russell,
> >=20
> > Can we have your Acked-by on this patch so that it can be moved to a
> > stable branch along with some of the other patches in this branch that
> > both Marvell and Tegra PCIe drivers need?
>=20
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks, Russell.

Thierry

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9mCGAAoJEN0jrNd/PrOh/JwP/i1AyNoN+XWQ8C+p0i5UvV+g
YhK+LE0K0fxfPDF+e1P+jaIcsrR+eXppOjtfG/b4vk8wT5hNxVbtR8qCj0ropRSI
JVns7ufWwgiVd6MhunpxhuCCQzp7MPZ88dKjqtqC0vc3mgOxj52h+s5Vw0xMhRka
CZQiYKQF1ddXhti2WoOrAe3K5OzSAg0zTsu0dQNnRu4zxo613WLY928mv7kqIlwr
MitrpX0uCIM+SAaBU7E5VaYUSPSE2FLrahYFKfVQE/yxKLSb+VcZTgVdk/df/K2l
qdB+bydcuI/+/tysS2ykMG8p5bgB3VW508Pvbjohz/sBJjMlF7FjzrdHiX6MKGuo
YZdXx6dGVbSYIAOFaB0GStRJ/wNLe/5pD6K4M4etFc+iuzHl7Fkini8yexmZZwU1
xqI6spoLOnAh3w6VmRTD5wNBXYoB9E5ZNXDBSsFzOVcJ42bmJIDQsAzgACknmA6V
zXGxH872fO8AlPhorXynEtXWpyOr6gHXL2Mq6cXcKlkE4V50ldBz3t4Z8fY2r9H0
Z+NO06M0oBUEmfcDub4asl1kEBem45hMYu7meQ+iEEJ7SOtRUY85odnQTAvGcd8/
jYBe0wnzq91brTsawnzGnIhL2tBfZHW8meERFOu1bVYYTxQryEX0YZdnNMrdqdnG
HArj++Za0toWtxZylAUa
=SjFn
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--
