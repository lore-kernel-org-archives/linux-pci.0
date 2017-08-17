Return-Path: <SRS0=lEde=7T=imgtec.com=Paul.Burton@kernel.org>
Return-Path: <SRS0=lEde=7T=imgtec.com=Paul.Burton@kernel.org>
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: kbuild test robot <fengguang.wu@intel.com>, <kbuild-all@01.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [pci:pci/host-xilinx 1/7] include/linux/pci-epf.h:53:25: error: field 'interrupt_pin' has incomplete type
Date: Thu, 17 Aug 2017 15:35:47 -0700
Message-ID: <1533328.JElFo5W3X3@np-p-burton>
In-Reply-To: <20170816165243.GB28977@bhelgaas-glaptop.roam.corp.google.com>
References: <201708160641.ZKA3UsJg%fengguang.wu@intel.com> <20170816165243.GB28977@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart100201832.njOBehVrue";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-pci.vger.kernel.org>

--nextPart100201832.njOBehVrue
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Bjorn,

On Wednesday, 16 August 2017 09:52:43 PDT Bjorn Helgaas wrote:
> On Wed, Aug 16, 2017 at 06:11:45AM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> > pci/host-xilinx head:   95b008920fd38e828a37c8a7131b449d33ba03b9
> > commit: 13ff772beae556a664c029d5d75eaf7f3c104258 [1/7] PCI: Move enum
> > pci_interrupt_pin to linux/pci.h config: blackfin-allyesconfig (attached
> > as .config)
> > compiler: bfin-uclinux-gcc (GCC) 6.2.0
> > 
> > reproduce:
> >         wget
> >         https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/mak
> >         e.cross -O ~/bin/make.cross chmod +x ~/bin/make.cross
> >         git checkout 13ff772beae556a664c029d5d75eaf7f3c104258
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=blackfin
> > 
> > All error/warnings (new ones prefixed by >>):
> >    In file included from include/linux/pci-epc.h:15:0,
> >    
> >                     from drivers/pci/endpoint/pci-ep-cfs.c:23:
> > >> include/linux/pci-epf.h:53:25: error: field 'interrupt_pin' has
> > >> incomplete type> >> 
> >      enum pci_interrupt_pin interrupt_pin;
> 
> I think the problem with this (and the similar m68k report) is that
> enum pci_interrupt_pin was originally defined unconditionally in
> include/linux/pci-epf.h, but after "PCI: Move enum pci_interrupt_pin
> to linux/pci.h", it was defined in include/linux/pci.h under #ifdef
> CONFIG_PCI.  Neither this blackfin config nor the m68k config defines
> CONFIG_PCI.
> 
> CONFIG_PCI enables the host side of the PCI core, e.g., host bridge
> infrastructure, device enumeration, etc.  It is possible to build
> endpoint support without that, and pci_interrupt_pin is still useful
> there.
> 
> I reworked the patch to define enum pci_interrupt_pin outside the
> #ifdef CONFIG_PCI.
> 
> Bjorn

Thanks for fixing that up :)

Paul
--nextPart100201832.njOBehVrue
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmWGkMACgkQgiDZ+mk8
HGXNxw//VwUThzGMd2V0/cz70AvE+6wr2oBmSfMSdFtW6/r0hDflA+I/V9iN2IEx
svZe13eZRQ5JCXBtxSKeupk+v4nPYrDVsvnp5KrYk+iw9DfHqkIOI2JseG/b3h/r
KwTBWA5XY4puXhK5kjL7rOQDr0dO3FJewtEjckL/0YbSXTZ5+6SZ9ccrvL7hhIvb
v6emFniKzDk7g6uQOmBjzcWdtMfKSqC/JbTNCwZcrdZj1z4YD/sX+BELfB0BeNdn
h8flmxFOmFuwGorbY9AjYPODjntn+O7B588KtXfDHdktjjbyWH8JfBzGNB/9nnB0
EEbIwgio1UQIMeNnzTEI3/PaPv1vtQq4mW6adNNQxG0gWtD7DODp22Kh6qYTf3Ml
ggY0kM4sSUtcTAQeNxd6zuSknqAwp7hQx9xhj4WhPNZU6kWtUc5B5BNeHqxSoSb4
vSRBbCKqNTK7iAQQ+S1FrHUFxjy0T47fXqdtk/+/+RpUeWltXiqcLml40CPFAKuV
efvKYxNXvqrUWgqDarL1raeEuM+2faP1juk57xE+vpmXunfZDBgPxcMQUdwUSkc4
X4xpwL9Adn7FN+hHuzqapTqK1pRQtgHZjXYPk/wcCdRlrxX7cqzddRFHW0LAPUR9
aHC6E4rKiRUvNUQJ0JBLhlI5BWldQDzfbKUMj19bTlnv47s//jw=
=CwCc
-----END PGP SIGNATURE-----

--nextPart100201832.njOBehVrue--
