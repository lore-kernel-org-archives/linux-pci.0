Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:23377 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbbHUFQr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 01:16:47 -0400
Message-ID: <55D6B42B.5010803@hisilicon.com>
Date: Fri, 21 Aug 2015 13:16:27 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Jingoo Han <jingoohan1@gmail.com>
CC: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"<bhelgaas@google.com>" <bhelgaas@google.com>,
	"<linux-pci@vger.kernel.org>" <linux-pci@vger.kernel.org>,
	"<pratyush.anand@gmail.com>" <pratyush.anand@gmail.com>,
	"<yuanzhichang@hisilicon.com>" <yuanzhichang@hisilicon.com>,
	"<zhudacai@hisilicon.com>" <zhudacai@hisilicon.com>,
	"<zhangjukuo@huawei.com>" <zhangjukuo@huawei.com>,
	"<qiuzhenfa@hisilicon.com>" <qiuzhenfa@hisilicon.com>,
	"<liguozhu@hisilicon.com>" <liguozhu@hisilicon.com>
Subject: Re: [PATCH] PCI: designware: fix dw_pcie_cfg_write
References: <1440079113-165527-1-git-send-email-gabriele.paoloni@huawei.com> <55D68405.1000901@hisilicon.com> <90DF1C90-A030-416D-9F86-364DBA1AABB6@gmail.com>
In-Reply-To: <90DF1C90-A030-416D-9F86-364DBA1AABB6@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/8/21 12:48, Jingoo Han wrote:
> On 2015. 8. 21., at AM 10:51, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>>
>>> On 2015/8/20 21:58, Gabriele Paoloni wrote:
>>> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>>>
>>> Currently in dw_pcie_cfg_write() if the input size is 2 bytes
>>> the address offset is wrongly calculated as we mask also bit0
>>> of "where" input parameter. Instead we should mask all bits of
>>> "where" except bit0 and bit1.
>>>
>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> ---
>>> drivers/pci/host/pcie-designware.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>>> index 69486be..a27f536 100644
>>> --- a/drivers/pci/host/pcie-designware.c
>>> +++ b/drivers/pci/host/pcie-designware.c
>>> @@ -99,7 +99,7 @@ int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
>>>    if (size == 4)
>>>        writel(val, addr);
>>>    else if (size == 2)
>>> -        writew(val, addr + (where & 2));
>>> +        writew(val, addr + (where & 3));
>>>    else if (size == 1)
>>>        writeb(val, addr + (where & 3));
>>>    else
>>
>> Hi Jingoo,
>>
>> Is there some special consideration? If we miss something, please let us know.
> 
> This patch is unnecessary.
> 
> In the case of 'size == 2', the writew() in dw_pcie_cfg_write() should handle the following values of 'where'.
> 
>   h00    b0000
>   h02    b0010
> 
> Thus, there is no need to keep 0th bit.
> 
> One more thing, is there any reason to urge me to review this patch within a few hours?
> Please wait for reviews for enough hours.

Honestly speaking, I didn't mean to push you to review it :)

I thought maybe there was some hardware issues involved in above patch,
just asking a question about it. Anyway, maybe I should have waited for your reply.

Many thanks,
Zhou

> 
> Maybe, your company looks to support you and other engineers for mainline kernel.
> However, I am not supported at all, so it is not easy to review the patches quickly.
>
> Best regards,
> Jingoo Han
> 
>> Thanks,
>> Zhou
>>
> 
> .
> 


