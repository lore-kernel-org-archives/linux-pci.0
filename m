Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125F329E62;
	Fri, 20 Feb 2026 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771605649; cv=none; b=g+uc4YyyAGbY/yYKsoPVmp2gWdCv1LCF8SIZ9Lo1RhVXsl4ZUJBahi5pdyLghBVCvf7V+QklaUSA6mSRss9fvCp4cW8OEm5OIDjKtsLmpMuJ94M0oahds0ZTW9ivdZEzpzHF9xJyCVJ+4KxQvPnUD76mPYrFHKe6lqRDgKrjpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771605649; c=relaxed/simple;
	bh=7bopRjgeCMkxfOz5hoQeo1KxTHPUS1QZQ2F/Hzwz7as=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Usjd8HLQelXkoS0JvDB6JZx/tCCNY0YuJHPRJ+Aam60mVeRJUUtrT14JsmiPOW2Htopuj3apQOeEGDmNlnIl+ykbHMxCGkI0Glvyywg77td7oOmqRMHOS+VOUeLdUqgIub8PwAXYEMs4CaqaLU+qlJ1NpEfVJRDBFe0pUm4q5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJyqZJe3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJyqZJe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C2BC116C6;
	Fri, 20 Feb 2026 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771605648;
	bh=7bopRjgeCMkxfOz5hoQeo1KxTHPUS1QZQ2F/Hzwz7as=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GJyqZJe3Ui+UseWudoI1uCbUKjLKLL/izuZT9Uja+YqADhXMOdoA4YjPRrZ/dtloP
	 phj8J836fEuMCDUyD6AIT4ag7TfFKCC8NkUScKFYRnAudzrWKMWsOHQJv4fY9MWYLo
	 jpUNn4V6l+6qTMfoOykd+J7rdjWntcM4jFB4enRht/lUuG4VBTmxCMd83UpIoZS2lJ
	 KgI7iSzsYqlwri+wXa2bmTRyGsuUrDHTmEx+mE5T/PUOoee+qxs8rPAQyP5Fm5KXAk
	 t0X1rxicbY01x8vwJLqvR2gV3dHaZwZs2EjsjBPTrVw4qUpdQTALdIq4l1KlLPChsF
	 ZiWjOL/xv5gfg==
Date: Fri, 20 Feb 2026 10:40:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <20260220164046.GA3528004@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZfIfn9viQRj4uy4@google.com>

On Thu, Feb 19, 2026 at 06:35:42PM -0800, Brian Norris wrote:
> On Thu, Feb 19, 2026 at 04:25:14PM -0600, Bjorn Helgaas wrote:
> > On Mon, Feb 09, 2026 at 05:15:35PM -0800, Brian Norris wrote:
> > > The PCIe port driver fails to probe if it finds no child services,
> > > presumably under the assumption that the driver is not useful in that
> > > case. However, the driver *can* still be useful for power management
> > > support -- namely, it still configures the port for runtime PM / D3,
> > > which may be important for allowing a bridge to enter low power modes.
> > > 
> > > Thus, allow probe to succeed even if no IRQs and no child services are
> > > available. This also mirrors existing behavior for ports that have no
> > > PCIe capabilities, where we'd also probe successfully.
> > > 
> > > This change is a bit more important after commit f5cd8a929c82 ("PCI:
> > > dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> > > controller"), because it's common for some DWC-based systems to:
> > > 
> > > 1. have only have the "aer" and "pcie_pme" port services available and
> > > 2. not define legacy INTx interrupts properly in their device tree.
> > > 
> > > After commit f5cd8a929c82, such systems may fail
> > > pcie_init_service_irqs() and so exit with -ENODEV.
> > > 
> > > Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > > 
> > > Changes in v2:
> > >  * clear master when we have no child services
> > > 
> > >  drivers/pci/pcie/portdrv.c | 21 +++++++--------------
> > >  1 file changed, 7 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > > index 88af0dacf351..19b08f3653ee 100644
> > > --- a/drivers/pci/pcie/portdrv.c
> > > +++ b/drivers/pci/pcie/portdrv.c
> > > @@ -330,7 +330,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
> > >   */
> > >  static int pcie_port_device_register(struct pci_dev *dev)
> > >  {
> > > -	int status, capabilities, i, nr_service;
> > > +	int status, capabilities, i;
> > >  	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
> > >  
> > >  	/* Enable PCI Express port device */
> > > @@ -355,29 +355,22 @@ static int pcie_port_device_register(struct pci_dev *dev)
> > >  	if (status) {
> > >  		capabilities &= PCIE_PORT_SERVICE_HP;
> > >  		if (!capabilities)
> > > -			goto error_disable;
> > > +			goto out;
> > >  	}
> > >  
> > >  	/* Allocate child services if any */
> > > -	status = -ENODEV;
> > > -	nr_service = 0;
> > >  	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
> > >  		int service = 1 << i;
> > >  		if (!(capabilities & service))
> > >  			continue;
> > > -		if (!pcie_device_init(dev, service, irqs[i]))
> > > -			nr_service++;
> > > +		pcie_device_init(dev, service, irqs[i]);
> > >  	}
> > > -	if (!nr_service)
> > > -		goto error_cleanup_irqs;
> > >  
> > > +out:
> > > +	/* With no child services, we shouldn't need bus mastering. */
> > > +	if (!capabilities)
> > > +		pci_clear_master(dev);
> > 
> > I'm curious about this part because we pci_set_master()
> > unconditionally just above:
> > 
> >   pci_set_master(dev);
> >   pcie_init_service_irqs(dev, irqs, capabilities);
> >   for (i = 0; ...; i++)
> >     pcie_device_init(dev, service, irqs[i]);
> >   if (!capabilities)
> >     pci_clear_master(dev);
> > 
> > Bus mastering on a bridge must be enabled for DMA from downstream
> > devices to work, but I think that's done by pci_enable_bridge() when a
> > driver calls pci_enable_device() for an endpoint.
> > 
> > I assume the reason we call pci_set_master() here is so MSI/MSI-X from
> > the bridge will work, even if there is no downstream device.
> > 
> > I don't think either pcie_init_service_irqs() or pcie_device_init()
> > requires bus mastering, so I don't know why we enable it here.  It
> > seems like we should do it when we set up MSI/MSI-X interrupts.
> 
> I'm no expert here, but by code inspection, pcie_init_service_irqs() may
> call pci_msi_set_enable() which sets PCI_MSI_FLAGS_ENABLE. Could that
> confuse a device to see MSI enabled but bus mastering disabled?

You're right that this path may set the MSI Enable bit:

  pcie_init_service_irqs
    pcie_port_enable_irq_vec
      pci_alloc_irq_vectors
        pci_alloc_irq_vectors_affinity
          __pci_enable_msi_range
            msi_capability_init
              __msi_capability_init
                pci_msi_set_enable(1)
                  # set PCI_MSI_FLAGS_ENABLE

Setting MSI Enable allows the device to use MSI when it asserts an
interrupt, but my understanding is that it doesn't enable the
interrupt source itself.  The MSI Capability is an interrupt
mechanism, not itself a source -- there's no interrupt handler at this
point.

The sources have their own interrupt enable bits, e.g, Root Control
PME Interrupt Enable, Link Control Link Bandwidth Management Interrupt
Enable, Slot Control Hot-Plug Interrupt Enable, DPC Interrupt Enable,
AER Root Error Command Error Reporting Enable bits, 

The drivers using these interrupts should be setting up their
interrupt handlers before setting their interrupt enable bit.

Bus master is a global thing that affects all kinds of transactions
coming from the device.  There's no problem setting in from various
places, but clearing it in a single place affects all of them, so we
basically need global knowledge to know that it's safe.  That's why I
suggested doing a conditional bus master enable instead of the
unconditional enable followed by a conditional disable.

But I still do think this is not quite the right place even to enable
it.  I think it would make more sense to enable bus mastering in the
drivers that need the MSI/MSI-X, e.g., PME, pciehp, bwctrl, aer, etc.
At this point in pcie_port_device_register(), I don't think we can be
certain that any of those services will actually enable the interrupt.

> > If we want to do it in pcie_port_device_register() (instead of in
> > service driver when they set up an interrupt), maybe we should drop
> > the initial pci_set_master() and do it conditionally, e.g.,
> > 
> >   if (capabilities)
> >     pci_set_master(dev);
