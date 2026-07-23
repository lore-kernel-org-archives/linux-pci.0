Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262743F8899;
	Thu, 23 Jul 2026 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843926; cv=none; b=Iv4e7tcRnM02qnD4SMghWXYx14QEvlNro+0zLbGk8zqfq4g8322qEOLzf/0UHk62JfN8CiFYZJ+4HmGanu1c7voG3LdF6mnDaqfLPMkdGxjKqQE8QEcFq5+gCT2utlxQeOY1bMHzDGqfPYB1BuqKbsqTReFpy46K6Z9zdKIOk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843926; c=relaxed/simple;
	bh=4IyB0bS4utudoco73H4ceD3nM1xYTTHYC6ZgZAzJft4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PTQSRvOeGJmiUtoRSQJ5SvjSOARzThlZfHBsZ1G/iR4y2ITCnatfcgFLEwRuqbFigttf/R6k1CvKB3x91TfQsxnOrXAJWavmbPu8o0QvWRy46DOrzOJ2f43NQqZwjFFgB92iDpzNbHYjv7gMvJ+d2Ezim9K8fIcSHigpAldNKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWsqM7v2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWsqM7v2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11521F000E9;
	Thu, 23 Jul 2026 21:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784843923;
	bh=hH7Xt1Rj/RtfLqU6Y/36IlAaqiMN8rWY+VuUOnAA+ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=AWsqM7v2h5Q7XJSIORhcnRS+fYhNwPjJG2NmSb6O5vP0tPRXPslo6NFJ2eMW+0xEP
	 6EEHdvqSEmUel97VS7dahbHBsWjsc1fCyEso/vAAVrxZUj2UaL93/q9eblwXkXXcPh
	 c54zxCmnyDrD2uNuf5F7zxOZuy8Zfcbu3c0JLw9kcuKXQTYeeK7f592kT1rycr3Mup
	 9vHuc+1x1GrgLJI11takQOBuvwCQkBjXzgBx1/oP5AnjhR4sKD6E34jjzZ2Dr/wAPp
	 CF8hv5l2d+1xseSYDs9NhvcVqK8hHtNjWIh6I5yOp+yr8THpIvZtwUQkj9XEmlc6nx
	 eOuREaDfTkuUA==
Date: Thu, 23 Jul 2026 16:58:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	David Matlack <dmatlack@google.com>, Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/portdrv: Allow probing even without child services
Message-ID: <20260723215841.GA865570@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722160942.v4.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>

On Wed, Jul 22, 2026 at 04:09:42PM -0700, Brian Norris wrote:
> The PCIe port driver fails to probe if it finds no child services,
> presumably under the assumption that the driver is not useful in that case.
> However, the driver *can* still be useful for power management support --
> namely, it still configures the port for runtime PM / D3, which may be
> important for allowing a bridge to enter low power modes.
> 
> Thus, allow probe to succeed even if no IRQs and no child services are
> available. This also mirrors existing behavior for ports that don't support
> any portdrv services (PCIe hotplug, AER, DPC, PME, bwctrl), where we'd also
> probe successfully.
> 
> This change is a bit more important after commit f5cd8a929c82 ("PCI: dwc:
> Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> controller"), because it's common for some DWC-based systems to:
> 
>   1. have only the "aer" and "pcie_pme" port services available and
> 
>   2. not define legacy INTx interrupts properly in their device tree.
> 
> After commit f5cd8a929c82, such systems may fail pcie_init_service_irqs()
> and so exit with -ENODEV.
> 
> Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied to pci/portdrv for v7.3, thanks!

> ---
> 
> Changes in v4:
>  * Between sashiko-bot / Mani / me / Bjorn, we agreed that deferring
>    pci_set_master() may cause us to drop some MSIs:
>      https://lore.kernel.org/all/af574zaysKnXjx15@google.com/
>    So we revert to the v2 approach, with some small changes
>  * Address some of Lukas's review comments:
>      https://lore.kernel.org/all/al68lFtbq_Q4RCL2@google.com/
>    Specifically:
>      - ensure pcie_device_init() return code is checked
>      - release IRQs (pci_free_irq_vectors()) when no services registered
>        properly
>  * Borrow some of Bjorn's commit message tweaks
> 
> Changes in v3:
>  * Defer pci_set_master() until we really know we have some child
>    service
> 
> Changes in v2:
>  * Clear master when we have no child services
> 
>  drivers/pci/pcie/portdrv.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 2d6aa488fe7b..18ee190acc6e 100644
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
> @@ -355,29 +355,29 @@ static int pcie_port_device_register(struct pci_dev *dev)
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
> +		if (pcie_device_init(dev, service, irqs[i]))
> +			capabilities &= ~service;
>  	}
> -	if (!nr_service)
> -		goto error_cleanup_irqs;
>  
> -	return 0;
> +out:
> +	/*
> +	 * With no child services, we shouldn't need bus mastering or any IRQ
> +	 * vectors we allocated.
> +	 */
> +	if (!capabilities) {
> +		pci_free_irq_vectors(dev);
> +		pci_clear_master(dev);
> +	}
>  
> -error_cleanup_irqs:
> -	pci_free_irq_vectors(dev);
> -error_disable:
> -	pci_disable_device(dev);
> -	return status;
> +	return 0;
>  }
>  
>  typedef int (*pcie_callback_t)(struct pcie_device *);
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
