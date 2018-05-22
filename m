Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35875 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEVMyr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 08:54:47 -0400
Subject: Re: [PATCH] PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20180521210522.29346-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVkeSEsO-jRCzh-_9VkzZ+4X-VAN1KZOA2wB7bUQTrRYg@mail.gmail.com>
 <3936f87b-155f-7fc1-1618-287d5d64b7b3@gmail.com>
 <CAMuHMdU=s3ZyCLO5zDXgQis8Ak5akhJhcShs4hgQikaoWYLGZw@mail.gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <f7d3ed30-0290-8297-1a7b-7c6bfb2dfcb6@gmail.com>
Date: Tue, 22 May 2018 14:20:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU=s3ZyCLO5zDXgQis8Ak5akhJhcShs4hgQikaoWYLGZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/22/2018 12:33 PM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Tue, May 22, 2018 at 11:48 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 05/22/2018 11:42 AM, Geert Uytterhoeven wrote:
>>> On Mon, May 21, 2018 at 11:05 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> The data link active signal usually takes ~20 uSec to be asserted,
>>>> poll the bit more often to avoid useless delays in this function.
>>>> Use udelay() instead of usleep() for such a small delay as suggested
>>>> by the timer documentation and because this will be used in atomic
>>>> context later on when the suspend/resume patches land.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/drivers/pci/host/pcie-rcar.c
>>>> +++ b/drivers/pci/host/pcie-rcar.c
>>>> @@ -529,13 +529,13 @@ static void phy_write_reg(struct rcar_pcie *pcie,
>>>>
>>>>  static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
>>>>  {
>>>> -       unsigned int timeout = 10;
>>>> +       unsigned int timeout = 10000;
>>>>
>>>>         while (timeout--) {
>>>>                 if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
>>>>                         return 0;
>>>>
>>>> -               msleep(5);
>>>> +               udelay(5);
>>>
>>> + cpu_relax()?
>>
>> Is it safe to use in atomic context ? Because of that suspend/resume thing.
> 
> Yes.

OK, added.

>>>>         }
>>>
>>> if this ever happens, it will have blocked for more than 50 ms...
>>
>> Well yes, so did the previous thing.
> 
> No, the previous thing slept. Big difference.

True

-- 
Best regards,
Marek Vasut
