Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B092D5A01;
	Wed, 15 Jul 2026 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153729; cv=none; b=I3rPjfptI8ovM/NVlS134Mmkjb6DQA8Culb/VFTOJuEkswKvC6OZQ0g+H2zkQ//2x3Lhi+Cnl97NLAw8CzyVBaO6tq67bgdfiJ4L/XOWKD6MVHBmOK2sgh2bfjZ1dacp/8s/0Hp8H0DMb0WaBA4c4eltM8FyfYqOux2qBNe4O/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153729; c=relaxed/simple;
	bh=ZPXPSxWTx44bZKIVI/aIk95SiwuWZ6Q40Mi5OzHxd5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lUzuubN/eMyf68YM5U9oOMvbZxzHt01M1diaIMHwQCcNTBhUu8HzWOCjZgfDNfdgV24QMQuRLtx0mk02UzY+7S18pfPzqvyJFmBJBlMq9PVTdfrJf9dyp7zlIO9jNOMXIDsd5+QVr9mC3kn1s0dKic24hHnDEJBlkyljjZ7dmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLmYnQ2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLmYnQ2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9551F000E9;
	Wed, 15 Jul 2026 22:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784153728;
	bh=qfKaLynfYdL9lBOS8egaOGArv7g0KxY23QHM8mGCwFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=YLmYnQ2SdS7xEyUKxig9B5UlwI65zvIkTUktjBqgnjQugIm5PJJZ6hg9fnCIoh0zb
	 X9Weeai7zVBbkwGtpBSzi+36oHd0QSNf59vewE49J3Mx0B6njdFfNfYLDF60prw9Pn
	 qx+iVNXMvaFZmEPVUFnju4XMzYv7YjIL2R4LqIg/ny1Vsr7OLo/tdDjCtvmGR52ru1
	 auih198FZHWViusEm+Qi+6pr+16Uf9+pKA7NHki0wPqVTGSLsC3Rj46poJUQF9wIBR
	 8Dm+4GwOJj5gMTmhEpWXWDmNepiniFQl5PnZ0FXEZsMDFvkeFmoWPlnSADnRmT+FS5
	 8iO6HIDvHtsnw==
Date: Wed, 15 Jul 2026 17:15:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: sashiko@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	David Matlack <dmatlack@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v3] PCI/portdrv: Allow probing even without child services
Message-ID: <20260715221526.GA117606@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af574zaysKnXjx15@google.com>

[+cc David, Mani]

On Fri, May 08, 2026 at 05:12:19PM -0700, Brian Norris wrote:
> On Fri, May 08, 2026 at 11:30:22PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Moving `pci_set_master()` after child device registration causes child drivers to probe with Bus Mastering disabled, risking permanently lost MSI/MSI-X interrupts.
> > --
> > 
> > commit 9b851bf8faf271ab0b2daad51bfd51f89a1e87d4
> > Author: Brian Norris <briannorris@chromium.org>
> > 
> > PCI/portdrv: Allow probing even without child services
> > 
> > This commit modifies the PCIe port driver to allow probe to succeed even
> > if no child services are available. This ensures the port can still be
> > configured for runtime PM and low power modes on systems that only have
> > certain port services available or lack legacy INTx interrupts.
> > 
> > Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> > 
> > > --- a/drivers/pci/pcie/portdrv.c
> > > +++ b/drivers/pci/pcie/portdrv.c
> > > @@ -343,7 +343,6 @@ static int pcie_port_device_register(struct pci_dev *dev)
> > >  	if (!capabilities)
> > >  		return 0;
> > >  
> > > -	pci_set_master(dev);
> > >  	/*
> > >  	 * Initialize service irqs. Don't use service devices that
> > >  	 * require interrupts if there is no way to generate them.
> > 
> > [ ... ]
> > 
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
> > > -	return 0;
> > > +	pci_set_master(dev);
> > 
> > Does moving pci_set_master() after the pcie_device_init() loop
> > risk dropping MSI/MSI-X interrupts during child driver probes?
> > 
> > The pcie_device_init() function calls device_register(), which
> > synchronously invokes the probe routines of child service drivers
> > like pciehp or aer.  During probe, these child drivers configure
> > the hardware and enable their interrupts.
> > 
> > Because PCIe MSI and MSI-X interrupts are memory write
> > transactions, they require the Bus Master Enable (BME) bit to be
> > set in the PCI Command Register.
> > 
> > If a hardware event occurs immediately after the child driver
> > unmasks the interrupt but before pci_set_master(dev) is called,
> > will the hardware attempt to send an MSI and drop the memory write
> > because BME is 0?
> > 
> > Since PCIe interrupts are edge-triggered messages, could these
> > dropped interrupts result in permanently missed hotplug events or
> > cause hardware error handling regressions?
> 
> Ha, that's funny. It's all a great question I think, and that's
> pretty much what I asked Bjorn here when he suggested moving this:
> 
> https://lore.kernel.org/all/aZfIfn9viQRj4uy4@google.com/
> 
> He seems to think it's not a problem:
> 
> https://lore.kernel.org/all/20260220164046.GA3528004@bhelgaas/
> 
> but I'm frankly not very convinced. I think it's perfectly possible
> that a child service will try to enable MSI, the device will try to
> write, and those writes will be dropped, producing a missing
> interrupt.

I think you're right that if we move the pci_set_master() after
pcie_device_init(), there is a window where MSIs could be dropped.

If pcie_portdrv_probe() is called after pcie_portdrv_init() registers
service drivers (which would certainly happen if a port is hot-added)
the service .probe() will be called inside pcie_device_init(), so BME
must be set before that.

  pcie_portdrv_init                   # device_initcall
    pcie_init_services
      pcie_aer_init
        pcie_port_service_register
          driver_register

  pcie_portdrv_probe
    pcie_port_device_register
      pci_set_master                  # current location
      pcie_init_service_irqs
        # set generic PCI_MSI_FLAGS_ENABLE
      for (i = 0; ...)
        pcie_device_init
          device_register
            aer_probe
              # set PCI_ERR_ROOT_CMD_COR_EN interrupt enable

> Bjorn, what do you think? Personally, I'd go back to something
> closer to v2, where we enable mastering before initializing
> children.

Yes, I agree.  What do you think of the patch below?  It's fairly
similar to your v2.

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 69283cd04a78..6912743df767 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -328,7 +328,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
  * Allocate the port extension structure and register services associated with
  * the port.
  */
-static int pcie_port_device_register(struct pci_dev *dev)
+static void pcie_port_device_register(struct pci_dev *dev)
 {
 	int status, capabilities, i, nr_service;
 	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
@@ -336,12 +336,12 @@ static int pcie_port_device_register(struct pci_dev *dev)
 	/* Enable PCI Express port device */
 	status = pci_enable_device(dev);
 	if (status)
-		return status;
+		return;
 
 	/* Get and check PCI Express port services */
 	capabilities = get_port_device_capability(dev);
 	if (!capabilities)
-		return 0;
+		return;
 
 	pci_set_master(dev);
 	/*
@@ -359,7 +359,6 @@ static int pcie_port_device_register(struct pci_dev *dev)
 	}
 
 	/* Allocate child services if any */
-	status = -ENODEV;
 	nr_service = 0;
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
 		int service = 1 << i;
@@ -368,16 +367,16 @@ static int pcie_port_device_register(struct pci_dev *dev)
 		if (!pcie_device_init(dev, service, irqs[i]))
 			nr_service++;
 	}
+
 	if (!nr_service)
 		goto error_cleanup_irqs;
 
-	return 0;
+	return;
 
 error_cleanup_irqs:
 	pci_free_irq_vectors(dev);
 error_disable:
 	pci_disable_device(dev);
-	return status;
 }
 
 typedef int (*pcie_callback_t)(struct pcie_device *);
@@ -698,9 +697,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	if (type == PCI_EXP_TYPE_RC_EC)
 		pcie_link_rcec(dev);
 
-	status = pcie_port_device_register(dev);
-	if (status)
-		return status;
+	pcie_port_device_register(dev);
 
 	pci_save_state(dev);
 
