Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EA7C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 16:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAC920693
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 16:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbfCZQeS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:34:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731710AbfCZQeR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 12:34:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 226D6A855866BE22D27A;
        Wed, 27 Mar 2019 00:34:14 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Mar 2019
 00:34:03 +0800
Subject: Re: [RFC PATCH v2 1/3] resource: Request IO port regions from
 children of ioport_resource
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
 <1553105650-28012-2-git-send-email-john.garry@huawei.com>
 <20190325233255.GF24180@google.com>
CC:     <rafael@kernel.org>, <arnd@arndb.de>, <lorenzo.pieralisi@arm.com>,
        <bp@suse.de>, <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linuxarm@huawei.com>, <andy.shevchenko@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b9164269-c2a1-e0fa-4c17-2d06fb42f39b@huawei.com>
Date:   Tue, 26 Mar 2019 16:33:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190325233255.GF24180@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/03/2019 23:32, Bjorn Helgaas wrote:
> Hi John,
>

Hi Bjorn,

Thanks for reviewing this.

> On Thu, Mar 21, 2019 at 02:14:08AM +0800, John Garry wrote:
>> Currently when we request an IO port region, the request is made directly
>> to the top resource, ioport_resource.
>
> Let's be explicit here, e.g.,
>
>   Currently request_region() requests an IO port region directly from the
>   top resource, ioport_resource.

ok

>
>> There is an issue here, in that drivers may successfully request an IO
>> port region even if the IO port region has not even been mapped in
>> (in pci_remap_iospace()).
>>
>> This may lead to crashes when the system has no PCI host, or, has a host
>> but it has failed enumeration, while drivers still attempt to access PCI
>> IO ports, as below:
>
> I don't understand the strategy here.  f71882fg is not a driver for a
> PCI device, so it should work even if there is no PCI host in the
> system.

 From my checking, the f71882fg hwmon is accessed via the super-io 
interface on the PCH on x86. The super-io interface is at fixed 
addresses, those being 0x2e and 0x4e.

Please see the following:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/f71805f.c?h=v5.1-rc2#n1621

and

https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/8-series-chipset-pch-datasheet.pdf 
(Table 9.2).

On x86 systems, these PCH IO ports will be mapped on a PCI bus, like:

$more /proc/ioports
0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0064-0064 : keyboard
   0070-0077 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : fpu

So, the idea in the patch is that if PCI Bus 0000:00 does not exist 
because of no PCI host, then we should fail a request to an IO port region.

>
> On x86, I think inb/inw/inl from a port where nothing responds
> probably just returns ~0, and outb/outw/outl just get dropped.
> Shouldn't arm64 do the same, without crashing?

That would be ideal and we're doing something similar in patch 2/3.

So on ARM64 we have to IO remap the PCI IO resource. If this mapping is 
not done (due to no PCI host), then any inb/inw/inl calls will crash the 
system.

So in patch 2/3, I am also making the change to the logical PIO 
inb/inw/inl accessors to discard accesses when no PCI MMIO regions are 
registered in logical PIO space.

This is really a second line of defense (this patch being the first).

>
>> root@(none)$root@(none)$ insmod f71882fg.ko
>> [  152.215377] Unable to handle kernel paging request at virtual address ffff7dfffee0002e
>> [  152.231299] Mem abort info:
>> [  152.236898]   ESR = 0x96000046
>> [  152.243019]   Exception class = DABT (current EL), IL = 32 bits
>> [  152.254905]   SET = 0, FnV = 0
>> [  152.261024]   EA = 0, S1PTW = 0
>> [  152.267320] Data abort info:
>> [  152.273091]   ISV = 0, ISS = 0x00000046
>> [  152.280784]   CM = 0, WnR = 1
>> [  152.286730] swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>> [  152.300537] [ffff7dfffee0002e] pgd=000000000141c003, pud=000000000141d003, pmd=0000000000000000
>> [  152.318016] Internal error: Oops: 96000046 [#1] PREEMPT SMP
>> [  152.329199] Modules linked in: f71882fg(+)
>> [  152.337415] CPU: 8 PID: 2732 Comm: insmod Not tainted 5.1.0-rc1-00002-gab1a0e9200b8-dirty #102
>> [  152.354712] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
>> [  152.373058] pstate: 80000005 (Nzcv daif -PAN -UAO)
>> [  152.382675] pc : logic_outb+0x54/0xb8
>> [  152.390017] lr : f71882fg_find+0x64/0x390 [f71882fg]
>> [  152.399977] sp : ffff000013393aa0
>> [  152.406618] x29: ffff000013393aa0 x28: ffff000008b98b10
>> [  152.417278] x27: ffff000013393df0 x26: 0000000000000100
>> [  152.427938] x25: ffff801f8c872d30 x24: ffff000011420000
>> [  152.438598] x23: ffff801fb49d2940 x22: ffff000011291000
>> [  152.449257] x21: 000000000000002e x20: 0000000000000087
>> [  152.459917] x19: ffff000013393b44 x18: ffffffffffffffff
>> [  152.470577] x17: 0000000000000000 x16: 0000000000000000
>> [  152.481236] x15: ffff00001127d6c8 x14: ffff801f8cfd691c
>> [  152.491896] x13: 0000000000000000 x12: 0000000000000000
>> [  152.502555] x11: 0000000000000003 x10: 0000801feace2000
>> [  152.513215] x9 : 0000000000000000 x8 : ffff841fa654f280
>> [  152.523874] x7 : 0000000000000000 x6 : 0000000000ffc0e3
>> [  152.534534] x5 : ffff000011291360 x4 : ffff801fb4949f00
>> [  152.545194] x3 : 0000000000ffbffe x2 : 76e767a63713d500
>> [  152.555853] x1 : ffff7dfffee0002e x0 : ffff7dfffee00000
>> [  152.566514] Process insmod (pid: 2732, stack limit = 0x(____ptrval____))
>> [  152.579968] Call trace:
>> [  152.584863]  logic_outb+0x54/0xb8
>> [  152.591506]  f71882fg_find+0x64/0x390 [f71882fg]
>> [  152.600768]  f71882fg_init+0x38/0xc70 [f71882fg]
>> [  152.610031]  do_one_initcall+0x5c/0x198
>> [  152.617723]  do_init_module+0x54/0x1b0
>> [  152.625237]  load_module+0x1dc4/0x2158
>> [  152.632752]  __se_sys_init_module+0x14c/0x1e8
>> [  152.641490]  __arm64_sys_init_module+0x18/0x20
>> [  152.650404]  el0_svc_common+0x5c/0x100
>> [  152.657919]  el0_svc_handler+0x2c/0x80
>> [  152.665433]  el0_svc+0x8/0xc
>> [  152.671202] Code: d2bfdc00 f2cfbfe0 f2ffffe0 8b000021 (39000034)
>> [  152.683434] ---[ end trace fd4f35b610829a48 ]---
>> Segmentation fault
>> root@(none)$
>
> Please remove the timestamps (because they don't contribute useful
> information) and indent the example a couple spaces (which is
> conventional for quoted material).

ok

>
>> Note that the f71882fg driver correctly calls request_muxed_region().
>>
>> This issue was originally reported in [1].
>>
>> This patch changes the functionality of request{muxed_}_region() to
>> request a region from a direct child descendent of the top
>> ioport_resource.
>>
>> In this, if the IO port region has not been mapped for a particular IO
>> region, the PCI IO resource would also not have been inserted, and so a
>> suitable child region will not exist. As such,
>> request_{muxed_}region() calls will fail.
>>
>> A side note: there are many drivers in the kernel which fail to even call
>> request_{muxed_}region() prior to IO port accesses, and they also need to
>> be fixed (to call request_{muxed_}region(), as appropriate) separately.
>>
>> [1] https://www.spinics.net/lists/linux-pci/msg49821.html
>
> Please use a https://lore.kernel.org/ URL instead of spinics.net.

ok, I hope that I can find this old thread.

>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---

Thanks!

>>  include/linux/ioport.h | 12 +++++++++---
>>  kernel/resource.c      | 28 ++++++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+), 3 deletions(-)
>>

Leaving remaing text as a reference.

>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index da0ebaec25f0..d7b7e1e08291 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -217,19 +217,25 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
>>
>>
>>  /* Convenience shorthand with allocation */
>> -#define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
>> -#define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
>> +#define request_region(start,n,name)		__request_region_from_children(&ioport_resource, (start), (n), (name), 0)
>> +#define request_muxed_region(start,n,name)	__request_region_from_children(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
>>  #define __request_mem_region(start,n,name, excl) __request_region(&iomem_resource, (start), (n), (name), excl)
>>  #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name), 0)
>>  #define request_mem_region_exclusive(start,n,name) \
>>  	__request_region(&iomem_resource, (start), (n), (name), IORESOURCE_EXCLUSIVE)
>>  #define rename_region(region, newname) do { (region)->name = (newname); } while (0)
>>
>> -extern struct resource * __request_region(struct resource *,
>> +extern struct resource *__request_region(struct resource *,
>>  					resource_size_t start,
>>  					resource_size_t n,
>>  					const char *name, int flags);
>>
>> +extern struct resource *__request_region_from_children(struct resource *,
>> +					resource_size_t start,
>> +					resource_size_t n,
>> +					const char *name, int flags);
>> +
>> +
>>  /* Compatibility cruft */
>>  #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
>>  #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index 92190f62ebc5..87ed200eda8b 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -1097,6 +1097,34 @@ resource_size_t resource_alignment(struct resource *res)
>>
>>  static DECLARE_WAIT_QUEUE_HEAD(muxed_resource_wait);
>>
>> +/**
>> + * __request_region_from_children - create a new busy region from a child
>> + * @parent: parent resource descriptor
>> + * @start: resource start address
>> + * @n: resource region size
>> + * @name: reserving caller's ID string
>> + * @flags: IO resource flags
>> + */
>> +struct resource *__request_region_from_children(struct resource *parent,
>> +						resource_size_t start,
>> +						resource_size_t n,
>> +						const char *name, int flags)
>> +{
>> +	struct resource *res = __request_region(parent, start, n, name, flags);
>> +
>> +	if (res && res->parent == parent) {
>> +		/*
>> +		 * This is a direct descendent of the parent, which is
>> +		 * what we didn't want.
>> +		 */
>> +		__release_region(parent, start, n);
>> +		res = NULL;
>> +	}
>> +
>> +	return res;
>> +}
>> +EXPORT_SYMBOL(__request_region_from_children);
>> +
>>  /**
>>   * __request_region - create a new busy resource region
>>   * @parent: parent resource descriptor
>> --
>> 2.17.1
>>
>
> .
>


