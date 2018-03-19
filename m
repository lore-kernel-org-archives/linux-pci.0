Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54331 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbeCSOEK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2018 10:04:10 -0400
Subject: Re: [PATCH 1/2] PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20180318105253.30532-1-marek.vasut+renesas@gmail.com>
 <20180319083839.h3qdt4obbsbqlx73@verge.net.au>
 <b7dad289-c9de-ae19-a0d2-3eb127e0955a@gmail.com>
 <CAMuHMdVjU=1ndTK1jTU90Vw2sgPsTRRsH56vvY6nuuoDWUo-Aw@mail.gmail.com>
 <618f1841-f8b9-7fdb-5887-01a080a231db@gmail.com>
 <ebef6e5d-03ac-e1a7-ab9b-11ddfee72355@mentor.com>
 <05d70e5e-4751-9dc7-3b88-f4b6f4c70e82@gmail.com>
 <ea14c5a4-3588-77e2-4352-6e8eecd7c9a4@mentor.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <5f63d151-5397-4612-43c1-904dd614ac17@gmail.com>
Date: Mon, 19 Mar 2018 15:04:07 +0100
MIME-Version: 1.0
In-Reply-To: <ea14c5a4-3588-77e2-4352-6e8eecd7c9a4@mentor.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/19/2018 02:56 PM, Vladimir Zapolskiy wrote:
> On 03/19/2018 03:48 PM, Marek Vasut wrote:
>> On 03/19/2018 02:43 PM, Vladimir Zapolskiy wrote:
>>> On 03/19/2018 12:56 PM, Marek Vasut wrote:
>>>> On 03/19/2018 11:53 AM, Geert Uytterhoeven wrote:
>>>>> Hi Marek,
>>>>>
>>>>> On Mon, Mar 19, 2018 at 10:53 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>> On 03/19/2018 09:38 AM, Simon Horman wrote:
>>>>>>> On Sun, Mar 18, 2018 at 11:52:52AM +0100, Marek Vasut wrote:
>>>>>>>> The data link active signal usually takes ~20 uSec to be asserted,
>>>>>>>> poll the bit more often to avoid useless delays in this function.
>>>>>>>>
>>>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>>>>>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>>>>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>>>>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>>>>>
>>>>>>> Unless my eyes deceive me this seems to be quite a lot (100x) more often,
>>>>>>> but so be it.
>>>>>>
>>>>>> It's just a higher frequency to avoid slowdown when bringing the link up.
>>>>>
>>>>> No it isn't: you replaced a sleep by a delay, thus making it blocking.
>>>>
>>>> For much shorter period of time.
>>>>
>>>>> So this can spin for up to 50 ms (+ overhead)?
>>>>
>>>> That's what it did before too , it used msleep and now it uses udelay.
>>>>
>>>
>>> msleep() does not spin, it reschedules the process.
>>>
>>> Instead to find a balance you may want to play with usleep_range().
>>
>> Which does not work in atomic context, which will be needed when using
>> this function in suspend/resume later on.
>>
> 
> IIRC suspend/resume are never executed in atomic context, and runtime
> suspend/resume are invoked in atomic context only if pm_runtime_irq_safe()
> is called (just a few drivers in vanilla uses it at the moment).
> 
> Nevertheless, the commit message does not say that the change is needed
> for future suspend/resume add-on.

Well, then drop this patch for now, I'll resubmit it later with the
suspend/resume series. I presume 2/2 can go in though, so I don't have
to resubmit it over and over again.

-- 
Best regards,
Marek Vasut
