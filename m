Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59498 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeGSQmL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jul 2018 12:42:11 -0400
Subject: Re: [PATCH v2 2/4] pci: dwc: pci-dra7xx: Enable errata i870 for both
 EP and RC mode
To: Tony Lindgren <tony@atomide.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20180627122919.23926-1-vigneshr@ti.com>
 <20180627122919.23926-3-vigneshr@ti.com> <20180718110250.GA21589@red-moon>
 <b7f1cef7-b0d8-733a-c450-163299d281d0@ti.com>
 <20180719111556.GB9213@e107981-ln.cambridge.arm.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <c9d953f8-bc60-5243-bd11-a3a053c08340@ti.com>
Date: Thu, 19 Jul 2018 21:29:02 +0530
MIME-Version: 1.0
In-Reply-To: <20180719111556.GB9213@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 19 July 2018 04:45 PM, Lorenzo Pieralisi wrote:
> On Thu, Jul 19, 2018 at 04:04:34PM +0530, Vignesh R wrote:
>> Hi Lorenzo,
>>
[...]
>>>> +	ret = dra7xx_pcie_unaligned_memaccess(dev);
>>>> +	if (ret)
>>>> +		dev_err(dev, "WA for Errata i870 not appplied. Update DT\n");
>>>
>>> Hi Vignesh,
>>>
>>> Nit: s/appplied/applied
>>>
>>
>> Oops, let me know if you want me to resend with this fixed.
> 
> I can fix it, no problem but see below.
> 
>>> Two questions:
>>>
>>> - Current code applies the unaligned_memaccess() workaround for all
>>>   compatible variants. This is fine for current controllers (since
>>>   they are all affected), the code path above will have to be
>>>   reworked if there is any other compatible IP re-using the driver
>>>   that does not require the workaround.
>>
>> There are no compatible IPs that don't require this workaround. Also, I
>> don't see this IP being re-used in future. If you insist, I can add a
>> errata flag
> 
> I do not insist, I just pointed this out ;-)
> 
>>> - How do you want this series to go upstream ? If it goes via arm-soc,
>>>   which I think it should, here is my ACK on this patch:
>>>
>> Patch 1 and 2(dt bindings update and driver patch) can go in via PCI
>> tree. And DT changes(patch 3 and 4) can be picked up by Tony via
>> omap/arm-soc tree. They are mostly independent and should not cause any
>> problems. Does that sound good?
> 
> It should be fine but technically as soon as patch (2) is applied we
> would have a regression if patches (3) and (4) are applied separately.
> 

Right, although not a regression, I see your point. It would be good to
merge patch 3 and 4 before patch 2.

Tony,
Let me know if you are okay with taking this series via omap tree. I can
resend re-ordering patch 2 to come at the end of the series.

Regards
Vignesh

> 
>>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>
>>
>> Thanks!
>>
>>> Please let me know if I can drop this series from the PCI patchwork.
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>>> +
>>>>  	switch (mode) {
>>>>  	case DW_PCIE_RC_TYPE:
>>>>  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
>>>> @@ -717,10 +721,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>>>>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>>>>  				   DEVICE_TYPE_EP);
>>>>  
>>>> -		ret = dra7xx_pcie_ep_unaligned_memaccess(dev);
>>>> -		if (ret)
>>>> -			goto err_gpio;
>>>> -
>>>>  		ret = dra7xx_add_pcie_ep(dra7xx, pdev);
>>>>  		if (ret < 0)
>>>>  			goto err_gpio;
>>>> -- 
>>>> 2.18.0
>>>>
>>
>> -- 
>> Regards
>> Vignesh

-- 
Regards
Vignesh
