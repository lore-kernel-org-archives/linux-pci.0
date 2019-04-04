Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53513C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158912082E
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfDDQwz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:52:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbfDDQwz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Apr 2019 12:52:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2259BAFA273A0D07A216;
        Fri,  5 Apr 2019 00:52:52 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 00:52:43 +0800
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
To:     Guenter Roeck <linux@roeck-us.net>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
 <1554393602-152448-4-git-send-email-john.garry@huawei.com>
 <20190404164130.GA12203@roeck-us.net>
CC:     <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <bp@suse.de>,
        <wangkefeng.wang@huawei.com>, <linuxarm@huawei.com>,
        <andy.shevchenko@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
Date:   Thu, 4 Apr 2019 17:52:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190404164130.GA12203@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/04/2019 17:41, Guenter Roeck wrote:
> On Fri, Apr 05, 2019 at 12:00:01AM +0800, John Garry wrote:
>> Currently when accessing logical indirect PIO addresses in
>> logic_{in, out}{,s}, we first ensure that the region is registered.
>>
>> However, no such check exists for CPU MMIO regions. The CPU MMIO regions
>> would be registered by the PCI host - when PCI_IOBASE is defined - in
>> pci_register_io_range().
>>
>> We have seen scenarios when systems which don't have a PCI host or, they
>> do, and the PCI host probe fails, that certain devices attempts to still
>> attempt to access PCI IO ports; examples are in [1] and [2].
>>
>> And even though we should protect against this by ensuring the driver
>> calls request_{muxed_}region(), some don't do this:
>>
>> root@(none)$ insmod hwmon/f71805f.ko
>>  Unable to handle kernel paging request at virtual address ffff7dfffee0002e
>>  Mem abort info:
>>    ESR = 0x96000046
>>    Exception class = DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>  Data abort info:
>>    ISV = 0, ISS = 0x00000046
>>    CM = 0, WnR = 1
>>  swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>>  [ffff7dfffee0002e] pgd=000000000141c003, pud=000000000141d003, pmd=0000000000000000
>>  Internal error: Oops: 96000046 [#1] PREEMPT SMP
>>  Modules linked in: f71805f(+)
>>  CPU: 20 PID: 2736 Comm: insmod Not tainted 5.1.0-rc1-00003-g6f1bfec2a620-dirty #99
>>  Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
>>  pstate: 80000005 (Nzcv daif -PAN -UAO)
>>  pc : logic_outb+0x54/0xb8
>>  lr : f71805f_find+0x2c/0x1b8 [f71805f]
>>  sp : ffff000025fbba90
>>  x29: ffff000025fbba90 x28: ffff000008b944d0
>>  x27: ffff000025fbbdf0 x26: 0000000000000100
>>  x25: ffff801f8c270580 x24: ffff000011420000
>>  x23: ffff000025fbbb3e x22: ffff000025fbbb40
>>  x21: ffff000008b991b8 x20: 0000000000000087
>>  x19: 000000000000002e x18: ffffffffffffffff
>>  x17: 0000000000000000 x16: 0000000000000000
>>  x15: ffff00001127d6c8 x14: 0000000000000000
>>  x13: 0000000000000000 x12: 0000000000000000
>>  x11: 0000000000010820 x10: 0000841fdac40000
>>  x9 : 0000000000000001 x8 : 0000000040000000
>>  x7 : 0000000000210d00 x6 : 0000000000000000
>>  x5 : ffff801fb6a46040 x4 : ffff841febeaeda0
>>  x3 : 0000000000ffbffe x2 : ffff000025fbbb40
>>  x1 : ffff7dfffee0002e x0 : ffff7dfffee00000
>>  Process insmod (pid: 2736, stack limit = 0x(____ptrval____))
>>  Call trace:
>>   logic_outb+0x54/0xb8
>>   f71805f_find+0x2c/0x1b8 [f71805f]
>>   f71805f_init+0x38/0xe48 [f71805f]
>>   do_one_initcall+0x5c/0x198
>>   do_init_module+0x54/0x1b0
>>   load_module+0x1dc4/0x2158
>>   __se_sys_init_module+0x14c/0x1e8
>>   __arm64_sys_init_module+0x18/0x20
>>   el0_svc_common+0x5c/0x100
>>   el0_svc_handler+0x2c/0x80
>>   el0_svc+0x8/0xc
>>  Code: d2bfdc00 f2cfbfe0 f2ffffe0 8b000021 (39000034)
>>  ---[ end trace 10ea80bde051bbfc ]---
>> root@(none)$
>>
>> Note that the f71805f driver does not call request_{muxed_}region(), as it
>> should.
>>

Hi Guenter,

> ... which is the real problem, one that is not solved by this patch. This may
> result in parallel and descructive accesses if there is another device on the
> LPC bus, and another driver accessing that device. Personally I'd rather have
> request_muxed_region() added to the f71805f driver.

Right, we should and will still fix f71805f. If you recall, I did have 
the f71805f fix in the v1 series, but you committed that it was 
orthogonal, so I decided to take it out of this work for now.

And even if we fix up f71805f and other known drivers which don't call 
request_muxed_region(), we still need to police against these rogue 
accesses, which is what this patch attempts to do.

Thanks,
John

>
> Guenter
>
>> This patch adds a check to ensure that the CPU MMIO region is registered
>> prior to accessing the PCI IO ports.
>>
>> [1] https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
>> [2] https://lore.kernel.org/linux-arm-kernel/e6995b4a-184a-d8d4-f4d4-9ce75d8f47c0@huawei.com/
>>
>> This patch includes some other tidy-up.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>  lib/logic_pio.c | 103 +++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 75 insertions(+), 28 deletions(-)
>>
>> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
>> index 431cd8d99236..3d8d986e9dcb 100644
>> --- a/lib/logic_pio.c
>> +++ b/lib/logic_pio.c
>> @@ -193,95 +193,135 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
>>
>>  #if defined(PCI_IOBASE)
>>  #if defined(CONFIG_INDIRECT_PIO)
>> +#define INVALID_RANGE(range)						\
>> +	(!(range) || ((range)->flags == LOGIC_PIO_INDIRECT && !(range)->ops))
>> +
>>  #define BUILD_LOGIC_IO(bw, type)					\
>>  type logic_in##bw(unsigned long addr)					\
>>  {									\
>>  	type ret = (type)~0;						\
>> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
>> +									\
>> +	if (INVALID_RANGE(range)) {					\
>> +		WARN_ON_ONCE(1);					\
>> +		return ret;						\
>> +	}								\
>>  									\
>>  	if (addr < MMIO_UPPER_LIMIT) {					\
>>  		ret = read##bw(PCI_IOBASE + addr);			\
>>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
>> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
>>  		size_t sz = sizeof(type);				\
>> +		void *hostdata = range->hostdata;			\
>>  									\
>> -		if (entry && entry->ops)				\
>> -			ret = entry->ops->in(entry->hostdata, addr, sz);\
>> -		else							\
>> -			WARN_ON_ONCE(1);				\
>> +		if (range->ops->in)					\
>> +			ret = range->ops->in(hostdata, addr, sz);	\
>>  	}								\
>>  	return ret;							\
>>  }									\
>>  									\
>> -void logic_out##bw(type value, unsigned long addr)			\
>> +void logic_out##bw(type val, unsigned long addr)			\
>>  {									\
>> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
>> +									\
>> +	if (INVALID_RANGE(range)) {					\
>> +		WARN_ON_ONCE(1);					\
>> +		return;							\
>> +	}								\
>> +									\
>>  	if (addr < MMIO_UPPER_LIMIT) {					\
>> -		write##bw(value, PCI_IOBASE + addr);			\
>> +		write##bw(val, PCI_IOBASE + addr);			\
>>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
>> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
>>  		size_t sz = sizeof(type);				\
>> +		void *hostdata = range->hostdata;			\
>>  									\
>> -		if (entry && entry->ops)				\
>> -			entry->ops->out(entry->hostdata,		\
>> -					addr, value, sz);		\
>> -		else							\
>> -			WARN_ON_ONCE(1);				\
>> +		if (range->ops->out)					\
>> +			range->ops->out(hostdata, addr, val, sz);	\
>>  	}								\
>>  }									\
>>  									\
>>  void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
>>  {									\
>> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
>> +									\
>> +	if (INVALID_RANGE(range)) {					\
>> +		WARN_ON_ONCE(1);					\
>> +		return;							\
>> +	}								\
>> +									\
>>  	if (addr < MMIO_UPPER_LIMIT) {					\
>>  		reads##bw(PCI_IOBASE + addr, buf, cnt);			\
>>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
>> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
>>  		size_t sz = sizeof(type);				\
>> +		void *hostdata = range->hostdata;			\
>>  									\
>> -		if (entry && entry->ops)				\
>> -			entry->ops->ins(entry->hostdata,		\
>> -				addr, buf, sz, cnt);			\
>> -		else							\
>> -			WARN_ON_ONCE(1);				\
>> +		if (range->ops->ins)					\
>> +			range->ops->ins(hostdata, addr, buf, sz, cnt);	\
>>  	}								\
>> -									\
>>  }									\
>>  									\
>>  void logic_outs##bw(unsigned long addr, const void *buf,		\
>>  		    unsigned int cnt)					\
>>  {									\
>> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
>> +									\
>> +	if (INVALID_RANGE(range)) {					\
>> +		WARN_ON_ONCE(1);					\
>> +		return;							\
>> +	}								\
>> +									\
>>  	if (addr < MMIO_UPPER_LIMIT) {					\
>>  		writes##bw(PCI_IOBASE + addr, buf, cnt);		\
>>  	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
>> -		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
>>  		size_t sz = sizeof(type);				\
>> +		void *hostdata = range->hostdata;			\
>>  									\
>> -		if (entry && entry->ops)				\
>> -			entry->ops->outs(entry->hostdata,		\
>> -				addr, buf, sz, cnt);			\
>> -		else							\
>> -			WARN_ON_ONCE(1);				\
>> +		if (range->ops->outs)					\
>> +			range->ops->outs(hostdata, addr, buf, sz, cnt);	\
>>  	}								\
>>  }
>>
>>  #else /* CONFIG_INDIRECT_PIO */
>>
>> +#define INVALID_RANGE(range) (!(range))
>> +
>>  #define BUILD_LOGIC_IO(bw, type)					\
>>  type logic_in##bw(unsigned long addr)					\
>>  {									\
>>  	type ret = (type)~0;						\
>> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
>> +									\
>> +	if (INVALID_RANGE(range)) {					\
>> +		WARN_ON_ONCE(1);					\
>> +		return ret;						\
>> +	}								\
>>  									\
>>  	if (addr < MMIO_UPPER_LIMIT)					\
>>  		ret = read##bw(PCI_IOBASE + addr);			\
>>  	return ret;							\
>>  }									\
>>  									\
>> -void logic_out##bw(type value, unsigned long addr)			\
>> +void logic_out##bw(type val, unsigned long addr)			\
>>  {									\
>> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
>> +									\
>> +	if (INVALID_RANGE(range)) {					\
>> +		WARN_ON_ONCE(1);					\
>> +		return;							\
>> +	}								\
>> +									\
>>  	if (addr < MMIO_UPPER_LIMIT)					\
>> -		write##bw(value, PCI_IOBASE + addr);			\
>> +		write##bw(val, PCI_IOBASE + addr);			\
>>  }									\
>>  									\
>>  void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
>>  {									\
>> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
>> +									\
>> +	if (INVALID_RANGE(range)) {					\
>> +		WARN_ON_ONCE(1);					\
>> +		return;							\
>> +	}								\
>> +									\
>>  	if (addr < MMIO_UPPER_LIMIT)					\
>>  		reads##bw(PCI_IOBASE + addr, buf, cnt);			\
>>  }									\
>> @@ -289,6 +329,13 @@ void logic_ins##bw(unsigned long addr, void *buf, unsigned int cnt)	\
>>  void logic_outs##bw(unsigned long addr, const void *buf,		\
>>  		    unsigned int cnt)					\
>>  {									\
>> +	struct logic_pio_hwaddr *range = find_io_range(addr);		\
>> +									\
>> +	if (INVALID_RANGE(range)) {					\
>> +		WARN_ON_ONCE(1);					\
>> +		return;							\
>> +	}								\
>> +									\
>>  	if (addr < MMIO_UPPER_LIMIT)					\
>>  		writes##bw(PCI_IOBASE + addr, buf, cnt);		\
>>  }
>> --
>> 2.17.1
>>
>
> .
>


