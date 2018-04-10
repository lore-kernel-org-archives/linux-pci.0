Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:54375 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDJQSB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2018 12:18:01 -0400
From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V5] PCI: rcar: Use runtime PM to control controller clock
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
References: <20180408130925.19088-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVGBkEY2kE7auUwXBn2QSfX+yhxkFH--4tTw+XJ3WCk0w@mail.gmail.com>
 <3973dcdf-c6d7-5622-0c19-ea6f77899261@gmail.com>
 <20180409114159.azxeehjkeuinwrwe@verge.net.au>
 <CAMuHMdUF0oG+fdWv2CissD9tviHiVCg3ofW3oR3vY+=Km41tAg@mail.gmail.com>
 <20180409122636.6rmtzhqqlpqxyear@verge.net.au>
 <caaa0a56-7487-a4de-2b43-82f5fa5b5552@gmail.com>
 <CAMuHMdWTTaJF8+GJdLmM_4J+gMaHPzT2rpO=B2kWYb_2bNbQNg@mail.gmail.com>
 <a5a0d78d-627b-6277-ee75-44e204cbd390@gmail.com>
 <CAMuHMdX9d29JYVDsghd3Koyg8Aeuv0D2Fx5Lnn0bBZSb9RntDw@mail.gmail.com>
Message-ID: <cdc1b25a-e87d-144b-50c1-4abe31bcf5d0@gmail.com>
Date: Tue, 10 Apr 2018 18:17:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX9d29JYVDsghd3Koyg8Aeuv0D2Fx5Lnn0bBZSb9RntDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/10/2018 05:28 PM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

[...]

>>>> The pairing looks as follows:
>>>>
>>>> .- rcar_pcie_parse_request_of_pci_ranges()
>>>> |  (pm_runtime_enable is here)
>>>> | .- pm_runtime_get_sync()
>>>> | | .- rcar_pcie_get_resources()
>>>
>>> rcar_pcie_get_resources() is called  while the device is runtime-enabled/resumed
>>
>> Because something may access the device, yes.
>>
>>>> | | |
>>>> | | '- pm_runtime_put()
>>>> | '- pm_runtime_disable() + pci_free_resource_list()
>>>
>>> pci_free_resource_list() is called while the device is runtime-disabled.
>>
>> Because nothing will access the device.
>>
>>>> '- pci_free_host_bridge()
>>>>
>>>> It looks symmetric to me ...
>>>
>>> rcar_pcie_get_resources() is called while the device is
>>> runtime-enabled/resumed,
>>> pci_free_resource_list() is called while the device is runtime-disabled.
>>
>> At this point, I think I'd rather see a diff of changes which you have
>> in mind rather than this endless discussion. Can you provide one against
>> this patch ?
> 
> My final comment:
> 
> If the steps during probing are A..Z, cleanup and removal should undo them
> in reverse order (Z..A), unless there's a very good reason not to do so.

I spent extra time going through the probe function and I just don't see
how it is not done in the exact reverse, I checked every single goto
statement in probe.

I noticed this though:

>>> rcar_pcie_get_resources() is called while the device is
>>> runtime-enabled/resumed,
>>> pci_free_resource_list() is called while the device is runtime-disabled.

rcar_pcie_get_resources() is NOT a pair function for
pci_free_resource_list() . rcar_pcie_parse_request_of_pci_ranges() is a
pair function for pci_free_resource_list().

rcar_pcie_parse_request_of_pci_ranges() calls
of_pci_get_host_bridge_resources() internally, so every single function
called after successful call of rcar_pcie_parse_request_of_pci_ranges()
must call pci_free_resource_list().

Both of_pci_get_host_bridge_resources() and pci_free_resource_list() are
called with runtime PM disabled.

The naming of the functions is confusing though.

-- 
Best regards,
Marek Vasut
