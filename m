Return-Path: <SRS0=6IA2=A2=nic.cz=marek.behun@kernel.org>
Return-Path: <SRS0=6IA2=A2=nic.cz=marek.behun@kernel.org>
Date: Mon, 25 Sep 2017 10:47:45 +0200
From: Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: aardvark pci controller ath9k request_irq fail
Message-ID: <20170925104745.3d029615@dellmb.labs.office.nic.cz>
In-Reply-To: <20170922134401.GA5207@red-moon>
References: <20170922132444.588e27cb@dellmb.labs.office.nic.cz>
	<20170922133515.GA12546@bhelgaas-glaptop.roam.corp.google.com>
	<20170922134401.GA5207@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <linux-pci.vger.kernel.org>

Hello guys, the patch helped. Thanks :)

Marek

On Fri, 22 Sep 2017 14:44:01 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Fri, Sep 22, 2017 at 08:35:15AM -0500, Bjorn Helgaas wrote:
> > [+cc Thomas (aardvark maintainer), Lorenzo]
> >=20
> > On Fri, Sep 22, 2017 at 01:24:44PM +0200, Marek Beh=FAn wrote: =20
> > > Hello,
> > > we are developing a new board based on Marvell Armada 3720.
> > > While testing the PCI-e slot, I have enountered this problem:
> > >=20
> > > - lspci always correctly prints information about the PCIe card
> > > in the slot
> > > - when a ath9k card is in the slot, ath9k fails to initialize with
> > >      ath9k 0000:00:00.0: request_irq failed
> > >=20
> > >   The irq number passed to the request_irq function is from the
> > > irq member of struct pci_dev:
> > >      request_irq(pdev->irq, ath_isr, IRQF_SHARED, "ath9k", sc);
> > >=20
> > >   this number (pdev->irq) is 255
> > >=20
> > >   The request_irq function fails in request_threaded_irq on line:
> > >      desc =3D irq_to_desc(irq);
> > >   (desc is NULL and thus -EINVAL is returned.)
> > >=20
> > > - what is strange is that another card, Intel Centrino Ultimate-N
> > > 6300 with iwlwifi works.
> > >=20
> > > - another card (ath10k driver) also does not work.
> > >=20
> > > Is this a problem with the pci-aardvark driver for the Aardvark
> > > controller? =20
> >=20
> > What kernel version are you using?  Has any kernel version worked
> > correctly?  There have been significant IRQ mapping changes in the
> > last couple releases.
> >=20
> > dev->irq should be assigned in pci_assign_irq().  Can you turn on
> > the debug there (and maybe add more) and collect the complete dmesg
> > log? =20
>=20
> It is very likely this will fix it:
>=20
> https://patchwork.ozlabs.org/patch/811432/
>=20
> Apologies to you and Thomas again - I went through a number of changes
> and mechanically missed pci-aardvark.
>=20
> Thanks,
> Lorenzo
