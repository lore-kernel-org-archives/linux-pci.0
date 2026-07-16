Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3BD3C3C0F;
	Thu, 16 Jul 2026 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222803; cv=none; b=ZXRki2137c4P5WGUjK560/x6my9FNhWuZNkf684H+FuwFBKpsOmni50suN76p+ABbx/lBFGbthaQGSnLqxOOxRma8GTGON8kH9mnK4PqpmltRL0kp3GZ3L8z0UF9wLXFtt18DhzbgPHJHuSQPgXpK+3PVkijCtP/ROIK4jAHi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222803; c=relaxed/simple;
	bh=7SfnxVYjxI6EszlZpnzE5b0mPmk087AFNoPLUWTYll4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tvlWJ9KySBoCDF8bsJvQ+0mDZv58AhrLuYW5eceCs70cIKYml0x8SmnYJ6cF3T63OFtAdg2XrEvnaWgyW1Ax1fhG+XNliQAvPk8XvG/sSOKfy0fSaXmkYP7FLDsE+nMGi4hrBhKPWc6erPPED26cEqX0rnA4QGK/BbhGPO8mipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz9ta8+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz9ta8+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7721F000E9;
	Thu, 16 Jul 2026 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784222802;
	bh=zU6TxPnl+f2t/Tzrk9q+yD/TnbaCg3/Zu9plUjd5aKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=gz9ta8+nPrOLCORh7auahfTpA0WRsyFYUM/0FUqnKSleO8asocZGVqQK5hM6gFFkc
	 M5gFyorHYEJ4yXiQx5as8EQxsYlHEo4JdHGkJxv4tuMoSMwZ4S/qSQwQmD9rQQIGnZ
	 /W7nJAIN/4q1E5xN15i+nVooqR38V00v4jeB9FfFZ+7QSzlVKEmA+ukF5hbAGNnQ+e
	 DuGWY+fTPZeCokaeLLd0OBN5i+RG0zLiY2ZyhTFVut5WvbM61Bc8mXQXPQcKDq8SZb
	 8ft0q/CHIn9zXQLH9G6DF9177Q43We87aJffffW3utfhryCkU52OGCQSYRhAcmuk1v
	 vCWqkLqSORJTg==
Date: Thu, 16 Jul 2026 12:26:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <20260716172641.GA100369@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209171535.v2.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>

[+cc David]

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

Applied to pci/portdrv for v7.3, thank you!

I did update the commit log to be more specific about "ports that have
no PCIe capabilities" because I think we only care about AER, DPC, and
things in the PCIe Capability itself:

  This also mirrors existing behavior for ports that don't support any
  portdrv services (PCIe hotplug, AER, DPC, PME, bwctrl), where we'd
  also probe successfully.

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
>  	return 0;
> -
> -error_cleanup_irqs:
> -	pci_free_irq_vectors(dev);
> -error_disable:
> -	pci_disable_device(dev);
> -	return status;
>  }
>  
>  typedef int (*pcie_callback_t)(struct pcie_device *);
> -- 
> 2.53.0.239.g8d8fc8a987-goog
> 
