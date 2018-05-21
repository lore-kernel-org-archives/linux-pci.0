Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40685 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeEULIj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2018 07:08:39 -0400
Subject: Re: [PATCH V5] PCI: rcar: Use runtime PM to control controller clock
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <CAMuHMdUF0oG+fdWv2CissD9tviHiVCg3ofW3oR3vY+=Km41tAg@mail.gmail.com>
 <20180409122636.6rmtzhqqlpqxyear@verge.net.au>
 <caaa0a56-7487-a4de-2b43-82f5fa5b5552@gmail.com>
 <CAMuHMdWTTaJF8+GJdLmM_4J+gMaHPzT2rpO=B2kWYb_2bNbQNg@mail.gmail.com>
 <a5a0d78d-627b-6277-ee75-44e204cbd390@gmail.com>
 <CAMuHMdX9d29JYVDsghd3Koyg8Aeuv0D2Fx5Lnn0bBZSb9RntDw@mail.gmail.com>
 <cdc1b25a-e87d-144b-50c1-4abe31bcf5d0@gmail.com>
 <20180413124819.tw5436lolpn5eqhw@verge.net.au>
 <20180501105556.GB19391@e107981-ln.cambridge.arm.com>
 <d03db400-9f3e-906f-7886-a54cccb96a40@gmail.com>
 <20180514154909.GB13324@e107981-ln.cambridge.arm.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c210df35-ba85-4b22-ae84-fc030ddc094a@gmail.com>
Date: Mon, 21 May 2018 13:08:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180514154909.GB13324@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/14/2018 05:49 PM, Lorenzo Pieralisi wrote:
> On Mon, May 14, 2018 at 05:32:04PM +0200, Marek Vasut wrote:
>> On 05/01/2018 12:55 PM, Lorenzo Pieralisi wrote:
>>> On Fri, Apr 13, 2018 at 02:48:19PM +0200, Simon Horman wrote:
>>>> On Tue, Apr 10, 2018 at 06:17:04PM +0200, Marek Vasut wrote:
>>>>> On 04/10/2018 05:28 PM, Geert Uytterhoeven wrote:
>>>>
>>>> ...
>>>>
>>>>>>>> rcar_pcie_get_resources() is called while the device is
>>>>>>>> runtime-enabled/resumed,
>>>>>>>> pci_free_resource_list() is called while the device is runtime-disabled.
>>>>>
>>>>> rcar_pcie_get_resources() is NOT a pair function for
>>>>> pci_free_resource_list() . rcar_pcie_parse_request_of_pci_ranges() is a
>>>>> pair function for pci_free_resource_list().
>>>>>
>>>>> rcar_pcie_parse_request_of_pci_ranges() calls
>>>>> of_pci_get_host_bridge_resources() internally, so every single function
>>>>> called after successful call of rcar_pcie_parse_request_of_pci_ranges()
>>>>> must call pci_free_resource_list().
>>>>>
>>>>> Both of_pci_get_host_bridge_resources() and pci_free_resource_list() are
>>>>> called with runtime PM disabled.
>>>>>
>>>>> The naming of the functions is confusing though.
>>>>
>>>> Hi,
>>>>
>>>> thanks everyone for their efforts in preparing/reviewing this patch.
>>>>
>>>> It seems there are some differences of opinion on how best to handle the
>>>> error paths but unlike earlier versions this one seems correct to me. If
>>>> that turns out to be false we can address it. But I don't think its likely
>>>> things will be enhanced by continuing this review.
>>>>
>>>> Lorenzo, please consider taking this patch in its current form.
>>>>
>>>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>>>
>>> Applied to pci/rcar for v4.18, thanks.
>>
>> Is there any reason why this patch isnt in next yet ?
> 
> Bjorn will merge it into -next this week.

Seems this got missed last week ?

-- 
Best regards,
Marek Vasut
