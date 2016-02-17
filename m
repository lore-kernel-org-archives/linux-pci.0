Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 17 Feb 2016 18:18:55 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	jchandra@broadcom.com, Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH V5 14/15] arm64, pci, acpi: Assign legacy IRQs once
 device is enable.
Message-ID: <20160217181855.GB11132@red-moon>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-15-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455630825-27253-15-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+ Duc, this needs testing on DT PCI hosts that do not call pci_fixup_irqs()]

On Tue, Feb 16, 2016 at 02:53:44PM +0100, Tomasz Nowicki wrote:

Subject is wrong, leftover from previous posting (ie you do not allocate
at device enable anymore).

> This is the last step before enabling generic ACPI PCI host controller
> for ARM64. We need to take care of legacy IRQ mapping for non-MSI(X)

You do not check MSIs anymore.

> PCI devices. pcibios_alloc_irq() evaluation is not sensitive to
> ACPI device enumeration order, so it is the best place to assign
> device's IRQs for ACPI boot method. Also, it does not hurt DT to be
> initialized form the same place.
> 
> NOTE: *This is going to be temporary solution*. There is ongoing work
> which aims for cleaning legacy IRQ allocation from arch specific code.
> We can consider this patch as the necessary evil which will be removed
> once cleanup series lands in mailnline in the near future.

"To enable PCI legacy IRQs on platforms booting with ACPI, arch code
should include ACPI specific callbacks that parse and set-up the
device IRQ number, equivalent to the DT boot path. Owing to the current
ACPI core scan handlers implementation, ACPI PCI legacy IRQs bindings
cannot be parsed at device add time, since that would trigger ACPI scan
handlers ordering issues depending on how the ACPI tables are defined.

To solve this problem and consolidate FW PCI legacy IRQs parsing in
one single pcibios callback (pending final removal), this patch moves
DT PCI IRQ parsing to the pcibios_alloc_irq() callback (called by
PCI core code at device probe time) and adds ACPI PCI legacy IRQs
parsing to the same callback too, so that FW PCI legacy IRQs parsing
is confined in one single arch callback that can be easily removed
when code parsing PCI legacy IRQs is consolidated and moved to core
PCI code".

?

> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/kernel/pci.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 023b983..6e77e1b 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -52,11 +52,16 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>  }
>  
>  /*
> - * Try to assign the IRQ number from DT when adding a new device
> + * Try to assign the IRQ number when probing a new device
>   */
> -int pcibios_add_device(struct pci_dev *dev)
> +int pcibios_alloc_irq(struct pci_dev *dev)
>  {
> -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> +	if (acpi_disabled)
> +		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> +#ifdef CONFIG_ACPI
> +	else
> +		return acpi_pci_irq_enable(dev);
> +#endif
>  
>  	return 0;
>  }

It is good this code is now in one single function, it will be removed
more quickly :D

So pending APM X-gene DT testing:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
