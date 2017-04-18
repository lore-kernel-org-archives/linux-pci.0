Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932327AbdDRT0P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Apr 2017 15:26:15 -0400
Date: Tue, 18 Apr 2017 14:26:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [TRIVIAL PATCH] PCI: Change pci_host_common_probe visibility
Message-ID: <20170418192611.GG25295@bhelgaas-glaptop.roam.corp.google.com>
References: <11bd9bd5-5d96-bd7c-24c7-5f262a46085c@sigmadesigns.com>
 <b79fcb7f-1621-58e4-ef16-1df2911accbe@sigmadesigns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b79fcb7f-1621-58e4-ef16-1df2911accbe@sigmadesigns.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 10, 2017 at 02:26:42PM +0200, Marc Gonzalez wrote:
> On 28/03/2017 17:29, Marc Gonzalez wrote:
> 
> > pci_host_common_probe is defined when CONFIG_PCI_HOST_COMMON=y
> > therefore the function declaration should match that.
> > 
> > drivers/pci/host/pcie-tango.c:300:9: error:
> > 	implicit declaration of function 'pci_host_common_probe'
> > 
> > Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> > ---
> >  include/linux/pci-ecam.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> > index 33c4750781a0..e746803df566 100644
> > --- a/include/linux/pci-ecam.h
> > +++ b/include/linux/pci-ecam.h
> > @@ -60,7 +60,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
> >  /* default ECAM ops */
> >  extern struct pci_ecam_ops pci_generic_ecam_ops;
> >  
> > -#ifdef CONFIG_PCI_HOST_GENERIC
> > +#ifdef CONFIG_PCI_HOST_COMMON
> >  /* for DT-based PCI controllers that support ECAM */
> >  int pci_host_common_probe(struct platform_device *pdev,
> >  			  struct pci_ecam_ops *ops);
> > 
> 
> Hello Bjorn,
> 
> What is the status of this patch?
> 
> Arnd submitted an alternative patch earlier.
> 
> https://patchwork.kernel.org/patch/9637045/
> https://patchwork.kernel.org/patch/9649993/
> 
> Arnd's solution is to make the declaration always visible.
> My solution is to make the declaration visible only when
> CONFIG_PCI_HOST_COMMON is defined.
> 
> The difference boils down to getting an error
> at link-time VS at compile-time.

I applied this to pci/misc for v4.12, thanks!

Arnd's patch included:

  Fixes: 4e64dbe226e7 ("PCI: generic: Expose pci_host_common_probe() for use by other drivers")

which didn't look quite right to me.  I was originally hoping to merge
it for v4.11, but I didn't think I had quite the right justification
for that.

In any case, I like the idea of making the declaration visible in
exactly the same case the definition is visible.

Bjorn
