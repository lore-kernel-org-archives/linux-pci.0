Return-Path: <SRS0=vxig=JG=arm.com=punit.agrawal@kernel.org>
Return-Path: <SRS0=vxig=JG=arm.com=punit.agrawal@kernel.org>
From: Punit Agrawal <punit.agrawal@arm.com>
To: Xie XiuQi <xiexiuqi@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,  Michal Hocko <mhocko@kernel.org>,  Hanjun Guo <guohanjun@huawei.com>,  Bjorn Helgaas <helgaas@kernel.org>,  <tnowicki@caviumnetworks.com>,  <linux-pci@vger.kernel.org>,  Catalin Marinas <catalin.marinas@arm.com>,  "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,  Will Deacon <will.deacon@arm.com>,  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,  Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,  <linux-mm@kvack.org>,  <wanghuiqiang@huawei.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Bjorn Helgaas <bhelgaas@google.com>,  Andrew Morton <akpm@linux-foundation.org>,  zhongjiang <zhongjiang@huawei.com>,  linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
References: <20180611145330.GO13364@dhcp22.suse.cz>
	<87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
	<87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
	<8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
	<20180619120714.GE13685@dhcp22.suse.cz>
	<874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
	<20180619140818.GA16927@e107981-ln.cambridge.arm.com>
	<87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
	<20180619151425.GH13685@dhcp22.suse.cz>
	<87r2l23i2b.fsf@e105922-lin.cambridge.arm.com>
	<20180619163256.GA18952@e107981-ln.cambridge.arm.com>
	<814205eb-ae86-a519-bed0-f09b8e2d3a02@huawei.com>
Date: Wed, 20 Jun 2018 12:51:22 +0100
In-Reply-To: <814205eb-ae86-a519-bed0-f09b8e2d3a02@huawei.com> (Xie XiuQi's
	message of "Wed, 20 Jun 2018 11:31:34 +0800")
Message-ID: <87602d3ccl.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Xie XiuQi <xiexiuqi@huawei.com> writes:

> Hi Lorenzo, Punit,
>
>
> On 2018/6/20 0:32, Lorenzo Pieralisi wrote:
>> On Tue, Jun 19, 2018 at 04:35:40PM +0100, Punit Agrawal wrote:
>>> Michal Hocko <mhocko@kernel.org> writes:
>>>
>>>> On Tue 19-06-18 15:54:26, Punit Agrawal wrote:
>>>> [...]
>>>>> In terms of $SUBJECT, I wonder if it's worth taking the original patch
>>>>> as a temporary fix (it'll also be easier to backport) while we work on
>>>>> fixing these other issues and enabling memoryless nodes.
>>>>
>>>> Well, x86 already does that but copying this antipatern is not really
>>>> nice. So it is good as a quick fix but it would be definitely much
>>>> better to have a robust fix. Who knows how many other places might hit
>>>> this. You certainly do not want to add a hack like this all over...
>>>
>>> Completely agree! I was only suggesting it as a temporary measure,
>>> especially as it looked like a proper fix might be invasive.
>>>
>>> Another fix might be to change the node specific allocation to node
>>> agnostic allocations. It isn't clear why the allocation is being
>>> requested from a specific node. I think Lorenzo suggested this in one of
>>> the threads.
>> 
>> I think that code was just copypasted but it is better to fix the
>> underlying issue.
>> 
>>> I've started putting together a set fixing the issues identified in this
>>> thread. It should give a better idea on the best course of action.
>> 
>> On ACPI ARM64, this diff should do if I read the code correctly, it
>> should be (famous last words) just a matter of mapping PXMs to nodes for
>> every SRAT GICC entry, feel free to pick it up if it works.
>> 
>> Yes, we can take the original patch just because it is safer for an -rc
>> cycle even though if the patch below would do delaying the fix for a
>> couple of -rc (to get it tested across ACPI ARM64 NUMA platforms) is
>> not a disaster.
>
> I tested this patch on my arm board, it works.

I am assuming you tried the patch without enabling support for
memory-less nodes.

The patch de-couples the onlining of numa nodes (as parsed from SRAT)
from NR_CPUS restriction. When it comes to building zonelists, the node
referenced by the PCI controller also has zonelists initialised.

So it looks like a fallback node is setup even if we don't have
memory-less nodes enabled. I need to stare some more at the code to see
why we need memory-less nodes at all then ...
