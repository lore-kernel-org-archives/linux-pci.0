Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55330F927;
	Wed,  6 May 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074688; cv=none; b=hwRhvxlmLKYeJFu0LHE+C2ZGupejjlS1TsXaAZ9ry88GGQh01osvyzC6x62qzncv9IgG15nSLVl9kSyRK6T28OVjHJZOhQK+uCthHugwe3ijHZ96oWHkvkN8CK17sM8OSmP9tL1KKhu0VYvROnf0Mn6IdrCfY25gzBisjKm82b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074688; c=relaxed/simple;
	bh=vieghuNcP4/wAF01QlBhgZQjXaPutz2uTHabc/a677I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmf8yDI0p/VtDgKEXSLwfNRt0TW06AOiO1nTJrnUgFqne9M3rqflzr29ZCK64MT6NXc8TbuseqlZnzTczA+Bx2Dveb9d07jNRKJius8zZKow1RzPLtIpFPqmRkavo9VXyqZL6B7mHf/h2Jj7Ayjhp1jFgBroaO14NdCZYDmJPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfzTO1mb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfzTO1mb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778074685; x=1809610685;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vieghuNcP4/wAF01QlBhgZQjXaPutz2uTHabc/a677I=;
  b=SfzTO1mbmJUoAoC18w3vrmNmWGkBlZmpwE2yxfxbtyAlyrgszkKVAnnS
   lsr+FOz2UNKFcUSRukmq8B9j9nrqNTZJklhDBldsvfuezp0l1V00FDmrJ
   f0/uJHpwWqqN/Nfh2+20uJkOVQoMiu5OsIuMH3Ed2TrWVzx8anAEWmH6Z
   N8NPItahKtMMfJFhqY2k5RT9Ig5o99VQ/Xd5QaelvRAsyyvoLLudEGChL
   W2b3IVnU8zyfpjEVNrlZBg3aBlhjNgXTqxEdrl2+pWgpa7qrsbRZzllIW
   2INsN396SqpVgeHTfP2rQHShqOXVgCMpfpgquIaheDBcOrL52sNTIoWH3
   g==;
X-CSE-ConnectionGUID: BGoIoNhmT32EWOJxm26PWA==
X-CSE-MsgGUID: YziEeIX1QhO79VRCJ5Cbyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78853429"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78853429"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:38:04 -0700
X-CSE-ConnectionGUID: 286yCJQUTwaGiElu7IuGoQ==
X-CSE-MsgGUID: 6x2AmTW8QEenqBtsU2c4nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="266489415"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.236]) ([10.245.244.236])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 06:38:01 -0700
Message-ID: <bc001a04-d39b-4ad8-98c0-f0d72c3c8f3b@linux.intel.com>
Date: Wed, 6 May 2026 16:37:58 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: add AMD PROM21 xHCI hwmon support for
 temperature monitoring
To: Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Raju Rangoju <Raju.Rangoju@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux PCI <linux-pci@vger.kernel.org>
References: <20260506032939.92351-1-hurryman2212@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260506032939.92351-1-hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 5/6/26 06:29, Jihong Min wrote:
> AMD PROM21 xHCI controllers expose a temperature byte through a
> vendor-specific index/data register pair in the xHCI PCI MMIO BAR region.
> Add hwmon support for this, limited to temperature monitoring, and
> initialize it from the xHCI PCI driver probe path.
> 
> The xhci-pci probe and remove paths call the PROM21 hwmon helpers only for
> AMD 1022:43fd controllers. The hwmon read path selects the temperature
> register through the vendor index register, reads the raw temperature byte
> from the data register, and restores the previous index before returning.
> 
> No public AMD register reference is available for this value. The
> conversion formula is derived from observed temperature readings:
> 
>    temp[C] = raw * 0.9066 - 78.624
> 
> This is not implemented as a standalone driver because the temperature
> register belongs to the PROM21 xHCI PCI function, is accessed through the
> xHCI BAR after the host controller is initialized, and should share that
> device's lifetime and runtime PM. Keep the device-specific PROM21 code in a
> separate helper called only from xhci-pci, while linking it into xhci-hcd
> to match the existing xHCI object layout. The xhci-pci remove path
> invalidates the helper before HCD teardown.
> 

To me it looks like a sepate device should be created for this, and a new
driver in drivers/hwmon bind to it.

Not sure what is the best solution, do we create a parent mfd driver that
binds to the PCI device, which then creates two child devices, xhci and hwmon.
Or do we just create some kind of platform device as a child to this xhci
PCI device.

Maybe someone on the PCI list would know (added to cc)? I guess it's not the
first time we have a "multi function" PCI device that has just has one BAR.

The resources this device needs look simple, only access two registers at
offset 0x3000 and 0x3008 from mmio base.

Does accessing those registers depend on xHC state? or is enough that the
PCI device is enabled and in D0?  i.e. does xHC need to be in "running"
state?
I'd like to avoid resuming and restarting xHC every time temperature is read
from a sysfs file.

Thanks
Mathias

(keeping reset of message as reference for pci list readers)

> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> ---
>   drivers/usb/host/Kconfig             |  10 ++
>   drivers/usb/host/Makefile            |   4 +
>   drivers/usb/host/xhci-pci.c          |   9 +
>   drivers/usb/host/xhci-prom21-hwmon.c | 241 +++++++++++++++++++++++++++
>   drivers/usb/host/xhci-prom21-hwmon.h |  26 +++
>   5 files changed, 290 insertions(+)
>   create mode 100644 drivers/usb/host/xhci-prom21-hwmon.c
>   create mode 100644 drivers/usb/host/xhci-prom21-hwmon.h
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 0a277a07cf70..da41ebc272b0 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -42,6 +42,16 @@ config USB_XHCI_PCI
>   	depends on USB_PCI
>   	default y
>   
> +config USB_XHCI_PCI_PROM21_HWMON
> +	bool "AMD PROM21 xHCI temperature sensor support"
> +	depends on USB_XHCI_PCI
> +	depends on HWMON
> +	help
> +	  Say Y here to expose the AMD PROM21 xHCI temperature sensor
> +	  through the hwmon subsystem. The sensor is accessed through a
> +	  vendor-specific index/data register pair in the controller's PCI
> +	  MMIO BAR and reports temperature only. If unsure, say N.
> +
>   config USB_XHCI_PCI_RENESAS
>   	tristate "Support for additional Renesas xHCI controller with firmware"
>   	depends on USB_XHCI_PCI
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index a07e7ba9cd53..22f141cb2af7 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -36,6 +36,10 @@ ifneq ($(CONFIG_USB_XHCI_SIDEBAND),)
>   	xhci-hcd-y		+= xhci-sideband.o
>   endif
>   
> +ifneq ($(CONFIG_USB_XHCI_PCI_PROM21_HWMON),)
> +	xhci-hcd-y += xhci-prom21-hwmon.o
> +endif
> +
>   obj-$(CONFIG_USB_PCI)	+= pci-quirks.o
>   
>   obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 585b2f3117b0..54713efc931f 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -18,6 +18,7 @@
>   #include "xhci.h"
>   #include "xhci-trace.h"
>   #include "xhci-pci.h"
> +#include "xhci-prom21-hwmon.h"
>   
>   #define SSIC_PORT_NUM		2
>   #define SSIC_PORT_CFG2		0x880c
> @@ -677,6 +678,10 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   	if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
>   		pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
>   
> +	if (dev->vendor == PCI_VENDOR_ID_AMD &&
> +	    dev->device == PCI_DEVICE_ID_AMD_PROM21_XHCI)
> +		xhci_prom21_hwmon_init(xhci, dev);
> +
>   	return 0;
>   
>   put_usb3_hcd:
> @@ -713,6 +718,10 @@ void xhci_pci_remove(struct pci_dev *dev)
>   	xhci = hcd_to_xhci(pci_get_drvdata(dev));
>   	set_power_d3 = xhci->quirks & XHCI_SPURIOUS_WAKEUP;
>   
> +	if (dev->vendor == PCI_VENDOR_ID_AMD &&
> +	    dev->device == PCI_DEVICE_ID_AMD_PROM21_XHCI)
> +		xhci_try_prom21_hwmon_invalidate(dev);
> +
>   	xhci->xhc_state |= XHCI_STATE_REMOVING;
>   
>   	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
> diff --git a/drivers/usb/host/xhci-prom21-hwmon.c b/drivers/usb/host/xhci-prom21-hwmon.c
> new file mode 100644
> index 000000000000..5f71e72f4a90
> --- /dev/null
> +++ b/drivers/usb/host/xhci-prom21-hwmon.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD PROM21 xHCI Hwmon Implementation
> + * (only temperature monitoring is supported)
> + *
> + * This can be effectively used as the alternative chipset temperature monitor.
> + *
> + * Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com>
> + */
> +
> +#include <linux/device/devres.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/hwmon.h>
> +#include <linux/io.h>
> +#include <linux/math.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +
> +#include "xhci.h"
> +#include "xhci-prom21-hwmon.h"
> +
> +#define XHCI_PROM21_INDEX 0x3000
> +#define XHCI_PROM21_DATA 0x3008
> +#define XHCI_PROM21_TEMP_REG 0x0001e520
> +
> +#define XHCI_PROM21_HWMON_NAME "xhci_prom21"
> +
> +struct xhci_prom21_hwmon {
> +	struct pci_dev *pdev;
> +	void __iomem *regs;
> +	bool removing;
> +	struct mutex lock; /* protects removing and the index/data registers */
> +};
> +
> +struct xhci_prom21_hwmon_devres {
> +	struct xhci_prom21_hwmon *hwmon;
> +};
> +
> +static void xhci_prom21_hwmon_invalidate(struct xhci_prom21_hwmon *hwmon)
> +{
> +	mutex_lock(&hwmon->lock);
> +	hwmon->removing = true;
> +	mutex_unlock(&hwmon->lock);
> +}
> +
> +static void xhci_prom21_hwmon_devres_release(struct device *dev, void *res)
> +{
> +	struct xhci_prom21_hwmon_devres *devres = res;
> +
> +	/*
> +	 * devm hwmon unregister runs after this lookup record is released.
> +	 * Mark the data path closed first so any late sysfs read returns
> +	 * without touching xHCI MMIO.
> +	 */
> +	xhci_prom21_hwmon_invalidate(devres->hwmon);
> +}
> +
> +/*
> + * This is not a pure MMIO read. The PROM21 vendor data register is selected
> + * by temporarily writing XHCI_PROM21_TEMP_REG to the vendor index register.
> + * Keep the sequence short and restore the previous index before returning.
> + */
> +static int
> +xhci_prom21_read_temp_raw_restore_index(struct xhci_prom21_hwmon *hwmon,
> +					u8 *raw)
> +{
> +	struct device *dev = &hwmon->pdev->dev;
> +	u32 index;
> +	u32 data;
> +	int ret;
> +
> +	/*
> +	 * xhci_try_prom21_hwmon_invalidate() uses the same lock before HCD
> +	 * teardown. Keep runtime PM and MMIO inside the critical section so a
> +	 * sysfs read cannot use the vendor register pair after remove starts.
> +	 */
> +	mutex_lock(&hwmon->lock);
> +	if (hwmon->removing) {
> +		mutex_unlock(&hwmon->lock);
> +		return -ENODEV;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		mutex_unlock(&hwmon->lock);
> +		return ret;
> +	}
> +
> +	index = readl(hwmon->regs + XHCI_PROM21_INDEX);
> +	/* Select the PROM21 temperature register through the vendor index. */
> +	writel(XHCI_PROM21_TEMP_REG, hwmon->regs + XHCI_PROM21_INDEX);
> +	data = readl(hwmon->regs + XHCI_PROM21_DATA);
> +	/* Restore the previous vendor index register value. */
> +	writel(index, hwmon->regs + XHCI_PROM21_INDEX);
> +	readl(hwmon->regs + XHCI_PROM21_INDEX);
> +
> +	/* Let xHCI PCI runtime PM coalesce repeated sysfs polling. */
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +	mutex_unlock(&hwmon->lock);
> +
> +	*raw = data & 0xff;
> +	if (!*raw || *raw == 0xff)
> +		return -ENODATA;
> +
> +	return 0;
> +}
> +
> +static long xhci_prom21_raw_to_millicelsius(u8 raw)
> +{
> +	/*
> +	 * No public AMD register reference is available for this value.
> +	 * The scale was derived from observed PROM21 xHCI temperature readings:
> +	 *  temp[C] = raw * 0.9066 - 78.624
> +	 */
> +	return DIV_ROUND_CLOSEST(raw * 9066, 10) - 78624;
> +}
> +
> +static umode_t xhci_prom21_hwmon_is_visible(const void *drvdata,
> +					    enum hwmon_sensor_types type,
> +					    u32 attr, int channel)
> +{
> +	if (type != hwmon_temp || channel)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int xhci_prom21_hwmon_read(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long *val)
> +{
> +	struct xhci_prom21_hwmon *hwmon = dev_get_drvdata(dev);
> +	u8 raw;
> +	int ret;
> +
> +	if (type != hwmon_temp || attr != hwmon_temp_input || channel)
> +		return -EOPNOTSUPP;
> +
> +	ret = xhci_prom21_read_temp_raw_restore_index(hwmon, &raw);
> +	if (ret)
> +		return ret;
> +
> +	*val = xhci_prom21_raw_to_millicelsius(raw);
> +	return 0;
> +}
> +
> +static const struct hwmon_ops xhci_prom21_hwmon_ops = {
> +	.is_visible = xhci_prom21_hwmon_is_visible,
> +	.read = xhci_prom21_hwmon_read,
> +};
> +
> +static const struct hwmon_channel_info *const xhci_prom21_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL,
> +};
> +
> +static const struct hwmon_chip_info xhci_prom21_chip_info = {
> +	.ops = &xhci_prom21_hwmon_ops,
> +	.info = xhci_prom21_hwmon_info,
> +};
> +
> +void xhci_prom21_hwmon_init(struct xhci_hcd *xhci, struct pci_dev *pdev)
> +{
> +	struct xhci_prom21_hwmon_devres *devres;
> +	struct xhci_prom21_hwmon *hwmon;
> +	struct usb_hcd *hcd = xhci_to_hcd(xhci);
> +	struct device *dev = &pdev->dev;
> +	struct device *hwmon_dev;
> +
> +	if (!hcd->regs || hcd->rsrc_len < XHCI_PROM21_DATA + sizeof(u32)) {
> +		dev_err(dev,
> +			"AMD PROM21 hwmon unavailable: invalid MMIO resource\n");
> +		return;
> +	}
> +
> +	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
> +	if (!hwmon) {
> +		/* The allocator reports OOM; add PROM21 device context. */
> +		dev_err(dev, "AMD PROM21 hwmon state unavailable\n");
> +		return;
> +	}
> +
> +	devres = devres_alloc(xhci_prom21_hwmon_devres_release, sizeof(*devres),
> +			      GFP_KERNEL);
> +	if (!devres) {
> +		dev_err(dev, "AMD PROM21 hwmon devres allocation failed\n");
> +		return;
> +	}
> +
> +	hwmon->pdev = pdev;
> +	hwmon->regs = hcd->regs;
> +	mutex_init(&hwmon->lock);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> +							 XHCI_PROM21_HWMON_NAME,
> +							 hwmon,
> +							 &xhci_prom21_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev)) {
> +		devres_free(devres);
> +		dev_err(dev, "AMD PROM21 hwmon registration failed: %pe\n",
> +			hwmon_dev);
> +		return;
> +	}
> +
> +	/*
> +	 * Store a private devres record so the device remove path can find this
> +	 * state without adding PROM21-specific part to xhci-pci.
> +	 */
> +	devres->hwmon = hwmon;
> +	devres_add(dev, devres);
> +}
> +EXPORT_SYMBOL_GPL(xhci_prom21_hwmon_init);
> +
> +void xhci_try_prom21_hwmon_invalidate(struct pci_dev *pdev)
> +{
> +	struct xhci_prom21_hwmon_devres *devres;
> +
> +	/*
> +	 * This is called for every xHCI PCI device. Devices without PROM21
> +	 * hwmon support simply have no matching helper devres entry.
> +	 */
> +	devres = devres_find(&pdev->dev, xhci_prom21_hwmon_devres_release, NULL,
> +			     NULL);
> +	if (!devres) {
> +		dev_dbg(&pdev->dev, "AMD PROM21 hwmon state not found\n");
> +		return;
> +	}
> +
> +	xhci_prom21_hwmon_invalidate(devres->hwmon);
> +}
> +EXPORT_SYMBOL_GPL(xhci_try_prom21_hwmon_invalidate);
> diff --git a/drivers/usb/host/xhci-prom21-hwmon.h b/drivers/usb/host/xhci-prom21-hwmon.h
> new file mode 100644
> index 000000000000..eca8db23c0ea
> --- /dev/null
> +++ b/drivers/usb/host/xhci-prom21-hwmon.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com> */
> +
> +#ifndef XHCI_PROM21_HWMON_H
> +#define XHCI_PROM21_HWMON_H
> +
> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI 0x43fd
> +
> +struct pci_dev;
> +struct xhci_hcd;
> +
> +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_PROM21_HWMON)
> +void xhci_prom21_hwmon_init(struct xhci_hcd *xhci, struct pci_dev *pdev);
> +void xhci_try_prom21_hwmon_invalidate(struct pci_dev *pdev);
> +#else
> +static inline void xhci_prom21_hwmon_init(struct xhci_hcd *xhci,
> +					  struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void xhci_try_prom21_hwmon_invalidate(struct pci_dev *pdev)
> +{
> +}
> +#endif
> +
> +#endif

