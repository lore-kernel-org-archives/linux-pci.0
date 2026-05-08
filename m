Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D722EDD7D
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255117; cv=none; b=QNv2hSNtMlaPEsh+mHjF9C3eUiIVxnd6KsqgQrRlltL4KdSBaWoozHzn7laEftFSYvCg+NtJlu+iz9okfgl1vNqP7UkjmPcaPqoyVEl0svKStQ9VBYBQj5OO/qD0Jk2z86ZnZCBCbp2w+8cbZE3fdSoaNYqW0Z1pofkEnVCssz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255117; c=relaxed/simple;
	bh=6paRAVwk0PZoN4nszLIT7hKf5hH14eTB0iWX/VR0Tmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPRQ5lSC0bui6zpBqGxFMlms3QkqdD+oGmsRhDLme9xNhrW7o1/cK4h5vNEyjg6UKccSKG64zPeBh7BwUte8b6tr992qycp8rgilUznU53h03Y6O6TG3ywjB3V2IKB3Pxd6mqGkN6po22o9TyqpWdzlHQ/P5BdGvGks1O60CMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn9PLkhV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn9PLkhV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so734269a91.1
        for <linux-pci@vger.kernel.org>; Fri, 08 May 2026 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778255114; x=1778859914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oJRHVQq7aQgGmot3T8SSBCUdDsZa5RJoIlCaB/RdQcQ=;
        b=Xn9PLkhVjmCDx5cewkqr4gph7gL/t1LX4y3zJVOOWrhgxQVpgdFsvGYW6pZ69B8r8Y
         CSw1ZwhnlqiosAIt+bZPy6303xgq39x9cfrwWoU7SVQDjYiFCNVfUtal37oyIgI6ZrRM
         HflLSTBjJGOQllFakFRxkgsA83iRgJBr9fO1tYwBYh+JZtY5VT7TTV9hPlVW63ARMT3M
         yN2udOiJgZQiS4467lGEAMeQMO2/4cP5Tc70w7netJgYZNb2pxLcUfGfaTXwqKw+v7Na
         Sn6oiVttijqUjiX533tKmIwM8Kw2eITUEAuhDfDqPPjlgJZi+X+58FSQTjM6zy1QrEFB
         rWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778255114; x=1778859914;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJRHVQq7aQgGmot3T8SSBCUdDsZa5RJoIlCaB/RdQcQ=;
        b=Xi14/iJ7GRzBFpkVg/dER4eL5EYFpNbWmqatSVnvcjF6HipzRl4j9HIFE2HvKZRpJN
         A9I1cBYWTcvWSGr9FJwrQQgPcUacIs3B0n/gcbyBnv0UWL6Rs7vyjVbDwpJGlbsjNGb+
         5myPlRNe3ANxwCfMLwxS1czjquPgdbn3oPHIvwzgKrtP4AW2zrdlN5/X/JR/8X65bMIH
         H3k8n6c8pO1lio+1yVWXVCndnQYXAmuSjvDhg8WiToepw4AmmnuvV36skN+U1oZgPez3
         gtZkjCdlTq07hq1Tvl4eNdMxzjNFRsc62H5XnHzXiHb2lkZLh/iEzFpkM/uFph9n5D07
         hSvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JgpV3knH7vx1+YLfYthex5N/Cs6X460YtNrh0WT/tbSMKcsM2A7ney4+XPqjdrGvs/jyWcBSz3iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHV9UGWJpa8j2Z8kYiWPdX3KK6Z31/DiW1Dhebcia5f4AvQprI
	IRNZu6Hkr68eGNpnaXodj8Gy3qC5A0I5B+VwDzG2z49DgF6bA+6WgZHl
X-Gm-Gg: Acq92OFxO/E3FiIlTRcjSZdzbrcUpkrYFRxt7xGs2XCxwTL962ShvbqJGddCbVxqRCc
	yiEP8krxnaKwluHGxHohqjByLNAcAbnZPDu49yJPnkPTsOe3ZJ32Mu2nOY8CRibFnquQ4ehDj8q
	/v1f2+pp+bej0RjGWFxYYQ2bpj2rvt/fBBRiawzM1JUWn9ltXrFaJK8iIYTvdD6AcP4fFpF4tB5
	hiTB78/Kv20B8lipW8sa9Wy1hIdOWmXEQ1l9rHTK8e+xQJBJVIqJng52QOtJJnXSkR2MWTDz7hN
	sONyKXpZ4pG8RCVjHA/wdcNpVN41+qg8YPyLxX62zJMd8bAvENItLGX6PJOMQT4+T1gZuBQm6EX
	fWMB1xXktBh8FhiVQ8zxCZ1igXI0vHT6pN7VHH1Y02ACr+gWsB7sRmuC9P/Y6vrzgckbZVRkOvq
	tAF5A+5/cC2kSlqqUhVXc6AZMhKvaZ9FRP4b2fen6jWVrZdgyNhoK4PPSkrt5MCVED6W1HL+0M
X-Received: by 2002:a17:902:cf4c:b0:2b2:5840:809c with SMTP id d9443c01a7336-2ba78b49e00mr134787025ad.1.1778255113973;
        Fri, 08 May 2026 08:45:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1c5466bsm26707695ad.0.2026.05.08.08.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 08:45:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0269bf45-316b-4ba5-af0e-312f6c2bebdd@roeck-us.net>
Date: Fri, 8 May 2026 08:45:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
To: Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508143910.14673-1-hurryman2212@gmail.com>
 <20260508143910.14673-3-hurryman2212@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260508143910.14673-3-hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/26 07:39, Jihong Min wrote:
> Add an auxiliary-bus hwmon driver for the temperature sensor exposed by
> AMD Promontory 21 (PROM21) xHCI PCI functions. The driver binds to the
> "hwmon" auxiliary device published by the PROM21 xHCI PCI glue and
> exposes the sensor as temp1_input under the prom21_xhci hwmon device.
> 
> The sensor is accessed through a PROM21 vendor index/data register pair
> in the xHCI PCI MMIO BAR. The read path restores the previous vendor
> index value after sampling and does not runtime-resume the parent PCI
> device; reads from a suspended parent return -ENODATA.
> 
> Document the supported device, register access, runtime PM behavior, and
> sysfs lookup method. The documentation also records the observation
> method used to identify the register pair and derive the conversion
> formula.
> 
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> ---
>   Documentation/hwmon/index.rst       |   1 +
>   Documentation/hwmon/prom21-xhci.rst |  99 +++++++++++
>   drivers/hwmon/Kconfig               |  10 ++
>   drivers/hwmon/Makefile              |   1 +
>   drivers/hwmon/prom21-xhci.c         | 250 ++++++++++++++++++++++++++++
>   5 files changed, 361 insertions(+)
>   create mode 100644 Documentation/hwmon/prom21-xhci.rst
>   create mode 100644 drivers/hwmon/prom21-xhci.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 8b655e5d6b68..324208f1faa2 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -216,6 +216,7 @@ Hardware Monitoring Kernel Drivers
>      pmbus
>      powerz
>      powr1220
> +   prom21-xhci
>      pt5161l
>      pxe1610
>      pwm-fan
> diff --git a/Documentation/hwmon/prom21-xhci.rst b/Documentation/hwmon/prom21-xhci.rst
> new file mode 100644
> index 000000000000..10d03c4476c3
> --- /dev/null
> +++ b/Documentation/hwmon/prom21-xhci.rst
> @@ -0,0 +1,99 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver prom21-xhci
> +=========================
> +
> +Supported chips:
> +
> +  * AMD Promontory 21 (PROM21) xHCI
> +
> +    Prefix: 'prom21_xhci'
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
> +The auxiliary device is created by the ``xhci-pci-prom21`` PCI glue driver.
> +USB host operation is otherwise delegated to the common ``xhci-pci`` code.
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

I am a bis concerned about this. Any mutex protection only applies to this driver,
but not to any other drivers or ACPI code accessing the vendor registers.
What if ACPI reads from the same register set ?

> +No public AMD reference is available for the register pair or the raw value.
> +The register pair was identified on an X870E system with two PROM21 xHCI
> +controllers. One controller was passed through to a Windows VM, and the same
> +controller's PCI MMIO BAR was observed from the Linux host while HWiNFO64 was
> +reporting the PROM21 xHCI temperature. In the test environment, the reported
> +temperature was very stable at idle and the displayed sensor resolution was
> +low, which made it possible to look for a consistently repeating MMIO response
> +for the same reported temperature. During observation, offset 0x3000 repeatedly
> +contained selector ``0x0001e520``. Writing the same selector to offset 0x3000
> +from Linux and then reading offset 0x3008 reproduced the same raw value, so the
> +offsets are treated as a vendor index/data register pair.
> +
> +The conversion formula was empirically inferred by matching observed raw
> +8-bit values against HWiNFO64's reported PROM21 xHCI temperature for the same
> +controller. The observed mapping is:
> +
> +  temp[C] = raw * 0.9066 - 78.624
> +
> +Runtime PM
> +----------
> +
> +The driver does not wake the xHCI PCI device for hwmon reads. It reads the
> +temperature only when the parent device is already active. A read from a
> +suspended device returns ``-ENODATA``. Sensor reads do not mark the xHCI PCI
> +device as busy or schedule autosuspend, so polling the sensor does not delay
> +runtime suspend.
> +
> +Sysfs entries
> +-------------
> +
> +======================= =====================================================
> +temp1_input		Temperature in millidegrees Celsius
> +======================= =====================================================
> +
> +The hwmon device name is ``prom21_xhci``. The sysfs path depends on the hwmon
> +device number assigned by the kernel. Userspace can locate the device by
> +matching the ``name`` attribute:
> +
> +.. code-block:: sh
> +
> +   for hwmon in /sys/class/hwmon/hwmon*; do
> +           [ "$(cat "$hwmon/name")" = "prom21_xhci" ] || continue
> +           cat "$hwmon/temp1_input"
> +   done
> +
> +``temp1_input`` reports millidegrees Celsius, so a value of ``50113`` means
> +50.113 degrees Celsius.

The above reflects the hardware monitoring ABI and is pointless
to repeat here. Please drop.

  If the raw register value is invalid, ``temp1_input``
> +returns ``-ENODATA``.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 14e4cea48acc..fe0f14e247b5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -951,6 +951,16 @@ config SENSORS_POWR1220
>   	  This driver can also be built as a module. If so, the module
>   	  will be called powr1220.
>   
> +config SENSORS_PROM21_XHCI
> +	tristate "AMD Promontory 21 xHCI temperature sensor"
> +	depends on USB_XHCI_PCI_PROM21
> +	help
> +	  If you say yes here you get support for the AMD Promontory 21
> +	  (PROM21) xHCI temperature sensor.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called prom21-xhci.
> +
>   config SENSORS_LAN966X
>   	tristate "Microchip LAN966x Hardware Monitoring"
>   	depends on SOC_LAN966 || COMPILE_TEST
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 4788996aa137..0bda542e8e2b 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -196,6 +196,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>   obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
>   obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
>   obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
> +obj-$(CONFIG_SENSORS_PROM21_XHCI)	+= prom21-xhci.o
>   obj-$(CONFIG_SENSORS_PT5161L)	+= pt5161l.o
>   obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
>   obj-$(CONFIG_SENSORS_QNAP_MCU_HWMON)	+= qnap-mcu-hwmon.o
> diff --git a/drivers/hwmon/prom21-xhci.c b/drivers/hwmon/prom21-xhci.c
> new file mode 100644
> index 000000000000..f91303ce3428
> --- /dev/null
> +++ b/drivers/hwmon/prom21-xhci.c
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Promontory 21 xHCI Hwmon Implementation
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

Is this needed ?

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

Please use

#define<space>NAME<tab>value

and align the value column.


> +
> +struct prom21_xhci {
> +	struct pci_dev *pdev;
> +	struct device *hwmon_dev;
> +	void __iomem *regs;
> +	struct mutex lock; /* serializes index/data register access */

Why is this lock still needed on top of the hwmon subsystem lock ?

> +};
> +
> +static int prom21_xhci_pm_get(struct prom21_xhci *hwmon, bool *pm_ref)
> +{
> +	struct device *dev = &hwmon->pdev->dev;
> +	int ret;
> +
> +	*pm_ref = false;
> +
> +	/*
> +	 * PROM21 temperature register access does not return a valid value while
> +	 * the parent xHCI PCI function is suspended. Do not wake the device from
> +	 * a hwmon read; only read when runtime PM reports the device as active,
> +	 * or when runtime PM is disabled and the device is not marked as
> +	 * suspended.
> +	 */
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
> +		return -ENODATA;
> +
> +	return ret;
> +}
> +
> +/*
> + * This is not a pure MMIO read. The PROM21 vendor data register is selected
> + * by temporarily writing PROM21_TEMP_REG to the vendor index register.
> + * Serialize the sequence, keep it short, and restore the previous index before
> + * returning so this driver does not leave the vendor index/data register pair
> + * in a different state for other possible users.
> + */
> +static int prom21_xhci_read_temp_raw_restore_index(struct prom21_xhci *hwmon,
> +						   u8 *raw)
> +{
> +	struct device *dev = &hwmon->pdev->dev;
> +	bool pm_ref;
> +	u32 index;
> +	u32 data;
> +	int ret;
> +
> +	ret = prom21_xhci_pm_get(hwmon, &pm_ref);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&hwmon->lock);
> +	index = readl(hwmon->regs + PROM21_INDEX);
> +	/* Select the PROM21 temperature register through the vendor index. */
> +	writel(PROM21_TEMP_REG, hwmon->regs + PROM21_INDEX);
> +	data = readl(hwmon->regs + PROM21_DATA);
> +	/* Restore the previous vendor index register value. */
> +	writel(index, hwmon->regs + PROM21_INDEX);
> +	readl(hwmon->regs + PROM21_INDEX);
> +	mutex_unlock(&hwmon->lock);
> +
> +	if (pm_ref) {
> +		/*
> +		 * Drop only the reference taken by pm_runtime_get_if_active().
> +		 * Do not mark the device busy or schedule autosuspend from the
> +		 * hwmon path; sensor polling must not keep the xHCI PCI device
> +		 * active.
> +		 */
> +		pm_runtime_put_noidle(dev);
> +	}
> +
> +	*raw = data & 0xff;
> +	if (!*raw || *raw == 0xff)
> +		return -ENODATA;
> +
> +	return 0;
> +}
> +
> +static long prom21_xhci_raw_to_millicelsius(u8 raw)
> +{
> +	/*
> +	 * No public AMD reference is available for this value.
> +	 * The scale was derived from observed PROM21 xHCI temperature readings:
> +	 *  temp[C] = raw * 0.9066 - 78.624
> +	 */
> +	return DIV_ROUND_CLOSEST(raw * 9066, 10) - 78624;
> +}
> +
> +static umode_t prom21_xhci_is_visible(const void *drvdata,
> +				      enum hwmon_sensor_types type, u32 attr,
> +				      int channel)
> +{
> +	if (type != hwmon_temp || channel)

Drop as unnecessary.

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
> +static int prom21_xhci_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *val)
> +{
> +	struct prom21_xhci *hwmon = dev_get_drvdata(dev);
> +	u8 raw;
> +	int ret;
> +
> +	if (type != hwmon_temp || attr != hwmon_temp_input || channel)
> +		return -EOPNOTSUPP;

I am ok with the type and attr checks, but the channel check is really
unnecessary. Please drop.

> +
> +	ret = prom21_xhci_read_temp_raw_restore_index(hwmon, &raw);
> +	if (ret)
> +		return ret;
> +
> +	*val = prom21_xhci_raw_to_millicelsius(raw);
> +	return 0;
> +}
> +
> +static const struct hwmon_ops prom21_xhci_ops = {
> +	.is_visible = prom21_xhci_is_visible,
> +	.read = prom21_xhci_read,
> +};
> +
> +static const struct hwmon_channel_info *const prom21_xhci_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL,
> +};
> +
> +static const struct hwmon_chip_info prom21_xhci_chip_info = {
> +	.ops = &prom21_xhci_ops,
> +	.info = prom21_xhci_info,
> +};
> +
> +static int prom21_xhci_probe(struct auxiliary_device *auxdev,
> +			     const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &auxdev->dev;
> +	struct device *parent = dev->parent;
> +	struct prom21_xhci *hwmon;
> +	struct pci_dev *pdev;
> +	struct usb_hcd *hcd;
> +	int ret;
> +
> +	if (!parent || !dev_is_pci(parent))
> +		return -ENODEV;

How would this ever happen ?

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

Isn't that a bit fragile ? Can a driver like this really make assumptions
about the contents of struct usb_hcd and the content of the parent's
driver data ?

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

I am sure I understand the reasoning here. What is the problem if it is attached
to the auxiliary device ? Other drivers do that, so I don't immediate see why
that would be a problem here.

> +	hwmon->hwmon_dev =
> +		hwmon_device_register_with_info(&pdev->dev, "prom21_xhci",
> +						hwmon, &prom21_xhci_chip_info,
> +						NULL);
> +	if (IS_ERR(hwmon->hwmon_dev))
> +		return PTR_ERR(hwmon->hwmon_dev);
> +
> +	return 0;
> +}
> +
> +static void prom21_xhci_remove(struct auxiliary_device *auxdev)
> +{
> +	struct prom21_xhci *hwmon = auxiliary_get_drvdata(auxdev);
> +
> +	/*
> +	 * The PROM21 PCI glue destroys the auxiliary device before HCD teardown.
> +	 * Unregister the hwmon device here so sysfs removes the attributes,
> +	 * stops new reads, and drains active hwmon callbacks before the xHCI
> +	 * MMIO mapping is released.
> +	 */
> +	hwmon_device_unregister(hwmon->hwmon_dev);
> +}
> +
> +static const struct auxiliary_device_id prom21_xhci_id_table[] = {
> +	{ .name = "xhci_pci_prom21.hwmon" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, prom21_xhci_id_table);
> +
> +static struct auxiliary_driver prom21_xhci_driver = {
> +	.name = "prom21-xhci",
> +	.probe = prom21_xhci_probe,
> +	.remove = prom21_xhci_remove,
> +	.id_table = prom21_xhci_id_table,
> +};
> +module_auxiliary_driver(prom21_xhci_driver);
> +
> +MODULE_AUTHOR("Jihong Min <hurryman2212@gmail.com>");
> +MODULE_DESCRIPTION("AMD Promontory 21 xHCI temperature sensor driver");
> +MODULE_LICENSE("GPL");

