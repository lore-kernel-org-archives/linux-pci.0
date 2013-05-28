Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:33290 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3E1EvF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 00:51:05 -0400
Message-ID: <51A437A8.7090104@huawei.com>
Date: Tue, 28 May 2013 12:50:48 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] PCI/X86: increase info->res_num before checking pci_use_crs
 return
References: <1369709709-14504-1-git-send-email-wangyijing@huawei.com> <CAE9FiQXkwoRfFbcEn15MRGv6fVeOM5WC1Gh2NAhWj7yTda3G+g@mail.gmail.com>
In-Reply-To: <CAE9FiQXkwoRfFbcEn15MRGv6fVeOM5WC1Gh2NAhWj7yTda3G+g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/5/28 12:35, Yinghai Lu wrote:
> On Mon, May 27, 2013 at 7:55 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> I separate this patch from patchset "Add hostbridge resource release to
>> support root bus hotplug in IA64", because it's a Separate issue.
>>
>> We should increase info->res_num before we checking pci_use_crs return
>> when pci=nocrs set.
> 
> there is no function change or issue here.

Hi Yinghai,
   Thanks for review and comments!
Yes, this patch is no functional change. I just sent this patch for make code flow more clearly.
Because free_pci_root_info_res() will free all info->res and info->res_offset. So I think move info->res_num++
before pci_use_crs check is better, better readability.

> 
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> Cc: Yinghai Lu <yinghai@kernel.org>
>> Cc: Jiang Liu <liuj97@gmail.com>
>> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>> Cc: Feng Tang <feng.tang@intel.com>
>> ---
>>  arch/x86/pci/acpi.c |    7 ++-----
>>  1 files changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index 3e72425..662dfdf 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -324,14 +324,11 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
>>         res->start = start;
>>         res->end = end;
>>         info->res_offset[info->res_num] = addr.translation_offset;
>> +       info->res_num++;
>>
>> -       if (!pci_use_crs) {
>> +       if (!pci_use_crs)
>>                 dev_printk(KERN_DEBUG, &info->bridge->dev,
>>                            "host bridge window %pR (ignored)\n", res);
>> -               return AE_OK;
>> -       }
>> -
>> -       info->res_num++;
>>
>>         return AE_OK;
>>  }
> 
> info->res_num is not used after probe_pci_root_info for pci_nocrs case.
> 
> Thanks
> 
> Yinghai
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

