Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 26 Sep 2017 15:25:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jork Loeser <jloeser@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] ACPI / PCI: Bail early in acpi_pci_add_bus() if there is
 no ACPI handle
Message-ID: <20170926202508.GQ15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170914145014.2834-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914145014.2834-1-vkuznets@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 14, 2017 at 04:50:14PM +0200, Vitaly Kuznetsov wrote:
> Hyper-V instances support PCI pass-through which is implemented through
> PV pci-hyperv driver. When a device is passed through a new root PCI bus
> is created in the guest. The bus sits on top of VMBus and has no
> associated information in ACPI. acpi_pci_add_bus() in this case proceeds
> all the way to acpi_evaluate_dsm() with reports
> 
>     ACPI: \: failed to evaluate _DSM (0x1001)
> 
> While acpi_pci_slot_enumerate() and acpiphp_enumerate_slots() are protected
> against ACPI_HANDLE() being NULL and do nothing acpi_evaluate_dsm() is not
> and gives us the error. It seems the correct fix is to not do anything in
> acpi_pci_add_bus() in such cases.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied to pci/acpi for v4.15, thanks!

Rafael, let me know if you have any objections or if you'd rather take
it yourself.

> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a8da543b3814..4708eb9df71b 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -624,7 +624,7 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>  	union acpi_object *obj;
>  	struct pci_host_bridge *bridge;
>  
> -	if (acpi_pci_disabled || !bus->bridge)
> +	if (acpi_pci_disabled || !bus->bridge || !ACPI_HANDLE(bus->bridge))
>  		return;
>  
>  	acpi_pci_slot_enumerate(bus);
> -- 
> 2.13.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
