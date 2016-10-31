Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:17385 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943100AbcJaNnv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Oct 2016 09:43:51 -0400
Date: Mon, 31 Oct 2016 09:54:41 -0400
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 3/3] pci/msix: Skip disabling removed devices
Message-ID: <20161031135440.GA10069@localhost.localdomain>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <1477695497-6207-4-git-send-email-keith.busch@intel.com>
 <20161031110040.GA9693@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161031110040.GA9693@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 31, 2016 at 12:00:40PM +0100, Lukas Wunner wrote:
> On Fri, Oct 28, 2016 at 06:58:17PM -0400, Keith Busch wrote:
> > There is no need to disable MSIx interrupts or write message data on a
> > device that isn't present. This patch checks the device removed state
> > prior to executing device shutdown operations so that tear down on
> > removed devices completes quicker.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/pci/msi.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index bfdd074..9249ec1 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -317,7 +317,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
> >  {
> >  	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
> >  
> > -	if (dev->current_state != PCI_D0) {
> > +	if (dev->current_state != PCI_D0 || dev->is_removed) {
> >  		/* Don't touch the hardware now */
> >  	} else if (entry->msi_attrib.is_msix) {
> >  		void __iomem *base = pci_msix_desc_addr(entry);
> 
> Hm, I don't see __pci_write_msi_msg() being called anywhere on device
> removal.  Am I missing something?  Rest of the patch LGTM.

Prior to calling pci_disable_msix as part of typical driver unbinding,
the driver needs to call free_irq for every registerded action. That
will get to this __pci_write_msi_msg when it tries to mask the vector.
