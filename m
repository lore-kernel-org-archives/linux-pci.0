Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46902 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeDSKAX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Apr 2018 06:00:23 -0400
MIME-Version: 1.0
In-Reply-To: <cdc1b25a-e87d-144b-50c1-4abe31bcf5d0@gmail.com>
References: <20180408130925.19088-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVGBkEY2kE7auUwXBn2QSfX+yhxkFH--4tTw+XJ3WCk0w@mail.gmail.com>
 <3973dcdf-c6d7-5622-0c19-ea6f77899261@gmail.com> <20180409114159.azxeehjkeuinwrwe@verge.net.au>
 <CAMuHMdUF0oG+fdWv2CissD9tviHiVCg3ofW3oR3vY+=Km41tAg@mail.gmail.com>
 <20180409122636.6rmtzhqqlpqxyear@verge.net.au> <caaa0a56-7487-a4de-2b43-82f5fa5b5552@gmail.com>
 <CAMuHMdWTTaJF8+GJdLmM_4J+gMaHPzT2rpO=B2kWYb_2bNbQNg@mail.gmail.com>
 <a5a0d78d-627b-6277-ee75-44e204cbd390@gmail.com> <CAMuHMdX9d29JYVDsghd3Koyg8Aeuv0D2Fx5Lnn0bBZSb9RntDw@mail.gmail.com>
 <cdc1b25a-e87d-144b-50c1-4abe31bcf5d0@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Apr 2018 12:00:21 +0200
Message-ID: <CAMuHMdWpV-HN=ojjv_-PGDCe+Ud8AOPzJSk5fZXOG6tVC3mV+w@mail.gmail.com>
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

On Tue, Apr 10, 2018 at 6:17 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 04/10/2018 05:28 PM, Geert Uytterhoeven wrote:
>>>>> The pairing looks as follows:
>>>>>
>>>>> .- rcar_pcie_parse_request_of_pci_ranges()
>>>>> |  (pm_runtime_enable is here)
>>>>> | .- pm_runtime_get_sync()
>>>>> | | .- rcar_pcie_get_resources()
>>>>
>>>> rcar_pcie_get_resources() is called  while the device is runtime-enabled/resumed
>>>
>>> Because something may access the device, yes.
>>>
>>>>> | | |
>>>>> | | '- pm_runtime_put()
>>>>> | '- pm_runtime_disable() + pci_free_resource_list()
>>>>
>>>> pci_free_resource_list() is called while the device is runtime-disabled.
>>>
>>> Because nothing will access the device.
>>>
>>>>> '- pci_free_host_bridge()
>>>>>
>>>>> It looks symmetric to me ...
>>>>
>>>> rcar_pcie_get_resources() is called while the device is
>>>> runtime-enabled/resumed,
>>>> pci_free_resource_list() is called while the device is runtime-disabled.
>>>
>>> At this point, I think I'd rather see a diff of changes which you have
>>> in mind rather than this endless discussion. Can you provide one against
>>> this patch ?
>>
>> My final comment:
>>
>> If the steps during probing are A..Z, cleanup and removal should undo them
>> in reverse order (Z..A), unless there's a very good reason not to do so.
>
> I spent extra time going through the probe function and I just don't see
> how it is not done in the exact reverse, I checked every single goto
> statement in probe.
>
> I noticed this though:
>
>>>> rcar_pcie_get_resources() is called while the device is
>>>> runtime-enabled/resumed,
>>>> pci_free_resource_list() is called while the device is runtime-disabled.
>
> rcar_pcie_get_resources() is NOT a pair function for
> pci_free_resource_list() . rcar_pcie_parse_request_of_pci_ranges() is a
> pair function for pci_free_resource_list().
>
> rcar_pcie_parse_request_of_pci_ranges() calls
> of_pci_get_host_bridge_resources() internally, so every single function
> called after successful call of rcar_pcie_parse_request_of_pci_ranges()
> must call pci_free_resource_list().
>
> Both of_pci_get_host_bridge_resources() and pci_free_resource_list() are
> called with runtime PM disabled.
>
> The naming of the functions is confusing though.

You are right, your changes are correct, and the naming of these functions
is confusing. Perhaps it should be changed, to avoid misleading the (not so)
casual reviewer?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

BTW, while diving deeper, I noticed a few other pre-existing issues in error
handling:

1. If anything fails after rcar_pcie_get_resources(), the bus clock is never
   disabled,
2. The error path of rcar_pcie_enable_msi() does not call
   irq_dispose_mapping() before irq_domain_remove(),
3. If rcar_pcie_enable() fails, none of the setup done in
   rcar_pcie_enable_msi() is reverted.
   Apart from the IRQ domain handling in 2, that includes freeing msi->pages
   (should this be allocated using the DMA API?), and undoing the related HW
   setup, to prevent the HW from scribbling the former MSI page in the future.

Care to fix these, too?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
