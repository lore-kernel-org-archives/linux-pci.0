Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:53595 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935214AbdGTVuW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jul 2017 17:50:22 -0400
Date: Thu, 20 Jul 2017 15:34:21 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, keith.busch@intel.com,
        david.fugate@intel.com, bhelgaas@google.com
Subject: Re: [PATCH] PCI: vmd: Free up IRQs on suspend path
Message-ID: <20170720213420.lxllowcwnp24gmxf@sbauer-Z170X-UD5>
References: <20170720202858.1918-1-scott.bauer@intel.com>
 <cfc64209-82cb-432b-8ca1-c02c50d34d68@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cfc64209-82cb-432b-8ca1-c02c50d34d68@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 25, 2017 at 08:15:32PM -0600, Jon Derrick wrote:
> On 07/20/2017 02:28 PM, Scott Bauer wrote:
> > This patch frees up the IRQs we request on the suspend path,
> > and reallocates them on the resume path.
> > 
> > Fixes:
> > [  559.964386] CPU 111 disable failed: CPU has 9 vectors assigned and there are only 0 available.
> > [  559.966824] Error taking CPU111 down: -34
> > [  559.966825] Non-boot CPUs are not disabled
> > [  559.966826] Enabling non-boot CPUs ...
> > 
> > Signed-off-by: Scott Bauer <scott.bauer@intel.com>
> > ---
> >  drivers/pci/host/vmd.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> > index 6088c3083194..88bf0c754fb2 100644
> > --- a/drivers/pci/host/vmd.c
> > +++ b/drivers/pci/host/vmd.c
> > @@ -755,6 +755,11 @@ static void vmd_remove(struct pci_dev *dev)
> >  static int vmd_suspend(struct device *dev)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct vmd_dev *vmd = pci_get_drvdata(pdev);
> > +	int i;
> > +
> > +	for (i = 0; i < vmd->msix_count; i++)
> > +                devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
> >  
> >  	pci_save_state(pdev);
> >  	return 0;
> > @@ -763,7 +768,16 @@ static int vmd_suspend(struct device *dev)
> >  static int vmd_resume(struct device *dev)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct vmd_dev *vmd = pci_get_drvdata(pdev);
> > +	int err, i;
> >  
> > +	for (i = 0; i < vmd->msix_count; i++) {
> > +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
> > +				       vmd_irq, IRQF_NO_THREAD,
> The flag here looks redundant to me because the fn calls into
> request_threaded_irq with no thread_fn. But since it's a bit more
> verbose, can you change the other devm_request_irq to use IRQF_NO_THREAD?

I actually yanked the request irq from the other call. It was changed
to NO_THREAD in April:

(3eefa790c968) PCI: host: Mark PCIe/PCI (MSI) cascade ISR as IRQF_NO_THREAD
