Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43225 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab2CUO4o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2012 10:56:44 -0400
Received: by ghrr11 with SMTP id r11so991653ghr.19
        for <linux-pci@vger.kernel.org>; Wed, 21 Mar 2012 07:56:43 -0700 (PDT)
Message-ID: <4F69EC1F.1090901@gmail.com>
Date: Wed, 21 Mar 2012 22:56:31 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@huawei.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Subject: Re: [PATCH 2/6] x86,IRQ: Mark unused entries in 'ioapics' array as
 free at startup
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com> <1332260463-13924-1-git-send-email-jiang.liu@huawei.com> <1332260463-13924-4-git-send-email-jiang.liu@huawei.com> <CAE9FiQX9NJ4n09_OWJVf7n579=JWDUi+XF79aMKUFunCXL3PJw@mail.gmail.com> <4F694BCF.80106@huawei.com>
In-Reply-To: <4F694BCF.80106@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,
	Get your points now and will drop this patch from the series.
	Thanks!

On 03/21/2012 11:32 AM, Jiang Liu wrote:
> So seems another patch is needed to search all entries in the ioapics
> array to find a free entry for real hot-added IOAPICs. Current
> implementation can only support hot-replace scenario, but can't support
> real hot-add. If needed, I will work out another patch to address that.
> 
> Gerry
> 
> On 2012-3-21 11:25, Yinghai Lu wrote:
>> On Tue, Mar 20, 2012 at 9:20 AM, Jiang Liu<liuj97@gmail.com>  wrote:
>>> Unused entries in ioapics array should be marked as free at startup,
>>> so they could be used by hot-added IOAPICs.
>>>
>>> Signed-off-by: Jiang Liu<jiang.liu@huawei.com>
>>> ---
>>>   arch/x86/kernel/apic/io_apic.c |    4 ++++
>>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
>>> index 7412eb8..622374f 100644
>>> --- a/arch/x86/kernel/apic/io_apic.c
>>> +++ b/arch/x86/kernel/apic/io_apic.c
>>> @@ -392,6 +392,10 @@ int __init arch_early_irq_init(void)
>>>                 cpumask_set_cpu(0, cfg->domain);
>>>         }
>>>
>>> +       /* Mark all left entries as free for IOAPIC hot-adding. */
>>> +       for (i = nr_ioapics; i<  MAX_IO_APICS; i++)
>>> +               ioapics[i].mp_config.apicid = 0xff;
>>> +
>>>         return 0;
>>>   }
>>
>> this one looks like not needed, we did not search that after
>> nr_ioapics, and just use nr_ioapics if open spot is found.
>>
>> Yinghai
>>
>>
> 
> 

