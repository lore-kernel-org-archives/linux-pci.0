Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:32999 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbcEESUK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2016 14:20:10 -0400
Subject: Re: [PATCH 2/2] pci: host: Add Broadcom STB PCIE RC controller
To: Jim Quinlan <jim2101024@gmail.com>
References: <1462238749-19715-1-git-send-email-f.fainelli@gmail.com>
 <1462238749-19715-3-git-send-email-f.fainelli@gmail.com>
 <2339405.90vXV1p6zU@wuerfel> <572A4F31.8010802@gmail.com>
 <CANCKTBuNFQFLsab2WS+BRGUOuUOTLYuoaWNuM5T9HPGihvwYCg@mail.gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <572B8ECD.4070100@gmail.com>
Date: Thu, 5 May 2016 11:19:57 -0700
MIME-Version: 1.0
In-Reply-To: <CANCKTBuNFQFLsab2WS+BRGUOuUOTLYuoaWNuM5T9HPGihvwYCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/05/16 10:48, Jim Quinlan wrote:
>>> Why is this?
>>
>> This is so we do not end-up programming the PCIe RC which is agnostic of
>> the number of
> 
> I believe this code is still around for folks passing us a device tree
> with lacking information.  It should be removed.

I have actually reworked this to utilize the brcm,log2-scb-sizes
property, since the number of elements in the property is equal to the
number of memory controllers populated on the system.

> 
>>
>>>
>>>> +    resource_list_for_each_entry(win, &res) {
>>>> +            struct brcm_window *w = &pcie->out_wins[i];
>>>> +
>>>> +            r = win->res;
>>>> +
>>>> +            if (!r->flags)
>>>> +                    continue;
>>>> +
>>>> +            switch (resource_type(r)) {
>>>> +            case IORESOURCE_MEM:
>>>> +                    w->cpu_addr = r->start;
>>>> +                    w->size = resource_size(r);
>>>> +                    w->pcie_iomem_res.name  = "External PCIe MEM";
>>>> +                    w->pcie_iomem_res.flags = r->flags;
>>>> +                    w->pcie_iomem_res.start = r->start;
>>>> +                    w->pcie_iomem_res.end   = r->end;
>>>> +                    pcie->num_out_wins++;
>>>> +                    i++;
>>>> +                    /* Request memory region resources. */
>>>> +                    ret = devm_request_resource(&pdev->dev,
>>>> +                                                &iomem_resource,
>>>> +                                                &w->pcie_iomem_res);
>>>> +                    if (ret) {
>>>> +                            dev_err(&pdev->dev,
>>>> +                                    "request PCIe memory resource failed\n");
>>>> +                            goto out_err_clk;
>>>> +                    }
>>>> +                    break;
>>>> +
>>>> +            default:
>>>> +                    continue;
>>>> +            }
>>>> +    }
>>>
>>> What about IORESOURCE_IO?
>>
>> We do not support I/O space on this controller AFAIR. Our downstream
>> driver does insert a fake bogus I/O range, but I cannot really remember
>> why that was needed now, Jim do you remember?
>> --
>> Florian
> 
> We added a bogus IO region because there was no other way to proceed
> w/o getting an error.  Or should I say, I knew of no other way to
> proceed...

AH, I found your commit doing that, I would really think that the PCI
domains logic should be able to take care of assigning non-conflicting
I/O regions these days, if not, that seems like a bug to me.

Do I need a specific board with a ton of switches/peripherals attached
to it to expose whether this is needed or not? Right now, I removed it
from this patchset, but I suppose we could add it back, would we need that?

Thanks Jim!
-- 
Florian
