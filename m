Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V4 22/23] arm64, pci, acpi: Assign legacy IRQs once device
 is enable.
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
 <1454606941-9523-23-git-send-email-tn@semihalf.com>
 <20160211115843.GA24136@red-moon> <20160211171700.GB25235@red-moon>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <56BCD550.2050601@semihalf.com>
Date: Thu, 11 Feb 2016 19:39:12 +0100
MIME-Version: 1.0
In-Reply-To: <20160211171700.GB25235@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11.02.2016 18:17, Lorenzo Pieralisi wrote:
> Here (on top of your series), ready for flak.
>
> Lorenzo
>
> -- >8 --
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 0b53262..26ee291 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -45,28 +45,23 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>    */
>   int pcibios_enable_device(struct pci_dev *dev, int mask)
>   {
> -	int ret;
> -
>   	if (pci_has_flag(PCI_PROBE_ONLY))
>   		return 0;
>
> -	ret = pci_enable_resources(dev, mask);
> -	if (ret < 0)
> -		return ret;
> -
> -#ifdef CONFIG_ACPI
> -	if (!pci_dev_msi_enabled(dev))
> -		return acpi_pci_irq_enable(dev);
> -#endif
> -	return 0;
> +	return pci_enable_resources(dev, mask);
>   }
>
>   /*
> - * Try to assign the IRQ number from DT when adding a new device
> + * Try to assign the IRQ number when probing a new device
>    */
> -int pcibios_add_device(struct pci_dev *dev)
> +int pcibios_alloc_irq(struct pci_dev *dev)
>   {
> -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> +	if (acpi_disabled)
> +		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> +#ifdef CONFIG_ACPI
> +	else
> +		return acpi_pci_irq_enable(dev);
> +#endif
>
>   	return 0;
>   }

I miss that way of solving the problem. OK lets try this way. I will 
integrate it.

Tomasz
