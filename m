Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 25 Sep 2015 18:40:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, wfg@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, x86@kernel.org
Subject: Re: [Bugfix 1/2] ACPI, PCI, irq: Do not share PCI IRQ with ISA IRQ
Message-ID: <20150925234040.GB23134@localhost>
References: <1442469766-31264-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442469766-31264-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 17, 2015 at 02:02:45PM +0800, Jiang Liu wrote:
> Avoid IRQs occupied by ISA IRQs when allocating IRQs for PCI link devices,
> otherwise it may cause interrupt storm due to incompatible pin attributes.
> 
> This issue was triggered on a KVM virtual machine, which
> 1) uses IRQ9 for SCI in high level mode.
> 2) defines an PCI interrupt link device (LNKS) with IRQ9 as the only
>    possible irq.
> 3) has an PCI device referring to link device LNKS.
> So it causes interrupt storm when enabling the PCI device because PCI IRQ
> works in low level mode.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/pci_irq.c  |    1 +
>  drivers/acpi/pci_link.c |   13 +++++++++++++
>  include/linux/acpi.h    |    1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 6da0f9beab19..c9336751e5e3 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -372,6 +372,7 @@ static int acpi_isa_register_gsi(struct pci_dev *dev)
>  
>  	/* Interrupt Line values above 0xF are forbidden */
>  	if (dev->irq > 0 && (dev->irq <= 0xF) &&
> +	    acpi_isa_irq_available(dev->irq) &&
>  	    (acpi_isa_irq_to_gsi(dev->irq, &dev_gsi) == 0)) {
>  		dev_warn(&dev->dev, "PCI INT %c: no GSI - using ISA IRQ %d\n",
>  			 pin_name(dev->pin), dev->irq);
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 3b4ea98e3ea0..246e50d22120 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -553,6 +553,13 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  				irq = link->irq.possible[i];
>  		}
>  	}
> +	if (acpi_irq_penalty[irq] >= PIRQ_PENALTY_ISA_ALWAYS) {
> +		printk(KERN_ERR PREFIX "No IRQ available for %s [%s]. "
> +			    "Try pci=noacpi or acpi=off\n",
> +			    acpi_device_name(link->device),
> +			    acpi_device_bid(link->device));
> +		return -ENODEV;
> +	}
>  
>  	/* Attempt to enable the link device at this IRQ. */
>  	if (acpi_pci_link_set(link, irq)) {
> @@ -821,6 +828,12 @@ void acpi_penalize_isa_irq(int irq, int active)
>  	}
>  }
>  
> +bool acpi_isa_irq_available(int irq)
> +{
> +	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
> +			    acpi_irq_penalty[irq] < PIRQ_PENALTY_ISA_ALWAYS);
> +}
> +
>  /*
>   * Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict with
>   * PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be use for
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 7235c4851460..43856d19cf4d 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -217,6 +217,7 @@ struct pci_dev;
>  
>  int acpi_pci_irq_enable (struct pci_dev *dev);
>  void acpi_penalize_isa_irq(int irq, int active);
> +bool acpi_isa_irq_available(int irq);
>  void acpi_penalize_sci_irq(int irq, int trigger, int polarity);
>  void acpi_pci_irq_disable (struct pci_dev *dev);
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
