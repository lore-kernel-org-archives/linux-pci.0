Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:10176 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbbLIUh3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2015 15:37:29 -0500
Subject: Re: [PATCH] PCI: hisi: fix the hisi_pcie_cfg_read bug when size=4
To: Bjorn Helgaas <helgaas@kernel.org>,
	Dongdong Liu <liudongdong3@huawei.com>
References: <1448600280-83695-1-git-send-email-liudongdong3@huawei.com>
 <20151204224334.GL20125@localhost> <20151209161643.GE31930@localhost>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<gabriele.paoloni@huawei.com>, <qiujiang@huawei.com>,
	<zhangjukuo@huawei.com>, <haifeng.wei@huawei.com>,
	<yisen.zhuang@huawei.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <566890D5.2020007@hisilicon.com>
Date: Thu, 10 Dec 2015 04:36:37 +0800
MIME-Version: 1.0
In-Reply-To: <20151209161643.GE31930@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/12/10 0:16, Bjorn Helgaas wrote:
> On Fri, Dec 04, 2015 at 04:43:34PM -0600, Bjorn Helgaas wrote:
>> On Fri, Nov 27, 2015 at 12:58:00PM +0800, Dongdong Liu wrote:
>>> Current hisi_pcie_cfg_read code read the RC configuration space,
>>> this has a problem that the output parameter "*val" have not been
>>> assigned when size=4, so we fix the bug by "*val = reg_val" when size=4.
>>>
>>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>>
>> Wow, that's a pretty egregious bug.  Was the hisi driver ever tested
>> at all?  We use dword reads in pci_bus_read_dev_vendor_id() to
>> enumerate devices, so if those didn't return valid data, nothing at
>> all should have worked.
>>
>> I tentatively put this on my for-linus branch for v4.4, but I wonder
>> whether it might be smarter to revert the driver completely until I
>> have more confidence in it.
>>
>> What sort of testing have you done on this driver?
> 
> Since I haven't heard anything about whether this driver was ever
> tested, I dropped this patch from my for-linus branch and I reverted
> the entire hisi driver.
> 
> Let me know when you have some testing results, and I'll take another
> look at it.
> 
> Bjorn
>

Hi Bjorn,

Very sorry for late, I am on business trip at the moment so I have restricted
access to emails and my replies can be late.

The driver has been tested extensively based on internal version, but I did this
mistake when upstreaming :(. I will send a test log ASAP.

Many Thanks,
Zhou

>>> ---
>>>  drivers/pci/host/pcie-hisi.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
>>> index 35457ec..da677b1 100644
>>> --- a/drivers/pci/host/pcie-hisi.c
>>> +++ b/drivers/pci/host/pcie-hisi.c
>>> @@ -61,7 +61,9 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
>>>  		*val = *(u8 __force *) walker;
>>>  	else if (size == 2)
>>>  		*val = *(u16 __force *) walker;
>>> -	else if (size != 4)
>>> +	else if (size == 4)
>>> +		*val = reg_val;
>>> +	else
>>>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>  
>>>  	return PCIBIOS_SUCCESSFUL;
>>> -- 
>>> 1.9.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 

