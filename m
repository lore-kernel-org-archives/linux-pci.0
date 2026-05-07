Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAD3F23B7
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169221; cv=none; b=ZSfhN3quADDvr9JMtB3kNFXtdp+2IzzuLWHYk8s9ERplgbeZjIpzLikuZ3FTvj6ngaSF1+rdCl/zq8tUc6TOSexNun+2wZSvIp7vW+hH8flcq4RMLpBlVFKKWmGhqV50zu+bU/N6RIrVyp2sXAJlMm5W34l3nKQiwOLn31O/voo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169221; c=relaxed/simple;
	bh=vjPL0oVZSrVrl6gTFunO9mMFontzsdAiTVB3hep1DCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sunb+JAbc8hCiXU4liSFdXnHiCOhvyE6j8xh8XKNa0G7mrS67Ohxo4eloZTY8gmmoZOEH6Rr3mG+jlubERjzkJR/njIYLc/ZrpoHyTYql2qkD9Q01cgFS7PyHCg+N8VDrgYqKx5I90kjpbyrFzIcF8Njq0r5rOULmUSRHIQK8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp6yG8c1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp6yG8c1"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-365312a27abso1065122a91.3
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169219; x=1778774019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDQdpvY42qhAKybVGNrdzb4IK/HsLJwLhlok1qZgcq0=;
        b=Qp6yG8c1w8mf7qWz9oVbbUS7LS1m4/zTgTJoDERlvNbTdS3Q1QhQdw115QzwuO5xeK
         0KuA7NO5DzCbgkRnMkvu+WT7t3hD4nY+FatM938RUIUJyFnXELDYOcWC7c26Fi1H1L4S
         x71Sdq3auBHmQJzHUZ2XisUDb5WH8GDxoU94ahnfeEOCIM+IM0N7DogZgfDirb0Jg5FC
         5a0aWMi1elT4oGS8s2h01FBcY0pCvW22esh2HdYZiESgMTB5sspuizVP+TmMnSLf6mxy
         HvuzZgz7HTbUZdVJAVUibNRcbBFnDg67aeRKEAWysLnF5b6fZkk1JqV0ZxOzRcXgC4bn
         Wyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169219; x=1778774019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YDQdpvY42qhAKybVGNrdzb4IK/HsLJwLhlok1qZgcq0=;
        b=JrqSDMUM0zN3V1WQDmb6NJPAKRsIVudtJF9+g6Uxcs42KHUG8ZVktLg10BYAHo3zVT
         AQheAPgNGzkfx5lxKVE0HZovTEUGbfj6fKcZLjHiWlk/3XfmzvjX4Cx+DpUN8IItBD7Q
         oge9MHwRVKO0Hiu5AfNbn175rqyDpqI+xov2ei81MCFnaaMCOO3DDLD2NPSvuPLwwi++
         IEOEtnBrtFrZ0Y0MpNR/olBEYldqSXxJ+E0rMrEi1rv2kcCgvVXfjWPP2KYg9n/Rg8fF
         8fTLpF/ukeAauzPHAaDFxsobeOuu8uE0m7GI8CJSgcdWH2X2dj8g1bMUKZZlJtngjyFy
         7nvg==
X-Forwarded-Encrypted: i=1; AFNElJ/NODlP56V78ctjO0JzEqasZy2kcTMXBycpKV3IeKUUN4NQyQCEKAD2WxUvFIvv6GplL1jROU5StJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk94XtKeWWu2iofnxVNykuyamEnOZ7p2KvRQIngng7HavWpBvO
	yhJqX4B2FP96X+Udm+oxEAAUS86PsHZeGHcH4QpSPx2FTFNYkgAd/jyI
X-Gm-Gg: AeBDieubPT961eVaMflDf3ZV3K1o9+HiFv/tCz1uSzfLevIBlWKPk+0n9PPhe87PrGJ
	7CMBLEvX2gDPgi3kxvY7o569vqppj6VqVPALXQlAPXf+ae7IDh1c93iwJsjAaov75YB56LIFk60
	dDUslGfpBE7cXaAy81vtrYGoOPew8J5fnPU7DIsZEgBJbXsGtkfmou2MkjwziHZRYGMnpbRjtbN
	//vAgyMFPdFxFIdLW12+YHFz3o7p72xH+D/4Os7EHjdF5AscAeviCnTWq5vBVNlYXzE1YXy9Z1o
	bcwo72HipFF59fFnhVqt/byBTr/hiqnetlA09oDJdH4ocw3KpRsSP9N6vzxywa0in98j/7zrwqv
	GCJ2E3gm24blE3N/2nDruKgyU13oaP8yr4Ke5zDMqBwqDnKag4znRUEej10K25F7j/nl8sMze6G
	yhwVw0dkoDsX20JIdsRSe1Pg4uya/XrtuSsXui8ZtWGo/q4Sgw6w7Do+RHiQ==
X-Received: by 2002:a17:90b:1c8b:b0:35e:3e86:e2d1 with SMTP id 98e67ed59e1d1-365ab9dbfdcmr9047692a91.7.1778169218919;
        Thu, 07 May 2026 08:53:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4bd67b1sm9475446a91.1.2026.05.07.08.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:53:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 May 2026 08:53:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jihong Min <hurryman2212@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-usb@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
Message-ID: <35c2436b-d172-4172-a684-a96c4a0dcabe@roeck-us.net>
References: <cover.1778123510.git.hurryman2212@gmail.com>
 <0c35058bb088213397b42fca8d51e9ad0bba5169.1778123510.git.hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c35058bb088213397b42fca8d51e9ad0bba5169.1778123510.git.hurryman2212@gmail.com>

On Thu, May 07, 2026 at 12:31:59PM +0900, Jihong Min wrote:
> PROM21 xHCI controllers expose an 8-bit temperature value through a
> vendor-specific index/data register pair in the xHCI PCI MMIO BAR
> region. Add an auxiliary hwmon driver for PROM21 controllers with PCI
> ID 1022:43fd.
> 
> PROM21 is an AMD chipset IP used in single-chip or daisy-chained
> configurations to build AMD 6xx/8xx series chipsets.
> 
> The vendor index register is at byte offset 0x3000 from the xHCI MMIO
> BAR base and the vendor data register is at byte offset 0x3008. The
> driver writes register selector 0x0001e520 to the index register, reads
> the raw temperature value from the low 8 bits of the data register, and
> restores the previous index before returning. Expose temp1_input and an
> xHCI label through hwmon.
> 
> Register the hwmon device under the parent PCI function so userspace
> reports it as a PCI adapter, while the auxiliary driver still owns the
> hwmon lifetime and unregisters it from the auxiliary remove path.
> 
> No public AMD reference is available for this value. The conversion
> formula is derived from observed temperature readings:
> 
>   temp[C] = raw * 0.9066 - 78.624
> 
> Testing showed that the temperature register does not return a valid
> value while the xHCI PCI function is runtime suspended. By default, the
> driver does not wake the parent PCI device from hwmon reads and returns
> -EPERM while the device is suspended.

Seriously ? Why would this be a permission issue ? Make it -ENODATA.

> 
> Document the supported device, register access, conversion formula,
> module parameter, sysfs attributes, and sysfs lookup method.
> 
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> ---
>  Documentation/hwmon/index.rst        |   1 +
>  Documentation/hwmon/prom21-hwmon.rst |  86 ++++++++
>  drivers/hwmon/Kconfig                |  11 +
>  drivers/hwmon/Makefile               |   1 +
>  drivers/hwmon/prom21-hwmon.c         | 293 +++++++++++++++++++++++++++
>  5 files changed, 392 insertions(+)
>  create mode 100644 Documentation/hwmon/prom21-hwmon.rst
>  create mode 100644 drivers/hwmon/prom21-hwmon.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 8b655e5d6b68..41072977f0ef 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -216,6 +216,7 @@ Hardware Monitoring Kernel Drivers
>     pmbus
>     powerz
>     powr1220
> +   prom21-hwmon
>     pt5161l
>     pxe1610
>     pwm-fan
> diff --git a/Documentation/hwmon/prom21-hwmon.rst b/Documentation/hwmon/prom21-hwmon.rst
> new file mode 100644
> index 000000000000..0ba763e68ae9
> --- /dev/null
> +++ b/Documentation/hwmon/prom21-hwmon.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver prom21-hwmon
> +==========================
> +
> +Supported chips:
> +
> +  * AMD Promontory 21 (PROM21) xHCI
> +
> +    Prefix: 'prom21_hwmon'

The "hwmon" in this name is redundant. Yes, I know, others like it too,
but it is still redundant. I won't comment on it further, though.

> +
> +    PCI ID: 1022:43fd
> +
> +Author:
> +
> +  - Jihong Min <hurryman2212@gmail.com>
> +
> +Description
> +-----------
> +
> +This driver exposes the temperature sensor in AMD PROM21 xHCI controllers.
> +
> +The driver binds to an auxiliary device created by the xHCI PCI driver for
> +supported controllers. The sensor value is accessed through a vendor-specific
> +index/data register pair in the controller's PCI MMIO BAR.
> +
> +PROM21 is an AMD chipset IP used in single-chip or daisy-chained configurations
> +to build AMD 6xx/8xx series chipsets. Since the xHCI controllers are
> +integrated in PROM21, this temperature can also be used as a monitor for a
> +temperature close to the AMD chipset temperature.
> +
> +Register access
> +---------------
> +
> +The temperature value is read through a vendor-specific index/data register
> +pair in the xHCI PCI MMIO BAR. The driver uses the following byte offsets from
> +the MMIO BAR base:
> +
> +======================= =====================================================
> +0x3000			Vendor index register
> +0x3008			Vendor data register
> +======================= =====================================================
> +
> +The driver saves the current vendor index register value, writes the
> +temperature selector ``0x0001e520`` to the vendor index register, reads the
> +vendor data register, and restores the previous vendor index value before
> +returning. The raw temperature value is the low 8 bits of the vendor data
> +register value.
> +
> +No public AMD reference is available for the raw value. The temperature
> +conversion formula is derived from observed PROM21 xHCI temperature readings:
> +
> +  temp[C] = raw * 0.9066 - 78.624
> +
> +Module parameters
> +-----------------
> +
> +pm: bool
> +  Allow runtime PM state changes for device memory access. This is disabled
> +  by default. If disabled, the driver does not wake the xHCI PCI device from
> +  a temperature read. It reads the temperature only when the device is active.
> +  A read from a suspended device returns ``-EPERM``.
> +
> +Sysfs entries
> +-------------
> +
> +======================= =====================================================
> +temp1_input		Temperature in millidegrees Celsius
> +temp1_label		"xHCI"

This is pointless and not the idea behind having a "label" attribute.
The driver name itself already associates the sensor with xhci.
Please drop.

> +======================= =====================================================
> +
> +The hwmon device name is ``prom21_hwmon``. The sysfs path depends on the hwmon
> +device number assigned by the kernel. Userspace can locate the device by
> +matching the ``name`` attribute:
> +
> +.. code-block:: sh
> +
> +   for hwmon in /sys/class/hwmon/hwmon*; do
> +           [ "$(cat "$hwmon/name")" = "prom21_hwmon" ] || continue
> +           cat "$hwmon/temp1_label"
> +           cat "$hwmon/temp1_input"
> +   done
> +
> +``temp1_input`` reports millidegrees Celsius, so a value of ``50113`` means
> +50.113 degrees Celsius. If the raw register value is invalid, ``temp1_input``
> +returns ``-ENODATA``.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 14e4cea48acc..06d81cc29fec 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -940,6 +940,17 @@ config SENSORS_POWERZ
>  	  This driver can also be built as a module. If so, the module
>  	  will be called powerz.
>  
> +config SENSORS_PROM21
> +	tristate "AMD Promontory 21 xHCI temperature sensor"
> +	depends on USB_XHCI_PCI
> +	select USB_XHCI_PCI_AUXDEV
> +	help
> +	  If you say yes here you get support for the AMD Promontory 21
> +	  (PROM21) xHCI temperature sensor.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called prom21-hwmon.
> +
>  config SENSORS_POWR1220
>  	tristate "Lattice POWR1220 Power Monitoring"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 4788996aa137..7693ed3b3f72 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -196,6 +196,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>  obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
>  obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
> +obj-$(CONFIG_SENSORS_PROM21)	+= prom21-hwmon.o
>  obj-$(CONFIG_SENSORS_PT5161L)	+= pt5161l.o
>  obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
>  obj-$(CONFIG_SENSORS_QNAP_MCU_HWMON)	+= qnap-mcu-hwmon.o
> diff --git a/drivers/hwmon/prom21-hwmon.c b/drivers/hwmon/prom21-hwmon.c
> new file mode 100644
> index 000000000000..1c137304d65d
> --- /dev/null
> +++ b/drivers/hwmon/prom21-hwmon.c
> @@ -0,0 +1,293 @@
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
> +#include <linux/auxiliary_bus.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/hwmon.h>
> +#include <linux/io.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +
> +#define PROM21_INDEX 0x3000
> +#define PROM21_DATA 0x3008
> +#define PROM21_TEMP_REG 0x0001e520
> +
> +#define PROM21_HWMON_NAME "prom21_hwmon"
> +#define PROM21_TEMP_LABEL "xHCI"
> +
> +struct prom21_hwmon {
> +	struct pci_dev *pdev;
> +	struct device *hwmon_dev;
> +	void __iomem *regs;
> +	bool removing;
> +	struct mutex lock; /* protects removing and the index/data registers */

It is difficult to believe that auxiliary device management is so unstable
that it needs all that complexity. This will require confirmation from
someone who knows how this is supposed to work, and a detailed explanation
in the driver explaining why it is necessary.

> +};
> +
> +static bool pm;
> +module_param(pm, bool, 0444);
> +MODULE_PARM_DESC(pm, "Allow runtime PM state changes for device memory access");

No. Either enable it or don't, but please don't add such module parameters.
The pm complexity in the driver, as written, makes it all but impossible
to determine what is going on.

> +
> +static void prom21_hwmon_invalidate(struct prom21_hwmon *hwmon)
> +{
> +	mutex_lock(&hwmon->lock);
> +	hwmon->removing = true;
> +	mutex_unlock(&hwmon->lock);
> +}
> +
> +static int prom21_hwmon_pm_get(struct prom21_hwmon *hwmon, bool *pm_ref)
> +{
> +	struct device *dev = &hwmon->pdev->dev;
> +	int ret;
> +
> +	*pm_ref = false;
> +
> +	/*
> +	 * PROM21 temperature register access does not return a valid value while
> +	 * the parent xHCI PCI function is suspended. By default, only read when
> +	 * runtime PM reports the device as active, or when runtime PM is disabled
> +	 * and the device is not marked as suspended. If pm=Y, allow runtime PM
> +	 * state changes while accessing the temperature register.
> +	 */
> +	if (pm) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		*pm_ref = true;
> +		return 0;
> +	}
> +
> +	ret = pm_runtime_get_if_active(dev);
> +	if (ret > 0) {
> +		*pm_ref = true;
> +		return 0;
> +	}
> +
> +	if (ret == -EINVAL && !pm_runtime_status_suspended(dev))
> +		return 0;
> +
> +	if (!ret || pm_runtime_status_suspended(dev))
> +		return -EPERM;
> +
> +	return ret;
> +}
> +
> +/*
> + * This is not a pure MMIO read. The PROM21 vendor data register is selected
> + * by temporarily writing PROM21_TEMP_REG to the vendor index register. Keep
> + * the sequence short and restore the previous index before returning.
> + */
> +static int prom21_hwmon_read_temp_raw_restore_index(struct prom21_hwmon *hwmon,
> +						    u8 *raw)
> +{
> +	struct device *dev = &hwmon->pdev->dev;
> +	bool pm_ref;
> +	u32 index;
> +	u32 data;
> +	int ret;
> +
> +	/*
> +	 * The xHCI PCI remove path destroys the auxiliary device before HCD
> +	 * teardown. Keep runtime PM and MMIO inside the critical section so a
> +	 * sysfs read cannot use the vendor register pair after remove starts.
> +	 */
> +	mutex_lock(&hwmon->lock);
> +	if (hwmon->removing) {
> +		mutex_unlock(&hwmon->lock);
> +		return -ENODEV;
> +	}
> +
> +	ret = prom21_hwmon_pm_get(hwmon, &pm_ref);
> +	if (ret) {
> +		mutex_unlock(&hwmon->lock);
> +		return ret;
> +	}
> +
> +	index = readl(hwmon->regs + PROM21_INDEX);
> +	/* Select the PROM21 temperature register through the vendor index. */
> +	writel(PROM21_TEMP_REG, hwmon->regs + PROM21_INDEX);
> +	data = readl(hwmon->regs + PROM21_DATA);
> +	/* Restore the previous vendor index register value. */
> +	writel(index, hwmon->regs + PROM21_INDEX);
> +	readl(hwmon->regs + PROM21_INDEX);
> +
> +	if (pm_ref) {
> +		/*
> +		 * Use autosuspend so repeated sysfs reads do not suspend the
> +		 * controller immediately after each successful register access.
> +		 */
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +	}
> +	mutex_unlock(&hwmon->lock);
> +
> +	*raw = data & 0xff;
> +	if (!*raw || *raw == 0xff)
> +		return -ENODATA;
> +
> +	return 0;
> +}
> +
> +static long prom21_hwmon_raw_to_millicelsius(u8 raw)
> +{
> +	/*
> +	 * No public AMD reference is available for this value.
> +	 * The scale was derived from observed PROM21 xHCI temperature readings:
> +	 *  temp[C] = raw * 0.9066 - 78.624
> +	 */
> +	return DIV_ROUND_CLOSEST(raw * 9066, 10) - 78624;
> +}
> +
> +static umode_t prom21_hwmon_is_visible(const void *drvdata,
> +				       enum hwmon_sensor_types type, u32 attr,
> +				       int channel)
> +{
> +	if (type != hwmon_temp || channel)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_label:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int prom21_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			     u32 attr, int channel, long *val)
> +{
> +	struct prom21_hwmon *hwmon = dev_get_drvdata(dev);
> +	u8 raw;
> +	int ret;
> +
> +	if (type != hwmon_temp || attr != hwmon_temp_input || channel)
> +		return -EOPNOTSUPP;
> +
> +	ret = prom21_hwmon_read_temp_raw_restore_index(hwmon, &raw);
> +	if (ret)
> +		return ret;
> +
> +	*val = prom21_hwmon_raw_to_millicelsius(raw);
> +	return 0;
> +}
> +
> +static int prom21_hwmon_read_string(struct device *dev,
> +				    enum hwmon_sensor_types type, u32 attr,
> +				    int channel, const char **str)
> +{
> +	if (type != hwmon_temp || attr != hwmon_temp_label || channel)
> +		return -EOPNOTSUPP;
> +
> +	*str = PROM21_TEMP_LABEL;
> +	return 0;
> +}
> +
> +static const struct hwmon_ops prom21_hwmon_ops = {
> +	.is_visible = prom21_hwmon_is_visible,
> +	.read = prom21_hwmon_read,
> +	.read_string = prom21_hwmon_read_string,
> +};
> +
> +static const struct hwmon_channel_info *const prom21_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL,
> +};
> +
> +static const struct hwmon_chip_info prom21_hwmon_chip_info = {
> +	.ops = &prom21_hwmon_ops,
> +	.info = prom21_hwmon_info,
> +};
> +
> +static int prom21_hwmon_probe(struct auxiliary_device *auxdev,
> +			      const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &auxdev->dev;
> +	struct device *parent = dev->parent;
> +	struct prom21_hwmon *hwmon;
> +	struct pci_dev *pdev;
> +	struct usb_hcd *hcd;
> +	int ret;
> +
> +	if (!parent || !dev_is_pci(parent))
> +		return -ENODEV;
> +
> +	pdev = to_pci_dev(parent);
> +	hcd = pci_get_drvdata(pdev);
> +	if (!hcd)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "xHCI HCD data unavailable\n");
> +
> +	if (!hcd->regs || hcd->rsrc_len < PROM21_DATA + sizeof(u32))
> +		return dev_err_probe(dev, -ENODEV, "invalid MMIO resource\n");
> +
> +	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	ret = devm_mutex_init(dev, &hwmon->lock);
> +	if (ret)
> +		return ret;
> +
> +	hwmon->pdev = pdev;
> +	hwmon->regs = hcd->regs;
> +	auxiliary_set_drvdata(auxdev, hwmon);
> +
> +	/*
> +	 * Use the PCI function as the hwmon parent so user space reports it as
> +	 * a PCI adapter. Lifetime is still owned by this auxiliary driver;
> +	 * remove() unregisters the hwmon device before xhci-pci tears down the
> +	 * HCD.
> +	 */
> +	hwmon->hwmon_dev =
> +		hwmon_device_register_with_info(&pdev->dev, PROM21_HWMON_NAME,
> +						hwmon, &prom21_hwmon_chip_info,
> +						NULL);
> +	if (IS_ERR(hwmon->hwmon_dev))
> +		return PTR_ERR(hwmon->hwmon_dev);
> +
> +	return 0;
> +}
> +
> +static void prom21_hwmon_remove(struct auxiliary_device *auxdev)
> +{
> +	struct prom21_hwmon *hwmon = auxiliary_get_drvdata(auxdev);
> +
> +	if (hwmon) {
> +		prom21_hwmon_invalidate(hwmon);
> +		hwmon_device_unregister(hwmon->hwmon_dev);
> +	}
> +}
> +
> +static const struct auxiliary_device_id prom21_hwmon_id_table[] = {
> +	{ .name = "xhci_pci." PROM21_HWMON_NAME },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, prom21_hwmon_id_table);
> +
> +static struct auxiliary_driver prom21_hwmon_driver = {
> +	.name = "prom21-hwmon",
> +	.probe = prom21_hwmon_probe,
> +	.remove = prom21_hwmon_remove,
> +	.id_table = prom21_hwmon_id_table,
> +};
> +module_auxiliary_driver(prom21_hwmon_driver);
> +
> +MODULE_AUTHOR("Jihong Min <hurryman2212@gmail.com>");
> +MODULE_DESCRIPTION("AMD PROM21 xHCI hwmon driver");
> +MODULE_LICENSE("GPL");
