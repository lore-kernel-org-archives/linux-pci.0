Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56083 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeDJObT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2018 10:31:19 -0400
Subject: Re: [PATCH V5] PCI: rcar: Use runtime PM to control controller clock
To: Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20180408130925.19088-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVGBkEY2kE7auUwXBn2QSfX+yhxkFH--4tTw+XJ3WCk0w@mail.gmail.com>
 <3973dcdf-c6d7-5622-0c19-ea6f77899261@gmail.com>
 <20180409114159.azxeehjkeuinwrwe@verge.net.au>
 <CAMuHMdUF0oG+fdWv2CissD9tviHiVCg3ofW3oR3vY+=Km41tAg@mail.gmail.com>
 <20180409122636.6rmtzhqqlpqxyear@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <caaa0a56-7487-a4de-2b43-82f5fa5b5552@gmail.com>
Date: Tue, 10 Apr 2018 16:31:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180409122636.6rmtzhqqlpqxyear@verge.net.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/09/2018 02:26 PM, Simon Horman wrote:
> On Mon, Apr 09, 2018 at 01:47:38PM +0200, Geert Uytterhoeven wrote:
>> Hi Simon, Marek,
>>
>> On Mon, Apr 9, 2018 at 1:41 PM, Simon Horman <horms@verge.net.au> wrote:
>>> On Mon, Apr 09, 2018 at 10:20:05AM +0200, Marek Vasut wrote:
>>>> On 04/09/2018 10:07 AM, Geert Uytterhoeven wrote:
>>>>> On Sun, Apr 8, 2018 at 3:09 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>>>>>>
>>>>>> The controller clock can be switched off during suspend/resume,
>>>>>> let runtime PM take care of that.
>>>>>>
>>>>>> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
>>>>>> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>>>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>>>> To: linux-pci@vger.kernel.org
>>>>>> ---
>>>>>> V2: - Reorder the fail path in rcar_pcie_probe() to cater for the
>>>>>>       reordering of function calls in probe
>>>>>>     - Dispose of fail_clk in rcar_pcie_get_resources()
>>>>>> V3: - Fix up the failpath in probe function
>>>>>> V4: - Rebase on recent linux-next
>>>>>> V5: - Do not call pci_free_resource_list(&pcie->resources) if
>>>>>>       rcar_pcie_parse_request_of_pci_ranges() fails, since that
>>>>>>       functiona calls pci_free_resource_list() already.
>>>>>
>>>>> Thanks for the update!
>>>>>
>>>>>> --- a/drivers/pci/host/pcie-rcar.c
>>>>>> +++ b/drivers/pci/host/pcie-rcar.c
>>>>>
>>>>>> @@ -1124,22 +1111,22 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>>>>>         if (err)
>>>>>>                 goto err_free_bridge;
>>>>>>
>>>>>> +       pm_runtime_enable(pcie->dev);
>>>>>> +       err = pm_runtime_get_sync(pcie->dev);
>>>>>> +       if (err < 0) {
>>>>>> +               dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
>>>>>> +               goto err_pm_disable;
>>>>>> +       }
>>>>>> +
>>>>>
>>>>> As you moved the pm_runtime setup up...
>>>>>
>>>>>>         err = rcar_pcie_get_resources(pcie);
>>>>>>         if (err < 0) {
>>>>>>                 dev_err(dev, "failed to request resources: %d\n", err);
>>>>>> -               goto err_free_resource_list;
>>>>>> +               goto err_pm_put;
>>>>>>         }
>>>>>>
>>>>>>         err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
>>>>>>         if (err)
>>>>>> -               goto err_free_resource_list;
>>>>>> -
>>>>>> -       pm_runtime_enable(dev);
>>>>>> -       err = pm_runtime_get_sync(dev);
>>>>>> -       if (err < 0) {
>>>>>> -               dev_err(dev, "pm_runtime_get_sync failed\n");
>>>>>> -               goto err_pm_disable;
>>>>>> -       }
>>>>>> +               goto err_pm_put;
>>>>>>
>>>>>>         /* Failure to get a link might just be that no cards are inserted */
>>>>>>         hw_init_fn = of_device_get_match_data(dev);
>>>>>> @@ -1174,9 +1161,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>>>>>
>>>>>>  err_pm_disable:
>>>>>>         pm_runtime_disable(dev);
>>>>>
>>>>> ... shouldn't it be moved down here, for symmetry?
>>>>
>>>> I am reasonably certain the failpath should be correct now. Did I still
>>>> miss something ?
>>>
>>> It looks correct to me too. Geert are Marek and I missing something?
>>
>> Probably it will still work fine, but after this patch, Runtime PM is enabled
>> early, and disabled early, which is not symmetrical.
>>
>> I like symmetry ;-)
> 
> Understood. I think that is reasonable.
> Marek, would you care to respin?

I am looking into the driver, but I fail to see what Geert is trying to
make me change here.

The pairing looks as follows:

.- rcar_pcie_parse_request_of_pci_ranges()
|  (pm_runtime_enable is here)
| .- pm_runtime_get_sync()
| | .- rcar_pcie_get_resources()
| | |
| | '- pm_runtime_put()
| '- pm_runtime_disable() + pci_free_resource_list()
'- pci_free_host_bridge()

It looks symmetric to me ...

-- 
Best regards,
Marek Vasut
