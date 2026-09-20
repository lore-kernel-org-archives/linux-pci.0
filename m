Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6552C21FD;
	Sun, 20 Sep 2026 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889414; cv=none; b=hLmvdOKlISjqVUVED8Y1SZoZK4z/YEd172bpQ64/J7HVtN4NZg/mzbbI5fw0/q1Y2EsINoi+HoGo/RM2Km0qB5AO2UndfSPyh8JnxXAPrHHaBEkuBsUK5k9RXK+9DYsHSoXaNwSZqg89DkFvPtzty+C5iwOSU9VY2XTo3fBdRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889414; c=relaxed/simple;
	bh=DSmKi0gEUDXgiCebk2KZg2kigiuBP4n+dizNd1OBVOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKt4W/DFxVcaKpYWvxbP9tcd9OX09TpTXNrrewY2hk4M0t/peS4qdutgNOpupKDpLpZKh1lypNf7ApXsL4BO+i0q5LxyON6BWREFkehV4t8B13/+dEF8ufL4+cjZwN+DcFqctL3qWNkH1Tg3aoG/mwZAAWXGqf8J2IaXJCLC1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U22eTeQZ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U22eTeQZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789889402; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3GIjOkoORuW+fwMx+GZ0VoC+jn9XTjlz2B/8pb+MN/U=;
	b=U22eTeQZKFo9hmHSSp+9hX60vTac33PD9l+EPckHU+kCrJz8nGufRQ8uLcKh9JvFHPEVrzQdmn4UVP24XbQnff7u7UMb9kUdqf52cl2PAITDOlFVJexOHUxSOwKrqa3gwSrlJLUiPfssT9hzaVKMpOT8OoUvrZSxeMQkzWuTXvg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XBFJB44_1789889075;
Received: from 30.178.84.196(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBFJB44_1789889075 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 15:24:36 +0800
Message-ID: <905ddaea-8ed3-4c8b-ae4e-593a81e59833@linux.alibaba.com>
Date: Sun, 20 Sep 2026 15:24:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/5] PCI/ACPI: Centralize pcie_ports_native checking
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rafael J Wysocki <rafael@kernel.org>,
 Olof Johansson <olof@lixom.net>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-5-sathyanarayanan.kuppuswamy@linux.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260919162655.3499010-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/20 00:26, Kuppuswamy Sathyanarayanan 写道:
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
> This also extends "pcie_ports=native" to host_bridge->native_dpc, which
> had no pcie_ports_native fallback before.  The effect is narrow.
> native_dpc is only used by pci_dpc_recovered(), and only when
> CONFIG_PCIE_EDR=n, where hotplug now waits for firmware-owned DPC
> recovery.
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
> [bhelgaas: commit log, rework OSC_PCIE_PORT_SERVICE_CONTROLS, logging]
> Link: https://lore.kernel.org/r/bc87c9e675118960949043a832bed86bc22becbd.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>、
Should add Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER").

Best Regards,
Guixin Liu
> ---
> Changes since v12
>
>  * Rebased to v7.3-rc3.
>  * Fold "pcie_ports=native" into the _OSC control mask instead of
>    overriding the native_X flags afterwards, and report which features we
>    override, as agreed in the v12 review.
>  * Do not force native_ltr, which v12 did.  LTR is not a PCIe port
>    service, so "pcie_ports=" should not affect it.
>
> v12 posting
> https://lore.kernel.org/all/20201126011816.711106-1-helgaas@kernel.org/
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

