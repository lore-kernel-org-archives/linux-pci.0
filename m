Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53311 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbaKGOZG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Nov 2014 09:25:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	catalin.marinas@arm.com, will.deacon@arm.com, bhelgaas@google.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, rjw@rjwysocki.net, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] arm64, acpi, pci: Provide arch-specific calls for PCI host bridge dirver (PNP0A03).
Date: Fri, 07 Nov 2014 15:24:30 +0100
Message-ID: <4474363.kMvYSLl2Ev@wuerfel>
In-Reply-To: <1415366876-30811-5-git-send-email-tomasz.nowicki@linaro.org>
References: <1415366876-30811-1-git-send-email-tomasz.nowicki@linaro.org> <1415366876-30811-5-git-send-email-tomasz.nowicki@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 07 November 2014 14:27:56 Tomasz Nowicki wrote:
>  
>  #ifdef CONFIG_PCI
> +struct pci_controller {
> +	struct acpi_device *companion;
> +	int segment;
> +	int node;		/* nearest node with memory or NUMA_NO_NODE for global allocation */
> +};
> +
> +#define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
> +

Don't use busdev->sysdata in architecture specific code, it belongs to the
host bridge driver with the new model. For ACPI you don't have a host bridge
driver, but it's better to keep these separate.

The segment is always the same as the domain number, so just use that.
The node and companion members here can get added to struct pci_host_bridge.

> @@ -43,7 +53,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>   */
>  int pcibios_add_device(struct pci_dev *dev)
>  {
> -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> +	if (acpi_disabled)
> +		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>  
>  	return 0;
>  }

How do you assign the irq number with ACPI? Do you only support MSI?

>  /*
>   * raw_pci_read/write - Platform-specific PCI config space access.
> - *
> - * Default empty implementation.  Replace with an architecture-specific setup
> - * routine, if necessary.
>   */
>  int raw_pci_read(unsigned int domain, unsigned int bus,
>  		  unsigned int devfn, int reg, int len, u32 *val)
>  {
> -	return -EINVAL;
> +	char __iomem *addr;
> +
> +	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095))) {
> +err:		*val = -1;
> +		return -EINVAL;
> +	}
> +
> +	rcu_read_lock();
> +	addr = pci_dev_base(domain, bus, devfn);
> +	if (!addr) {
> +		rcu_read_unlock();
> +		goto err;
> +	}

The config space accessors should probably be shared with
drivers/pci/host/pci-host-generic.c, e.g. by moving the rest of
the new code in there as well, or by moving the config space
accessors from that file to drivers/pci/mmconfig.c.

	Arnd
