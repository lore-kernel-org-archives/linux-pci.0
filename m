Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932976AbeEWNst (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 May 2018 09:48:49 -0400
Date: Wed, 23 May 2018 08:48:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: James Hogan <jhogan@kernel.org>
Cc: linux-pci@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MIPS: PCI: Use dev_printk() when possible
Message-ID: <20180523134847.GB150632@bhelgaas-glaptop.roam.corp.google.com>
References: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152699470263.162686.16975145205315900817.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180523081447.GA15645@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523081447.GA15645@jamesdev>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2018 at 09:14:48AM +0100, James Hogan wrote:
> On Tue, May 22, 2018 at 08:11:42AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Use the pci_info() and pci_err() wrappers for dev_printk() when possible.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  arch/mips/pci/pci-legacy.c |    7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> > index 0c65c38e05d6..73643e80f02d 100644
> > --- a/arch/mips/pci/pci-legacy.c
> > +++ b/arch/mips/pci/pci-legacy.c
> > @@ -263,9 +263,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
> >  				(!(r->flags & IORESOURCE_ROM_ENABLE)))
> >  			continue;
> >  		if (!r->start && r->end) {
> > -			printk(KERN_ERR "PCI: Device %s not available "
> > -			       "because of resource collisions\n",
> > -			       pci_name(dev));
> > +			pci_err(dev, "can't enable device: resource collisions\n");
> 
> The pedantic side of me wants to point out that you could wrap that line
> after the comma to keep it within 80 columns.

Done, thanks!

> Either way though:
> Acked-by: James Hogan <jhogan@kernel.org>
> 
> Cheers
> James
