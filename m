Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:47928 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751954AbdKHJ7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 04:59:08 -0500
Subject: Re: [PATCH] PCI: rcar: Add compatible string for r8a7796
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-pci@vger.kernel.org
Cc: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20171108091521.8423-1-marek.vasut+renesas@gmail.com>
 <538f7964-0f69-2ed2-35f2-e14244a7e6ba@cogentembedded.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <b5f4014e-7574-ef0a-cec5-576cfaa99a2f@gmail.com>
Date: Wed, 8 Nov 2017 10:31:14 +0100
MIME-Version: 1.0
In-Reply-To: <538f7964-0f69-2ed2-35f2-e14244a7e6ba@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/08/2017 10:28 AM, Sergei Shtylyov wrote:
> Hello!

Hi

> On 11/8/2017 12:15 PM, Marek Vasut wrote:
> 
>> From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
>>
>> Add compatible string for the RCar M3 R8A7796 SoC.
> 
>    It's M3-W.
> 
>> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>>   drivers/pci/host/pcie-rcar.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>> index 12796eccb2be..8b51208875fc 100644
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
>> @@ -1062,6 +1062,7 @@ static const struct of_device_id
>> rcar_pcie_of_match[] = {
>>       { .compatible = "renesas,pcie-rcar-gen2",
>>         .data = rcar_pcie_hw_init_gen2 },
>>       { .compatible = "renesas,pcie-r8a7795", .data =
>> rcar_pcie_hw_init },
>> +    { .compatible = "renesas,pcie-r8a7796", .data = rcar_pcie_hw_init },
> 
>    Why, if we already have the line below?

For the sake of completeness, but I'll reply to Geerts email about this.

> And don't you need to update the bindings?

Nope, the bindings already have this entry.

>>       { .compatible = "renesas,pcie-rcar-gen3", .data =
>> rcar_pcie_hw_init },
>>       {},
>>   };
> 
> MBR, Sergei


-- 
Best regards,
Marek Vasut
