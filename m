Return-Path: <SRS0=f3i4=7Q=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=f3i4=7Q=intel.com=keith.busch@kernel.org>
Date: Mon, 14 Aug 2017 14:15:47 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Scott Bauer <scott.bauer@intel.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, jonathan.derrick@intel.com
Subject: Re: [PATCH] PCI: vmd: Free up IRQs on suspend path
Message-ID: <20170814181547.GF7233@localhost.localdomain>
References: <20170811205432.29612-1-scott.bauer@intel.com>
 <20170814180652.GA32525@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170814180652.GA32525@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 14, 2017 at 01:06:52PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 11, 2017 at 02:54:32PM -0600, Scott Bauer wrote:
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
> 
> Keith acked the previous version (which contained the enable/disable),
> but since this is different, I'll wait for his ack again.

Thanks for checking. This is actually the patch that was intended for
submission.

Acked-by: Keith Busch <keith.busch@intel.com>
 
> > ---
> >  drivers/pci/host/vmd.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> > index 7e967a8784b2..4fe1756af010 100644
> > --- a/drivers/pci/host/vmd.c
> > +++ b/drivers/pci/host/vmd.c
> > @@ -763,6 +763,11 @@ static void vmd_remove(struct pci_dev *dev)
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
> > @@ -771,6 +776,16 @@ static int vmd_suspend(struct device *dev)
> >  static int vmd_resume(struct device *dev)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> > +	struct vmd_dev *vmd = pci_get_drvdata(pdev);
> > +	int err, i;
> > +
> > +	for (i = 0; i < vmd->msix_count; i++) {
> > +		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
> > +				       vmd_irq, IRQF_NO_THREAD,
> > +				       "vmd", &vmd->irqs[i]);
> > +		if (err)
> > +			return err;
> > +	}
> >  
> >  	pci_restore_state(pdev);
> >  	return 0;
> > -- 
> > 2.11.0
> > 
