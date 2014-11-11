Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42000 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbaKKPqF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 10:46:05 -0500
Date: Tue, 11 Nov 2014 10:45:38 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	David Vrabel <david.vrabel@citrix.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/3] x86/xen: Introduce a global flag to fix the MSI mask
 bug
Message-ID: <20141111154538.GC6597@laptop.dumpdata.com>
References: <1414377878-23497-1-git-send-email-wangyijing@huawei.com>
 <1414377878-23497-2-git-send-email-wangyijing@huawei.com>
 <20141111000456.GB21470@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141111000456.GB21470@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 10, 2014 at 05:04:56PM -0700, Bjorn Helgaas wrote:
> On Mon, Oct 27, 2014 at 10:44:36AM +0800, Yijing Wang wrote:
> > Commit 0e4ccb1505a9 ("PCI: Add x86_msi.msi_mask_irq() and msix_mask_irq()")
> > fixed MSI mask bug which may cause kernel crash. But the commit
> > made MSI code complex. Introduce a new global flag "pci_msi_ignore_mask"
> > to ignore MSI/MSI-X to fix this issue, it's a cleaner solution.
> > And the commit 0e4ccb1505a9 will be reverted in the later patch.
> 
> The 0e4ccb1505a9 changelog says Xen guests can't write to MSI-X BARs.
> But it makes mask_irq a no-op for both MSI-X and MSI.  The MSI mask bit is
> in config space, not in memory space.  So why does mask_irq need to be a
> no-op for MSI as well?  Are Xen guests prohibited from writing to config

The PV guests it refers do not do write to config space. They have
an PCI frontend and backend driver which communicates to the backend (the
trusted domain) to setup the MSI and MSI-X. The 'pci_xen_init' (arch/x86/pci/xen.c)
is the one that sets up the overrides. When an MSI or MSI-X is requested
it is done via the request_irq which ends up calling 'xen_setup_msi_irqs'.
If you look there you can see:

173         if (type == PCI_CAP_ID_MSIX)                                            
174                 ret = xen_pci_frontend_enable_msix(dev, v, nvec);               
175         else                                                                    
176                 ret = xen_pci_frontend_enable_msi(dev, v);                      
177         if (ret)                                                                
178                 goto error;                                                     

Which are the calls to the Xen PCI driver to communicate with the
backend to setup the MSI.

> space, too?  (It's fine if they are; it's just that the changelog
> specifically mentioned MSI-X memory space tables, and it didn't mention
> config space at all.)

Correct. The config space is accessible to the guest but if it writes
to it - all of those values are ignored by the hypervisor - and that
is because the backend is suppose to communicate to the hypervisor
whether the guest can indeed setup MSI or MSI-X.

> 
> And I *assume* there's some Xen mechanism that accomplishes the mask_irq in
> a different way, since the actual mask_irq interface does nothing?  (This
> is really a question for 0e4ccb1505a9, since I don't think this particular
> patch changes anything in that respect.)

Correct. 'request_irq' ends up doing that. Or rather it ends up
calling xen_setup_msi_irqs which takes care of that.

The Xen PV guests (not to be confused with Xen HVM guests) run without
any emulated devices. That means most of the x86 platform things - ioports,
VGA, etc - are removed. Instead that functionality is provided via 
frontend drivers that communicate to the backend via a ring.

Hopefully this clarifies it?
> 
> > Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> > CC: David Vrabel <david.vrabel@citrix.com>
> > CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > CC: xen-devel@lists.xenproject.org
> > ---
> >  arch/x86/pci/xen.c  |    2 ++
> >  drivers/pci/msi.c   |    7 ++++++-
> >  include/linux/msi.h |    1 +
> >  3 files changed, 9 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> > index 093f5f4..5ef62ed 100644
> > --- a/arch/x86/pci/xen.c
> > +++ b/arch/x86/pci/xen.c
> > @@ -427,6 +427,7 @@ int __init pci_xen_init(void)
> >  	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
> >  	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
> >  	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
> > +	pci_msi_ignore_mask = 1;
> >  #endif
> >  	return 0;
> >  }
> > @@ -508,6 +509,7 @@ int __init pci_xen_initial_domain(void)
> >  	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
> >  	x86_msi.msi_mask_irq = xen_nop_msi_mask_irq;
> >  	x86_msi.msix_mask_irq = xen_nop_msix_mask_irq;
> > +	pci_msi_ignore_mask = 1;
> >  #endif
> >  	xen_setup_acpi_sci();
> >  	__acpi_register_gsi = acpi_register_gsi_xen;
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 38511d9..ecb5f54 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -23,6 +23,7 @@
> >  #include "pci.h"
> >  
> >  static int pci_msi_enable = 1;
> > +int pci_msi_ignore_mask;
> >  
> >  #define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
> >  
> > @@ -166,7 +167,7 @@ u32 default_msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
> >  {
> >  	u32 mask_bits = desc->masked;
> >  
> > -	if (!desc->msi_attrib.maskbit)
> > +	if (pci_msi_ignore_mask || !desc->msi_attrib.maskbit)
> >  		return 0;
> >  
> >  	mask_bits &= ~mask;
> > @@ -198,6 +199,10 @@ u32 default_msix_mask_irq(struct msi_desc *desc, u32 flag)
> >  	u32 mask_bits = desc->masked;
> >  	unsigned offset = desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE +
> >  						PCI_MSIX_ENTRY_VECTOR_CTRL;
> > +
> > +	if (pci_msi_ignore_mask)
> > +		return 0;
> > +
> >  	mask_bits &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
> >  	if (flag)
> >  		mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
> > diff --git a/include/linux/msi.h b/include/linux/msi.h
> > index 44f4746..86dc501 100644
> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -10,6 +10,7 @@ struct msi_msg {
> >  	u32	data;		/* 16 bits of msi message data */
> >  };
> >  
> > +extern int pci_msi_ignore_mask;
> >  /* Helper functions */
> >  struct irq_data;
> >  struct msi_desc;
> > -- 
> > 1.7.1
> > 
