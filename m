Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 11 Jan 2018 12:09:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, bp@suse.de
Subject: Re: [PATCH] PCI/ACPI: Disable AER when _OSC control bit is clear.
Message-ID: <20180111180905.GK241460@bhelgaas-glaptop.roam.corp.google.com>
References: <20180111150316.19951-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180111150316.19951-1-Yazen.Ghannam@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 11, 2018 at 09:03:16AM -0600, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Currently, aer_service_init() checks if AER is available and that
> Firmware First handling is not enabled. The _OSC request for AER is
> not taken into account when deciding to enable AER in Linux.
> 
> We should check that the _OSC control for AER is set. If it's not
> then AER should be disabled.
> 
> The _OSC control for AER is not requested when APEI Firmware First is
> used, so the same condition applies.
> 
> Mark AER as disabled if the _OSC request was not made or accepted.
> 
> Remove redunant check for aer_acpi_firmware_first() when calling
> aer_service_init(), since this is check is already included when
> checking the _OSC control.

s/redunant/redundant/

The concept seems right to me.  Please add a citation to the relevant spec
section.  I think this is somewhere in the PCI Firmware spec.

> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/acpi/pci_root.c       | 3 +++
>  drivers/pci/pcie/aer/aerdrv.c | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 6fc204a52493..19a625ed8de9 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -512,6 +512,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  		 */
>  		*no_aspm = 1;
>  	}
> +
> +	if (!(requested & control & OSC_PCI_EXPRESS_AER_CONTROL))
> +		pci_no_aer();
>  }
>  
>  static int acpi_pci_root_add(struct acpi_device *device,
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 6ff5f5b4f5e6..39bb059777d0 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -374,7 +374,7 @@ static void aer_error_resume(struct pci_dev *dev)
>   */
>  static int __init aer_service_init(void)
>  {
> -	if (!pci_aer_available() || aer_acpi_firmware_first())
> +	if (!pci_aer_available())
>  		return -ENXIO;
>  	return pcie_port_service_register(&aerdriver);
>  }
> -- 
> 2.14.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
