Received: from outbound.qs.icloud.com (qs-2003g-snip4-11.eps.apple.com [57.103.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCDC37BE7F
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223909; cv=none; b=uUy4A7D6y1r0aIviIT1ZEBqOaISpQ1FaIZYz3qpr2AFqitvEsJozn6YdkAuv7hOPypVTycEA8foiziX0SxCowaLtTLNfovwkHNX7zJgEiZ3l6iFrUMrUkGexsw5+1y2Q8Qp3WwlCAXPEub8Lqsuta87rC4Zg+VND6z1azIHWt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223909; c=relaxed/simple;
	bh=FVVww/7ZCIlmqpV3f56A52J55Nootnml61a5paF3DJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2m5S2UxVoGuIi24UCol0WFrCFWHVYRlyjVRpAVmbOYhaE2HTlbfsXAfEtX2grPeo+4rMbp/OcS1sVkCx22JM5VyXHHjS0/rm/bpfypPy+PgHtnDRMyKgZIMWbuPYbZR231lPZenT7jgLqsEOqAgAW5wEbnT4uKcFlh/ho4+CAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dRHlgSxC; arc=none smtp.client-ip=57.103.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dRHlgSxC"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-5 (Postfix) with ESMTPS id 7A33218000B1;
	Fri, 08 May 2026 07:04:59 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJBkMDRQVJF0wBTVIPDxhMCkEUWgpcQgtJAS1eCF4fTBwdDlgGEhZdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWEEOCloGUFEdXwIKBEcEWxdGA1NFQwMXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PGVoUXBhTRVEfVFheBFNWDhYNT1dUVAgDXVxLCg8aXwNJAFVRXQRaHxUASVFVUlsAEVtJVy1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778223902; x=1780815902; bh=vrmtu3cjU0Q9sWlHRKR3zouF3lZXojOuoaPUVq+EAGk=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=dRHlgSxCBwoj/Zd/vcadOj/ngR35cjx4kq2GWUFBWRgeElA4mHCfeIPBi5G1ouP/GLoceFsh0RxOsV5vBgNE7aftR3sDWUK2+A0YjxgEkjRmioIm/0JU/zC8dLFUNCynUEZZ6S7N+jH67+wV1ug4KFbLsHgZt8HMi98HSDhvqV6jC2AHYc5fml2vBk2bE8YGP4sWMosGwioKaMn/9KzZ1C0eX5GlrjfsLk6HRE+f2m3pYAhQHzQ3EXjUkxCeighdodgp0aqppCo+qg48cAl1bMydnTprZoA2qf+hpiJ9hfEn8j/mKhK8QQfuA2UiUehi3vuINnWs05+u5guYpzw7uA==
Received: from [192.168.89.2] (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-5 (Postfix) with ESMTPSA id 876501800160;
	Fri, 08 May 2026 07:04:55 +0000 (UTC)
Message-ID: <f47d9cc1-e39b-4199-b031-e91b8e02ab1d@icloud.com>
Date: Fri, 8 May 2026 16:04:52 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] usb: xhci-pci: add generic auxiliary device
 interface
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
 Jihong Min <hurryman2212@gmail.com>,
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
 <a5739875-b8a5-4918-8850-fa4b32d5279d@linux.intel.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <a5739875-b8a5-4918-8850-fa4b32d5279d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA2OSBTYWx0ZWRfX3OtCKsrl9iKU
 O0kZio6YZt0+Es+cFbKxRawMpamIQ0z5Zmi33Rr2pkBPoyyqwCgW2jre1TyywphSPIJeLCBDK/P
 yxS39LxuRePCzrmcTwNMsX02Q9Fq2R0K2OhfIBDGJbOwFyMPb4w9UmzbxiNMJy9ZsV6YfxNbeuR
 JUVYM6vpQgpehUnwYJkhdj7SQRQfCBVJ7oBMwqa800CgFo+TIbEBBVi5Z+JKjGMrnsQl3qy1K3j
 HzHPKDXMN1/CORzbjPS1dtBTJsXceHzjsKFUbXo0ex8Qd8iv4JffNfj8WIFBz109EcZH3vclFFZ
 PqYhy5h7dcoeXmrktBwpD3l7uxulVF2S51wAyJXa0g9C87URJvFFXbrSVFTM1o=
X-Proofpoint-GUID: jxdjthE2mhazQywaLHtx2bDqtk9HS8zs
X-Authority-Info-Out: v=2.4 cv=IdyKmGqa c=1 sm=1 tr=0 ts=69fd8b1c
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=L7A7A1ypuKKR8YZ4-2cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PgRulw5oR9JgysbTFEid:22 a=oa2-kN79Xhin27rcel9q:22
X-Proofpoint-ORIG-GUID: jxdjthE2mhazQywaLHtx2bDqtk9HS8zs

Hi Mathias,

I tried the xhci-pci-prom21.c approach you suggested, with a PROM21-specific
PCI glue driver calling xhci_pci_common_probe() and creating the auxiliary
hwmon child device from that driver.

While doing that I noticed a possible boot-time regression with the module
case.

If CONFIG_USB_XHCI_PCI=y and CONFIG_USB_XHCI_PCI_PROM21=m, then generic
xhci-pci sees CONFIG_USB_XHCI_PCI_PROM21 as enabled and refuses the PROM21
PCI ID:

     if (IS_ENABLED(CONFIG_USB_XHCI_PCI_PROM21) &&
         pci_match_id(pci_ids_prom21, dev))
             return -ENODEV;

That means the PROM21 xHCI controller is handled only by
xhci-pci-prom21.ko. If that module is not present in the initramfs or is not
loaded early enough, the PROM21 xHCI controller remains unbound during early
boot. Devices behind that controller, such as a USB keyboard used for early
boot or disk unlock, would not work even though the generic xhci-pci 
driver is
built in and could otherwise operate the controller.

This seems different from the Renesas case, where the separate PCI driver is
needed for controller-specific firmware handling. For PROM21, the USB/xHCI
operation itself is still generic; the only extra function is publishing an
optional hwmon child device.

So I am not sure what the preferred direction should be:

   1. Keep the separate xhci-pci-prom21.c PCI glue driver and make
      USB_XHCI_PCI_PROM21 built-in only, or otherwise constrain the 
Kconfig so
      the generic xhci-pci handoff cannot break early boot.

   2. Keep PROM21 handled by generic xhci-pci and add only a small
      PROM21-specific auxiliary-device creation hook in xhci-pci after the
      common probe succeeds. In that model, failure to create the 
optional hwmon
      auxiliary device would not affect USB operation.

   3. Some other split that keeps PROM21-specific sensor code outside
      xhci-pci, but does not prevent generic xhci-pci from binding the
      controller when the optional PROM21 glue is not available early.

Do you still prefer the separate xhci-pci-prom21.c PCI driver for this case,
or would the minimal xhci-pci auxiliary-device hook be more appropriate 
given
the built-in xhci-pci / modular PROM21 glue case?

Sincerely,
Jihong Min

On 5/7/26 18:31, Mathias Nyman wrote:
> On 5/7/26 06:31, Jihong Min wrote:
>> Some xHCI PCI controllers expose controller-specific functionality 
>> that is
>> not part of generic xHCI operation and is better handled by optional 
>> child
>> drivers in other subsystems. Add a small auxiliary device 
>> registration path
>> for selected xHCI PCI controllers.
>>
>> The initial PCI ID match table lists AMD Promontory 21 (PROM21) 
>> 1022:43fd
>> controllers. For matching controllers, xhci-pci creates an auxiliary
>> device and stores it in devres so the remove path destroys it before HCD
>> teardown.
>>
>> Subsystem-specific child drivers can then bind to those devices through
>> the auxiliary bus and keep their hardware-specific logic outside 
>> xhci-pci.
>>
>> Assisted-by: Codex:gpt-5.5
>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
>> ---
>>   drivers/usb/host/Kconfig    | 10 +++++
>>   drivers/usb/host/xhci-pci.c | 83 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 93 insertions(+)
>>
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index 0a277a07cf70..e0c2c7ac5c97 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -42,6 +42,16 @@ config USB_XHCI_PCI
>>       depends on USB_PCI
>>       default y
>>   +config USB_XHCI_PCI_AUXDEV
>> +    bool "xHCI PCI auxiliary device support"
>> +    depends on USB_XHCI_PCI
>> +    select AUXILIARY_BUS
>> +    help
>> +      This enables xHCI PCI support for registering auxiliary devices
>> +      for selected controllers. It is used by optional child drivers
>> +      that bind to xHCI PCI controller-specific functionality through
>> +      the auxiliary bus.
>> +
>>   config USB_XHCI_PCI_RENESAS
>>       tristate "Support for additional Renesas xHCI controller with 
>> firmware"
>>       depends on USB_XHCI_PCI
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 585b2f3117b0..618d6840e108 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -8,6 +8,8 @@
>>    * Some code borrowed from the Linux EHCI driver.
>>    */
>>   +#include <linux/auxiliary_bus.h>
>> +#include <linux/device/devres.h>
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>> @@ -80,6 +82,7 @@
>>   #define PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI        0x15e1
>>   #define PCI_DEVICE_ID_AMD_RAVEN2_XHCI            0x15e5
>>   #define PCI_DEVICE_ID_AMD_RENOIR_XHCI            0x1639
>> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI            0x43fd
>>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_4            0x43b9
>>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_3            0x43ba
>>   #define PCI_DEVICE_ID_AMD_PROMONTORYA_2            0x43bb
>> @@ -103,6 +106,80 @@ static int xhci_pci_run(struct usb_hcd *hcd);
>>   static int xhci_pci_update_hub_device(struct usb_hcd *hcd, struct 
>> usb_device *hdev,
>>                         struct usb_tt *tt, gfp_t mem_flags);
>>   +static const struct pci_device_id pci_ids_have_aux[] = {
>> +    { PCI_DEVICE_DATA(AMD, PROM21_XHCI, "prom21_hwmon") },
>> +    { /* end: all zeroes */ }
>> +};
>> +
>> +struct xhci_pci_aux_devres {
>> +    struct auxiliary_device *auxdev;
>> +};
>> +
>> +static const char *xhci_pci_aux_dev_name(struct pci_dev *pdev)
>> +{
>> +    const struct pci_device_id *id;
>> +
>> +    id = pci_match_id(pci_ids_have_aux, pdev);
>> +    if (!id)
>> +        return NULL;
>> +
>> +    return (const char *)id->driver_data;
>> +}
>> +
>> +static void xhci_pci_aux_devres_release(struct device *dev, void *res)
>> +{
>> +    struct xhci_pci_aux_devres *devres = res;
>> +
>> +    if (devres->auxdev)
>> +        auxiliary_device_destroy(devres->auxdev);
>> +}
>> +
>> +static void xhci_pci_try_add_aux_device(struct pci_dev *pdev)
>> +{
>> +    struct xhci_pci_aux_devres *devres;
>> +    struct auxiliary_device *auxdev;
>> +    const char *aux_dev_name;
>> +
>> +    aux_dev_name = xhci_pci_aux_dev_name(pdev);
>> +    if (!aux_dev_name)
>> +        return;
>> +
>> +    devres = devres_alloc(xhci_pci_aux_devres_release, sizeof(*devres),
>> +                  GFP_KERNEL);
>> +    if (!devres) {
>> +        dev_warn(&pdev->dev,
>> +             "failed to allocate auxiliary device state\n");
>> +        return;
>> +    }
>> +
>> +    auxdev = auxiliary_device_create(&pdev->dev, KBUILD_MODNAME,
>> +                     aux_dev_name, NULL,
>> +                     (pci_domain_nr(pdev->bus) << 16) |
>> +                         pci_dev_id(pdev));
>> +    if (!auxdev) {
>> +        devres_free(devres);
>> +        dev_warn(&pdev->dev, "failed to add %s auxiliary device\n",
>> +             aux_dev_name);
>> +        return;
>> +    }
>> +
>> +    devres->auxdev = auxdev;
>> +    devres_add(&pdev->dev, devres);
>> +}
>> +
>> +static void xhci_pci_try_remove_aux_device(struct pci_dev *pdev)
>> +{
>> +    struct xhci_pci_aux_devres *devres;
>> +
>> +    devres = devres_find(&pdev->dev, xhci_pci_aux_devres_release, NULL,
>> +                 NULL);
>> +    if (!devres || !devres->auxdev)
>> +        return;
>> +
>> +    auxiliary_device_destroy(devres->auxdev);
>> +    devres->auxdev = NULL;
>> +}
>> +
>>   static const struct xhci_driver_overrides xhci_pci_overrides 
>> __initconst = {
>>       .reset = xhci_pci_setup,
>>       .start = xhci_pci_run,
>> @@ -677,6 +754,9 @@ int xhci_pci_common_probe(struct pci_dev *dev, 
>> const struct pci_device_id *id)
>>       if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
>>           pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
>>   +    if (IS_ENABLED(CONFIG_USB_XHCI_PCI_AUXDEV))
>> +        xhci_pci_try_add_aux_device(dev);
>> +
>>       return 0;
>
> I think this should be turned around so that the vendor specific code 
> calls the common code.
> xhci-pci-renesas.c does this nicely.
>
> In your case it would be adding something like a xhci-pci-prom21.c pci 
> driver:
>
> xhci_pci_prom21_probe(struct pci_dev *dev, const struct pci_device_id 
> *id)
> {
>     crate_auxiliary_device(dev);
>     return xhci_pci_common_probe(dev, id);
> }
>
> xhci_pci_prom21_remove(struct pci_dev *dev)
> {
>     destroy_auxiliary_device(dev);
>     xhci_pci_remove(dev);
> }
>
> static const struct pci_device_id pci_ids[] = {
>     { PCI_DEVICE(YOUR_AMD_PCI_VENDOR_ID, YOUR_PROM21_DEVICE_ID) },
>     { /* end: all zeroes */ }
> };
> MODULE_DEVICE_TABLE(pci, pci_ids);
>
> static struct pci_driver xhci_prom21_pci_driver = {
>     .name =        "xhci-pci-prom21",
>     .id_table =    pci_ids,
>
>     .probe =    xhci_pci_prom21_probe,
>     .remove =    xhci_pci_prom21_remove,
>
>     .shutdown =     usb_hcd_pci_shutdown,
>     .driver = {
>         .pm = pm_ptr(&usb_hcd_pci_pm_ops),
>     },
> };
> module_pci_driver(xhci_prom21_pci_driver);
>
> MODULE_DESCRIPTION("AMD Promontory 21 xHCI PCI Host Controller Driver");
> MODULE_IMPORT_NS("xhci");
> MODULE_LICENSE("GPL v2");
>
> -Mathias
