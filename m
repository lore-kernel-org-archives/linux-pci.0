Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36576 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbeDHQxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Apr 2018 12:53:46 -0400
Subject: Re: [PATCH V2] PCI: rcar: Clean up the macros
To: Randy Dunlap <rdunlap@infradead.org>, linux-pci@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20180408130942.19148-1-marek.vasut+renesas@gmail.com>
 <7f63726a-fb96-a329-cce4-d1dd64b33de7@infradead.org>
 <710bfa56-09a6-5017-e493-fce7cd09e788@gmail.com>
 <21dff119-07a4-e7b0-f3c0-b21721124232@infradead.org>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <1043a359-7440-826b-5146-7dea494214b8@gmail.com>
Date: Sun, 8 Apr 2018 18:53:43 +0200
MIME-Version: 1.0
In-Reply-To: <21dff119-07a4-e7b0-f3c0-b21721124232@infradead.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/08/2018 06:51 PM, Randy Dunlap wrote:
> On 04/08/2018 09:34 AM, Marek Vasut wrote:
>> On 04/08/2018 05:27 PM, Randy Dunlap wrote:
>>> On 04/08/2018 06:09 AM, Marek Vasut wrote:
>>>> This patch replaces the (1 << n) with BIT(n) and cleans up whitespace,
>>>> no functional change.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>> ---
>>>> V2: Reword the commit message
>>>> ---
>>>>  drivers/pci/host/pcie-rcar.c | 52 ++++++++++++++++++++++----------------------
>>>>  1 file changed, 26 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>>>> index 25f68305322c..5ab7bf6a8de0 100644
>>>> --- a/drivers/pci/host/pcie-rcar.c
>>>> +++ b/drivers/pci/host/pcie-rcar.c
>>>> @@ -30,9 +30,9 @@
>>>
>>> missing this:
>>>
>>> #include <linux/bitops.h>
>>
>> This compiles just fine without it though, which means it's probably
>> pulled in through some of the other includes already present.
>>
> 
> I suspected that. However, please see rule #1 in
> Documentation/process/submit-checklist.rst:
> 
> 1) If you use a facility then #include the file that defines/declares
>    that facility.  Don't depend on other header files pulling in ones
>    that you use.

If I was to include every single header from which I use something,
wouldn't that make the list real long then ? Is that really worth it?

-- 
Best regards,
Marek Vasut
