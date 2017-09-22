Return-Path: <SRS0=+Syg=AX=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=+Syg=AX=arm.com=lorenzo.pieralisi@kernel.org>
Date: Fri, 22 Sep 2017 14:44:01 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
	linux-pci@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: aardvark pci controller ath9k request_irq fail
Message-ID: <20170922134401.GA5207@red-moon>
References: <20170922132444.588e27cb@dellmb.labs.office.nic.cz>
 <20170922133515.GA12546@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170922133515.GA12546@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 22, 2017 at 08:35:15AM -0500, Bjorn Helgaas wrote:
> [+cc Thomas (aardvark maintainer), Lorenzo]
> 
> On Fri, Sep 22, 2017 at 01:24:44PM +0200, Marek Behún wrote:
> > Hello,
> > we are developing a new board based on Marvell Armada 3720.
> > While testing the PCI-e slot, I have enountered this problem:
> > 
> > - lspci always correctly prints information about the PCIe card in the
> >   slot
> > - when a ath9k card is in the slot, ath9k fails to initialize with
> >      ath9k 0000:00:00.0: request_irq failed
> > 
> >   The irq number passed to the request_irq function is from the irq
> >   member of struct pci_dev:
> >      request_irq(pdev->irq, ath_isr, IRQF_SHARED, "ath9k", sc);
> > 
> >   this number (pdev->irq) is 255
> > 
> >   The request_irq function fails in request_threaded_irq on line:
> >      desc = irq_to_desc(irq);
> >   (desc is NULL and thus -EINVAL is returned.)
> > 
> > - what is strange is that another card, Intel Centrino Ultimate-N 6300
> >   with iwlwifi works.
> > 
> > - another card (ath10k driver) also does not work.
> > 
> > Is this a problem with the pci-aardvark driver for the Aardvark
> > controller?
> 
> What kernel version are you using?  Has any kernel version worked
> correctly?  There have been significant IRQ mapping changes in the
> last couple releases.
> 
> dev->irq should be assigned in pci_assign_irq().  Can you turn on the
> debug there (and maybe add more) and collect the complete dmesg log?

It is very likely this will fix it:

https://patchwork.ozlabs.org/patch/811432/

Apologies to you and Thomas again - I went through a number of changes
and mechanically missed pci-aardvark.

Thanks,
Lorenzo
