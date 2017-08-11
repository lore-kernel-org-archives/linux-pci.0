Return-Path: <SRS0=sgHu=7N=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=sgHu=7N=intel.com=keith.busch@kernel.org>
Date: Fri, 11 Aug 2017 15:32:50 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Scott Bauer <scott.bauer@intel.com>, linux-pci@vger.kernel.org,
	jonathan.derrick@intel.com, david.fugate@intel.com,
	bhelgaas@google.com
Subject: Re: [RESEND] PCI: vmd: Free up IRQs on suspend path
Message-ID: <20170811193250.GD7233@localhost.localdomain>
References: <20170811180949.26923-1-scott.bauer@intel.com>
 <20170811184924.GE17039@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170811184924.GE17039@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 11, 2017 at 01:49:24PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 11, 2017 at 12:09:49PM -0600, Scott Bauer wrote:
> > This patch frees up the IRQs we request on the suspend path,
> > and reallocates them on the resume path.
> > 
> > Fixes:
> > [  559.964386] CPU 111 disable failed: CPU has 9 vectors assigned and there are only 0 available.
> > [  559.966824] Error taking CPU111 down: -34
> > [  559.966825] Non-boot CPUs are not disabled
> > [  559.966826] Enabling non-boot CPUs ...
> 
> From the "RESEND", I assume this is identical to the original posting.
> 
> I disposed of the original as "changes requested" because of Jon's
> comments.  Keith subsequently chimed in saying he thought it was OK
> as-is.  Keith, can I convert that to a formal ack from you?

Yes, I'm okay with this patch.

Acked-by: Keith Busch <keith.busch@intel.com>

 
> > Signed-off-by: Scott Bauer <scott.bauer@intel.com>
> > ---
> >  drivers/pci/host/vmd.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> > index 7e967a8784b2..ac643a3d0bf3 100644
> > --- a/drivers/pci/host/vmd.c
> > +++ b/drivers/pci/host/vmd.c
> > @@ -763,15 +763,32 @@ static void vmd_remove(struct pci_dev *dev)
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
> > +	pci_disable_device(pdev);
> >  	return 0;
> >  }
> >  
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
> > +	pcim_enable_device(pdev);
> >  	pci_restore_state(pdev);
> >  	return 0;
> >  }
> > -- 
> > 2.11.0
> > 
