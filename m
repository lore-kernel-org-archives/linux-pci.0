Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41319 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbeDJP2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2018 11:28:37 -0400
MIME-Version: 1.0
In-Reply-To: <a5a0d78d-627b-6277-ee75-44e204cbd390@gmail.com>
References: <20180408130925.19088-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVGBkEY2kE7auUwXBn2QSfX+yhxkFH--4tTw+XJ3WCk0w@mail.gmail.com>
 <3973dcdf-c6d7-5622-0c19-ea6f77899261@gmail.com> <20180409114159.azxeehjkeuinwrwe@verge.net.au>
 <CAMuHMdUF0oG+fdWv2CissD9tviHiVCg3ofW3oR3vY+=Km41tAg@mail.gmail.com>
 <20180409122636.6rmtzhqqlpqxyear@verge.net.au> <caaa0a56-7487-a4de-2b43-82f5fa5b5552@gmail.com>
 <CAMuHMdWTTaJF8+GJdLmM_4J+gMaHPzT2rpO=B2kWYb_2bNbQNg@mail.gmail.com> <a5a0d78d-627b-6277-ee75-44e204cbd390@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Apr 2018 17:28:35 +0200
Message-ID: <CAMuHMdX9d29JYVDsghd3Koyg8Aeuv0D2Fx5Lnn0bBZSb9RntDw@mail.gmail.com>
Subject: Re: [PATCH V5] PCI: rcar: Use runtime PM to control controller clock
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Simon Horman <horms@verge.net.au>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek,

On Tue, Apr 10, 2018 at 5:25 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 04/10/2018 04:42 PM, Geert Uytterhoeven wrote:
>> On Tue, Apr 10, 2018 at 4:31 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> On 04/09/2018 02:26 PM, Simon Horman wrote:
>>>> On Mon, Apr 09, 2018 at 01:47:38PM +0200, Geert Uytterhoeven wrote:
>>>>> On Mon, Apr 9, 2018 at 1:41 PM, Simon Horman <horms@verge.net.au> wrote:
>>>>>> On Mon, Apr 09, 2018 at 10:20:05AM +0200, Marek Vasut wrote:
>>>>>>> On 04/09/2018 10:07 AM, Geert Uytterhoeven wrote:
>>>>>>>> On Sun, Apr 8, 2018 at 3:09 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>>>>> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>>>>>>>>>
>>>>>>>>> The controller clock can be switched off during suspend/resume,
>>>>>>>>> let runtime PM take care of that.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
>>>>>>>>> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
>>>>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>>>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>>>>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>>>>>>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>>>>>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>>>>>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>>>>>>> To: linux-pci@vger.kernel.org
>>>>>>>>> ---
>>>>>>>>> V2: - Reorder the fail path in rcar_pcie_probe() to cater for the
>>>>>>>>>       reordering of function calls in probe
>>>>>>>>>     - Dispose of fail_clk in rcar_pcie_get_resources()
>>>>>>>>> V3: - Fix up the failpath in probe function
>>>>>>>>> V4: - Rebase on recent linux-next
>>>>>>>>> V5: - Do not call pci_free_resource_list(&pcie->resources) if
>>>>>>>>>       rcar_pcie_parse_request_of_pci_ranges() fails, since that
>>>>>>>>>       functiona calls pci_free_resource_list() already.
>>>>>>>>
>>>>>>>> Thanks for the update!
>>>>>>>>
>>>>>>>>> --- a/drivers/pci/host/pcie-rcar.c
>>>>>>>>> +++ b/drivers/pci/host/pcie-rcar.c
>>>>>>>>
>>>>>>>>> @@ -1124,22 +1111,22 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>>>>>>>>         if (err)
>>>>>>>>>                 goto err_free_bridge;
>>>>>>>>>
>>>>>>>>> +       pm_runtime_enable(pcie->dev);
>>>>>>>>> +       err = pm_runtime_get_sync(pcie->dev);
>>>>>>>>> +       if (err < 0) {
>>>>>>>>> +               dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
>>>>>>>>> +               goto err_pm_disable;
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>
>>>>>>>> As you moved the pm_runtime setup up...
>>>>>>>>
>>>>>>>>>         err = rcar_pcie_get_resources(pcie);
>>>>>>>>>         if (err < 0) {
>>>>>>>>>                 dev_err(dev, "failed to request resources: %d\n", err);
>>>>>>>>> -               goto err_free_resource_list;
>>>>>>>>> +               goto err_pm_put;
>>>>>>>>>         }
>>>>>>>>>
>>>>>>>>>         err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
>>>>>>>>>         if (err)
>>>>>>>>> -               goto err_free_resource_list;
>>>>>>>>> -
>>>>>>>>> -       pm_runtime_enable(dev);
>>>>>>>>> -       err = pm_runtime_get_sync(dev);
>>>>>>>>> -       if (err < 0) {
>>>>>>>>> -               dev_err(dev, "pm_runtime_get_sync failed\n");
>>>>>>>>> -               goto err_pm_disable;
>>>>>>>>> -       }
>>>>>>>>> +               goto err_pm_put;
>>>>>>>>>
>>>>>>>>>         /* Failure to get a link might just be that no cards are inserted */
>>>>>>>>>         hw_init_fn = of_device_get_match_data(dev);
>>>>>>>>> @@ -1174,9 +1161,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>>>>>>>>
>>>>>>>>>  err_pm_disable:
>>>>>>>>>         pm_runtime_disable(dev);
>>>>>>>>
>>>>>>>> ... shouldn't it be moved down here, for symmetry?
>>>>>>>
>>>>>>> I am reasonably certain the failpath should be correct now. Did I still
>>>>>>> miss something ?
>>>>>>
>>>>>> It looks correct to me too. Geert are Marek and I missing something?
>>>>>
>>>>> Probably it will still work fine, but after this patch, Runtime PM is enabled
>>>>> early, and disabled early, which is not symmetrical.
>>>>>
>>>>> I like symmetry ;-)
>>>>
>>>> Understood. I think that is reasonable.
>>>> Marek, would you care to respin?
>>>
>>> I am looking into the driver, but I fail to see what Geert is trying to
>>> make me change here.
>>>
>>> The pairing looks as follows:
>>>
>>> .- rcar_pcie_parse_request_of_pci_ranges()
>>> |  (pm_runtime_enable is here)
>>> | .- pm_runtime_get_sync()
>>> | | .- rcar_pcie_get_resources()
>>
>> rcar_pcie_get_resources() is called  while the device is runtime-enabled/resumed
>
> Because something may access the device, yes.
>
>>> | | |
>>> | | '- pm_runtime_put()
>>> | '- pm_runtime_disable() + pci_free_resource_list()
>>
>> pci_free_resource_list() is called while the device is runtime-disabled.
>
> Because nothing will access the device.
>
>>> '- pci_free_host_bridge()
>>>
>>> It looks symmetric to me ...
>>
>> rcar_pcie_get_resources() is called while the device is
>> runtime-enabled/resumed,
>> pci_free_resource_list() is called while the device is runtime-disabled.
>
> At this point, I think I'd rather see a diff of changes which you have
> in mind rather than this endless discussion. Can you provide one against
> this patch ?

My final comment:

If the steps during probing are A..Z, cleanup and removal should undo them
in reverse order (Z..A), unless there's a very good reason not to do so.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
