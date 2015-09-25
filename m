Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 25 Sep 2015 18:41:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, wfg@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, x86@kernel.org
Subject: Re: [Bugfix 2/2] ACPI / PCI: Remove duplicated penalty on SCI IRQ
Message-ID: <20150925234100.GC23134@localhost>
References: <1442469766-31264-1-git-send-email-jiang.liu@linux.intel.com>
 <1442469766-31264-2-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442469766-31264-2-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 17, 2015 at 02:02:46PM +0800, Jiang Liu wrote:
> Now we have dedicated interface acpi_penalize_sci_irq() to penalize
> ISA IRQ used by ACPI SCI, so remove duplicated code to penalize ACPI SCI
> in acpi_irq_penalty_init().
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/pci_link.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 246e50d22120..7c8408b946ca 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -498,8 +498,7 @@ int __init acpi_irq_penalty_init(void)
>  			    PIRQ_PENALTY_PCI_POSSIBLE;
>  		}
>  	}
> -	/* Add a penalty for the SCI */
> -	acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] += PIRQ_PENALTY_PCI_USING;
> +
>  	return 0;
>  }
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
