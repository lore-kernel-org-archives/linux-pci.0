Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5385C10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 10:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91320830
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 10:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfDIKjB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:39:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfDIKjA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Apr 2019 06:39:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B4F0FDA63F2C9846DED6;
        Tue,  9 Apr 2019 18:38:56 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
 18:38:45 +0800
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
To:     Will Deacon <will.deacon@arm.com>
References: <20190404164130.GA12203@roeck-us.net>
 <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
 <20190404174336.GA10404@roeck-us.net> <20190404185815.GA26522@google.com>
 <2d0f583a-cabe-df4e-ad89-c1800d9b4804@huawei.com>
 <20190405180615.GB109021@google.com> <20190405182923.GA11563@roeck-us.net>
 <ec054678-ce9e-bd5c-5225-a025214f1075@huawei.com>
 <9be8d131-d1d5-cc97-26fe-e32fe30c0544@roeck-us.net>
 <efff6e58-b48d-f168-ed92-1714f5a08292@huawei.com>
 <20190408165001.GD7872@fuggles.cambridge.arm.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <arnd@arndb.de>, <rafael@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <andy.shevchenko@gmail.com>, <catalin.marinas@arm.com>,
        <bp@suse.de>, <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <574d4ce0-b2e3-c598-ce12-cefa4ddb98e8@huawei.com>
Date:   Tue, 9 Apr 2019 11:38:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190408165001.GD7872@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>>>>
>>>> To me, it's not good that these hwmon, watchdog, gpio, etc drivers
>>>> make unconstrained accesses to 0x2e and 0x4e ports (ignoring the
>>>> request_muxed_region() call).
>>>>
>>>> The issue I see is that on an arm, IO space for some other device may
>>>> be mapped in this region, so it would not be right for these drivers
>>>> to access those same regions.
>>>>
>>> Yes, but then there _could_ be some arm or arm64 device supporting one
>>> of those chips,
>>> so we can not just add something like "depends on !(ARM || ARM64)".
>>
>> This looks like what has been added for PPC in commmit 746cdfbf01c0.
>>
>> However, agreed, it's not a good approach.
>>
>>>
>>>> Is there any other platform check which can be made to ensure that
>>>> accesses these super-IO ports is appropriate?
>>>>
>>>
>>> Not that I know of. It would make some sense to provide API functions
>>> for Super-IO accesses, but that would be a lot of work, and I guess
>>> it isn't really valuable enough for anyone to pick up and do.
>>>
>>> Normally, if you have such a system, the respective drivers should not be
>>> built. After all, this isn't the only instance where drivers
>>> unconditionally
>>> access some io region, no matter if the underlying hardware exists or not.
>>> The only real defense against that is to not build those drivers into
>>> a given kernel.
>>
>> If we're going to support a multi-plaform kernel for a given arch, then we
>> can't always avoid it.
>>
>> It seems that the only solution on the table now is to discard these IO port
>> accesses on arm64 when the IO port are not mapped.
>
> Hmm, how are you going to achieve that? I'm not sure we can guarantee a
> synchronous abort, so I'd be nervous about anything that tries to handle
> the exception after making the unmapped access.
>

Patches 2+3 in this series are the attempt to solve it.

The solution is not in handling an abort generated in accessing the 
unmapped region, but rather avoiding any potential abort and just 
discard the access if the region is unmapped. This is done in the IO 
port accessors, by checking if a PCI host has registered a region in 
"logical PIO" space.

For more info on logical PIO space, see commits 031e3601869c ("lib: Add 
generic PIO mapping method") and 5745392e0c2b ("PCI: Apply the new 
generic I/O management on PCI IO hosts").

In these patches, I add a check in memory-mapped IO port region accesses 
to ensure that a PCI host has registered a region, i.e. IO ports are mapped.

With these patches, we now get the following on an arm64 system with no 
PCI host:

root@(none)$ insmod hwmon/f71882fg.ko
[   30.950909] LOGIC PIO: PIO entry token 0x2e invalid
[   30.955795] LOGIC PIO: PIO entry token 0x2e invalid
[   30.960664] LOGIC PIO: PIO entry token 0x2e invalid
[   30.965531] LOGIC PIO: PIO entry token 0x2f invalid
[   30.970398] LOGIC PIO: PIO entry token 0x2e invalid
[   30.975264] LOGIC PIO: PIO entry token 0x2f invalid
[   30.980131] LOGIC PIO: PIO entry token 0x2e invalid
[   30.984997] LOGIC PIO: PIO entry token 0x4e invalid
[   30.989864] LOGIC PIO: PIO entry token 0x4e invalid
[   30.994730] LOGIC PIO: PIO entry token 0x4e invalid
[   30.999596] LOGIC PIO: PIO entry token 0x4f invalid
[   31.004463] LOGIC PIO: PIO entry token 0x4e invalid
[   31.009329] LOGIC PIO: PIO entry token 0x4f invalid
[   31.014195] LOGIC PIO: PIO entry token 0x4e invalid
insmod: can't insert 'hwmon/f71882fg.ko': No such device
root@(none)$

Note: I've removed a WARN_ONCE from the patches for this experiment. 
Maybe I'll permanently remove.

Without the patches:

root@(none)$ insmod hwmon/f71882fg.ko
[   82.001270] Unable to handle kernel paging request at virtual address 
ffff7dfffee0002e
[   82.009194] Mem abort info:
[   82.011980]   ESR = 0x96000046
[   82.015025]   Exception class = DABT (current EL), IL = 32 bits
[   82.020934]   SET = 0, FnV = 0
[   82.023978]   EA = 0, S1PTW = 0
[   82.027108] Data abort info:
[   82.029975]   ISV = 0, ISS = 0x00000046
[   82.033800]   CM = 0, WnR = 1
[   82.036757] swapper pgtable: 4k pages, 48-bit VAs, pgdp = 
(____ptrval____)
[   82.043620] [ffff7dfffee0002e] pgd=000000000141c003, 
pud=000000000141d003, pmd=0000000000000000
[   82.052309] Internal error: Oops: 96000046 [#1] PREEMPT SMP
[   82.057867] Modules linked in: f71882fg(+)
[   82.061953] CPU: 10 PID: 2731 Comm: insmod Not tainted 
5.1.0-rc1-00003-g938306ea0c86-dirty #230
[   82.070637] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon 
D05 IT21 Nemo 2.0 RC0 04/18/2018
[   82.079754] pstate: 80000005 (Nzcv daif -PAN -UAO)
[   82.084538] pc : logic_outb+0x54/0xb8
[   82.088188] lr : f71882fg_find+0x64/0x390 [f71882fg]
[   82.093139] sp : ffff000026a1baa0
[   82.096439] x29: ffff000026a1baa0 x28: ffff000008b98b10
[   82.101738] x27: ffff000026a1bdf0 x26: 0000000000000100
[   82.107037] x25: ffff801fb5391530 x24: ffff000011420000
[   82.112335] x23: ffff801fb68a3700 x22: ffff000011291000
[   82.117634] x21: 000000000000002e x20: 0000000000000087
[   82.122932] x19: ffff000026a1bb44 x18: ffffffffffffffff
[   82.128230] x17: 0000000000000000 x16: 0000000000000000
[   82.133528] x15: ffff00001127d6c8 x14: 0000000000000000
[   82.138826] x13: 0000000000000000 x12: 0000000000000000
[   82.144124] x11: ffff801ffbf92c80 x10: 0000801fead0f000
[   82.149422] x9 : 0000000000000000 x8 : ffff841fa6403680
[   82.154721] x7 : 0000000000000000 x6 : 000000000000003f
[   82.160019] x5 : ffff000011291360 x4 : 0000000000000000
[   82.165318] x3 : 0000000000ffbffe x2 : eed92a7132399200
[   82.170616] x1 : ffff7dfffee0002e x0 : ffff7dfffee00000
[   82.175915] Process insmod (pid: 2731, stack limit = 0x(____ptrval____))
[   82.182601] Call trace:
[   82.185035]  logic_outb+0x54/0xb8
[   82.188338]  f71882fg_find+0x64/0x390 [f71882fg]
[   82.192943]  f71882fg_init+0x38/0xc70 [f71882fg]
[   82.197548]  do_one_initcall+0x5c/0x198
[   82.201372]  do_init_module+0x54/0x1b0
[   82.205107]  load_module+0x1dc4/0x2158
[   82.208843]  __se_sys_init_module+0x14c/0x1e8
[   82.213186]  __arm64_sys_init_module+0x18/0x20
[   82.217618]  el0_svc_common+0x5c/0x100
[   82.221353]  el0_svc_handler+0x2c/0x80
[   82.225089]  el0_svc+0x8/0xc
[   82.227957] Code: d2bfdc00 f2cfbfe0 f2ffffe0 8b000021 (39000034)
[   82.234038] ---[ end trace 57421eeb25dcc011 ]---
Segmentation fault
root@(none)$

@Guenter, sorry for citing a hwmon driver again as triggering a crash...

John


> Will
>
> .
>


