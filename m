Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF047DD65
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077572; cv=none; b=LVcomu6oM/8v1Li56UWVxOCYOF/1xjyPhKRj5Ye4wxeb2fLyBvFEugidqIlX+evZBJfaTRij084arCVY8i6CM6Mp5SVhLn7nrwB8vF/Io/9HVf7dDAhWV12veyOD9x6Usv6adhvUTc1b2smPW7CgDnUxjt8Tl0GvBiDIacp8RdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077572; c=relaxed/simple;
	bh=/+0L2ay5SVeVgVEItOirWEbVnP1jbDpQml5xIN8A65M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjUw8MJ1xQxxmkqRPpSYh1WOgzejqA+NlZNxwpYFV6OHVVrbF+UK4fwHh5SpyYUveSNW8qtz2V87sE/mvDahfxzq/3MGF0jV4CrHXiEJEvKwToGWUmFIJ9bAIMYP8VIX2Ft5HtSNhoXU+/ObEsuHFTZ76KXQ1SD64jrd1ibf3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFVVpish; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFVVpish"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-364ff382b0bso5447700a91.2
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077569; x=1778682369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V2cNqGbCj6D/kukvb25xX0cgso3G1hIMWWL8Y+TjfWY=;
        b=BFVVpishmgnIyA2wMvKeLNERIRmR+JSPCfTJz2laG5ROkjt3iK6bHjnRRyrGOT5dsg
         eldNDMCWtyztsYdAc947Vs3mAascLpCUFHg7hZUH3Gwwml0vMWds2onOgLSBn4g8f0wu
         Vlh61ongRWL0s8YhLqL243T7WMIzzugAsNp96rf72ZtdT58rDg9GpcP3k8IfCUUHraRl
         wJbe3+BlZJevUSNx7nKNx5ZKmO9i7YeBJAiB7uaQNDZllbwwECGPBSZE1jgXIXqWukmn
         5S53g+gVICq4iycIZLUgY/Ow3SMKI6JH0dEbT0Frn3jB1jPGPOofePy7omPKmFtstc/j
         tVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077569; x=1778682369;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2cNqGbCj6D/kukvb25xX0cgso3G1hIMWWL8Y+TjfWY=;
        b=dB9AVeLnnX9oicqDfZf/+LncjDLsnHVNdl5uwCPAtQbOrQBMhIX1cfy7E0U3YCL4PD
         pvTXADryadOdZ9uX2yPxHFhFdbp0is0czps+4o4sCu1B0JL699nEawp7DVYNVC1KC/He
         QvW458pOhYtJG3+GGfFcHI94+NNroRv+Jm1ZGsAlKxKTZSysvkN1UbXz10q4yM66CtrF
         NsI0k7q9xetsmC5qgyyjVhMH+0fpsj1Fgxu+nA+FBXQn8TmEZAjBqCyt6PymdFZ3cefy
         IgKitMJ0d8COzgnoZYgnqV9HZwwBeqL8Lc8kULJKlSONdA4jCuHsyONbiFd7bNFKKR/Q
         FfDw==
X-Forwarded-Encrypted: i=1; AFNElJ8JygQdXx9/gxIXEHZ5zs/JZUqM9uz3QeDxdfM68DCiJ4kwnlT7A0pZ8SwXEy0W8ydbnWQW6sff65Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8jtVqvbpRS08yASGZGN5NcR3m9UrDvXeWSVOvrMTU9coma9f
	ws5R8C+hPzDVUEfU+QZeU0EsbgfdM2EKlCK7CfI0nKMtg+Mabqk6lbGU2Cc7PQ==
X-Gm-Gg: AeBDieutUy+fOCVHSX4VJ7FMXnVhurzPfcNQY7KaUahLwhphWxZpq8+/VloAV9CsnHA
	5dD8UNle9U+LieRNWxgswKn7PVvUV1z9SehfOOqEL/fHCyHBfcgm9GmDIA9lKfQeQYzRKDbgCAH
	5YhfTJyQgSoXgdKrgvfpkscC3KxO4aS967kjjizieskuLpQMt6CsgLjkVzFLlnDkJ4bVEZwHwJC
	A4w49f4XvxbHYaW+8Vw6rZ/hmBzWAHDaRFbJvcHOncw32M+GfwHr2raUZflmduLFxIfqK5e+Hs2
	/xYTw6EOkTeAcXcGariH296KFQaqhIEJQNxTw90ApjbkfTkN2yS6rr++EJ8r3+MqhVKMDPZIuUy
	bGpVezMRYmbi2QyzFsMEUOEbo1pyN0NCO5YgRmvw7xnyMlgXOX4mLSwMX6w3qi+zYMvS4SvMuH4
	tb/buDqYZ0TYlvEn2U7QyydSVHlpx8th4ph+hKviJte9yhguptg81YDn2You0A9GvcmMA0TMP7c
	dZWDRwH12A=
X-Received: by 2002:a17:90b:4b0c:b0:35b:e5cf:20fc with SMTP id 98e67ed59e1d1-365ac793ed4mr3764047a91.26.1778077569206;
        Wed, 06 May 2026 07:26:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b06adc51sm1087986a91.4.2026.05.06.07.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 07:26:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <35bbf02d-0746-47d9-b317-e83121f03f89@roeck-us.net>
Date: Wed, 6 May 2026 07:26:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: add AMD PROM21 xHCI hwmon support for
 temperature monitoring
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Raju Rangoju <Raju.Rangoju@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux PCI <linux-pci@vger.kernel.org>
References: <20260506032939.92351-1-hurryman2212@gmail.com>
 <bc001a04-d39b-4ad8-98c0-f0d72c3c8f3b@linux.intel.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <bc001a04-d39b-4ad8-98c0-f0d72c3c8f3b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/26 06:37, Mathias Nyman wrote:
> Hi
> 
> On 5/6/26 06:29, Jihong Min wrote:
>> AMD PROM21 xHCI controllers expose a temperature byte through a
>> vendor-specific index/data register pair in the xHCI PCI MMIO BAR region.
>> Add hwmon support for this, limited to temperature monitoring, and
>> initialize it from the xHCI PCI driver probe path.
>>
>> The xhci-pci probe and remove paths call the PROM21 hwmon helpers only for
>> AMD 1022:43fd controllers. The hwmon read path selects the temperature
>> register through the vendor index register, reads the raw temperature byte
>> from the data register, and restores the previous index before returning.
>>
>> No public AMD register reference is available for this value. The
>> conversion formula is derived from observed temperature readings:
>>
>>    temp[C] = raw * 0.9066 - 78.624
>>
>> This is not implemented as a standalone driver because the temperature
>> register belongs to the PROM21 xHCI PCI function, is accessed through the
>> xHCI BAR after the host controller is initialized, and should share that
>> device's lifetime and runtime PM. Keep the device-specific PROM21 code in a
>> separate helper called only from xhci-pci, while linking it into xhci-hcd
>> to match the existing xHCI object layout. The xhci-pci remove path
>> invalidates the helper before HCD teardown.
>>
> 
> To me it looks like a sepate device should be created for this, and a new
> driver in drivers/hwmon bind to it.
> 
> Not sure what is the best solution, do we create a parent mfd driver that
> binds to the PCI device, which then creates two child devices, xhci and hwmon.
> Or do we just create some kind of platform device as a child to this xhci
> PCI device.
> 

Auxiliary devices were created specifically for this purpose. The parent driver
would create an auxiliary device in its probe function, which would then be
instantiated from the client driver.

On a side note, the code below looks messy. I would personally prefer something
like the Renesas solution.

Guenter

> Maybe someone on the PCI list would know (added to cc)? I guess it's not the
> first time we have a "multi function" PCI device that has just has one BAR.
> 
> The resources this device needs look simple, only access two registers at
> offset 0x3000 and 0x3008 from mmio base.
> 
> Does accessing those registers depend on xHC state? or is enough that the
> PCI device is enabled and in D0?  i.e. does xHC need to be in "running"
> state?
> I'd like to avoid resuming and restarting xHC every time temperature is read
> from a sysfs file.
> 
> Thanks
> Mathias
> 
> (keeping reset of message as reference for pci list readers)
> 
>> Assisted-by: Codex:gpt-5.5
>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
>> ---
>>   drivers/usb/host/Kconfig             |  10 ++
>>   drivers/usb/host/Makefile            |   4 +
>>   drivers/usb/host/xhci-pci.c          |   9 +
>>   drivers/usb/host/xhci-prom21-hwmon.c | 241 +++++++++++++++++++++++++++
>>   drivers/usb/host/xhci-prom21-hwmon.h |  26 +++
>>   5 files changed, 290 insertions(+)
>>   create mode 100644 drivers/usb/host/xhci-prom21-hwmon.c
>>   create mode 100644 drivers/usb/host/xhci-prom21-hwmon.h
>>
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index 0a277a07cf70..da41ebc272b0 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -42,6 +42,16 @@ config USB_XHCI_PCI
>>       depends on USB_PCI
>>       default y
>> +config USB_XHCI_PCI_PROM21_HWMON
>> +    bool "AMD PROM21 xHCI temperature sensor support"
>> +    depends on USB_XHCI_PCI
>> +    depends on HWMON
>> +    help
>> +      Say Y here to expose the AMD PROM21 xHCI temperature sensor
>> +      through the hwmon subsystem. The sensor is accessed through a
>> +      vendor-specific index/data register pair in the controller's PCI
>> +      MMIO BAR and reports temperature only. If unsure, say N.
>> +
>>   config USB_XHCI_PCI_RENESAS
>>       tristate "Support for additional Renesas xHCI controller with firmware"
>>       depends on USB_XHCI_PCI
>> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
>> index a07e7ba9cd53..22f141cb2af7 100644
>> --- a/drivers/usb/host/Makefile
>> +++ b/drivers/usb/host/Makefile
>> @@ -36,6 +36,10 @@ ifneq ($(CONFIG_USB_XHCI_SIDEBAND),)
>>       xhci-hcd-y        += xhci-sideband.o
>>   endif
>> +ifneq ($(CONFIG_USB_XHCI_PCI_PROM21_HWMON),)
>> +    xhci-hcd-y += xhci-prom21-hwmon.o
>> +endif
>> +
>>   obj-$(CONFIG_USB_PCI)    += pci-quirks.o
>>   obj-$(CONFIG_USB_EHCI_HCD)    += ehci-hcd.o
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 585b2f3117b0..54713efc931f 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -18,6 +18,7 @@
>>   #include "xhci.h"
>>   #include "xhci-trace.h"
>>   #include "xhci-pci.h"
>> +#include "xhci-prom21-hwmon.h"
>>   #define SSIC_PORT_NUM        2
>>   #define SSIC_PORT_CFG2        0x880c
>> @@ -677,6 +678,10 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>       if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
>>           pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
>> +    if (dev->vendor == PCI_VENDOR_ID_AMD &&
>> +        dev->device == PCI_DEVICE_ID_AMD_PROM21_XHCI)
>> +        xhci_prom21_hwmon_init(xhci, dev);
>> +
>>       return 0;
>>   put_usb3_hcd:
>> @@ -713,6 +718,10 @@ void xhci_pci_remove(struct pci_dev *dev)
>>       xhci = hcd_to_xhci(pci_get_drvdata(dev));
>>       set_power_d3 = xhci->quirks & XHCI_SPURIOUS_WAKEUP;
>> +    if (dev->vendor == PCI_VENDOR_ID_AMD &&
>> +        dev->device == PCI_DEVICE_ID_AMD_PROM21_XHCI)
>> +        xhci_try_prom21_hwmon_invalidate(dev);
>> +
>>       xhci->xhc_state |= XHCI_STATE_REMOVING;
>>       if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
>> diff --git a/drivers/usb/host/xhci-prom21-hwmon.c b/drivers/usb/host/xhci-prom21-hwmon.c
>> new file mode 100644
>> index 000000000000..5f71e72f4a90
>> --- /dev/null
>> +++ b/drivers/usb/host/xhci-prom21-hwmon.c
>> @@ -0,0 +1,241 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD PROM21 xHCI Hwmon Implementation
>> + * (only temperature monitoring is supported)
>> + *
>> + * This can be effectively used as the alternative chipset temperature monitor.
>> + *
>> + * Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com>
>> + */
>> +
>> +#include <linux/device/devres.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/io.h>
>> +#include <linux/math.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pci.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/slab.h>
>> +
>> +#include "xhci.h"
>> +#include "xhci-prom21-hwmon.h"
>> +
>> +#define XHCI_PROM21_INDEX 0x3000
>> +#define XHCI_PROM21_DATA 0x3008
>> +#define XHCI_PROM21_TEMP_REG 0x0001e520
>> +
>> +#define XHCI_PROM21_HWMON_NAME "xhci_prom21"
>> +
>> +struct xhci_prom21_hwmon {
>> +    struct pci_dev *pdev;
>> +    void __iomem *regs;
>> +    bool removing;
>> +    struct mutex lock; /* protects removing and the index/data registers */
>> +};
>> +
>> +struct xhci_prom21_hwmon_devres {
>> +    struct xhci_prom21_hwmon *hwmon;
>> +};
>> +
>> +static void xhci_prom21_hwmon_invalidate(struct xhci_prom21_hwmon *hwmon)
>> +{
>> +    mutex_lock(&hwmon->lock);
>> +    hwmon->removing = true;
>> +    mutex_unlock(&hwmon->lock);
>> +}
>> +
>> +static void xhci_prom21_hwmon_devres_release(struct device *dev, void *res)
>> +{
>> +    struct xhci_prom21_hwmon_devres *devres = res;
>> +
>> +    /*
>> +     * devm hwmon unregister runs after this lookup record is released.
>> +     * Mark the data path closed first so any late sysfs read returns
>> +     * without touching xHCI MMIO.
>> +     */
>> +    xhci_prom21_hwmon_invalidate(devres->hwmon);
>> +}
>> +
>> +/*
>> + * This is not a pure MMIO read. The PROM21 vendor data register is selected
>> + * by temporarily writing XHCI_PROM21_TEMP_REG to the vendor index register.
>> + * Keep the sequence short and restore the previous index before returning.
>> + */
>> +static int
>> +xhci_prom21_read_temp_raw_restore_index(struct xhci_prom21_hwmon *hwmon,
>> +                    u8 *raw)
>> +{
>> +    struct device *dev = &hwmon->pdev->dev;
>> +    u32 index;
>> +    u32 data;
>> +    int ret;
>> +
>> +    /*
>> +     * xhci_try_prom21_hwmon_invalidate() uses the same lock before HCD
>> +     * teardown. Keep runtime PM and MMIO inside the critical section so a
>> +     * sysfs read cannot use the vendor register pair after remove starts.
>> +     */
>> +    mutex_lock(&hwmon->lock);
>> +    if (hwmon->removing) {
>> +        mutex_unlock(&hwmon->lock);
>> +        return -ENODEV;
>> +    }
>> +
>> +    ret = pm_runtime_resume_and_get(dev);
>> +    if (ret < 0) {
>> +        mutex_unlock(&hwmon->lock);
>> +        return ret;
>> +    }
>> +
>> +    index = readl(hwmon->regs + XHCI_PROM21_INDEX);
>> +    /* Select the PROM21 temperature register through the vendor index. */
>> +    writel(XHCI_PROM21_TEMP_REG, hwmon->regs + XHCI_PROM21_INDEX);
>> +    data = readl(hwmon->regs + XHCI_PROM21_DATA);
>> +    /* Restore the previous vendor index register value. */
>> +    writel(index, hwmon->regs + XHCI_PROM21_INDEX);
>> +    readl(hwmon->regs + XHCI_PROM21_INDEX);
>> +
>> +    /* Let xHCI PCI runtime PM coalesce repeated sysfs polling. */
>> +    pm_runtime_mark_last_busy(dev);
>> +    pm_runtime_put_autosuspend(dev);
>> +    mutex_unlock(&hwmon->lock);
>> +
>> +    *raw = data & 0xff;
>> +    if (!*raw || *raw == 0xff)
>> +        return -ENODATA;
>> +
>> +    return 0;
>> +}
>> +
>> +static long xhci_prom21_raw_to_millicelsius(u8 raw)
>> +{
>> +    /*
>> +     * No public AMD register reference is available for this value.
>> +     * The scale was derived from observed PROM21 xHCI temperature readings:
>> +     *  temp[C] = raw * 0.9066 - 78.624
>> +     */
>> +    return DIV_ROUND_CLOSEST(raw * 9066, 10) - 78624;
>> +}
>> +
>> +static umode_t xhci_prom21_hwmon_is_visible(const void *drvdata,
>> +                        enum hwmon_sensor_types type,
>> +                        u32 attr, int channel)
>> +{
>> +    if (type != hwmon_temp || channel)
>> +        return 0;
>> +
>> +    switch (attr) {
>> +    case hwmon_temp_input:
>> +        return 0444;
>> +    default:
>> +        return 0;
>> +    }
>> +}
>> +
>> +static int xhci_prom21_hwmon_read(struct device *dev,
>> +                  enum hwmon_sensor_types type, u32 attr,
>> +                  int channel, long *val)
>> +{
>> +    struct xhci_prom21_hwmon *hwmon = dev_get_drvdata(dev);
>> +    u8 raw;
>> +    int ret;
>> +
>> +    if (type != hwmon_temp || attr != hwmon_temp_input || channel)
>> +        return -EOPNOTSUPP;
>> +
>> +    ret = xhci_prom21_read_temp_raw_restore_index(hwmon, &raw);
>> +    if (ret)
>> +        return ret;
>> +
>> +    *val = xhci_prom21_raw_to_millicelsius(raw);
>> +    return 0;
>> +}
>> +
>> +static const struct hwmon_ops xhci_prom21_hwmon_ops = {
>> +    .is_visible = xhci_prom21_hwmon_is_visible,
>> +    .read = xhci_prom21_hwmon_read,
>> +};
>> +
>> +static const struct hwmon_channel_info *const xhci_prom21_hwmon_info[] = {
>> +    HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
>> +    NULL,
>> +};
>> +
>> +static const struct hwmon_chip_info xhci_prom21_chip_info = {
>> +    .ops = &xhci_prom21_hwmon_ops,
>> +    .info = xhci_prom21_hwmon_info,
>> +};
>> +
>> +void xhci_prom21_hwmon_init(struct xhci_hcd *xhci, struct pci_dev *pdev)
>> +{
>> +    struct xhci_prom21_hwmon_devres *devres;
>> +    struct xhci_prom21_hwmon *hwmon;
>> +    struct usb_hcd *hcd = xhci_to_hcd(xhci);
>> +    struct device *dev = &pdev->dev;
>> +    struct device *hwmon_dev;
>> +
>> +    if (!hcd->regs || hcd->rsrc_len < XHCI_PROM21_DATA + sizeof(u32)) {
>> +        dev_err(dev,
>> +            "AMD PROM21 hwmon unavailable: invalid MMIO resource\n");
>> +        return;
>> +    }
>> +
>> +    hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
>> +    if (!hwmon) {
>> +        /* The allocator reports OOM; add PROM21 device context. */
>> +        dev_err(dev, "AMD PROM21 hwmon state unavailable\n");
>> +        return;
>> +    }
>> +
>> +    devres = devres_alloc(xhci_prom21_hwmon_devres_release, sizeof(*devres),
>> +                  GFP_KERNEL);
>> +    if (!devres) {
>> +        dev_err(dev, "AMD PROM21 hwmon devres allocation failed\n");
>> +        return;
>> +    }
>> +
>> +    hwmon->pdev = pdev;
>> +    hwmon->regs = hcd->regs;
>> +    mutex_init(&hwmon->lock);
>> +
>> +    hwmon_dev = devm_hwmon_device_register_with_info(dev,
>> +                             XHCI_PROM21_HWMON_NAME,
>> +                             hwmon,
>> +                             &xhci_prom21_chip_info,
>> +                             NULL);
>> +    if (IS_ERR(hwmon_dev)) {
>> +        devres_free(devres);
>> +        dev_err(dev, "AMD PROM21 hwmon registration failed: %pe\n",
>> +            hwmon_dev);
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Store a private devres record so the device remove path can find this
>> +     * state without adding PROM21-specific part to xhci-pci.
>> +     */
>> +    devres->hwmon = hwmon;
>> +    devres_add(dev, devres);
>> +}
>> +EXPORT_SYMBOL_GPL(xhci_prom21_hwmon_init);
>> +
>> +void xhci_try_prom21_hwmon_invalidate(struct pci_dev *pdev)
>> +{
>> +    struct xhci_prom21_hwmon_devres *devres;
>> +
>> +    /*
>> +     * This is called for every xHCI PCI device. Devices without PROM21
>> +     * hwmon support simply have no matching helper devres entry.
>> +     */
>> +    devres = devres_find(&pdev->dev, xhci_prom21_hwmon_devres_release, NULL,
>> +                 NULL);
>> +    if (!devres) {
>> +        dev_dbg(&pdev->dev, "AMD PROM21 hwmon state not found\n");
>> +        return;
>> +    }
>> +
>> +    xhci_prom21_hwmon_invalidate(devres->hwmon);
>> +}
>> +EXPORT_SYMBOL_GPL(xhci_try_prom21_hwmon_invalidate);
>> diff --git a/drivers/usb/host/xhci-prom21-hwmon.h b/drivers/usb/host/xhci-prom21-hwmon.h
>> new file mode 100644
>> index 000000000000..eca8db23c0ea
>> --- /dev/null
>> +++ b/drivers/usb/host/xhci-prom21-hwmon.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com> */
>> +
>> +#ifndef XHCI_PROM21_HWMON_H
>> +#define XHCI_PROM21_HWMON_H
>> +
>> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI 0x43fd
>> +
>> +struct pci_dev;
>> +struct xhci_hcd;
>> +
>> +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_PROM21_HWMON)
>> +void xhci_prom21_hwmon_init(struct xhci_hcd *xhci, struct pci_dev *pdev);
>> +void xhci_try_prom21_hwmon_invalidate(struct pci_dev *pdev);
>> +#else
>> +static inline void xhci_prom21_hwmon_init(struct xhci_hcd *xhci,
>> +                      struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static inline void xhci_try_prom21_hwmon_invalidate(struct pci_dev *pdev)
>> +{
>> +}
>> +#endif
>> +
>> +#endif
> 

