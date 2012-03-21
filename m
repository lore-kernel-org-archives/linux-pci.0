Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([58.251.152.66]:49491 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756617Ab2CUDhz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 23:37:55 -0400
Received: from huawei.com (szxga03-in [172.24.2.9])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M17003JCTUPZU@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 21 Mar 2012 11:32:49 +0800 (CST)
Received: from szxrg02-dlp.huawei.com ([172.24.2.119])
 by szxga03-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M1700GK3TUO1S@szxga03-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 21 Mar 2012 11:32:49 +0800 (CST)
Date: Wed, 21 Mar 2012 11:32:31 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH 2/6] x86,IRQ: Mark unused entries in 'ioapics' array as
 free at startup
In-reply-to: <CAE9FiQX9NJ4n09_OWJVf7n579=JWDUi+XF79aMKUFunCXL3PJw@mail.gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Message-id: <4F694BCF.80106@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
 <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
 <1332260463-13924-4-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQX9NJ4n09_OWJVf7n579=JWDUi+XF79aMKUFunCXL3PJw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So seems another patch is needed to search all entries in the ioapics
array to find a free entry for real hot-added IOAPICs. Current
implementation can only support hot-replace scenario, but can't support
real hot-add. If needed, I will work out another patch to address that.

Gerry

On 2012-3-21 11:25, Yinghai Lu wrote:
> On Tue, Mar 20, 2012 at 9:20 AM, Jiang Liu<liuj97@gmail.com>  wrote:
>> Unused entries in ioapics array should be marked as free at startup,
>> so they could be used by hot-added IOAPICs.
>>
>> Signed-off-by: Jiang Liu<jiang.liu@huawei.com>
>> ---
>>   arch/x86/kernel/apic/io_apic.c |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
>> index 7412eb8..622374f 100644
>> --- a/arch/x86/kernel/apic/io_apic.c
>> +++ b/arch/x86/kernel/apic/io_apic.c
>> @@ -392,6 +392,10 @@ int __init arch_early_irq_init(void)
>>                 cpumask_set_cpu(0, cfg->domain);
>>         }
>>
>> +       /* Mark all left entries as free for IOAPIC hot-adding. */
>> +       for (i = nr_ioapics; i<  MAX_IO_APICS; i++)
>> +               ioapics[i].mp_config.apicid = 0xff;
>> +
>>         return 0;
>>   }
>
> this one looks like not needed, we did not search that after
> nr_ioapics, and just use nr_ioapics if open spot is found.
>
> Yinghai
>
>


