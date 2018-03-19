Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:41966 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754996AbeCSNni (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2018 09:43:38 -0400
Subject: Re: [PATCH 1/2] PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
To: Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20180318105253.30532-1-marek.vasut+renesas@gmail.com>
 <20180319083839.h3qdt4obbsbqlx73@verge.net.au>
 <b7dad289-c9de-ae19-a0d2-3eb127e0955a@gmail.com>
 <CAMuHMdVjU=1ndTK1jTU90Vw2sgPsTRRsH56vvY6nuuoDWUo-Aw@mail.gmail.com>
 <618f1841-f8b9-7fdb-5887-01a080a231db@gmail.com>
CC: Simon Horman <horms@verge.net.au>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <ebef6e5d-03ac-e1a7-ab9b-11ddfee72355@mentor.com>
Date: Mon, 19 Mar 2018 15:43:22 +0200
MIME-Version: 1.0
In-Reply-To: <618f1841-f8b9-7fdb-5887-01a080a231db@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/19/2018 12:56 PM, Marek Vasut wrote:
> On 03/19/2018 11:53 AM, Geert Uytterhoeven wrote:
>> Hi Marek,
>>
>> On Mon, Mar 19, 2018 at 10:53 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> On 03/19/2018 09:38 AM, Simon Horman wrote:
>>>> On Sun, Mar 18, 2018 at 11:52:52AM +0100, Marek Vasut wrote:
>>>>> The data link active signal usually takes ~20 uSec to be asserted,
>>>>> poll the bit more often to avoid useless delays in this function.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>>
>>>> Unless my eyes deceive me this seems to be quite a lot (100x) more often,
>>>> but so be it.
>>>
>>> It's just a higher frequency to avoid slowdown when bringing the link up.
>>
>> No it isn't: you replaced a sleep by a delay, thus making it blocking.
> 
> For much shorter period of time.
> 
>> So this can spin for up to 50 ms (+ overhead)?
> 
> That's what it did before too , it used msleep and now it uses udelay.
> 

msleep() does not spin, it reschedules the process.

Instead to find a balance you may want to play with usleep_range().

--
With best wishes,
Vladimir
