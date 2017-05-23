Return-Path: <SRS0=aZCs=45=redhat.com=alex.williamson@kernel.org>
Return-Path: <SRS0=aZCs=45=redhat.com=alex.williamson@kernel.org>
Date: Tue, 23 May 2017 10:39:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Piotr Gregor <piotrgregor@rsyncme.org>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Handle the case when PCI_COMMAND register hasn't
 changed in INTx masking test
Message-ID: <20170523103904.3a20d0cc@w520.home>
In-Reply-To: <20170523161929.GA24431@bhelgaas-glaptop.roam.corp.google.com>
References: <20170510122959.4uupohiz3ukzm4c4@debian1.home>
	<20170522233820.GH19733@bhelgaas-glaptop.roam.corp.google.com>
	<20170523161929.GA24431@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 23 May 2017 11:19:29 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex]
> 
> On Mon, May 22, 2017 at 06:38:20PM -0500, Bjorn Helgaas wrote:
> > Hi Piotr,
> > 
> > On Wed, May 10, 2017 at 01:30:01PM +0100, Piotr Gregor wrote:  
> > > The check for interrupt masking support is done by reading
> > > the PCI_COMMAND config word
> > > 
> > > 	pci_read_config_word(dev, PCI_COMMAND, &orig);
> > > 
> > > then flipping the PCI_COMMAND_INTX_DISABLE bit and writing result back
> > > 
> > > 	pci_write_config_word(dev, PCI_COMMAND,
> > > 		orig ^ PCI_COMMAND_INTX_DISABLE);
> > > 
> > > The expected result is that following read of the PCI_COMMAND
> > > 
> > > 	pci_read_config_word(dev, PCI_COMMAND, &new);
> > > 
> > > returns PCI_COMMAND with only PCI_COMMAND_INTX_DISABLE bit changed.
> > > 
> > > There are two possible outcomes:
> > > 
> > > 	1.	Command is the same (hasn't changed)
> > > 	2.	Commmand has changed
> > > 
> > > And the second of them may be decoupled to:
> > > 
> > > 	2.1	Command changed only for PCI_COMMAND_INTX_DISABLE bit
> > > 		(hasn't changed for bits different than PCI_COMMAND_INTX_DISABLE)
> > > 	2.2	Command changed for bit(s) different than PCI_COMMAND_INTX_DISABLE bit
> > > 		(and maybe for PCI_COMMAND_INTX_DISABLE too)
> > > 
> > > The 2.1 is expected result and anything else is error.
> > > The 2.2 outcome is handled by pci_intx_mask_supported by printing
> > > appropriate message to the log, but outcome 1 is not handled.
> > > 
> > > Log the message about command not being changed at all.
> > > 
> > > Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>
> > > ---
> > >  drivers/pci/pci.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index b01bd5b..67a611e 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -3712,7 +3712,7 @@ EXPORT_SYMBOL_GPL(pci_intx);
> > >   * pci_intx_mask_supported - probe for INTx masking support
> > >   * @dev: the PCI device to operate on
> > >   *
> > > - * Check if the device dev support INTx masking via the config space
> > > + * Check if the device dev supports INTx masking via the config space
> > >   * command word.
> > >   */
> > >  bool pci_intx_mask_supported(struct pci_dev *dev)
> > > @@ -3736,11 +3736,21 @@ bool pci_intx_mask_supported(struct pci_dev *dev)
> > >  	 * go ahead and check it.
> > >  	 */
> > >  	if ((new ^ orig) & ~PCI_COMMAND_INTX_DISABLE) {
> > > +		/*
> > > +		 * If anything else than PCI_COMMAND_INTX_DISABLE bit has
> > > +		 * changed (and maybe PCI_COMMAND_INTX_DISABLE too)
> > > +		 */
> > >  		dev_err(&dev->dev, "Command register changed from 0x%x to 0x%x: driver or hardware bug?\n",
> > >  			orig, new);
> > >  	} else if ((new ^ orig) & PCI_COMMAND_INTX_DISABLE) {
> > > +		/*
> > > +		 * OK. Only PCI_COMMAND_INTX_DISABLE bit has changed
> > > +		 */
> > >  		mask_supported = true;
> > >  		pci_write_config_word(dev, PCI_COMMAND, orig);
> > > +	} else {
> > > +		dev_err(&dev->dev, "Command register hasn't changed when written from 0x%x to 0x%x: driver or hardware bug?\n",
> > > +			orig, new);  
> > 
> > Bit 10 was a reserved bit in PCI r2.2 and was defined as
> > PCI_COMMAND_INTX_DISABLE in r2.3 of the spec, so I don't think we
> > should treat this as an error.  

Agreed, the only reason I can think that we'd ever want to point this
out as a hardware bug would be if the device is PCI-express or if we
can find other evidence in config space that the device should be
compliant to the PCI 2.3 spec.  Also, dev_err is sort of justified in
the original error case because something unexpected happened.  The
register is being poked from somewhere else or changed spontaneously.
Not supporting INTx masking is a completely valid state for hardware,
so I'd at best consider it a dev_dbg level test.

> 
> If we make a change here, I think it should be simplified to look like
> this:
> 
>   pci_cfg_access_lock(dev);
> 
>   pci_read_config_word(dev, PCI_COMMAND, &orig);
>   toggle = orig ^ PCI_COMMAND_INTX_DISABLE;
>   pci_write_config_word(dev, PCI_COMMAND, toggle);
>   pci_read_config_word(dev, PCI_COMMAND, &new);
>   pci_write_config_word(dev, PCI_COMMAND, orig);
> 
>   pci_cfg_access_unlock(dev);
> 
>   if (new == toggle)
>     return true;
> 
>   return false;
> 
> I don't really see the value in cluttering the code to check for
> things that "can't happen."  There's an infinite amount of that sort
> of stuff.  If we know about possible issues, that's one thing, but
> this seems like just looking for trouble.

I can imagine it being useful to allow a user to have some visibility
to this property for a device, but a printk doesn't feel like a useful
way to do that.  I don't know if it's worth a sysfs attribute though.

> It makes me a little nervous to have this interface that toggles
> PCI_COMMAND_INTX_DISABLE at run-time.  This could be called after a
> driver has set up interrupts, and I think there are some interactions
> between INTx and MSI/MSI-X that might cause unexpected things to
> happen if we toggle PCI_COMMAND_INTX_DISABLE.
> 
> I'd rather have the core check it once during enumeration (before we
> give it to a driver and before any interrupts are configured) and save
> the result in struct pci_dev.

I think that would be fine, the only users are uio and vfio, the former
testing it in the probe function, the latter testing it before giving
the user access to the device (and therefore before interrupts are
configured).  Thanks,

Alex

> 
> > >  	}
> > >  
> > >  	pci_cfg_access_unlock(dev);
> > > @@ -3798,7 +3808,7 @@ static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
> > >   * @dev: the PCI device to operate on
> > >   *
> > >   * Check if the device dev has its INTx line asserted, mask it and
> > > - * return true in that case. False is returned if not interrupt was
> > > + * return true in that case. False is returned if interrupt wasn't
> > >   * pending.  
> 
> We should definitely fix this typo.  Maybe "if no interrupt was
> pending"?
> 
> > >   */
> > >  bool pci_check_and_mask_intx(struct pci_dev *dev)
> > > -- 
> > > 2.1.4
> > >   
