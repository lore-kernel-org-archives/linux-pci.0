Received: from outbound.ci.icloud.com (ci-2006g-snip4-11.eps.apple.com [57.103.90.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C73B2FEB
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.90.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103785; cv=none; b=PVpzdTBG8qI+yJJ1I2aHB4LXi408Qa1za6Si6ucbDXW9JxyMykXlyoq5p/ChvHenl1GrmLVSilIY6JKMEmTpW3tXDAiUd7WpcIlfVK8EYI4O2kp86O860eKk1fY3iBDKzT01Mxwm03bpXsAU/Sr9/+U+CC/+IpaXBFWb8xdYdaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103785; c=relaxed/simple;
	bh=1OaoWHRDdVjk79B+wpy7ASwL5kbM1iO1mjImOJhogRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMmOft2swNhofL1yli6RB+NAeq9Nxcd1QZuZOLXVd8UrA66hwUcQWjR9yubNbj3niXiaAZMw+6/izgj9i8MAGVMatH+lEIYvJjZAjxf3lYt17VPHhgukON+wDuryxbNRmiNiyoaAhlIAYOcX6FCJ7/ogda7xqQ665awNXuqK7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lVC2Wu1t; arc=none smtp.client-ip=57.103.90.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lVC2Wu1t"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPS id AC4A4180009A;
	Wed, 06 May 2026 21:43:01 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhMHVsARQNFDFYEVBcOVk1RDUEfTgZTHgtKAl93AlEcVg1XQ1QEX1BfHA4FQhlACVQZXV8FWgAwUBtfAkIPHBNWFRMfVFYDRBkQVgFYVl0FTRpcGFkPHBNQVloOWwRHFBcbXAAXG0YCBCMCXwBFAl4JVgEwFw9WTVAbXwJCDxwTVhUTAF4PD0wLS1dZBF8FExRBAFgPRgYSX0AeD1ZcV11bHlJbBltQQwkcVQ93AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778103782; x=1780695782; bh=FV68AbIr/otmBzbF7yuQ1tjl9wNeXS04EJGZDdtkbtA=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=lVC2Wu1tLfWjptaBt1AXjIWACRs+jgy2ZlOnGfF7nfMbWDiMNU7Le3UvTzmdGKwZmowhEI4G3f699TmEP1mawdHJ2LpbEb1Z4IlDMCe1QHFsiK4N4Ub0eW9i6PtdmPEweiHNdQaMNTeEGqf7Or3XtxJ/42wD18Sqv3wuAUPTw3O0rI0bi6ucmiA+pfFUiEhyMSdDv9mNpuNftjaBNXdMoWmsO/vpN4pLuA0FRHAm/ofSrdwpvuJuuOlKHXbT72moUHgya2vlQKYlzuw0T9xPYj8u32tGIQOwdljdqYTRaJhWL1Xdvnhj+Z/EJTVyMb4g8SRlhPf4wuUrNxsX5QGijA==
Received: from [192.168.89.2] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPSA id 44EFA180018D;
	Wed, 06 May 2026 21:42:58 +0000 (UTC)
Message-ID: <23d4347c-9358-4bf8-ba7e-bfa610b30dfb@icloud.com>
Date: Thu, 7 May 2026 06:42:56 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: xhci-pci: add generic auxiliary device
 interface
To: Michal Pecio <michal.pecio@gmail.com>, Jihong Min <hurryman2212@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506032939.92351-1-hurryman2212@gmail.com>
 <cover.1778099627.git.hurryman2212@gmail.com>
 <3f26994ebb5f0e4e653a8108a9626bc793148679.1778099627.git.hurryman2212@gmail.com>
 <20260506231541.32f88ce1.michal.pecio@gmail.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <20260506231541.32f88ce1.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Info-Out: v=2.4 cv=AqbjHe9P c=1 sm=1 tr=0 ts=69fbb5e6
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=8lEAYtPj5W0hSlbCcAkA:9 a=QEXdDO2ut3YA:10
 a=PgRulw5oR9JgysbTFEid:22 a=oa2-kN79Xhin27rcel9q:22
X-Proofpoint-GUID: rWBkY6NVGTBiBZWj9NfvELYJprXQ7kvg
X-Proofpoint-ORIG-GUID: rWBkY6NVGTBiBZWj9NfvELYJprXQ7kvg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDIxMiBTYWx0ZWRfX7ZPsJA+Fhz64
 fjLjYsJuvuSuJK2SpFtaTab/VB2ABU9VhOi3ti8+M4gb4/NqPgDelCR0RAOaaTjbUnHvz1jYPcr
 QQTTqlpCSD1iEEttzG1MVY58ES4dyLfdb+gooUbHqLCk0J3WMEv6QQ1KrActrg6ME8c6Y1iDr1S
 4Z8oMA6apQPBl+PBXtcOwwwNMxHVw5HNADf9ehF7VmsO1J3AHCh0EyNhQq8jrsCakcC0J5bG965
 EDrtu+fC+nbIAy06PW6XRquaqD+32CIpwdaU/dEAbjXgF6u83PdZw4AbJolhiVoNV1fzFXEV3WK
 rfieB/DMexubrQF36GP1pDaG3oGTK81fxmJtHcDE2o3JUfWfgyV4AyxJQ3yWXg=

Thank you.

I've changed the code by removing the preprocessor macros and protecting 
the two entry points with `if (IS_ENABLED(CONFIG_USB_XHCI_PCI_AUXDEV))`, 
for v3.


Jihong Min

On 5/7/26 06:15, Michal Pecio wrote:
> On Thu,  7 May 2026 05:40:33 +0900, Jihong Min wrote:
>> Some xHCI PCI controllers expose controller-specific functionality that is
>> not part of generic xHCI operation and is better handled by optional child
>> drivers in other subsystems. Add a small auxiliary device registration path
>> for selected xHCI PCI controllers.
>>
>> The initial table creates an xhci_pci.hwmon auxiliary device for AMD
>> 1022:43fd controllers. Store the created auxiliary device in devres so the
>> xhci-pci remove path destroys it before HCD teardown. Use a
>> PCI-domain-qualified id so auxiliary device names remain unique across PCI
>> domains.
>>
>> This keeps xhci-pci responsible only for publishing selected controller
>> functions while allowing subsystem-specific drivers to bind through the
>> auxiliary bus.
>>
>> Assisted-by: Codex:gpt-5.5
>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
>> ---
>>   drivers/usb/host/Kconfig    |  10 ++++
>>   drivers/usb/host/xhci-pci.c | 114 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 124 insertions(+)
>>
>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> index 0a277a07cf70..e0c2c7ac5c97 100644
>> --- a/drivers/usb/host/Kconfig
>> +++ b/drivers/usb/host/Kconfig
>> @@ -42,6 +42,16 @@ config USB_XHCI_PCI
>>   	depends on USB_PCI
>>   	default y
>>   
>> +config USB_XHCI_PCI_AUXDEV
>> +	bool "xHCI PCI auxiliary device support"
>> +	depends on USB_XHCI_PCI
>> +	select AUXILIARY_BUS
>> +	help
>> +	  This enables xHCI PCI support for registering auxiliary devices
>> +	  for selected controllers. It is used by optional child drivers
>> +	  that bind to xHCI PCI controller-specific functionality through
>> +	  the auxiliary bus.
>> +
>>   config USB_XHCI_PCI_RENESAS
>>   	tristate "Support for additional Renesas xHCI controller with firmware"
>>   	depends on USB_XHCI_PCI
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 585b2f3117b0..1ab27d2182eb 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -8,6 +8,8 @@
>>    * Some code borrowed from the Linux EHCI driver.
>>    */
>>   
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/device/devres.h>
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>> @@ -103,6 +105,114 @@ static int xhci_pci_run(struct usb_hcd *hcd);
>>   static int xhci_pci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
>>   				      struct usb_tt *tt, gfp_t mem_flags);
>>   
>> +#if IS_ENABLED(CONFIG_USB_XHCI_PCI_AUXDEV)
>> +static const struct {
>> +	struct pci_device_id id;
>> +	const char *aux_dev_name;
>> +} pci_ids_have_aux[] = {
>> +	{
>> +		.id = { PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x43fd) }, /* PROM21 xHCI */
>> +		.aux_dev_name = "hwmon",
>> +	},
>> +	{ /* end: all zeroes */ }
>> +};
>> +
>> +struct xhci_pci_aux_devres {
>> +	struct auxiliary_device *auxdev;
>> +};
>> +
>> +static bool xhci_pci_aux_match_id(const struct pci_device_id *id,
>> +				  const struct pci_dev *pdev)
>> +{
>> +	if (id->vendor != PCI_ANY_ID && id->vendor != pdev->vendor)
>> +		return false;
>> +	if (id->device != PCI_ANY_ID && id->device != pdev->device)
>> +		return false;
>> +	if (id->subvendor != PCI_ANY_ID &&
>> +	    id->subvendor != pdev->subsystem_vendor)
>> +		return false;
>> +	if (id->subdevice != PCI_ANY_ID &&
>> +	    id->subdevice != pdev->subsystem_device)
>> +		return false;
>> +
>> +	return !((id->class ^ pdev->class) & id->class_mask);
>> +}
>> +
>> +static const char *xhci_pci_aux_dev_name(struct pci_dev *pdev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; pci_ids_have_aux[i].aux_dev_name; i++) {
>> +		if (xhci_pci_aux_match_id(&pci_ids_have_aux[i].id, pdev))
>> +			return pci_ids_have_aux[i].aux_dev_name;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static void xhci_pci_aux_devres_release(struct device *dev, void *res)
>> +{
>> +	struct xhci_pci_aux_devres *devres = res;
>> +
>> +	if (devres->auxdev)
>> +		auxiliary_device_destroy(devres->auxdev);
>> +}
>> +
>> +static void xhci_pci_try_add_aux_device(struct pci_dev *pdev)
>> +{
>> +	struct xhci_pci_aux_devres *devres;
>> +	struct auxiliary_device *auxdev;
>> +	const char *aux_dev_name;
>> +
>> +	aux_dev_name = xhci_pci_aux_dev_name(pdev);
>> +	if (!aux_dev_name)
>> +		return;
>> +
>> +	devres = devres_alloc(xhci_pci_aux_devres_release, sizeof(*devres),
>> +			      GFP_KERNEL);
>> +	if (!devres) {
>> +		dev_warn(&pdev->dev,
>> +			 "failed to allocate auxiliary device state\n");
>> +		return;
>> +	}
>> +
>> +	auxdev = auxiliary_device_create(&pdev->dev, KBUILD_MODNAME,
>> +					 aux_dev_name, NULL,
>> +					 (pci_domain_nr(pdev->bus) << 16) |
>> +						 pci_dev_id(pdev));
>> +	if (!auxdev) {
>> +		devres_free(devres);
>> +		dev_warn(&pdev->dev, "failed to add %s auxiliary device\n",
>> +			 aux_dev_name);
>> +		return;
>> +	}
>> +
>> +	devres->auxdev = auxdev;
>> +	devres_add(&pdev->dev, devres);
>> +}
>> +
>> +static void xhci_pci_try_remove_aux_device(struct pci_dev *pdev)
>> +{
>> +	struct xhci_pci_aux_devres *devres;
>> +
>> +	devres = devres_find(&pdev->dev, xhci_pci_aux_devres_release, NULL,
>> +			     NULL);
>> +	if (!devres || !devres->auxdev)
>> +		return;
>> +
>> +	auxiliary_device_destroy(devres->auxdev);
>> +	devres->auxdev = NULL;
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
>>   static const struct xhci_driver_overrides xhci_pci_overrides __initconst = {
>>   	.reset = xhci_pci_setup,
>>   	.start = xhci_pci_run,
>> @@ -677,6 +787,8 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>   	if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
>>   		pci_clear_and_set_config_dword(dev, 0xE0, 0, 1 << 22);
>>   
>> +	xhci_pci_try_add_aux_device(dev);
> Is it considered acceptable to add
>
> 	if (IS_ENABLED(CONFIG_USB_XHCI_PCI_AUXDEV))
>
> before this call, remove #ifdef around the definitions of the auxdev
> functions and rely on dead code elimination to clean them up?
>
> We already have a similar trick with CONFIG_USB_XHCI_PCI_RENESAS here
> and it seemed to be working, though the amount of conditional code is
> much lower and so is the potential risk.
>
> The reason for doing it this way was because Greg doesn't like #ifdefs
> in .c files, and neither do static analyzers like them.
>
>> +
>>   	return 0;
>>   
>>   put_usb3_hcd:
>> @@ -713,6 +825,8 @@ void xhci_pci_remove(struct pci_dev *dev)
>>   	xhci = hcd_to_xhci(pci_get_drvdata(dev));
>>   	set_power_d3 = xhci->quirks & XHCI_SPURIOUS_WAKEUP;
>>   
>> +	xhci_pci_try_remove_aux_device(dev);
>> +
>>   	xhci->xhc_state |= XHCI_STATE_REMOVING;
>>   
>>   	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
>> -- 
>> 2.53.0
>>
