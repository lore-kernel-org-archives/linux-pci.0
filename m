Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54633 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbbJOULM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 16:11:12 -0400
Date: Thu, 15 Oct 2015 15:11:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>,
	David Daney <ddaney.cavm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 7/8] PCI: Add per-device MSI domain hook
Message-ID: <20151015201109.GD10442@localhost>
References: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
 <1444151043-31084-8-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444151043-31084-8-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 06, 2015 at 06:04:02PM +0100, Marc Zyngier wrote:
> So far, we have considered that the MSI domain for a device was
> either set via the architecture-dependent pcibios implementation
> or inherited from the host bridge.
> 
> As we're about to break that assumption, add pci_dev_msi_domain
> which is the equivalent of pci_host_bridge_msi_domain, but for
> a single device.
> 
> Other than moving things around a bit, this patch on its own
> has no effect.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/probe.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8361d27..7c333f8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1622,15 +1622,40 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_enable_acs(dev);
>  }
>  
> +/*
> + * This is the equivalent of pci_host_bridge_msi_domain that acts on
> + * devices. Firmware interfaces that can select the MSI domain on a
> + * per-device basis should be called from here.
> + */
> +static struct irq_domain *pci_dev_msi_domain(struct pci_dev *dev)
> +{
> +	struct irq_domain *d;
> +
> +	/*
> +	 * If a domain has been set through the pcibios_add_device
> +	 * callback, then this is the one (platform code knows best).
> +	 */
> +	d = dev_get_msi_domain(&dev->dev);
> +	if (d)
> +		return d;
> +
> +	return NULL;
> +}
> +
>  static void pci_set_msi_domain(struct pci_dev *dev)
>  {
> +	struct irq_domain *d;
> +
>  	/*
> -	 * If no domain has been set through the pcibios_add_device
> -	 * callback, inherit the default from the bus device.
> +	 * If the platform or firmware interfaces cannot supply a
> +	 * device-specific MSI domain, then inherit the default domain
> +	 * from the host bridge itself.
>  	 */
> -	if (!dev_get_msi_domain(&dev->dev))
> -		dev_set_msi_domain(&dev->dev,
> -				   dev_get_msi_domain(&dev->bus->dev));
> +	d = pci_dev_msi_domain(dev);
> +	if (!d)
> +		d = dev_get_msi_domain(&dev->bus->dev);
> +
> +	dev_set_msi_domain(&dev->dev, d);
>  }
>  
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
