Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11BB3803F4;
	Thu,  1 Oct 2026 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790888048; cv=none; b=gsHBBUjwezjRjRuX9Vr+e3aii4hdDLVX7YbiBNkxT1bt0GOrWOOGnuKT6XqK48ASAjWxK0y69K+yXerD2dCH9idmtkXJfllg0UcV7gcb/2bGorg0vgRPLHDxKq2qduRqwLJ7idvFeRjerfKHYjJW9tsl0LQNM1BSyjDPtrRA1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790888048; c=relaxed/simple;
	bh=P3SF9otAZdJaxkszqcz5bv11Q1Mfs4zmqC0bR20qF+o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gUsye23hfbrw27L9tE3Wj7V4l9qxK0OwRU5yn+npD2yZX5H8oeL4duGjVdKTSwIviZq2Wl+Uuwf+NQ4qJO/uxmZC8uRtl53MVqF6iprwFx12wON814oXxiZfSbbDUTrnYhWdujGUMNyi2cuAgUOilQuuGSgqBny9uMLLd6AYiSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZboiL11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZboiL11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A741F000FF;
	Thu,  1 Oct 2026 20:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790888046;
	bh=19czLLVCO1aWFVXglQpbsw/YidD2Z2K+3NWJraSpMQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=aZboiL11hlWy+5tMoU8k3/CGxt+OvITo5nk9APZ9Dmp31l2JBoTROo1slOR6WykOg
	 Eel5a6r9pWdfaQzqTMBVMFW2HR+6l70yogDFl15p393EBlL5u5A0v8QFFPX5++OiFm
	 DPGFwX+uybzY/S8bUKAcYlmCClPTq9RzzdRuCIOdcmyJtONWV2L+00gaPlT8ND8g6t
	 XKcF9n1WxA4EC8LM8FnpYuMZTHQhPCWlpcnm2l87eQwGajfdaYG2Vr1fCy9hAsJyGs
	 UrBL9uOiQRR1QzpT5DhHS6gD+gjfBMFAxyirWyU/oj5XQyU55hrtwRJNfal94JMpMJ
	 IV0iVygYqHbRQ==
Date: Thu, 1 Oct 2026 15:54:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, lukas@wunner.de, terry.bowman@amd.com,
	kanie@linux.alibaba.com, olof@lixom.net
Subject: Re: [PATCH v14 3/4] PCI/ACPI: Centralize pcie_ports_native checking
Message-ID: <20261001205404.GA2718182@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922204548.3884906-4-sathyanarayanan.kuppuswamy@linux.intel.com>

On Tue, Sep 22, 2026 at 01:45:47PM -0700, Kuppuswamy Sathyanarayanan wrote:
> If the user booted with "pcie_ports=native", we take control of the PCIe
> port services unconditionally, regardless of what _OSC says.
> 
> Centralize the testing of pcie_ports_native in acpi_pci_root_create(),
> where we interpret the _OSC results, so other places only have to check
> host_bridge->native_X and we don't have to sprinkle tests of
> pcie_ports_native everywhere.
> 
> Rather than overriding the host_bridge->native_X flags after the fact,
> fold "pcie_ports=native" into the _OSC control mask we evaluate, i.e.,
> proceed as though the platform had granted control of the port services.
> That way there is a single mechanism deciding each native_X flag, and we
> can report exactly which features we are overriding _OSC for instead of
> just noting that we are overriding something:
> 
>   acpi PNP0A08:00: _OSC: OS forcing control ("pcie_ports=native") of [PCIeHotplug PME AER DPC]
> 
> Forcing host_bridge->native_aer also restores DPC service binding under
> "pcie_ports=native", which regressed in commit 97ca178c899d ("PCI/DPC:
> Allow DPC on all Downstream Ports when OS controls AER").  That commit
> replaced the AER service test in get_port_device_capability() with
> host->native_aer, so DPC stayed off when host_bridge->native_aer was not
> set.
> 
> This also extends "pcie_ports=native" to host_bridge->native_dpc, which
> had no pcie_ports_native fallback before.  That effect is narrow.
> native_dpc is only consumed by pci_dpc_recovered(), where with
> CONFIG_PCIE_EDR=n it previously gave up immediately and now lets pciehp
> wait for DPC recovery before treating a Link Down as a hotplug event.
> 
> host_bridge->native_ltr is deliberately not forced.  "pcie_ports="
> controls PCIe port services and LTR is not one.  There is no
> PCIE_PORT_SERVICE_LTR, and native_ltr is only used by
> pci_configure_ltr() to enable ASPM L1.2, so forcing it would be an ASPM
> policy decision users did not ask for.
> 
> SHPC hotplug is left alone for a simpler reason: SHPC is a conventional
> PCI feature rather than a PCIe one, so "pcie_ports=" has no bearing on
> it.
> 
> Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
> Closes: https://lore.kernel.org/linux-pci/20260901064554.2178688-1-kanie@linux.alibaba.com/
> [bhelgaas: commit log, rework OSC_PCIE_PORT_SERVICE_CONTROLS, logging]
> Link: https://lore.kernel.org/r/bc87c9e675118960949043a832bed86bc22becbd.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # ACPI core
> ---
> Changes since v13
> 
>  * Added the Fixes: tag for 97ca178c899d. (Guixin Liu)
>  * Reworded the commit log (Sashiko AI review).
>  * No code change. Picked up Rafael's Acked-by.
> 
> v13 posting
> https://lore.kernel.org/r/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com
> 
>  drivers/acpi/pci_root.c           | 36 +++++++++++++++++++++++++++++++
>  drivers/pci/hotplug/pciehp_core.c |  2 +-
>  drivers/pci/pci-acpi.c            |  3 ---
>  drivers/pci/pcie/aer.c            |  6 +++---
>  drivers/pci/pcie/aer_cxl_rch.c    |  2 +-
>  drivers/pci/pcie/err.c            |  2 +-
>  drivers/pci/pcie/portdrv.c        |  6 +++---
>  7 files changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 756dc2f055f5..2494811dd69b 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -999,6 +999,19 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
>  			flag = 0;		\
>  	} while (0)
>  
> +#define FLAG(x)		((x) ? '+' : '-')
> +
> +/*
> + * _OSC control bits for the features implemented by the PCIe port driver,
> + * i.e., the ones "pcie_ports=native" applies to.  LTR and SHPC hotplug are
> + * negotiated via _OSC as well, but they are not portdrv services, so
> + * "pcie_ports=" has no bearing on them.
> + */
> +#define OSC_PCIE_PORT_SERVICE_CONTROLS	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL | \
> +					 OSC_PCI_EXPRESS_PME_CONTROL | \
> +					 OSC_PCI_EXPRESS_AER_CONTROL | \
> +					 OSC_PCI_EXPRESS_DPC_CONTROL)
> +
>  struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  				     struct acpi_pci_root_ops *ops,
>  				     struct acpi_pci_root_info *info,
> @@ -1039,6 +1052,21 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	ctrl = root->osc_control_set;
>  	ext_ctrl = root->osc_ext_control_set;
>  
> +	/*
> +	 * If the user specified "pcie_ports=native", use the PCIe port
> +	 * services regardless of what _OSC says, i.e., proceed as though the
> +	 * platform had granted us control of them.  This may conflict with
> +	 * firmware that expects to own those features.
> +	 */
> +	if (pcie_ports_native) {
> +		u32 override = OSC_PCIE_PORT_SERVICE_CONTROLS & ~ctrl;
> +
> +		if (override)
> +			decode_osc_control(root, "OS forcing control (\"pcie_ports=native\") of",
> +					   override);
> +		ctrl |= override;
> +	}
> +
>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_NATIVE_HP_CONTROL,
>  		  host_bridge->native_pcie_hotplug);
>  	OSC_OWNER(ctrl, OSC_PCI_SHPC_NATIVE_HP_CONTROL,
> @@ -1051,6 +1079,14 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	OSC_OWNER(ext_ctrl, OSC_CXL_ERROR_REPORTING_CONTROL,
>  		  host_bridge->native_cxl_error);
>  
> +	dev_info(&root->device->dev, "OS native features: SHPCHotplug%c PCIeHotplug%c PME%c AER%c DPC%c LTR%c\n",
> +		 FLAG(host_bridge->native_shpc_hotplug),
> +		 FLAG(host_bridge->native_pcie_hotplug),
> +		 FLAG(host_bridge->native_pme),
> +		 FLAG(host_bridge->native_aer),
> +		 FLAG(host_bridge->native_dpc),

I think the native_dpc printed here is inaccurate if booted with
"pci=dpc-native", isn't it?

Can we test pcie_ports_dpc_native above, similar to what we did with
pcie_ports_native?

The DPC probe handling still seems kind of convoluted.  In portdrv.c,
we have this:

  get_port_device_capability()
  {
    if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
	pci_aer_available() &&
	(pcie_ports_dpc_native || host->native_aer))
	    services |= PCIE_PORT_SERVICE_DPC;

And then we have this in dpc.c:

  dpc_probe()
  {
    if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
	    return -ENOTSUPP;

The combination of get_port_device_capability() and dpc_probe() makes
my head hurt.

It seems like the DPC clause of get_port_device_capability() should be
parallel to the AER clause, i.e., set PCIE_PORT_SERVICE_DPC if the
device has a DPC Capability and the OS owns DPC (host->native_dpc).
Anything other than that needs explanation.

I'm confused about why host->native_dpc is not involved in the
dpc_probe() path at all.

> +		 FLAG(host_bridge->native_ltr));
> +
>  	acpi_dev_power_up_children_with_adr(device);
>  
>  	pci_scan_child_bus(bus);
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 2cafd3b26f34..b42829cf1377 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -258,7 +258,7 @@ static bool pme_is_native(struct pcie_device *dev)
>  	const struct pci_host_bridge *host;
>  
>  	host = pci_find_host_bridge(dev->port->bus);
> -	return pcie_ports_native || host->native_pme;
> +	return host->native_pme;
>  }
>  
>  static void pciehp_disable_interrupt(struct pcie_device *dev)
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 42d545edd7fa..1150f2fbabf4 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -812,9 +812,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>  		return false;
>  
> -	if (pcie_ports_native)
> -		return true;
> -
>  	host = pci_find_host_bridge(bridge->bus);
>  	return host->native_pcie_hotplug;
>  }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d8dcd238fda1..e84dd686582a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -260,7 +260,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  	if (!dev->aer_cap)
>  		return 0;
>  
> -	return pcie_ports_native || host->native_aer;
> +	return host->native_aer;
>  }
>  EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>  
> @@ -1847,7 +1847,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	 */
>  	aer = root ? root->aer_cap : 0;
>  
> -	if ((host->native_aer || pcie_ports_native) && aer)
> +	if (host->native_aer && aer)
>  		aer_disable_irq(root);
>  
>  	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
> @@ -1862,7 +1862,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  			pci_is_root_bus(dev->bus) ? "Root" : "Downstream", rc);
>  	}
>  
> -	if ((host->native_aer || pcie_ports_native) && aer) {
> +	if (host->native_aer && aer) {
>  		/* Clear Root Error Status */
>  		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
>  		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index e471eefec9c4..b480dad8bbf4 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -31,7 +31,7 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  
> -	return (pcie_ports_native || host->native_aer);
> +	return host->native_aer;
>  }
>  
>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index d77403d8855b..1a7fc71c79d8 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -273,7 +273,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	 * it is responsible for clearing this status.  In that case, the
>  	 * signaling device may not even be visible to the OS.
>  	 */
> -	if (host->native_aer || pcie_ports_native) {
> +	if (host->native_aer) {
>  		pcie_clear_device_status(dev);
>  		pci_aer_clear_nonfatal_status(dev);
>  	}
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index a9cbfc1d2bc7..32fc623dd410 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -223,7 +223,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	if (dev->is_pciehp &&
>  	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>  	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
> -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> +	    host->native_pcie_hotplug) {
>  		services |= PCIE_PORT_SERVICE_HP;
>  
>  		/*
> @@ -240,14 +240,14 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>               pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>  	    dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer))
> +	    host->native_aer)
>  		services |= PCIE_PORT_SERVICE_AER;
>  #endif
>  
>  	/* Root Ports and Root Complex Event Collectors may generate PMEs */
>  	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>  	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> -	    (pcie_ports_native || host->native_pme)) {
> +	    host->native_pme) {
>  		services |= PCIE_PORT_SERVICE_PME;
>  
>  		/*
> -- 
> 2.43.0
> 
