Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9964397E75
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246277; cv=none; b=VrnD4VTyOAfeNhaTAYs92GLbZ0/LPhxAHTbNzi36ZYjepOtJkyCHm2iYIBbYZQD5As4S++0R4L4+LfWcJwbEkR8Aj1T13EIrmH3QzTc9n8kvImkTkakLKCLP7UcICdcyEtp/ZAfwz0RaIANKGwH1qxxKoHzwiUcWw++kQcurCyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246277; c=relaxed/simple;
	bh=8p27S5MOGU71UbNINV14aMU5g0i9T0ZM6IUt5Ys7L38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeRJRR9DMUhFmv0AGv2O4GtNdEYnm7q0S02eesXEmhOy82XBccFdmzi917PhjzA3s4h0PgZKtBVVFdVHeoWYzZiBZ5po91MuhW2lEhyAy4x0txo6tvSmMdywh8+Kn4q72jhwlGSgkwtuvugsASB1E8lMMGv0D7kS5T4WyKqk6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=psxYf6iS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psxYf6iS"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8379e010b01so825860b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 08 May 2026 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778246275; x=1778851075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GPQqbo0BGx+WtuCfVxMY5CEZE7UAc0Y6Xa4Xm40mq+I=;
        b=psxYf6iSnTx2vR6kv8IOLvrsIJ/otyW6lYKpJ3tR1EOOlfaMSYkQc/srNsYRiQIGIh
         w5Sxi9qQ+eTg3Q35xbRrdZvp8oY5Ti5+p6kPNPYGiylf0D0Vp4YMhRfAkdiCVION+S8G
         tPGZaPERI6TK6+47FnYDwPfqyltZ4VCovlvoM5RvUiqbWYbsNSHrCNy2rbBf5PCCdGLw
         HkWLGdVtQBoZoF8tLIJrX2TPVIEtTH2qfUDy3MOOesAA7i/FOpvnVUs34+Bsvt5NSDDc
         IrVTFfOhCunrMp/gcBtJoIvhayhDaWYQA7YtjlWYthV1I7R4M1xS3WmwQpfYM0DYKiIU
         WH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778246275; x=1778851075;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPQqbo0BGx+WtuCfVxMY5CEZE7UAc0Y6Xa4Xm40mq+I=;
        b=cTICZ5gOb7YpCRoaNHvwCVJHhdluYL8vPqwmugGag5N4qjzj/sDVsYVcys4I+otmIT
         FY/Vjpmh3TbsqPiaSMeRgrcxq551DUzf3kfr10lb9Vk23HRQT3TAYbYwsl0NA5xH+nJE
         Nc8Y0IAbUpspSrzlu0eULjqxHFSqZ8+G8PdQgbJ0dagF2Rwwkj2i/l8srtSHOYN++R2x
         ZytiHi2iLLzNXmEyrjLMvMLynuBH0NHXmki5kvW6mx45osa1FR3d5IlxbVQmH0CXiecG
         OHBCif3CyD+mvoRXYdllrkOYkIUhhAg1NeFNnagQjZ+6ar/nGmBoi5Pm48maZoiv4Xbf
         DGAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ZPLruDA15W3kI+bci6mV5gTlTbjb6tEWk2od0CWbKpwXtXZ1IgKroV3AhPOTgfUtBomOM6NZg8yU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcg288S29hACcW3bhYnPrkhrRCVeQG8tIDRxOEPfst8CfjUhDq
	oqa5r9RqidRWfkM/XqaBVN+zquDyB9uD4RooVPvqE0VQNKDH3FnTwkGl
X-Gm-Gg: AeBDiet/Oz6U1/ZQ0U1RucUlVvK0YIjjUBRMgy9dZcsD4MV3eMsV8MfHYQgWck1U0TY
	b7LY1pYDlkCVG/HCxQwfhLwkrAVOkXXBmiFlPQDRSHxQ3LEmC9lndEKN+V97TiyO4VWdcqJ7X07
	iZWjlSdSaYMLWdSz44VTND7S56ssq8Ew0xl91NwdscEIW2sz1JhKUIlMJoxKUqEXboMZQI5vhYk
	XG0kybYE1fn4U2181NEDVfvF6ItNm/oWgQaLSD2ebqcMXCe793wnHSbYcZWqS3PvRsV6uqOhLhx
	+SE14GspvJvu8ZHl4iEimPK1ZDLsDF3vh2Fm78uiCcsInaQEO5bEmbwRNjUXy6kVM5ese39eP8y
	SC5MABtD1b6fT7nHV7rRB82t+R9kNDwVak/iZzowg6XyXcvJ3QDdqKDFkcYIUXlr9g9UdUCy2jP
	y5Ovw+MZb6mizm+8+veUnG/NSi1JKMdsJLMABGDTCpdtniKsHL2Rz5D1O1uiju6qC/GwUyj0Dc
X-Received: by 2002:a05:6a00:f0f:b0:838:3f54:a0ee with SMTP id d2e1a72fcca58-83a5b2d2c16mr12005499b3a.7.1778246275059;
        Fri, 08 May 2026 06:17:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945101sm12098812b3a.13.2026.05.08.06.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 06:17:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e9808463-021b-41cf-8080-0f4e45ae2ebb@roeck-us.net>
Date: Fri, 8 May 2026 06:17:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] usb: xhci-pci: add generic auxiliary device
 interface
To: Jihong Min <hurryman2212@icloud.com>,
 Mathias Nyman <mathias.nyman@linux.intel.com>,
 Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1778123510.git.hurryman2212@gmail.com>
 <effa7bd7bef8a8ea28b9e28fe47af6a58e39edf2.1778123510.git.hurryman2212@gmail.com>
 <a5739875-b8a5-4918-8850-fa4b32d5279d@linux.intel.com>
 <f47d9cc1-e39b-4199-b031-e91b8e02ab1d@icloud.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <f47d9cc1-e39b-4199-b031-e91b8e02ab1d@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/8/26 00:04, Jihong Min wrote:
> Hi Mathias,
> 
> I tried the xhci-pci-prom21.c approach you suggested, with a PROM21-specific
> PCI glue driver calling xhci_pci_common_probe() and creating the auxiliary
> hwmon child device from that driver.
> 
> While doing that I noticed a possible boot-time regression with the module
> case.
> 
> If CONFIG_USB_XHCI_PCI=y and CONFIG_USB_XHCI_PCI_PROM21=m, then generic
> xhci-pci sees CONFIG_USB_XHCI_PCI_PROM21 as enabled and refuses the PROM21
> PCI ID:
> 
>      if (IS_ENABLED(CONFIG_USB_XHCI_PCI_PROM21) &&
>          pci_match_id(pci_ids_prom21, dev))
>              return -ENODEV;
> 
> That means the PROM21 xHCI controller is handled only by
> xhci-pci-prom21.ko. If that module is not present in the initramfs or is not
> loaded early enough, the PROM21 xHCI controller remains unbound during early
> boot. Devices behind that controller, such as a USB keyboard used for early
> boot or disk unlock, would not work even though the generic xhci-pci driver is
> built in and could otherwise operate the controller.
> 
> This seems different from the Renesas case, where the separate PCI driver is
> needed for controller-specific firmware handling. For PROM21, the USB/xHCI
> operation itself is still generic; the only extra function is publishing an
> optional hwmon child device.
> 
> So I am not sure what the preferred direction should be:
> 
>    1. Keep the separate xhci-pci-prom21.c PCI glue driver and make
>       USB_XHCI_PCI_PROM21 built-in only, or otherwise constrain the Kconfig so
>       the generic xhci-pci handoff cannot break early boot.
> 
>    2. Keep PROM21 handled by generic xhci-pci and add only a small
>       PROM21-specific auxiliary-device creation hook in xhci-pci after the
>       common probe succeeds. In that model, failure to create the optional hwmon
>       auxiliary device would not affect USB operation.
> 
>    3. Some other split that keeps PROM21-specific sensor code outside
>       xhci-pci, but does not prevent generic xhci-pci from binding the
>       controller when the optional PROM21 glue is not available early.
> 
> Do you still prefer the separate xhci-pci-prom21.c PCI driver for this case,
> or would the minimal xhci-pci auxiliary-device hook be more appropriate given
> the built-in xhci-pci / modular PROM21 glue case?
> 

Maybe I am missing something, but it seems to me that CONFIG_USB_XHCI_PCI_PROM21
should be just as built-in as CONFIG_USB_XHCI_PCI.

Thanks,
Guenter

> Sincerely,
> Jihong Min
> 
> On 5/7/26 18:31, Mathias Nyman wrote:
>> On 5/7/26 06:31, Jihong Min wrote:
>>> Some xHCI PCI controllers expose controller-specific functionality that is
>>> not part of generic xHCI operation and is better handled by optional child
>>> drivers in other subsystems. Add a small auxiliary device registration path
>>> for selected xHCI PCI controllers.
>>>
>>> The initial PCI ID match table lists AMD Promontory 21 (PROM21) 1022:43fd
>>> controllers. For matching controllers, xhci-pci creates an auxiliary
>>> device and stores it in devres so the remove path destroys it before HCD
>>> teardown.
>>>
>>> Subsystem-specific child drivers can then bind to those devices through
>>> the auxiliary bus and keep their hardware-specific logic outside xhci-pci.
>>>
>>> Assisted-by: Codex:gpt-5.5
>>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
>>> ---
>>>   drivers/usb/host/Kconfig    | 10 +++++
>>>   drivers/usb/host/xhci-pci.c | 83 +++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 93 insertions(+)
>>>
>>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>>> index 0a277a07cf70..e0c2c7ac5c97 100644
>>> --- a/drivers/usb/host/Kconfig
>>> +++ b/drivers/usb/host/Kconfig
>>> @@ -42,6 +42,16 @@ config USB_XHCI_PCI
>>>       depends on USB_PCI
>>>       default y
>>>   +config USB_XHCI_PCI_AUXDEV
>>> +    bool "xHCI PCI auxiliary device support"
>>> +    depends on USB_XHCI_PCI
>>> +    select AUXILIARY_BUS
>>> +    help
>>> +      This enables xHCI PCI support for registering auxiliary devices
>>> +      for selected controllers. It is used by optional child drivers
>>> +      that bind to xHCI PCI controller-specific functionality through
>>> +      the auxiliary bus.
>>> +
>>>   config USB_XHCI_PCI_RENESAS
>>>       tristate "Support for additional Renesas xHCI controller with firmware"
>>>       depends on USB_XHCI_PCI
>>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>>> index 585b2f3117b0..618d6840e108 100644
>>> --- a/drivers/usb/host/xhci-pci.c
>>> +++ b/drivers/usb/host/xhci-pci.c
>>> @@ -8,6 +8,8 @@
>>>    * Some code borrowed from the Linux EHCI driver.
>>>    */
>>>   +#include <linux/auxiliary_bus.h>
>>> +#include <linux/device/devres.h>
>>>   #include <linux/pci.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/module.h>
>>> @@ -80,6 +82,7 @@
>>>   #define PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI        0x15e1
>>>   #define PCI_DEVICE_ID_AMD_RAVEN2_XHCI            0x15e5
>>>   #define PCI_DEVICE_ID_AMD_RENOIR_XHCI            0x1639
>>> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI            0x43fd
>>>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_4            0x43b9
>>>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_3            0x43ba
>>>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_2            0x43bb
>>> @@ -103,6 +106,80 @@ static int xhci_pci_run(struct usb_hcd *hcd);
>>>   static int xhci_pci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
>>>                         struct usb_tt *tt, gfp_t mem_flags);
>>>   +static const struct pci_device_id pci_ids_have_aux[] = {
>>> +    { PCI_DEVICE_DATA(AMD, PROM21_XHCI, "prom21_hwmon") },
>>> +    { /* end: all zeroes */ }
>>> +};
>>> +
>>> +struct xhci_pci_aux_devres {
>>> +    struct auxiliary_device *auxdev;
>>> +};
>>> +
>>> +static const char *xhci_pci_aux_dev_name(struct pci_dev *pdev)
>>> +{
>>> +    const struct pci_device_id *id;
>>> +
>>> +    id = pci_match_id(pci_ids_have_aux, pdev);
>>> +    if (!id)
>>> +        return NULL;
>>> +
>>> +    return (const char *)id->driver_data;
>>> +}
>>> +
>>> +static void xhci_pci_aux_devres_release(struct device *dev, void *res)
>>> +{
>>> +    struct xhci_pci_aux_devres *devres = res;
>>> +
>>> +    if (devres->auxdev)
>>> +        auxiliary_device_destroy(devres->auxdev);
>>> +}
>>> +
>>> +static void xhci_pci_try_add_aux_device(struct pci_dev *pdev)
>>> +{
>>> +    struct xhci_pci_aux_devres *devres;
>>> +    struct auxiliary_device *auxdev;
>>> +    const char *aux_dev_name;
>>> +
>>> +    aux_dev_name = xhci_pci_aux_dev_name(pdev);
>>> +    if (!aux_dev_name)
>>> +        return;
>>> +
>>> +    devres = devres_alloc(xhci_pci_aux_devres_release, sizeof(*devres),
>>> +                  GFP_KERNEL);
>>> +    if (!devres) {
>>> +        dev_warn(&pdev->dev,
>>> +             "failed to allocate auxiliary device state\n");
>>> +        return;
>>> +    }
>>> +
>>> +    auxdev = auxiliary_device_create(&pdev->dev, KBUILD_MODNAME,
>>> +                     aux_dev_name, NULL,
>>> +                     (pci_domain_nr(pdev->bus) << 16) |
>>> +                         pci_dev_id(pdev));
>>> +    if (!auxdev) {
>>> +        devres_free(devres);
>>> +        dev_warn(&pdev->dev, "failed to add %s auxiliary device\n",
>>> +             aux_dev_name);
>>> +        return;
>>> +    }
>>> +
>>> +    devres->auxdev = auxdev;
>>> +    devres_add(&pdev->dev, devres);
>>> +}
>>> +
>>> +static void xhci_pci_try_remove_aux_device(struct pci_dev *pdev)
>>> +{
>>> +    struct xhci_pci_aux_devres *devres;
>>> +
>>> +    devres = devres_find(&pdev->dev, xhci_pci_aux_devres_release, NULL,
>>> +                 NULL);
>>> +    if (!devres || !devres->auxdev)
>>> +        return;
>>> +
>>> +    auxiliary_device_destroy(devres->auxdev);
>>> +    devres->auxdev = NULL;
>>> +}
>>> +
>>>   static const struct xhci_driver_overrides xhci_pci_overrides __initconst = {
>>>       .reset = xhci_pci_setup,
>>>       .start = xhci_pci_run,
>>> @@ -677,6 +754,9 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>>       if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
>>>           pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
>>>   +    if (IS_ENABLED(CONFIG_USB_XHCI_PCI_AUXDEV))
>>> +        xhci_pci_try_add_aux_device(dev);
>>> +
>>>       return 0;
>>
>> I think this should be turned around so that the vendor specific code calls the common code.
>> xhci-pci-renesas.c does this nicely.
>>
>> In your case it would be adding something like a xhci-pci-prom21.c pci driver:
>>
>> xhci_pci_prom21_probe(struct pci_dev *dev, const struct pci_device_id *id)
>> {
>>     crate_auxiliary_device(dev);
>>     return xhci_pci_common_probe(dev, id);
>> }
>>
>> xhci_pci_prom21_remove(struct pci_dev *dev)
>> {
>>     destroy_auxiliary_device(dev);
>>     xhci_pci_remove(dev);
>> }
>>
>> static const struct pci_device_id pci_ids[] = {
>>     { PCI_DEVICE(YOUR_AMD_PCI_VENDOR_ID, YOUR_PROM21_DEVICE_ID) },
>>     { /* end: all zeroes */ }
>> };
>> MODULE_DEVICE_TABLE(pci, pci_ids);
>>
>> static struct pci_driver xhci_prom21_pci_driver = {
>>     .name =        "xhci-pci-prom21",
>>     .id_table =    pci_ids,
>>
>>     .probe =    xhci_pci_prom21_probe,
>>     .remove =    xhci_pci_prom21_remove,
>>
>>     .shutdown =     usb_hcd_pci_shutdown,
>>     .driver = {
>>         .pm = pm_ptr(&usb_hcd_pci_pm_ops),
>>     },
>> };
>> module_pci_driver(xhci_prom21_pci_driver);
>>
>> MODULE_DESCRIPTION("AMD Promontory 21 xHCI PCI Host Controller Driver");
>> MODULE_IMPORT_NS("xhci");
>> MODULE_LICENSE("GPL v2");
>>
>> -Mathias
> 

