Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51508 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933156AbbESP0s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 May 2015 11:26:48 -0400
Date: Tue, 19 May 2015 17:26:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [RFC 2/4] PCI, MSI: Optionally free legacy PCI IRQ when enabling
 MSI/MSI-X
Message-ID: <20150519172534-mutt-send-email-mst@redhat.com>
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com>
 <1430968374-29286-3-git-send-email-jiang.liu@linux.intel.com>
 <20150519150838.GQ31666@google.com>
 <20150519171518-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150519171518-mutt-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 19, 2015 at 05:16:54PM +0200, Michael S. Tsirkin wrote:
> On Tue, May 19, 2015 at 10:08:38AM -0500, Bjorn Helgaas wrote:
> > [+cc Michael]
> > 
> > On Thu, May 07, 2015 at 11:12:52AM +0800, Jiang Liu wrote:
> > > Once PCI MSI/MSI-X is enabled by the device driver, PCI device won't
> > > make use of legacy PCI IRQ until PCI MSI/MSI-X is disabled again.
> > > So optionally free legacy PCI IRQ when enabling MSI/MSI-X and reallocate
> > > when disabling MSI/MSI-X.
> > > 
> > > Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> > > ---
> > >  drivers/pci/msi.c |    6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > index c3e7dfcf9ff5..47cf72c669f0 100644
> > > --- a/drivers/pci/msi.c
> > > +++ b/drivers/pci/msi.c
> > > @@ -686,6 +686,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
> > >  	msi_set_enable(dev, 1);
> > >  	dev->msi_enabled = 1;
> > >  
> > > +	pcibios_free_irq(dev);
> > 
> > >From the recent discussion about disabling MSI at shutdown, I seem to
> > recall that turning off bus mastering also effectively disables MSI and
> > causes at least some devices to revert to using INTx.

So to stress this point, turning off bus mastering also effectively
disables MSI without making devices revert to using INTx.
This is why clearing bus master is the right thing to do
if you don't want any interrupts at all.


> > So with this patch, do we now have a problem in the following scenario?
> 
> Can't say, I didn't follow the discussion. But I'll address the
> comment below:
> 
> >     pci_enable_msi(dev);	/* now frees INTx IRQ */
> >     pci_clear_master(dev);
> >     <device interrupts>		/* uses INTx since bus mastering disabled */
> 
> Not really, this does not use INTx. Disabling bus master shuts down MSI
> but does not enable INTx, you effectively get no interrupts at all: MSI
> disabled INTx and bus master disabled MSI.
> 
> 
> > >  	dev->irq = entry->irq;
> > >  	return 0;
> > >  }
> > > @@ -813,9 +814,10 @@ static int msix_capability_init(struct pci_dev *dev,
> > >  	/* Set MSI-X enabled bits and unmask the function */
> > >  	pci_intx_for_msi(dev, 0);
> > >  	dev->msix_enabled = 1;
> > > -
> > >  	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
> > >  
> > > +	pcibios_free_irq(dev);
> > > +
> > >  	return 0;
> > >  
> > >  out_avail:
> > > @@ -930,6 +932,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
> > >  
> > >  	/* Restore dev->irq to its default pin-assertion irq */
> > >  	dev->irq = desc->msi_attrib.default_irq;
> > > +	pcibios_alloc_irq(dev);
> > >  }
> > >  
> > >  void pci_disable_msi(struct pci_dev *dev)
> > > @@ -1030,6 +1033,7 @@ void pci_msix_shutdown(struct pci_dev *dev)
> > >  	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> > >  	pci_intx_for_msi(dev, 1);
> > >  	dev->msix_enabled = 0;
> > > +	pcibios_alloc_irq(dev);
> > >  }
> > >  
> > >  void pci_disable_msix(struct pci_dev *dev)
> > > -- 
> > > 1.7.10.4
> > > 
