Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 20 Mar 2015 16:03:54 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH update] PCI / ACPI: PCI delay optimization from ACPI
Message-ID: <20150320210354.GK26935@google.com>
References: <54FD4FB9.2060802@intel.com>
 <5222588.FaRe37n2T1@vostro.rjw.lan>
 <54FE93A4.9040908@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54FE93A4.9040908@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 10, 2015 at 02:48:04PM +0800, Aaron Lu wrote:
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
> This patche adds support for function 8 and part of function 9. For
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
> index 489063987325..468c0733838e 100644
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
> + * Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM
> + * control method of either its own or its parent bridge.
> + *
> + * The UUID of the _DSM control method, together with other information like
> + * which delay values can be optimized, etc. is defined in a ECN available on
> + * PCIsig.com titled as: ACPI additions for FW latency optimizations.
> + * Function 9 of the ACPI _DSM control method, if available for a specific PCI
> + * device, provides various possible delay values that are less than what the
> + * SPEC requires. Here, we only deal with d3_delay and d3cold_delay. Others
> + * can be added later.
> + * Function 8 of the ACPI _DSM control method, if available for a specific PCI
> + * bridge, means all its children devices do not need the reset delay when
> + * leaving from D3cold state.
> + */
> +static void pci_acpi_delay_optimize(struct pci_dev *pdev, struct acpi_device *adev)
> +{
> +	const u8 uuid[] = {
> +		0xd0, 0x37, 0xc9, 0xe5, 0x53, 0x35, 0x7a, 0x4d,
> +		0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
> +	};

This is a duplicate of device_label_dsm_uuid[] from
drivers/pci/pci-label.c.  I don't really want two copies.

That UUID is not specific to device labels, so device_label_dsm_uuid[] is
mis-named anyway.  It's just the UUID for the single _DSM for PCI (see PCI
Firmware Specification, r3.0, sec 4.6), and all these different things
(device label, reset delay, slot info, etc.) use the same UUID with
different function indices.

We should also make #defines for the function indices instead of using
hard-coded numbers here.

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

Unless there's a reason to do this in "element[3], element[0]" order,
please do it in the natural "0, 3" order.

> +		}
> +		kfree(obj);
> +	}
> +
> +	function = 8;
> +	handle = ACPI_HANDLE(pdev->bus->bridge);
> +	obj = acpi_evaluate_dsm(handle, uuid, revision, function, NULL);

Hmm.  I think the ECN is poorly worded here.  Sec 4.6.8 says "This object
[_DSM] can only be placed within the scope of a PCI host bus." I think it
means "this _DSM *function* can only be implemented ..." (since any device
can have a _DSM), and I think it means "host *bridge*" (not bus, since I
don't think there's an ACPI object for a PCI bus).

It probably should say "This function can be implemented only by a _DSM
method within the scope of a PCI host bridge."

Anyway, I think this patch looks for a _DSM in PCI-PCI bridge devices as
well as PCI host bridge devices, and the ECN says any values returned by
function 8 of a non-host bridge _DSM method should be ignored.  At least,
that's how I read it.

I think you need something in pci_root.c that evaluates _DSM function 8 for
the host bridge, and then some mechanism for all the devices under that
bridge to inherit the result.

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
> -- 
> 2.1.0
> 
