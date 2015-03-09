Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Aaron Lu <aaron.lu@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI / ACPI: PCI delay optimization from ACPI
Date: Mon, 09 Mar 2015 15:33:30 +0100
Message-ID: <5222588.FaRe37n2T1@vostro.rjw.lan>
In-Reply-To: <54FD4FB9.2060802@intel.com>
References: <54FD4FB9.2060802@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, March 09, 2015 03:46:01 PM Aaron Lu wrote:
> An ECN meant to specify possible delay optimizations is available on
> the PCI website:
> https://www.pcisig.com/specifications/conventional/pci_firmware/ECN_fw_latency_optimization_final.pdf
> where it has defined two functions for an UUID specified _DSM:
> Function 8: If system firmware assumes the responsibility of post
> Conventional Reset delay (and informs the Operating System via this DSM
> function) on Sx Resume (such as boot from ACPI S5, or resume from ACPI
> S4 or S3 states), the Operating System may assume sufficient time has
> elapsed since the end of reset, and devices within the PCI subsystem are
> ready for Configuration Access.
> If the system firmware supports runtime power gating on any of the
> device within PCI subsystem covered by this DSM function, the system
> firmware is responsible for covering the necessary post power-on reset
> delay.
> 
> Function 9: Specify various smaller delay values than required by the
> SPEC for individual PCI devices like shorter delay values after
> conventional reset, D3hot to D0 transition, functional level reset, etc.
> 
> This patch adds support for function 8 and part of function 9. For
> function 8, the patch will check if the required _DSM function satisfies
> the requirement and then set the per PCI device's d3cold_delay variable
> to zero. For function 9, the values affecting delays after conventional
> reset and D3hot->D0 are examined and the per PCI device's d3cold_delay
> and d3_delay are updated if the _DSM's return value is smaller than what
> the SPEC requires.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  drivers/pci/pci-acpi.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 489063987325..c833b054c00c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -558,6 +558,64 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
>  				      check_children);
>  }
>  
> +/**
> + * pci_acpi_delay_optimize - optimize PCI D3 and D3cold delay from ACPI
> + * @pdev: the PCI device whose delay is to be updated
> + * @adev: the companion ACPI device of this PCI device
> + *
> + * Description:

The word "Description" above is not necessary.

> + *   This function is used to update the d3_delay and d3cold_delay of a PCI

I'd simply say

"Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM control
method of either its own or its parent bridge."

I'd add an empty line here and then the rest of the below starting with "The UUID ...".

> + *   device from ACPI _DSM control method of either its own or its parent
> + *   bridge device. The UUID of the _DSM control method, together with other
> + *   information like which delay values can be optimized, etc. is defined in
> + *   the fw_latency_optimization ECN availabe on PCIsig.com.

The ECN has a number or title I suppose?

> + *   Function 9 of the ACPI _DSM control method, if availabe for a specific PCI
> + *   device, provides various possible delay values that are less than what the
> + *   SPEC requires. Here, we only deal with d3_delay and d3cold_delay. Others
> + *   can be added later.
> + *   Function 8 of the ACPI _DSM control method, if availabe for a specific PCI
> + *   bridge, means all its children devices do not need the reset delay when
> + *   leaving from D3cold state.
> + */
> +static void pci_acpi_delay_optimize(struct pci_dev *pdev, struct acpi_device *adev)
> +{
> +	const u8 uuid[] = {
> +		0xd0, 0x37, 0xc9, 0xe5, 0x53, 0x35, 0x7a, 0x4d,
> +		0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
> +	};
> +	int revision = 3, function = 9, value;
> +	acpi_handle handle = adev->handle;
> +	union acpi_object *obj, *elements;
> +
> +	obj = acpi_evaluate_dsm(handle, uuid, revision, function, NULL);
> +	if (obj) {
> +		if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
> +			elements = obj->package.elements;
> +			if (elements[3].type == ACPI_TYPE_INTEGER) {
> +				value = (int)elements[3].integer.value / 1000;
> +				if (value < PCI_PM_D3_WAIT)
> +					pdev->d3_delay = value;
> +			}
> +			if (elements[0].type == ACPI_TYPE_INTEGER) {
> +				value = (int)elements[0].integer.value / 1000;
> +				if (value < PCI_PM_D3COLD_WAIT)
> +					pdev->d3cold_delay = value;
> +			}
> +		}
> +		kfree(obj);
> +	}
> +
> +	function = 8;
> +	handle = ACPI_HANDLE(pdev->bus->bridge);
> +	obj = acpi_evaluate_dsm(handle, uuid, revision, function, NULL);
> +	if (!obj)
> +		return;
> +
> +	if (obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 1)
> +		pdev->d3cold_delay = 0;
> +	kfree(obj);
> +}
> +
>  static void pci_acpi_setup(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> @@ -566,6 +624,9 @@ static void pci_acpi_setup(struct device *dev)
>  	if (!adev)
>  		return;
>  
> +	if (pci_dev->pm_cap)
> +		pci_acpi_delay_optimize(pci_dev, adev);
> +
>  	pci_acpi_add_pm_notifier(adev, pci_dev);
>  	if (!adev->wakeup.flags.valid)
>  		return;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
