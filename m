Received: from outbound.ci.icloud.com (ci-2004b-snip4-8.eps.apple.com [57.103.89.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FD376467
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099295; cv=none; b=UfjhNj6oVHXCha9HzYGyWhA7Zo1/ced+w0eTFsCyMCJdaf09LrRmDnpB+QbOgUGLCgi2uWp6eUqUNSkoFJBmS5iuiwDf/50sEGygPU/9AdGJe8kpRDywSaHbIC8MmsYaz0FIaFFIPW49UmoPCoAJRAsckQSUSJ2PCQhv0XUNERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099295; c=relaxed/simple;
	bh=vyS+jTAfCG+1uxpjXKZ7KDZ3ehRpSANhDzuTdIlpmdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjHY6sE0QBKY1aiEL1bOCRKgHyHNqEz4gi7zQFqmLLXZPL6pmbOD9hegREq1aRrfq9ndal0tYGggOFJFCecufisV3JFjSMUYhHQDV2R0yXBTZFseleHnDtY80H2pJ3u5Rv//CGJRazFib3o3t6NNmWYLAQNl31E6w3X/pwvK0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=T++T8GqI; arc=none smtp.client-ip=57.103.89.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="T++T8GqI"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id 4975C1800DE4;
	Wed, 06 May 2026 20:28:06 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhMHVsARQNFDFYEVBcOVk1RDUEfTgZTHgtKAl93AlEcVg1XQ1QEX1BfHA4FQhlACVQZXV8FWgAwUBtfAkIPHBNWFRMfVFYDQhkQVgFYVl0FTRpcGFkPHBNQVloOWwRHFBcbXAAXG0YCBCMCXwBFAl4JVgEwFw9WTVAbXwJCDxwTVhUTAF4PD0wBT1dVUQ5TFRQaAAtSRgYRXE4eDABeAF0ISgcLVlgGEVgbBlh3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778099289; x=1780691289; bh=6kEJm6vhBG8opLwqVb0ajKiFKBBWl5WXVc8U0agy+Jo=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=T++T8GqIYxVJuQBcKVxn8jISmzGpaQ68tgUegJUjMTrSWFUi4o8eebDtuxY6rnKpQy2hmtj6zdKVD82G53vo41o0Pe6dlgKEWsXdLOhATnRZheaW7LU+IshwDdtktPmpHVHhlbXGazWR5RXT4d3qWey9NxgLTiyJcZJzZjVjH9REKYkMEyxohjd4RTBE9BpuRr+64JfpJDcVZRWz3yRt10vWu8XH2JyL1FAs06ztHXdAeQMdoBEEN2GCfP0PrwAm2l6uYV/AhVnvS37kGzl+/Smjtl335T7yAbpwHR0s2/mNObgQFuZr7uPMmkx6V0VDWY381HLwn8p/fWAmDyvkiQ==
Received: from [192.168.89.2] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id DF0C218000BA;
	Wed, 06 May 2026 20:28:02 +0000 (UTC)
Message-ID: <87d8feae-b3fe-4ae6-a752-124fa34aac55@icloud.com>
Date: Thu, 7 May 2026 05:28:00 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: add AMD PROM21 xHCI hwmon support for
 temperature monitoring
To: Guenter Roeck <linux@roeck-us.net>,
 Mathias Nyman <mathias.nyman@linux.intel.com>,
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
 <35bbf02d-0746-47d9-b317-e83121f03f89@roeck-us.net>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <35bbf02d-0746-47d9-b317-e83121f03f89@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Y7H1cxeN c=1 sm=1 tr=0 ts=69fba457
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=l6-YASWEHvfqiCfSg_QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PgRulw5oR9JgysbTFEid:22 a=7Qc1FT-s8A_-IAtjNxYh:22
X-Proofpoint-ORIG-GUID: O6gdY5sIXHcxxoorTfi33Ejxv0M-g_f8
X-Proofpoint-GUID: O6gdY5sIXHcxxoorTfi33Ejxv0M-g_f8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDIwMSBTYWx0ZWRfX0/QQyrEkQUHZ
 hLGP0gpi5XAoumCfS3QsGADZYBnuz6h8aJzVtqKSV7bl0FJFKl8cSEg57p+puPmh0B28oN8zhm+
 gIxfuPjexghCU0r/ZpI43FqvDfJhVIqboReb9UiYS79Gtka/qPao9xE+uhTeOmdpZP5BI4nVXix
 eoNmFRaQolrsmswUjy9KDNAdbd8DaAnd4XjDGmv6cWOJYmwGTcTeV6mPWZSpiMSog0zCQudNPLo
 7PBgexMn/uNSpcg9uk3co2fLF48Lwn6IDXFvx1YBPcpp6kxZ6FcnOByhTIMcGVm6o9j4oPm/Ypn
 lHP5TfBuYR0M2QFlJx6Mb4GtNcwy9vLggxZJGK8YC6ZcAZ9bXZTWmTvsMwK1Dw=

Hi Mathias, Guenter,

Thank you for the review. I reworked the patch for v2 and addressed the
main points as follows.

 > To me it looks like a separate device should be created for this, and a
 > new driver in drivers/hwmon bind to it.

Addressed in v2. The PROM21-specific hwmon code is no longer linked into
drivers/usb/host. The xhci-pci side now creates an auxiliary device for
selected controllers, and the PROM21 temperature support is implemented as a
separate driver under drivers/hwmon which binds to that auxiliary device.

The v2 series is split into two patches:

   1. usb: xhci-pci: add generic auxiliary device interface
   2. hwmon: add initial support for AMD PROM21 xHCI temperature sensor

 > Auxiliary devices were created specifically for this purpose. The parent
 > driver would create an auxiliary device in its probe function, which 
would
 > then be instantiated from the client driver.

Addressed in v2. xhci-pci creates the auxiliary device only for
controllers matched by an internal PCI ID table, currently only AMD
1022:43fd. It destroys that auxiliary device from the remove path before
HCD teardown. The hwmon driver binds through the auxiliary bus and owns the
hwmon device lifetime.

The hwmon device is registered under the parent PCI function so userspace
still reports it as a PCI adapter, but the auxiliary driver explicitly
unregisters it from the auxiliary remove path before xhci-pci tears down the
HCD.

 > On a side note, the code below looks messy. I would personally prefer
 > something like the Renesas solution.

I moved the PROM21-specific code out of xhci-pci and out of
drivers/usb/host. xhci-pci now only has the generic auxiliary-device
creation side; the register offsets, conversion formula, hwmon callbacks,
and runtime PM policy are all in drivers/hwmon/prom21-hwmon.c.

I also tried to keep the generic auxiliary-device support in xhci-pci as
small and generic as possible. Similar to the Renesas handling, xhci-pci
uses PCI ID based filtering, and only matching devices get an auxiliary
child device.

 > Does accessing those registers depend on xHC state? or is enough that the
 > PCI device is enabled and in D0?  i.e. does xHC need to be in "running"
 > state?
 > I'd like to avoid resuming and restarting xHC every time temperature is
 > read from a sysfs file.

I tested this on my system. Reading the PROM21 temperature register without
runtime-resuming the parent xHCI PCI function did not return a valid
temperature value while the device was suspended. Reading after runtime
resume returned valid values.

Based on that result, v2 keeps the default behavior of allowing a
temperature read to wake the xHCI PCI device. I also added the
allow_pm_switch module parameter. With allow_pm_switch=N, a hwmon read
does not wake the xHCI PCI device; if the device is suspended, the read
returns -EAGAIN instead. v2 also adds
Documentation/hwmon/prom21-hwmon.rst, which documents this behavior.

 > Can this cause a linker error if CONFIG_USB_XHCI_PCI is built-in (y) and
 > CONFIG_HWMON is built as a module (m)?

Addressed by the v2 structure. xhci-hcd no longer calls into hwmon APIs or
links PROM21 hwmon code directly. The PROM21 temperature support is now a
standalone hwmon driver using the auxiliary bus, so the xhci-pci side only
creates the auxiliary device and does not reference hwmon symbols.

I also added Documentation/hwmon/prom21-hwmon.rst documenting the
supported device, register offsets, conversion formula, sysfs attributes,
lookup method, and allow_pm_switch behavior.

Sincerely,
Jihong Min

On 5/6/26 23:26, Guenter Roeck wrote:
> On 5/6/26 06:37, Mathias Nyman wrote:
>> Hi
>>
>> On 5/6/26 06:29, Jihong Min wrote:
>>> AMD PROM21 xHCI controllers expose a temperature byte through a
>>> vendor-specific index/data register pair in the xHCI PCI MMIO BAR 
>>> region.
>>> Add hwmon support for this, limited to temperature monitoring, and
>>> initialize it from the xHCI PCI driver probe path.
>>>
>>> The xhci-pci probe and remove paths call the PROM21 hwmon helpers 
>>> only for
>>> AMD 1022:43fd controllers. The hwmon read path selects the temperature
>>> register through the vendor index register, reads the raw 
>>> temperature byte
>>> from the data register, and restores the previous index before 
>>> returning.
>>>
>>> No public AMD register reference is available for this value. The
>>> conversion formula is derived from observed temperature readings:
>>>
>>>    temp[C] = raw * 0.9066 - 78.624
>>>
>>> This is not implemented as a standalone driver because the temperature
>>> register belongs to the PROM21 xHCI PCI function, is accessed 
>>> through the
>>> xHCI BAR after the host controller is initialized, and should share 
>>> that
>>> device's lifetime and runtime PM. Keep the device-specific PROM21 
>>> code in a
>>> separate helper called only from xhci-pci, while linking it into 
>>> xhci-hcd
>>> to match the existing xHCI object layout. The xhci-pci remove path
>>> invalidates the helper before HCD teardown.
>>>
>>
>> To me it looks like a sepate device should be created for this, and a 
>> new
>> driver in drivers/hwmon bind to it.
>>
>> Not sure what is the best solution, do we create a parent mfd driver 
>> that
>> binds to the PCI device, which then creates two child devices, xhci 
>> and hwmon.
>> Or do we just create some kind of platform device as a child to this 
>> xhci
>> PCI device.
>>
>
> Auxiliary devices were created specifically for this purpose. The 
> parent driver
> would create an auxiliary device in its probe function, which would 
> then be
> instantiated from the client driver.
>
> On a side note, the code below looks messy. I would personally prefer 
> something
> like the Renesas solution.
>
> Guenter
>
>> Maybe someone on the PCI list would know (added to cc)? I guess it's 
>> not the
>> first time we have a "multi function" PCI device that has just has 
>> one BAR.
>>
>> The resources this device needs look simple, only access two 
>> registers at
>> offset 0x3000 and 0x3008 from mmio base.
>>
>> Does accessing those registers depend on xHC state? or is enough that 
>> the
>> PCI device is enabled and in D0?  i.e. does xHC need to be in "running"
>> state?
>> I'd like to avoid resuming and restarting xHC every time temperature 
>> is read
>> from a sysfs file.
>>
>> Thanks
>> Mathias
>>
>> (keeping reset of message as reference for pci list readers)
>>
>>> Assisted-by: Codex:gpt-5.5
>>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
>>> ---
>>>   drivers/usb/host/Kconfig             |  10 ++
>>>   drivers/usb/host/Makefile            |   4 +
>>>   drivers/usb/host/xhci-pci.c          |   9 +
>>>   drivers/usb/host/xhci-prom21-hwmon.c | 241 
>>> +++++++++++++++++++++++++++
>>>   drivers/usb/host/xhci-prom21-hwmon.h |  26 +++
>>>   5 files changed, 290 insertions(+)
>>>   create mode 100644 drivers/usb/host/xhci-prom21-hwmon.c
>>>   create mode 100644 drivers/usb/host/xhci-prom21-hwmon.h
>>>
>>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>>> index 0a277a07cf70..da41ebc272b0 100644
>>> --- a/drivers/usb/host/Kconfig
>>> +++ b/drivers/usb/host/Kconfig
>>> @@ -42,6 +42,16 @@ config USB_XHCI_PCI
>>>       depends on USB_PCI
>>>       default y
>>> +config USB_XHCI_PCI_PROM21_HWMON
>>> +    bool "AMD PROM21 xHCI temperature sensor support"
>>> +    depends on USB_XHCI_PCI
>>> +    depends on HWMON
>>> +    help
>>> +      Say Y here to expose the AMD PROM21 xHCI temperature sensor
>>> +      through the hwmon subsystem. The sensor is accessed through a
>>> +      vendor-specific index/data register pair in the controller's PCI
>>> +      MMIO BAR and reports temperature only. If unsure, say N.
>>> +
>>>   config USB_XHCI_PCI_RENESAS
>>>       tristate "Support for additional Renesas xHCI controller with 
>>> firmware"
>>>       depends on USB_XHCI_PCI
>>> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
>>> index a07e7ba9cd53..22f141cb2af7 100644
>>> --- a/drivers/usb/host/Makefile
>>> +++ b/drivers/usb/host/Makefile
>>> @@ -36,6 +36,10 @@ ifneq ($(CONFIG_USB_XHCI_SIDEBAND),)
>>>       xhci-hcd-y        += xhci-sideband.o
>>>   endif
>>> +ifneq ($(CONFIG_USB_XHCI_PCI_PROM21_HWMON),)
>>> +    xhci-hcd-y += xhci-prom21-hwmon.o
>>> +endif
>>> +
>>>   obj-$(CONFIG_USB_PCI)    += pci-quirks.o
>>>   obj-$(CONFIG_USB_EHCI_HCD)    += ehci-hcd.o
>>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>>> index 585b2f3117b0..54713efc931f 100644
>>> --- a/drivers/usb/host/xhci-pci.c
>>> +++ b/drivers/usb/host/xhci-pci.c
>>> @@ -18,6 +18,7 @@
>>>   #include "xhci.h"
>>>   #include "xhci-trace.h"
>>>   #include "xhci-pci.h"
>>> +#include "xhci-prom21-hwmon.h"
>>>   #define SSIC_PORT_NUM        2
>>>   #define SSIC_PORT_CFG2        0x880c
>>> @@ -677,6 +678,10 @@ int xhci_pci_common_probe(struct pci_dev *dev, 
>>> const struct pci_device_id *id)
>>>       if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
>>>           pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
>>> +    if (dev->vendor == PCI_VENDOR_ID_AMD &&
>>> +        dev->device == PCI_DEVICE_ID_AMD_PROM21_XHCI)
>>> +        xhci_prom21_hwmon_init(xhci, dev);
>>> +
>>>       return 0;
>>>   put_usb3_hcd:
>>> @@ -713,6 +718,10 @@ void xhci_pci_remove(struct pci_dev *dev)
>>>       xhci = hcd_to_xhci(pci_get_drvdata(dev));
>>>       set_power_d3 = xhci->quirks & XHCI_SPURIOUS_WAKEUP;
>>> +    if (dev->vendor == PCI_VENDOR_ID_AMD &&
>>> +        dev->device == PCI_DEVICE_ID_AMD_PROM21_XHCI)
>>> +        xhci_try_prom21_hwmon_invalidate(dev);
>>> +
>>>       xhci->xhc_state |= XHCI_STATE_REMOVING;
>>>       if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
>>> diff --git a/drivers/usb/host/xhci-prom21-hwmon.c 
>>> b/drivers/usb/host/xhci-prom21-hwmon.c
>>> new file mode 100644
>>> index 000000000000..5f71e72f4a90
>>> --- /dev/null
>>> +++ b/drivers/usb/host/xhci-prom21-hwmon.c
>>> @@ -0,0 +1,241 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * AMD PROM21 xHCI Hwmon Implementation
>>> + * (only temperature monitoring is supported)
>>> + *
>>> + * This can be effectively used as the alternative chipset 
>>> temperature monitor.
>>> + *
>>> + * Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com>
>>> + */
>>> +
>>> +#include <linux/device/devres.h>
>>> +#include <linux/err.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/hwmon.h>
>>> +#include <linux/io.h>
>>> +#include <linux/math.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include "xhci.h"
>>> +#include "xhci-prom21-hwmon.h"
>>> +
>>> +#define XHCI_PROM21_INDEX 0x3000
>>> +#define XHCI_PROM21_DATA 0x3008
>>> +#define XHCI_PROM21_TEMP_REG 0x0001e520
>>> +
>>> +#define XHCI_PROM21_HWMON_NAME "xhci_prom21"
>>> +
>>> +struct xhci_prom21_hwmon {
>>> +    struct pci_dev *pdev;
>>> +    void __iomem *regs;
>>> +    bool removing;
>>> +    struct mutex lock; /* protects removing and the index/data 
>>> registers */
>>> +};
>>> +
>>> +struct xhci_prom21_hwmon_devres {
>>> +    struct xhci_prom21_hwmon *hwmon;
>>> +};
>>> +
>>> +static void xhci_prom21_hwmon_invalidate(struct xhci_prom21_hwmon 
>>> *hwmon)
>>> +{
>>> +    mutex_lock(&hwmon->lock);
>>> +    hwmon->removing = true;
>>> +    mutex_unlock(&hwmon->lock);
>>> +}
>>> +
>>> +static void xhci_prom21_hwmon_devres_release(struct device *dev, 
>>> void *res)
>>> +{
>>> +    struct xhci_prom21_hwmon_devres *devres = res;
>>> +
>>> +    /*
>>> +     * devm hwmon unregister runs after this lookup record is 
>>> released.
>>> +     * Mark the data path closed first so any late sysfs read returns
>>> +     * without touching xHCI MMIO.
>>> +     */
>>> +    xhci_prom21_hwmon_invalidate(devres->hwmon);
>>> +}
>>> +
>>> +/*
>>> + * This is not a pure MMIO read. The PROM21 vendor data register is 
>>> selected
>>> + * by temporarily writing XHCI_PROM21_TEMP_REG to the vendor index 
>>> register.
>>> + * Keep the sequence short and restore the previous index before 
>>> returning.
>>> + */
>>> +static int
>>> +xhci_prom21_read_temp_raw_restore_index(struct xhci_prom21_hwmon 
>>> *hwmon,
>>> +                    u8 *raw)
>>> +{
>>> +    struct device *dev = &hwmon->pdev->dev;
>>> +    u32 index;
>>> +    u32 data;
>>> +    int ret;
>>> +
>>> +    /*
>>> +     * xhci_try_prom21_hwmon_invalidate() uses the same lock before 
>>> HCD
>>> +     * teardown. Keep runtime PM and MMIO inside the critical 
>>> section so a
>>> +     * sysfs read cannot use the vendor register pair after remove 
>>> starts.
>>> +     */
>>> +    mutex_lock(&hwmon->lock);
>>> +    if (hwmon->removing) {
>>> +        mutex_unlock(&hwmon->lock);
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    ret = pm_runtime_resume_and_get(dev);
>>> +    if (ret < 0) {
>>> +        mutex_unlock(&hwmon->lock);
>>> +        return ret;
>>> +    }
>>> +
>>> +    index = readl(hwmon->regs + XHCI_PROM21_INDEX);
>>> +    /* Select the PROM21 temperature register through the vendor 
>>> index. */
>>> +    writel(XHCI_PROM21_TEMP_REG, hwmon->regs + XHCI_PROM21_INDEX);
>>> +    data = readl(hwmon->regs + XHCI_PROM21_DATA);
>>> +    /* Restore the previous vendor index register value. */
>>> +    writel(index, hwmon->regs + XHCI_PROM21_INDEX);
>>> +    readl(hwmon->regs + XHCI_PROM21_INDEX);
>>> +
>>> +    /* Let xHCI PCI runtime PM coalesce repeated sysfs polling. */
>>> +    pm_runtime_mark_last_busy(dev);
>>> +    pm_runtime_put_autosuspend(dev);
>>> +    mutex_unlock(&hwmon->lock);
>>> +
>>> +    *raw = data & 0xff;
>>> +    if (!*raw || *raw == 0xff)
>>> +        return -ENODATA;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static long xhci_prom21_raw_to_millicelsius(u8 raw)
>>> +{
>>> +    /*
>>> +     * No public AMD register reference is available for this value.
>>> +     * The scale was derived from observed PROM21 xHCI temperature 
>>> readings:
>>> +     *  temp[C] = raw * 0.9066 - 78.624
>>> +     */
>>> +    return DIV_ROUND_CLOSEST(raw * 9066, 10) - 78624;
>>> +}
>>> +
>>> +static umode_t xhci_prom21_hwmon_is_visible(const void *drvdata,
>>> +                        enum hwmon_sensor_types type,
>>> +                        u32 attr, int channel)
>>> +{
>>> +    if (type != hwmon_temp || channel)
>>> +        return 0;
>>> +
>>> +    switch (attr) {
>>> +    case hwmon_temp_input:
>>> +        return 0444;
>>> +    default:
>>> +        return 0;
>>> +    }
>>> +}
>>> +
>>> +static int xhci_prom21_hwmon_read(struct device *dev,
>>> +                  enum hwmon_sensor_types type, u32 attr,
>>> +                  int channel, long *val)
>>> +{
>>> +    struct xhci_prom21_hwmon *hwmon = dev_get_drvdata(dev);
>>> +    u8 raw;
>>> +    int ret;
>>> +
>>> +    if (type != hwmon_temp || attr != hwmon_temp_input || channel)
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    ret = xhci_prom21_read_temp_raw_restore_index(hwmon, &raw);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    *val = xhci_prom21_raw_to_millicelsius(raw);
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct hwmon_ops xhci_prom21_hwmon_ops = {
>>> +    .is_visible = xhci_prom21_hwmon_is_visible,
>>> +    .read = xhci_prom21_hwmon_read,
>>> +};
>>> +
>>> +static const struct hwmon_channel_info *const 
>>> xhci_prom21_hwmon_info[] = {
>>> +    HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
>>> +    NULL,
>>> +};
>>> +
>>> +static const struct hwmon_chip_info xhci_prom21_chip_info = {
>>> +    .ops = &xhci_prom21_hwmon_ops,
>>> +    .info = xhci_prom21_hwmon_info,
>>> +};
>>> +
>>> +void xhci_prom21_hwmon_init(struct xhci_hcd *xhci, struct pci_dev 
>>> *pdev)
>>> +{
>>> +    struct xhci_prom21_hwmon_devres *devres;
>>> +    struct xhci_prom21_hwmon *hwmon;
>>> +    struct usb_hcd *hcd = xhci_to_hcd(xhci);
>>> +    struct device *dev = &pdev->dev;
>>> +    struct device *hwmon_dev;
>>> +
>>> +    if (!hcd->regs || hcd->rsrc_len < XHCI_PROM21_DATA + 
>>> sizeof(u32)) {
>>> +        dev_err(dev,
>>> +            "AMD PROM21 hwmon unavailable: invalid MMIO resource\n");
>>> +        return;
>>> +    }
>>> +
>>> +    hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
>>> +    if (!hwmon) {
>>> +        /* The allocator reports OOM; add PROM21 device context. */
>>> +        dev_err(dev, "AMD PROM21 hwmon state unavailable\n");
>>> +        return;
>>> +    }
>>> +
>>> +    devres = devres_alloc(xhci_prom21_hwmon_devres_release, 
>>> sizeof(*devres),
>>> +                  GFP_KERNEL);
>>> +    if (!devres) {
>>> +        dev_err(dev, "AMD PROM21 hwmon devres allocation failed\n");
>>> +        return;
>>> +    }
>>> +
>>> +    hwmon->pdev = pdev;
>>> +    hwmon->regs = hcd->regs;
>>> +    mutex_init(&hwmon->lock);
>>> +
>>> +    hwmon_dev = devm_hwmon_device_register_with_info(dev,
>>> +                             XHCI_PROM21_HWMON_NAME,
>>> +                             hwmon,
>>> +                             &xhci_prom21_chip_info,
>>> +                             NULL);
>>> +    if (IS_ERR(hwmon_dev)) {
>>> +        devres_free(devres);
>>> +        dev_err(dev, "AMD PROM21 hwmon registration failed: %pe\n",
>>> +            hwmon_dev);
>>> +        return;
>>> +    }
>>> +
>>> +    /*
>>> +     * Store a private devres record so the device remove path can 
>>> find this
>>> +     * state without adding PROM21-specific part to xhci-pci.
>>> +     */
>>> +    devres->hwmon = hwmon;
>>> +    devres_add(dev, devres);
>>> +}
>>> +EXPORT_SYMBOL_GPL(xhci_prom21_hwmon_init);
>>> +
>>> +void xhci_try_prom21_hwmon_invalidate(struct pci_dev *pdev)
>>> +{
>>> +    struct xhci_prom21_hwmon_devres *devres;
>>> +
>>> +    /*
>>> +     * This is called for every xHCI PCI device. Devices without 
>>> PROM21
>>> +     * hwmon support simply have no matching helper devres entry.
>>> +     */
>>> +    devres = devres_find(&pdev->dev, 
>>> xhci_prom21_hwmon_devres_release, NULL,
>>> +                 NULL);
>>> +    if (!devres) {
>>> +        dev_dbg(&pdev->dev, "AMD PROM21 hwmon state not found\n");
>>> +        return;
>>> +    }
>>> +
>>> +    xhci_prom21_hwmon_invalidate(devres->hwmon);
>>> +}
>>> +EXPORT_SYMBOL_GPL(xhci_try_prom21_hwmon_invalidate);
>>> diff --git a/drivers/usb/host/xhci-prom21-hwmon.h 
>>> b/drivers/usb/host/xhci-prom21-hwmon.h
>>> new file mode 100644
>>> index 000000000000..eca8db23c0ea
>>> --- /dev/null
>>> +++ b/drivers/usb/host/xhci-prom21-hwmon.h
>>> @@ -0,0 +1,26 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/* Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com> */
>>> +
>>> +#ifndef XHCI_PROM21_HWMON_H
>>> +#define XHCI_PROM21_HWMON_H
>>> +
>>> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI 0x43fd
>>> +
>>> +struct pci_dev;
>>> +struct xhci_hcd;
>>> +
>>> +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_PROM21_HWMON)
>>> +void xhci_prom21_hwmon_init(struct xhci_hcd *xhci, struct pci_dev 
>>> *pdev);
>>> +void xhci_try_prom21_hwmon_invalidate(struct pci_dev *pdev);
>>> +#else
>>> +static inline void xhci_prom21_hwmon_init(struct xhci_hcd *xhci,
>>> +                      struct pci_dev *pdev)
>>> +{
>>> +}
>>> +
>>> +static inline void xhci_try_prom21_hwmon_invalidate(struct pci_dev 
>>> *pdev)
>>> +{
>>> +}
>>> +#endif
>>> +
>>> +#endif
>>
>
