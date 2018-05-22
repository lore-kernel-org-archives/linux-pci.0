Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33357 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEVKAj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 06:00:39 -0400
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
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <3936f87b-155f-7fc1-1618-287d5d64b7b3@gmail.com>
Date: Tue, 22 May 2018 11:48:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVkeSEsO-jRCzh-_9VkzZ+4X-VAN1KZOA2wB7bUQTrRYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/22/2018 11:42 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Mon, May 21, 2018 at 11:05 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> The data link active signal usually takes ~20 uSec to be asserted,
>> poll the bit more often to avoid useless delays in this function.
>> Use udelay() instead of usleep() for such a small delay as suggested
>> by the timer documentation and because this will be used in atomic
>> context later on when the suspend/resume patches land.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
>> @@ -529,13 +529,13 @@ static void phy_write_reg(struct rcar_pcie *pcie,
>>
>>  static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
>>  {
>> -       unsigned int timeout = 10;
>> +       unsigned int timeout = 10000;
>>
>>         while (timeout--) {
>>                 if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
>>                         return 0;
>>
>> -               msleep(5);
>> +               udelay(5);
> 
> + cpu_relax()?

Is it safe to use in atomic context ? Because of that suspend/resume thing.

>>         }
> 
> if this ever happens, it will have blocked for more than 50 ms...

Well yes, so did the previous thing.

-- 
Best regards,
Marek Vasut
