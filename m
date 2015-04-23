Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:54315 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbbDWBwn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Apr 2015 21:52:43 -0400
Message-ID: <55385039.6010100@hisilicon.com>
Date: Thu, 23 Apr 2015 09:51:53 +0800
From: yuanzhichang <yuanzhichang@hisilicon.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <grant.likely@linaro.org>, <linux-pci@vger.kernel.org>,
	<gabriele.paoloni@huawei.com>, <Liviu.Dudau@arm.com>
Subject: Re: [[PATCH v1]] of/pci: fix a bug in function pci_pio_to_address
References: <1429709759-79006-1-git-send-email-yuanzhichang@hisilicon.com> <20150422151111.GG20701@google.com>
In-Reply-To: <20150422151111.GG20701@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2015/4/22 23:11, Bjorn Helgaas wrote:
> On Wed, Apr 22, 2015 at 09:35:59PM +0800, Zhichang Yuan wrote:
>> In the patch whose commit id is 41f8bba7f5552d0, function pci_pio_to_address
>> was introduced to retieve the corresponding I/O port by CPU address. But the
>> convertion processing is not correct. It will return a wrong I/O port.
>> This patch will fix it.
>
> Hmmm, this subject and changelog don't seem right.  41f8bba7f555 did add
> pci_pio_to_address(), but that converts an I/O port to a CPU address, and
> this patch doesn't touch that function.
>
> This patch changes pci_address_to_pio(), which does return the I/O port
> corresponding to a CPU physical address.  This function was modified (but
> not added) by 41f8bba7f555.
>
> Please add:
>
> Fixes: 41f8bba7f555 ("of/pci: Add pci_register_io_range() and pci_pio_to_address()")
> CC: stable@vger.kernel.org	# v3.18+
>
Ok. I will update the log and submit the v2.
>> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
>> ---
>>   drivers/of/address.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index 78a7dcb..6906a3f 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -765,7 +765,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
>>   	spin_lock(&io_range_lock);
>>   	list_for_each_entry(res, &io_range_list, list) {
>>   		if (address >= res->start && address < res->start + res->size) {
>> -			addr = res->start - address + offset;
>> +			addr = address - res->start + offset;
>
> This looks like it's been broken since v3.18, and it's used by many
> platforms.  I/O port space isn't as common as it used to be, but it's still
> surprising that nobody noticed until now.
>
> This change does look correct to me, but I want to double-check that we're
> actually going to *fix* a bunch of platforms rather than breaking them.
>
>>   			break;
>>   		}
>>   		offset += res->size;
>> --
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

