Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37058 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbbCXWJr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2015 18:09:47 -0400
Received: by igcxg11 with SMTP id xg11so10513050igc.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2015 15:09:47 -0700 (PDT)
Date: Tue, 24 Mar 2015 17:09:43 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI / ACPI: PCI delay optimization from ACPI
Message-ID: <20150324220943.GD2495@google.com>
References: <54FD4FB9.2060802@intel.com>
 <5222588.FaRe37n2T1@vostro.rjw.lan>
 <54FE93A4.9040908@intel.com>
 <20150320210354.GK26935@google.com>
 <550FDA38.2090505@intel.com>
 <20150323150955.GR26935@google.com>
 <551128BA.7070508@intel.com>
 <20150324140812.GB2495@google.com>
 <55117FD6.5090903@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55117FD6.5090903@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 24, 2015 at 11:16:38PM +0800, Aaron Lu wrote:
> Here is an updat, kind of a proof of concept one, to see if it goes the
> right way:

I think what you've outlined below makes sense.  I had a few minor
comments.

> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index 3e5bbf9e8889..e40512d3f373 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -16,7 +16,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
>  	return bus;
>  }
>  
> -static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)

I'd change the name to "pci_find_host_bridge()" to be more like other
interfaces.  Do that in a separate patch because it changes some callers
and can be done separately.

>  {
>  	struct pci_bus *root_bus = find_pci_root_bus(bus);
>  
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e0afc94aca01..04d5b5befbe9 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -537,11 +537,32 @@ static struct pci_platform_pm_ops acpi_pci_platform_pm = {
>  
>  void acpi_pci_add_bus(struct pci_bus *bus)
>  {
> +	union acpi_object *obj;
> +	struct pci_host_bridge *bridge;
> +
>  	if (acpi_pci_disabled || !bus->bridge)
>  		return;
>  
>  	acpi_pci_slot_enumerate(bus);
>  	acpiphp_enumerate_slots(bus);
> +
> +	/*
> +	 * For a host bridge, check its _DSM for function 8 and if
> +	 * that is available, mark it in pci_host_bridge.
> +	 */
> +	if (!pci_is_root_bus(bus))
> +		return;
> +
> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), pci_acpi_dsm_uuid, 3,
> +				RESET_DELAY_DSM, NULL);
> +	if (obj) {
> +		if (obj->type == ACPI_TYPE_INTEGER &&
> +		    obj->integer.value == 1) {
> +			bridge = find_pci_host_bridge(bus);
> +			bridge->ignore_reset_delay = true;
> +		}
> +		ACPI_FREE(obj);
> +	}

    if (!obj)
	return;

    <mainline code is normal path, as you did below>
    ACPI_FREE(obj);

>  }
>  
>  void acpi_pci_remove_bus(struct pci_bus *bus)
> @@ -567,6 +588,56 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
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
> + * Function 8 of the ACPI _DSM control method, if available for the PCI host
> + * bridge(reflected by the bus' ignore_reset_delay filed), means all its
> + * children devices do not need the reset delay when leaving from D3cold state.
> + */
> +static void pci_acpi_delay_optimize(struct pci_dev *pdev,
> +				    acpi_handle handle)
> +{
> +	struct pci_host_bridge *bridge = find_pci_host_bridge(pdev->bus);
> +	int value;
> +	union acpi_object *obj, *elements;
> +
> +	if (bridge->ignore_reset_delay)
> +		pdev->d3cold_delay = 0;
> +
> +	obj = acpi_evaluate_dsm(handle, pci_acpi_dsm_uuid, 3,
> +				FUNCTION_DELAY_DSM, NULL);
> +	if (!obj)
> +		return;
> +
> +	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
> +		elements = obj->package.elements;
> +		if (elements[0].type == ACPI_TYPE_INTEGER) {
> +			value = (int)elements[0].integer.value / 1000;
> +			if (value < PCI_PM_D3COLD_WAIT)
> +				pdev->d3cold_delay = value;
> +		}
> +		if (elements[3].type == ACPI_TYPE_INTEGER) {
> +			value = (int)elements[3].integer.value / 1000;
> +			if (value < PCI_PM_D3_WAIT)
> +				pdev->d3_delay = value;
> +		}
> +	}
> +	ACPI_FREE(obj);
> +}
> +
>  static void pci_acpi_setup(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> @@ -575,6 +646,8 @@ static void pci_acpi_setup(struct device *dev)
>  	if (!adev)
>  		return;
>  
> +	pci_acpi_delay_optimize(pci_dev, adev->handle);
> +
>  	pci_acpi_add_pm_notifier(adev, pci_dev);
>  	if (!adev->wakeup.flags.valid)
>  		return;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4091f82239cd..802e7c0c7f9f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -321,4 +321,6 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>  }
>  #endif
>  
> +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 3801c704a945..a965efa52152 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -79,6 +79,8 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>  
>  extern const u8 pci_acpi_dsm_uuid[];
>  #define DEVICE_LABEL_DSM	0x07
> +#define RESET_DELAY_DSM		0x08
> +#define FUNCTION_DELAY_DSM	0x09
>  
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a379513bddef..e587832885e9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -406,6 +406,7 @@ struct pci_host_bridge {
>  	struct list_head windows;	/* resource_entry */
>  	void (*release_fn)(struct pci_host_bridge *);
>  	void *release_data;
> +	bool ignore_reset_delay;

I'm not sold on this new-fangled "bool" thing yet.  Please just use
"unsigned int ignore_reset_delay:1" like most other uses in pci.h.

>  };
>  
>  #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
> -- 
> 2.1.0
> 
