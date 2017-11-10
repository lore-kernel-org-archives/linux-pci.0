Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56862 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdKJV5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2017 16:57:51 -0500
Subject: Re: [PATCH 1/3] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-pci@vger.kernel.org
Cc: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
 <677fb0a8-de66-46d3-cdf6-512ca2a9d27e@cogentembedded.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <db5c1008-7b99-7d81-e0f6-51c872e532b8@gmail.com>
Date: Fri, 10 Nov 2017 22:01:49 +0100
MIME-Version: 1.0
In-Reply-To: <677fb0a8-de66-46d3-cdf6-512ca2a9d27e@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/08/2017 12:00 PM, Sergei Shtylyov wrote:
> On 11/8/2017 12:28 PM, Marek Vasut wrote:
> 
>> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>>
>> Reestablish the PCIe link very early in the resume process in case it
>> went down to prevent PCI accesses from hanging the bus. Such accesses
>> can happen early in the PCI resume process, in the resume_noirq, thus
>> the link must be reestablished in the resume_noirq callback of the
>> driver.
>>
>> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>>   drivers/pci/host/pcie-rcar.c | 31 ++++++++++++++++++++++++++++---
>>   1 file changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>> index 889603783f01..aa588a7d4811 100644
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
> [...]
>> @@ -529,7 +530,7 @@ static void phy_write_reg(struct rcar_pcie *pcie,
>>       phy_wait_for_ack(pcie);
>>   }
>>   -static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
>> +static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie, int atomic)
> 
>    How about *bool* atomic?

Not a big fan of bool in C, but I think I can avoid this altogether.
If I poll more often, I can just use udelay(5) for such a short delay.

> [...]
> 
> MBR, Sergei


-- 
Best regards,
Marek Vasut
