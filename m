Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH] ACPI/PCI: pci_link: reduce verbosity when IRQ is enabled
To: linux-acpi@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
References: <1516128664-23634-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <f508e749-2976-ec6f-681a-553b79c4ab76@codeaurora.org>
Date: Tue, 16 Jan 2018 13:53:00 -0500
MIME-Version: 1.0
In-Reply-To: <1516128664-23634-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Correcting linux-pci email.

On 1/16/2018 1:51 PM, Sinan Kaya wrote:
> When ACPI Link object is enabled, the message is printed with a warning
> prefix. Some test tools are capturing warning and test error types as
> errors. Let's reduce the verbosity of success case.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index bc3d914..85ad679 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -612,7 +612,7 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  			acpi_isa_irq_penalty[link->irq.active] +=
>  				PIRQ_PENALTY_PCI_USING;
>  
> -		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
> +		pr_info("%s [%s] enabled at IRQ %d\n",
>  		       acpi_device_name(link->device),
>  		       acpi_device_bid(link->device), link->irq.active);
>  	}
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
