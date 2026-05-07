Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F0175A6E;
	Thu,  7 May 2026 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146295; cv=none; b=Q93hRvHscN0MHTcVMYqz3jruQZuK6i8iG+EPgKjeoIWvYkHivirLNiJVn/9hyPJd7gD9OlFCFxcPlEvWEjd+R0oiUFbLr8HKU/EIB19orwRY79T2racbXGrW84UlrN+H8h8qtYZCguJqxUpDlAy71RMIpTPhY/Sr26lsGg2cxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146295; c=relaxed/simple;
	bh=fnl5fISQxFrCK/lisBXUvoXxWWrrbQLIv9INB6mUopQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUtWia4YISdcG6hfYKK6LBJpNiyQMZTgtNArT268G2vpCH73xKwraecGtxMTCBpDwu+lcDkKSIwUsfGMC9Egc6H9DYAid5DB7tNe9A8XEHkuRMNEufxlHwHqVBLrDL//immbanFo4qIJr41ncsJvLVhB+20LA4VvRplM9IhNZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8CoT6M5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8CoT6M5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778146294; x=1809682294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fnl5fISQxFrCK/lisBXUvoXxWWrrbQLIv9INB6mUopQ=;
  b=G8CoT6M5mhOZwG0BMo1G/n8/+XwOLL7D6s9za2GYDqDpIMsd52Z8I5d5
   f46JduFonIh4zpdOmri3b5YcTbd0p+thiPBQ42LMAYzbvHkT11rdupywx
   lzFjOFtIpDezwHZdQofgIjUap/iC9UWyd+DzelgOTL3CpfsQlXdhxibmW
   TxhNrIurhmx5VWvCliiN4+3quIa4Nb8uB0VBndIXwPuy45MpAyfWjMlgK
   IWCODWctuA2w4UcZQrM08xUPb9DwfhVDxLX8cWlKWlDI1o7KcvzODx+a2
   kQXvuSAOaZp2jFP2Q2L0Asp31LqLP/o1K7DzgSndzG134wxHTH2cYRXXN
   A==;
X-CSE-ConnectionGUID: m3P1y2DwTTiNGe6d073xxA==
X-CSE-MsgGUID: +gN0SbMDS3SJTp4idMxw+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="101767607"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="101767607"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:31:33 -0700
X-CSE-ConnectionGUID: 792qLpIHSgKnVzg2h56TEQ==
X-CSE-MsgGUID: B+lUKi63TAuujGLUo71Fkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="241410896"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.245.122]) ([10.245.245.122])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:31:27 -0700
Message-ID: <a5739875-b8a5-4918-8850-fa4b32d5279d@linux.intel.com>
Date: Thu, 7 May 2026 12:31:24 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] usb: xhci-pci: add generic auxiliary device
 interface
To: Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1778123510.git.hurryman2212@gmail.com>
 <effa7bd7bef8a8ea28b9e28fe47af6a58e39edf2.1778123510.git.hurryman2212@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <effa7bd7bef8a8ea28b9e28fe47af6a58e39edf2.1778123510.git.hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/26 06:31, Jihong Min wrote:
> Some xHCI PCI controllers expose controller-specific functionality that is
> not part of generic xHCI operation and is better handled by optional child
> drivers in other subsystems. Add a small auxiliary device registration path
> for selected xHCI PCI controllers.
> 
> The initial PCI ID match table lists AMD Promontory 21 (PROM21) 1022:43fd
> controllers. For matching controllers, xhci-pci creates an auxiliary
> device and stores it in devres so the remove path destroys it before HCD
> teardown.
> 
> Subsystem-specific child drivers can then bind to those devices through
> the auxiliary bus and keep their hardware-specific logic outside xhci-pci.
> 
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> ---
>   drivers/usb/host/Kconfig    | 10 +++++
>   drivers/usb/host/xhci-pci.c | 83 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 0a277a07cf70..e0c2c7ac5c97 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -42,6 +42,16 @@ config USB_XHCI_PCI
>   	depends on USB_PCI
>   	default y
>   
> +config USB_XHCI_PCI_AUXDEV
> +	bool "xHCI PCI auxiliary device support"
> +	depends on USB_XHCI_PCI
> +	select AUXILIARY_BUS
> +	help
> +	  This enables xHCI PCI support for registering auxiliary devices
> +	  for selected controllers. It is used by optional child drivers
> +	  that bind to xHCI PCI controller-specific functionality through
> +	  the auxiliary bus.
> +
>   config USB_XHCI_PCI_RENESAS
>   	tristate "Support for additional Renesas xHCI controller with firmware"
>   	depends on USB_XHCI_PCI
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 585b2f3117b0..618d6840e108 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -8,6 +8,8 @@
>    * Some code borrowed from the Linux EHCI driver.
>    */
>   
> +#include <linux/auxiliary_bus.h>
> +#include <linux/device/devres.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
>   #include <linux/module.h>
> @@ -80,6 +82,7 @@
>   #define PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI		0x15e1
>   #define PCI_DEVICE_ID_AMD_RAVEN2_XHCI			0x15e5
>   #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI			0x43fd
>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
> @@ -103,6 +106,80 @@ static int xhci_pci_run(struct usb_hcd *hcd);
>   static int xhci_pci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
>   				      struct usb_tt *tt, gfp_t mem_flags);
>   
> +static const struct pci_device_id pci_ids_have_aux[] = {
> +	{ PCI_DEVICE_DATA(AMD, PROM21_XHCI, "prom21_hwmon") },
> +	{ /* end: all zeroes */ }
> +};
> +
> +struct xhci_pci_aux_devres {
> +	struct auxiliary_device *auxdev;
> +};
> +
> +static const char *xhci_pci_aux_dev_name(struct pci_dev *pdev)
> +{
> +	const struct pci_device_id *id;
> +
> +	id = pci_match_id(pci_ids_have_aux, pdev);
> +	if (!id)
> +		return NULL;
> +
> +	return (const char *)id->driver_data;
> +}
> +
> +static void xhci_pci_aux_devres_release(struct device *dev, void *res)
> +{
> +	struct xhci_pci_aux_devres *devres = res;
> +
> +	if (devres->auxdev)
> +		auxiliary_device_destroy(devres->auxdev);
> +}
> +
> +static void xhci_pci_try_add_aux_device(struct pci_dev *pdev)
> +{
> +	struct xhci_pci_aux_devres *devres;
> +	struct auxiliary_device *auxdev;
> +	const char *aux_dev_name;
> +
> +	aux_dev_name = xhci_pci_aux_dev_name(pdev);
> +	if (!aux_dev_name)
> +		return;
> +
> +	devres = devres_alloc(xhci_pci_aux_devres_release, sizeof(*devres),
> +			      GFP_KERNEL);
> +	if (!devres) {
> +		dev_warn(&pdev->dev,
> +			 "failed to allocate auxiliary device state\n");
> +		return;
> +	}
> +
> +	auxdev = auxiliary_device_create(&pdev->dev, KBUILD_MODNAME,
> +					 aux_dev_name, NULL,
> +					 (pci_domain_nr(pdev->bus) << 16) |
> +						 pci_dev_id(pdev));
> +	if (!auxdev) {
> +		devres_free(devres);
> +		dev_warn(&pdev->dev, "failed to add %s auxiliary device\n",
> +			 aux_dev_name);
> +		return;
> +	}
> +
> +	devres->auxdev = auxdev;
> +	devres_add(&pdev->dev, devres);
> +}
> +
> +static void xhci_pci_try_remove_aux_device(struct pci_dev *pdev)
> +{
> +	struct xhci_pci_aux_devres *devres;
> +
> +	devres = devres_find(&pdev->dev, xhci_pci_aux_devres_release, NULL,
> +			     NULL);
> +	if (!devres || !devres->auxdev)
> +		return;
> +
> +	auxiliary_device_destroy(devres->auxdev);
> +	devres->auxdev = NULL;
> +}
> +
>   static const struct xhci_driver_overrides xhci_pci_overrides __initconst = {
>   	.reset = xhci_pci_setup,
>   	.start = xhci_pci_run,
> @@ -677,6 +754,9 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   	if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
>   		pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
>   
> +	if (IS_ENABLED(CONFIG_USB_XHCI_PCI_AUXDEV))
> +		xhci_pci_try_add_aux_device(dev);
> +
>   	return 0;

I think this should be turned around so that the vendor specific code calls the common code.
xhci-pci-renesas.c does this nicely.

In your case it would be adding something like a xhci-pci-prom21.c pci driver:

xhci_pci_prom21_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
	crate_auxiliary_device(dev);
	return xhci_pci_common_probe(dev, id);
}

xhci_pci_prom21_remove(struct pci_dev *dev)
{
	destroy_auxiliary_device(dev);
	xhci_pci_remove(dev);
}

static const struct pci_device_id pci_ids[] = {
	{ PCI_DEVICE(YOUR_AMD_PCI_VENDOR_ID, YOUR_PROM21_DEVICE_ID) },
	{ /* end: all zeroes */ }
};
MODULE_DEVICE_TABLE(pci, pci_ids);

static struct pci_driver xhci_prom21_pci_driver = {
	.name =		"xhci-pci-prom21",
	.id_table =	pci_ids,

	.probe =	xhci_pci_prom21_probe,
	.remove =	xhci_pci_prom21_remove,

	.shutdown = 	usb_hcd_pci_shutdown,
	.driver = {
		.pm = pm_ptr(&usb_hcd_pci_pm_ops),
	},
};
module_pci_driver(xhci_prom21_pci_driver);

MODULE_DESCRIPTION("AMD Promontory 21 xHCI PCI Host Controller Driver");
MODULE_IMPORT_NS("xhci");
MODULE_LICENSE("GPL v2");

-Mathias
