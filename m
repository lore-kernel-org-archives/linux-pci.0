Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9172D7D47;
	Thu, 19 Feb 2026 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539916; cv=none; b=bU0gOIiBp/1KALD/iiJv27DFoAE5W5hO6I7Urm+k2qWFReSw5YXm6F5D/EsyKI1u5rhIB5DHDzITC56aFrrWU4ZTDaOSYuIAKJTW/4FZrSWQg9xOOfoP0sOxuhISTYe1LFwqrk/NvihFl05RsapGpIwlka+ERDHmM12eE6qdJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539916; c=relaxed/simple;
	bh=jbamHdYNftJ4XHQZGC04/aHaeAeWrJEVXWzFownvB+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FxoaMPT6iUpKV1SQyHdXB7WmelnMOI0p3U1+Ear9CiOJjjPKMdVL8JqN6J/BCSnzkLVVcxatiYleRbW7wLjNUjJafqhDk4nIiyl9ePOgzuUxgPNpftL3xAoXk8Xgva3aGgG/F+PH4GZ0HJofCTpxuXuJx+5/Vu1WAqxKM5tTKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpgiE1pj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpgiE1pj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B0CC4CEF7;
	Thu, 19 Feb 2026 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539916;
	bh=jbamHdYNftJ4XHQZGC04/aHaeAeWrJEVXWzFownvB+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qpgiE1pjdpW56Y+cs1/DjG9uokbmlgAvWca1BWMBR2VXeVX6QmSYXpxfzTrMP1kik
	 L47r8X5lRXZ4I76EJHj2bjSzJLFsirdKr0kK6yekrnz9pSeVsLUqxdo3Rkpp9+zWGg
	 tRw/0FOsfUqDKsAejkZZAR6mS/LI9MTvGjyaA5/2xqnxL1LMXYMGFFSejWX+uBqzqg
	 43mY4aQHvSlk8HffA+6NNSETGIvmEwE78h5uzf64JnfLfCSX4WJi1IvpqvkQm3dCys
	 avtopjIH6GtSvVrqrtqiELjdn10gnFZnnRFvrS5jN/Ek1vbOIFfrjy6QIyb0jUNP+S
	 pxLji4crlsllg==
Date: Thu, 19 Feb 2026 16:25:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <20260219222514.GA3499908@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209171535.v2.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>

On Mon, Feb 09, 2026 at 05:15:35PM -0800, Brian Norris wrote:
> The PCIe port driver fails to probe if it finds no child services,
> presumably under the assumption that the driver is not useful in that
> case. However, the driver *can* still be useful for power management
> support -- namely, it still configures the port for runtime PM / D3,
> which may be important for allowing a bridge to enter low power modes.
> 
> Thus, allow probe to succeed even if no IRQs and no child services are
> available. This also mirrors existing behavior for ports that have no
> PCIe capabilities, where we'd also probe successfully.
> 
> This change is a bit more important after commit f5cd8a929c82 ("PCI:
> dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> controller"), because it's common for some DWC-based systems to:
> 
> 1. have only have the "aer" and "pcie_pme" port services available and
> 2. not define legacy INTx interrupts properly in their device tree.
> 
> After commit f5cd8a929c82, such systems may fail
> pcie_init_service_irqs() and so exit with -ENODEV.
> 
> Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> Changes in v2:
>  * clear master when we have no child services
> 
>  drivers/pci/pcie/portdrv.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 88af0dacf351..19b08f3653ee 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -330,7 +330,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>   */
>  static int pcie_port_device_register(struct pci_dev *dev)
>  {
> -	int status, capabilities, i, nr_service;
> +	int status, capabilities, i;
>  	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
>  
>  	/* Enable PCI Express port device */
> @@ -355,29 +355,22 @@ static int pcie_port_device_register(struct pci_dev *dev)
>  	if (status) {
>  		capabilities &= PCIE_PORT_SERVICE_HP;
>  		if (!capabilities)
> -			goto error_disable;
> +			goto out;
>  	}
>  
>  	/* Allocate child services if any */
> -	status = -ENODEV;
> -	nr_service = 0;
>  	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
>  		int service = 1 << i;
>  		if (!(capabilities & service))
>  			continue;
> -		if (!pcie_device_init(dev, service, irqs[i]))
> -			nr_service++;
> +		pcie_device_init(dev, service, irqs[i]);
>  	}
> -	if (!nr_service)
> -		goto error_cleanup_irqs;
>  
> +out:
> +	/* With no child services, we shouldn't need bus mastering. */
> +	if (!capabilities)
> +		pci_clear_master(dev);

I'm curious about this part because we pci_set_master()
unconditionally just above:

  pci_set_master(dev);
  pcie_init_service_irqs(dev, irqs, capabilities);
  for (i = 0; ...; i++)
    pcie_device_init(dev, service, irqs[i]);
  if (!capabilities)
    pci_clear_master(dev);

Bus mastering on a bridge must be enabled for DMA from downstream
devices to work, but I think that's done by pci_enable_bridge() when a
driver calls pci_enable_device() for an endpoint.

I assume the reason we call pci_set_master() here is so MSI/MSI-X from
the bridge will work, even if there is no downstream device.

I don't think either pcie_init_service_irqs() or pcie_device_init()
requires bus mastering, so I don't know why we enable it here.  It
seems like we should do it when we set up MSI/MSI-X interrupts.

If we want to do it in pcie_port_device_register() (instead of in
service driver when they set up an interrupt), maybe we should drop
the initial pci_set_master() and do it conditionally, e.g.,

  if (capabilities)
    pci_set_master(dev);
