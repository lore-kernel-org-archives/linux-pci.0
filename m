Received: from outbound.pv.icloud.com (pv-2004e-snip4-8.eps.apple.com [57.103.65.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3463AEF51
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101795; cv=none; b=fNdJvRhu4nYKNHJNyLWO5//sR26stsDhYotezKR2D//R/6RMgep4Th/9JwpLt6fKqIWCE2ywg3hNJZ54WFhnbZWkV8Eg3BGliXa20o6I/SZAi1eJwi95kxU1pVT9BkmvMItBQf3EXE9qlvTOFIGFAvco6Q6s5gFfUMHrl12KdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101795; c=relaxed/simple;
	bh=xhItaJiFgN5yRzIv4cYQftVxOYXNFdrftDSkh6GkG+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p09t31A6lfVeOtIsRQcbu513PdKcFGEhlnu5Sixjhoy1eJaq3xEbBHgimnLKe6r5M+ILZpYVhzg0VewkY/9pBUor44wiYpYhDAsPMpAlp5zlHEgVbrWsDGMe6SM+7HCXe+1pdqEPlcUG8uxRh7hPtrGqD/WgYr3n3IWmnsIpEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ghk65ysV; arc=none smtp.client-ip=57.103.65.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ghk65ysV"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-10-percent-2 (Postfix) with ESMTPS id BDA9E1800BDE;
	Wed, 06 May 2026 21:09:50 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhMHVsARQNFDFYEVBcOVk1RDUEfTgZTHgtKAl93AlEcVg1XQ1QEX1BfHA4FQhlACVQZXV8FWgAwUBtfAkIPHBNWFRMfVFYDQxkQVgFYVl0FTRpcGFkPHABPVloOWwRHFBcbXAAXG0YCBCMCXwBFAl4JVgEwFw9WTVAbXwJCDxwTVhUTAF4PD0xdTQVfDlgBRBRLBVwORgZECB0eVAUOUF0LQAtZAgkAE18ZBlp3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778101792; x=1780693792; bh=hfRdvhCbBJYSad/80rTb5YsNbiHQgE5KIYzOPDw0FTo=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=ghk65ysVIVyDpovWhtZEUkn1AxAOtqBDwAMBONn/Hg0weIkryIh8y5E5/94vpMKnOwTkrMNXA5qw3IqWstXBLFPrho+H9IJA2EnAnVKqY9iqTwt0FyMCpCSuhWqobtk4ygx/gh/DD1Qwwo56xZ9/Quo7IYBTwjK6mDGanzf8IV52NStvrqdSTElLj+XcGuDMTq9zKYRuvftjUJK5lie2LRLS96hshI4XxFRBEXKK45CgtSXfsE4OHKwGNlFSGM4QIiDr3aA1dRYuijoqiRczwk8CFUk7sgjeBwPYvNRjKUsbncrp7PHVe/7WkkhGZFRKOBKxVqTsgRRPBxYC3KeK+Q==
Received: from [192.168.89.2] (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-10-percent-2 (Postfix) with ESMTPSA id 0A7F51800BDD;
	Wed, 06 May 2026 21:09:47 +0000 (UTC)
Message-ID: <d5629334-3619-441e-92eb-28845b2cfa57@icloud.com>
Date: Thu, 7 May 2026 06:09:45 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: xhci-pci: add generic auxiliary device
 interface
To: Mario Limonciello <mario.limonciello@amd.com>,
 Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506032939.92351-1-hurryman2212@gmail.com>
 <cover.1778099627.git.hurryman2212@gmail.com>
 <3f26994ebb5f0e4e653a8108a9626bc793148679.1778099627.git.hurryman2212@gmail.com>
 <bb047320-594d-46de-9522-1098e784ebc1@amd.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <bb047320-594d-46de-9522-1098e784ebc1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hQpG0iB_lRLBxD8WYBCtYVq52zEpCcEg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDIwNyBTYWx0ZWRfX1A01szgfm5xO
 faiNiGEX70SOTp9/vJO9A+BsJdcjd17YZ2X2zJc46IPOZnolV8C5QgT+jxikWVinzPK95RXEjC4
 NjG16+TPVzdDCZFI0b40DJwgJnfCTgMM6g5+2vm9rDCXKi3T41m0o1tU519jflNSUTemsu1gcjN
 gnebXyEjpGJQZHyHngJ3PhhArOBOE8MhHNCJZyZlsOHKr5sFrHg8jVz60KMaqsUaimJ2uBxF+ak
 QfS6SCteRITYSL3gr41CsmOg61mQP5wWeOO3R+EFPaoXigqvfkEdHbS8V4jQWhxXLgBHZuLfxvA
 fvOk3GEbgCQRCr8xD+8AmP8dCMyIv2vBGhajdswo/vEZJNofhea+PcTamrUXPM=
X-Proofpoint-ORIG-GUID: hQpG0iB_lRLBxD8WYBCtYVq52zEpCcEg
X-Authority-Info-Out: v=2.4 cv=eqjSD4pX c=1 sm=1 tr=0 ts=69fbae20
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_EeEMxcBAAAA:8 a=pGLkceISAAAA:8 a=uczJOLB7-GI-dphXaB8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=czjwGCTIUPoA:10 a=PgRulw5oR9JgysbTFEid:22
 a=oa2-kN79Xhin27rcel9q:22

I refactored the auxiliary device table to use PCI_DEVICE_DATA(), store the
auxiliary device name in driver_data, and use pci_match_id() inside
xhci_pci_aux_dev_name(). The relevant change is:

#define PCI_DEVICE_ID_AMD_PROM21_XHCI            0x43fd
...
static const struct pci_device_id pci_ids_have_aux[] = {
     { PCI_DEVICE_DATA(AMD, PROM21_XHCI, "hwmon") },
     { /* end: all zeroes */ }
};
...
static const char *xhci_pci_aux_dev_name(struct pci_dev *pdev)
{
     const struct pci_device_id *id;

     id = pci_match_id(pci_ids_have_aux, pdev);
     if (!id)
         return NULL;

     return (const char *)id->driver_data;
}

I will include this in v3.

Thank you,
Jihong Min

On 5/7/26 05:53, Mario Limonciello wrote:
>
>
> On 5/6/26 15:40, Jihong Min wrote:
>> [You don't often get email from hurryman2212@gmail.com. Learn why 
>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Some xHCI PCI controllers expose controller-specific functionality 
>> that is
>> not part of generic xHCI operation and is better handled by optional 
>> child
>> drivers in other subsystems. Add a small auxiliary device 
>> registration path
>> for selected xHCI PCI controllers.
>>
>> The initial table creates an xhci_pci.hwmon auxiliary device for AMD
>> 1022:43fd controllers. Store the created auxiliary device in devres 
>> so the
>> xhci-pci remove path destroys it before HCD teardown. Use a
>> PCI-domain-qualified id so auxiliary device names remain unique 
>> across PCI
>> domains.
>>
>> This keeps xhci-pci responsible only for publishing selected controller
>> functions while allowing subsystem-specific drivers to bind through the
>> auxiliary bus.
>>
>> Assisted-by: Codex:gpt-5.5
>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
>> ---
>>   drivers/usb/host/Kconfig    |  10 ++++
>>   drivers/usb/host/xhci-pci.c | 114 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 124 insertions(+)
>>
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index 0a277a07cf70..e0c2c7ac5c97 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -42,6 +42,16 @@ config USB_XHCI_PCI
>>          depends on USB_PCI
>>          default y
>>
>> +config USB_XHCI_PCI_AUXDEV
>> +       bool "xHCI PCI auxiliary device support"
>> +       depends on USB_XHCI_PCI
>> +       select AUXILIARY_BUS
>> +       help
>> +         This enables xHCI PCI support for registering auxiliary 
>> devices
>> +         for selected controllers. It is used by optional child drivers
>> +         that bind to xHCI PCI controller-specific functionality 
>> through
>> +         the auxiliary bus.
>> +
>>   config USB_XHCI_PCI_RENESAS
>>          tristate "Support for additional Renesas xHCI controller 
>> with firmware"
>>          depends on USB_XHCI_PCI
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 585b2f3117b0..1ab27d2182eb 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -8,6 +8,8 @@
>>    * Some code borrowed from the Linux EHCI driver.
>>    */
>>
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/device/devres.h>
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>> @@ -103,6 +105,114 @@ static int xhci_pci_run(struct usb_hcd *hcd);
>>   static int xhci_pci_update_hub_device(struct usb_hcd *hcd, struct 
>> usb_device *hdev,
>>                                        struct usb_tt *tt, gfp_t 
>> mem_flags);
>>
>> +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_AUXDEV)
>> +static const struct {
>> +       struct pci_device_id id;
>> +       const char *aux_dev_name;
>> +} pci_ids_have_aux[] = {
>> +       {
>> +               .id = { PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x43fd) }, /* 
>> PROM21 xHCI */
>> +               .aux_dev_name = "hwmon",
>> +       },
>> +       { /* end: all zeroes */ }
>> +};
>> +
>> +struct xhci_pci_aux_devres {
>> +       struct auxiliary_device *auxdev;
>> +};
>> +
>> +static bool xhci_pci_aux_match_id(const struct pci_device_id *id,
>> +                                 const struct pci_dev *pdev)
>> +{
>> +       if (id->vendor != PCI_ANY_ID && id->vendor != pdev->vendor)
>> +               return false;
>> +       if (id->device != PCI_ANY_ID && id->device != pdev->device)
>> +               return false;
>> +       if (id->subvendor != PCI_ANY_ID &&
>> +           id->subvendor != pdev->subsystem_vendor)
>> +               return false;
>> +       if (id->subdevice != PCI_ANY_ID &&
>> +           id->subdevice != pdev->subsystem_device)
>> +               return false;
>> +
>> +       return !((id->class ^ pdev->class) & id->class_mask);
>
> What's wrong with pci_match_id()?
>
>> +}
>> +
>> +static const char *xhci_pci_aux_dev_name(struct pci_dev *pdev)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; pci_ids_have_aux[i].aux_dev_name; i++) {
>> +               if (xhci_pci_aux_match_id(&pci_ids_have_aux[i].id, 
>> pdev))
>> +                       return pci_ids_have_aux[i].aux_dev_name;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static void xhci_pci_aux_devres_release(struct device *dev, void *res)
>> +{
>> +       struct xhci_pci_aux_devres *devres = res;
>> +
>> +       if (devres->auxdev)
>> +               auxiliary_device_destroy(devres->auxdev);
>> +}
>> +
>> +static void xhci_pci_try_add_aux_device(struct pci_dev *pdev)
>> +{
>> +       struct xhci_pci_aux_devres *devres;
>> +       struct auxiliary_device *auxdev;
>> +       const char *aux_dev_name;
>> +
>> +       aux_dev_name = xhci_pci_aux_dev_name(pdev);
>> +       if (!aux_dev_name)
>> +               return;
>> +
>> +       devres = devres_alloc(xhci_pci_aux_devres_release, 
>> sizeof(*devres),
>> +                             GFP_KERNEL);
>> +       if (!devres) {
>> +               dev_warn(&pdev->dev,
>> +                        "failed to allocate auxiliary device state\n");
>> +               return;
>> +       }
>> +
>> +       auxdev = auxiliary_device_create(&pdev->dev, KBUILD_MODNAME,
>> +                                        aux_dev_name, NULL,
>> + (pci_domain_nr(pdev->bus) << 16) |
>> + pci_dev_id(pdev));
>> +       if (!auxdev) {
>> +               devres_free(devres);
>> +               dev_warn(&pdev->dev, "failed to add %s auxiliary 
>> device\n",
>> +                        aux_dev_name);
>> +               return;
>> +       }
>> +
>> +       devres->auxdev = auxdev;
>> +       devres_add(&pdev->dev, devres);
>> +}
>> +
>> +static void xhci_pci_try_remove_aux_device(struct pci_dev *pdev)
>> +{
>> +       struct xhci_pci_aux_devres *devres;
>> +
>> +       devres = devres_find(&pdev->dev, xhci_pci_aux_devres_release, 
>> NULL,
>> +                            NULL);
>> +       if (!devres || !devres->auxdev)
>> +               return;
>> +
>> +       auxiliary_device_destroy(devres->auxdev);
>> +       devres->auxdev = NULL;
>> +}
>> +#else
>> +static inline void xhci_pci_try_add_aux_device(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static inline void xhci_pci_try_remove_aux_device(struct pci_dev *pdev)
>> +{
>> +}
>> +#endif
>> +
>>   static const struct xhci_driver_overrides xhci_pci_overrides 
>> __initconst = {
>>          .reset = xhci_pci_setup,
>>          .start = xhci_pci_run,
>> @@ -677,6 +787,8 @@ int xhci_pci_common_probe(struct pci_dev *dev, 
>> const struct pci_device_id *id)
>>          if (device_property_read_bool(&dev->dev, 
>> "ti,pwron-active-high"))
>>                  pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
>>
>> +       xhci_pci_try_add_aux_device(dev);
>> +
>>          return 0;
>>
>>   put_usb3_hcd:
>> @@ -713,6 +825,8 @@ void xhci_pci_remove(struct pci_dev *dev)
>>          xhci = hcd_to_xhci(pci_get_drvdata(dev));
>>          set_power_d3 = xhci->quirks & XHCI_SPURIOUS_WAKEUP;
>>
>> +       xhci_pci_try_remove_aux_device(dev);
>> +
>>          xhci->xhc_state |= XHCI_STATE_REMOVING;
>>
>>          if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
>> -- 
>> 2.53.0
>>
>
