Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:38232 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751827AbbBPBxr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Feb 2015 20:53:47 -0500
Message-ID: <54E14DA4.8090708@renesas.com>
Date: Mon, 16 Feb 2015 10:53:40 +0900
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
To: Simon Horman <horms@verge.net.au>
CC: <bhelgaas@google.com>, <valentine.barshak@cogentembedded.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: rcar: Add address check of mem_res
References: <1423814138-18748-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com> <20150213164424.GA22407@verge.net.au>
In-Reply-To: <20150213164424.GA22407@verge.net.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Thnaks for your review.

(2015/02/14 1:44), Simon Horman wrote:
> Hi Iwamatsu-san,
>
> On Fri, Feb 13, 2015 at 04:55:38PM +0900, Nobuhiro Iwamatsu wrote:
>> lower 16 bits of the address, which is managed by mem_res need to be 0.
>> This adds address check of lower 16 bits.
>>
>> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.yj@renesas.com>
>> ---
>>   drivers/pci/host/pci-rcar-gen2.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
>> index d9c042f..13b2793 100644
>> --- a/drivers/pci/host/pci-rcar-gen2.c
>> +++ b/drivers/pci/host/pci-rcar-gen2.c
>> @@ -351,6 +351,9 @@ static int rcar_pci_probe(struct platform_device *pdev)
>>   	if (!priv)
>>   		return -ENOMEM;
>>
>> +	if (mem_res->start&  0xFFFF)
>> +		return -EINVAL;
>> +
>
> This check seems correct to me. But would it make sense to place it before
> the call to devm_kzalloc() rather than after it? I think that should group
> it would an existing checking of mem_res.
>

Yes, I will　resend patch.

>>   	priv->mem_res = *mem_res;
>>   	/*
>>   	 * The controller does not support/use port I/O,
>> --
>> 2.1.3
>>

Best regards,
   Nobuhiro
