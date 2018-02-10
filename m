Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbeBJUvX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Feb 2018 15:51:23 -0500
Date: Sat, 10 Feb 2018 14:51:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH kernel v3] powerpc/pci: Fix broken INTx configuration via
 OF
Message-ID: <20180210205118.GG206223@bhelgaas-glaptop.roam.corp.google.com>
References: <20180209062358.33457-1-aik@ozlabs.ru>
 <20180209180741.GB206223@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180209180741.GB206223@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 09, 2018 at 12:07:41PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 09, 2018 at 05:23:58PM +1100, Alexey Kardashevskiy wrote:
> > Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
> > replaced of_irq_parse_pci() + irq_create_of_mapping() with
> > of_irq_parse_and_map_pci() but this change lost virq returned by
> > irq_create_of_mapping() so virq remained zero causing INTx
> > misconfiguration.
> > 
> > This fixes pci_read_irq_line() not to loose a virq returned by
> > of_irq_parse_and_map_pci().
> 
> s/not to loose a/to not lose the/
> 
> > Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> I'm fine with this version.
> 
> Since you started applying a previous version, Michael, I'll assume
> you will handle this unless you tell me otherwise.  One way or another
> it would be good to get this in before -rc1.

I went ahead and applied this and asked Linus to pull it.

> > ---
> > Changes:
> > v3:
> > * change virq from unsigned to int as of_irq_parse_and_map_pci returns int
> > and even though it only returns non-negative values now, this may change
> > in the future
> > 
> > v2:
> > * changed the condition from <=0 to !=0 as by design
> > of_irq_parse_and_map_pci() can only return 0 for an error and virq>0.
> > ---
> >  arch/powerpc/kernel/pci-common.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index ae2ede4..446c796 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -362,7 +362,7 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
> >   */
> >  static int pci_read_irq_line(struct pci_dev *pci_dev)
> >  {
> > -	unsigned int virq = 0;
> > +	int virq;
> >  
> >  	pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
> >  
> > @@ -370,7 +370,8 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
> >  	memset(&oirq, 0xff, sizeof(oirq));
> >  #endif
> >  	/* Try to get a mapping from the device-tree */
> > -	if (!of_irq_parse_and_map_pci(pci_dev, 0, 0)) {
> > +	virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
> > +	if (virq <= 0) {
> >  		u8 line, pin;
> >  
> >  		/* If that fails, lets fallback to what is in the config
> > -- 
> > 2.11.0
> > 
