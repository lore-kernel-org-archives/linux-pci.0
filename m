Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32951 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbbHZCRb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 22:17:31 -0400
Received: by pacti10 with SMTP id ti10so70398088pac.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2015 19:17:30 -0700 (PDT)
References: <1440498929-44519-1-git-send-email-wangzhou1@hisilicon.com> <5DE197E3-8F25-4EAD-B21B-BE3220C6C21B@gmail.com> <55DD1CF1.4050706@hisilicon.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <55DD1CF1.4050706@hisilicon.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <24A4D961-E9D6-4DDD-968B-7DE2E44398D0@gmail.com>
Cc: "<pratyush.anand@gmail.com>" <pratyush.anand@gmail.com>,
	"<gabriele.paoloni@huawei.com>" <gabriele.paoloni@huawei.com>,
	"<linux-pci@vger.kernel.org>" <linux-pci@vger.kernel.org>,
	"<qiuzhenfa@hisilicon.com>" <qiuzhenfa@hisilicon.com>,
	"<zhangjukuo@huawei.com>" <zhangjukuo@huawei.com>,
	"<liudongdong3@huawei.com>" <liudongdong3@huawei.com>,
	"<qiujiang@huawei.com>" <qiujiang@huawei.com>,
	"<xuwei5@hisilicon.com>" <xuwei5@hisilicon.com>,
	"<liguozhu@hisilicon.com>" <liguozhu@hisilicon.com>,
	jingoohan1@gmail.com
From: Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: designware: Fix PORT_LOGIC_LINK_WIDTH_MASK
Date: Wed, 26 Aug 2015 11:17:21 +0900
To: Zhou Wang <wangzhou1@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015. 8. 26., at AM 10:57, Zhou Wang <wangzhou1@hisilicon.com> wrote:
> 
> Hi Jingoo,
> 
>> On 2015/8/25 19:14, Jingoo Han wrote:
>>> On 2015. 8. 25., at PM 7:35, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>>> 
>>> The value under PORT_LOGIC_LINK_WIDTH_MASK is 0x1, 0x2, 0x4, 0x8. Here change
>>> this mask to proper value.
>>> 
>>> In fact, for DesignWare PCIe IP version 4.4, it only uses bit8~12 to indicate
>>> number of lanes. Original mask will bring a mistake.
>> 
>> NAK
> 
> Sorry, maybe above commit message is no very clear. Will explain it below.
> 
>> 
>> The definitions of bits of registers should be defined based on hardware manual such as datasheet, databook.
>> 
>> According to the databook, the bits [16:8] are defined for NUM_OF_LANES.
> 
> Yes, according to databook of v4.2, bits [16:8] are defined for NUM_OF_LANES.
> 
>> 
>> In the future, if 16 lanes or 32 lanes is supported and 12th bit or 13th bit is used, what will you do?
>> 
>> Then, in the version 4.4 IP, the bits[16:13] are used for other usage?
> 
> Yes, according to databook of v4.4, bits [12:8] are defined for NUM_OF_LANES.
> [16:13] are for other usages(bit16 is AUTO_LANE_FLIP_CTRL_EN, bits [15:13] are
> PRE_DET_LANE). For details, maybe you can refer to v4.4 databook :)
> 
> My opinion is that there is no conflict about NUM_OF_LANES between v4.2 and v4.4.
> We can change this mask to avoid future problem.

OK, I see.
I got what you want to say. :-)

I think that there is no conflict between v4.2 and v4.4.
So, this patch can be accepted.

Then, would you send v2 patch with more detailed commit message above mentioned?

Best regards,
Jingoo Han

> Thanks
> Zhou
> 
>> Best regards,
>> Jingoo Han
>> 
>>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>> ---
>>> drivers/pci/host/pcie-designware.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>>> index 69486be..eb549b9 100644
>>> --- a/drivers/pci/host/pcie-designware.c
>>> +++ b/drivers/pci/host/pcie-designware.c
>>> @@ -35,7 +35,7 @@
>>> 
>>> #define PCIE_LINK_WIDTH_SPEED_CONTROL    0x80C
>>> #define PORT_LOGIC_SPEED_CHANGE (0x1 << 17)
>>> -#define PORT_LOGIC_LINK_WIDTH_MASK    (0x1ff << 8)
>>> +#define PORT_LOGIC_LINK_WIDTH_MASK    (0x1f << 8)
>>> #define PORT_LOGIC_LINK_WIDTH_1_LANES    (0x1 << 8)
>>> #define PORT_LOGIC_LINK_WIDTH_2_LANES    (0x2 << 8)
>>> #define PORT_LOGIC_LINK_WIDTH_4_LANES    (0x4 << 8)
>>> -- 
>>> 1.9.1
>> 
>> .
> 
> 
