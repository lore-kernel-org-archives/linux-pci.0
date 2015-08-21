Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35602 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbbHUJZa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 05:25:30 -0400
Received: by pacdd16 with SMTP id dd16so40593222pac.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2015 02:25:29 -0700 (PDT)
References: <1440079113-165527-1-git-send-email-gabriele.paoloni@huawei.com> <55D68405.1000901@hisilicon.com> <90DF1C90-A030-416D-9F86-364DBA1AABB6@gmail.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D824BF@lhreml503-mbs>
Mime-Version: 1.0 (1.0)
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D824BF@lhreml503-mbs>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <AEC0CFBF-431A-4C08-A795-80BC848996E9@gmail.com>
Cc: "Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"<bhelgaas@google.com>" <bhelgaas@google.com>,
	"<linux-pci@vger.kernel.org>" <linux-pci@vger.kernel.org>,
	"<pratyush.anand@gmail.com>" <pratyush.anand@gmail.com>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>, jingoohan1@gmail.com
From: Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: designware: fix dw_pcie_cfg_write
Date: Fri, 21 Aug 2015 18:25:19 +0900
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015. 8. 21., at PM 5:58, Gabriele Paoloni <gabriele.paoloni@huawei.com> wrote:
> 
> Hi Jingoo 
> 
>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>> owner@vger.kernel.org] On Behalf Of Jingoo Han
>> Sent: Friday, August 21, 2015 5:48 AM
>> To: Wangzhou (B)
>> Cc: Gabriele Paoloni; <bhelgaas@google.com>; <linux-
>> pci@vger.kernel.org>; <pratyush.anand@gmail.com>; Yuanzhichang;
>> Zhudacai; zhangjukuo; qiuzhenfa; Liguozhu (Kenneth);
>> jingoohan1@gmail.com
>> Subject: Re: [PATCH] PCI: designware: fix dw_pcie_cfg_write
>> 
>>> On 2015. 8. 21., at AM 10:51, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>>> 
>>>> On 2015/8/20 21:58, Gabriele Paoloni wrote:
>>>> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>>>> 
>>>> Currently in dw_pcie_cfg_write() if the input size is 2 bytes
>>>> the address offset is wrongly calculated as we mask also bit0
>>>> of "where" input parameter. Instead we should mask all bits of
>>>> "where" except bit0 and bit1.
>>>> 
>>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>>> ---
>>>> drivers/pci/host/pcie-designware.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/pci/host/pcie-designware.c
>> b/drivers/pci/host/pcie-designware.c
>>>> index 69486be..a27f536 100644
>>>> --- a/drivers/pci/host/pcie-designware.c
>>>> +++ b/drivers/pci/host/pcie-designware.c
>>>> @@ -99,7 +99,7 @@ int dw_pcie_cfg_write(void __iomem *addr, int
>> where, int size, u32 val)
>>>>   if (size == 4)
>>>>       writel(val, addr);
>>>>   else if (size == 2)
>>>> -        writew(val, addr + (where & 2));
>>>> +        writew(val, addr + (where & 3));
>>>>   else if (size == 1)
>>>>       writeb(val, addr + (where & 3));
>>>>   else
>>> 
>>> Hi Jingoo,
>>> 
>>> Is there some special consideration? If we miss something, please let
>> us know.
>> 
>> This patch is unnecessary.
>> 
>> In the case of 'size == 2', the writew() in dw_pcie_cfg_write() should
>> handle the following values of 'where'.
>> 
>>  h00    b0000
>>  h02    b0010
>> 
>> Thus, there is no need to keep 0th bit.
> 
> What if the last bits of "where" are h01(b0001), then the current implementation will clear the last bit...? 

Yep.

> Do you think it is impossible to have a scenario where: "where = hxxxxxx01" and  "size = 2"? 

Is there any function using "where = h01" and "size =2"?
It might be wrong usage.

Best regards,
Jingoo Han

>> 
>> One more thing, is there any reason to urge me to review this patch
>> within a few hours?
>> Please wait for reviews for enough hours.
>> 
>> Maybe, your company looks to support you and other engineers for
>> mainline kernel.
>> However, I am not supported at all, so it is not easy to review the
>> patches quickly.
> 
> Jingoo I am sorry for this. I am sure Zhou Wang did not mean to push you.
> 
> I agree that this patch is low prio...for us I think is much more important
> to have "PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05" patchset 
> pushed in mainline.
> 
>> Best regards,
>> Jingoo Han
>> 
>>> Thanks,
>>> Zhou
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
