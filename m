Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 30 Mar 2018 17:34:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] PCI/DPC: Do not enable DPC if AER control is not
 allowed by the BIOS
Message-ID: <20180330223441.GE9322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180327104835.19664-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180327104835.19664-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 27, 2018 at 01:48:35PM +0300, Mika Westerberg wrote:
> Commit eed85ff4c0da ("PCI/DPC: Enable DPC only if AER is available")
> made DPC control dependent whether AER is enabled in the OS. However, it
> does not take into account situations where BIOS has not given OS
> control of AER:
> 
>   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
>   acpi PNP0A08:00: _OSC: platform does not support [AER]
>   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 
> I think here it is better not to enable DPC even if the capability is
> available because then it would be against what "Determination of DPC
> Control" note in PCIe 4.0 sec 6.1.10 recommends.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to pci/portdrv for v4.17, thanks!

> ---
> Changes from v1:
> 
>   * Rebased on top of pci.git/pci/portdrv
>   * Dropped the other patch that disables interrupt generation during
>     suspend because there is development on-going to get rid of separate
>     PCIe portdrv and move everything to the PCI core instead.
> 
>  drivers/pci/pcie/portdrv_acpi.c | 4 ++--
>  drivers/pci/pcie/portdrv_core.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
> index 9d12650dc2ae..8ab5d434b9c6 100644
> --- a/drivers/pci/pcie/portdrv_acpi.c
> +++ b/drivers/pci/pcie/portdrv_acpi.c
> @@ -47,11 +47,11 @@ void pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
>  
>  	flags = root->osc_control_set;
>  
> -	*srv_mask = PCIE_PORT_SERVICE_DPC;
> +	*srv_mask = 0;
>  	if (flags & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)
>  		*srv_mask |= PCIE_PORT_SERVICE_HP;
>  	if (flags & OSC_PCI_EXPRESS_PME_CONTROL)
>  		*srv_mask |= PCIE_PORT_SERVICE_PME;
>  	if (flags & OSC_PCI_EXPRESS_AER_CONTROL)
> -		*srv_mask |= PCIE_PORT_SERVICE_AER;
> +		*srv_mask |= PCIE_PORT_SERVICE_AER | PCIE_PORT_SERVICE_DPC;
>  }
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index a1f838f2646a..eb463966094e 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -236,7 +236,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -	    pci_aer_available())
> +	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	return services;
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
