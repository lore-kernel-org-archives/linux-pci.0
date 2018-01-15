Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 15 Jan 2018 15:12:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, bp@suse.de
Subject: Re: [PATCH v2] PCI/ACPI: Disable AER when _OSC control bit is clear.
Message-ID: <20180115211212.GB178717@bhelgaas-glaptop.roam.corp.google.com>
References: <20180115162006.45553-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180115162006.45553-1-Yazen.Ghannam@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 15, 2018 at 10:20:06AM -0600, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Currently, aer_service_init() checks if AER is available and that
> Firmware First handling is not enabled. The _OSC request for AER is not
> taken into account when deciding to enable AER in Linux.

It *looks* like it should be, via the following paths:

  acpi_pci_root_add
    negotiate_os_control
      if (pci_aer_available() ...)
        control |= OSC_PCI_EXPRESS_AER_CONTROL
      acpi_pci_osc_control_set(..., &control, ...)
        acpi_pci_run_osc
        root->osc_control_set = *mask

  pcie_portdrv_probe
    pcie_port_device_register
      get_port_device_capability
        pcie_port_platform_notify
          pcie_port_acpi_setup
            flags = root->osc_control_set
            if (flags & OSC_PCI_EXPRESS_AER_CONTROL)
              *srv_mask |= PCIE_PORT_SERVICE_AER

But the _OSC and PCIe port driver setup is way too complicated, so I'm
not surprised something is broken.

Where did this path go wrong?  Could a similar problem happen with
services other than AER?  Is this fixing a real defect you tripped
over?  If so, what are the details of the problem?

The idea of "the OS not setting a control bit, but the platform
returning with it set" is not specific to AER, so if we need to check
for that, I think we should be consistent and do it for *all* the
bits, not just AER.

> From ACPI 6.2 Section 6.2.11.3, "If any bits in the Control Field are
> returned cleared (masked to zero) by the _OSC control method, the
> respective feature is designated unsupported by the platform and must
> not be enabled by the OS."
> 
> The OS and the Platform should agree that the OS can have control of AER
> otherwise we should disable AER in the OS.
> 
> Mark AER as disabled if the _OSC request was not made or accepted.
> 
> This covers two cases where the OS and Platform disagree:
> 1) The OS requests AER control and Platform denies the request.
> 2) The OS does not request AER control but the Platform returns the AER
>    control bit set, possibly due to a Firmware bug.
> 
> The _OSC control for AER is not requested when APEI Firmware First is
> used, so the same condition applies from case 2 above.
> 
> Remove redundant check for aer_acpi_firmware_first() when calling
> aer_service_init(), since this check is already included when checking
> the _OSC control.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20180111150316.19951-1-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * Expand commit message.
> * Add Spec reference to commit message.
> * Fix spelling error in commit message.
> * Add comment for 3-way bitwise AND.
> 
>  drivers/acpi/pci_root.c       | 7 +++++++
>  drivers/pci/pcie/aer/aerdrv.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 6fc204a52493..ab0192fd24c7 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -512,6 +512,13 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  		 */
>  		*no_aspm = 1;
>  	}
> +
> +	/*
> +	 * We can use a 3-way bitwise AND to check that the AER control bit is
> +	 * both requested by the OS and granted by the Platform.
> +	 */
> +	if (!(requested & control & OSC_PCI_EXPRESS_AER_CONTROL))
> +		pci_no_aer();

Now I think root->osc_control_set is incorrect: it claims the OS
controls AER, but that is not the case.

We should handle all these services the same way.  AFAICS,
osc_control_set is what the others rely on, so AER should do the same.

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

I agree this looks redundant.  I *think* it is unrelated to the rest
of the patch and should be split out to a separate patch because it
confuses what is already a confusing situation.

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
