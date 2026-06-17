Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80793311946;
	Wed, 17 Jun 2026 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667719; cv=none; b=ErNxhKl4SIBVg4zTGy1UP2K/TlhC+RSNHaYlyWVZLD2nvdl2qWjS2ul4UHxl7FAAbdAFb4oqKUjyS3OEK+SPQASQPXwBqlM2yLko7HlIe4olEqHEo3TsRxFuWiRdo9bQ/C65p4YbWt/SRXOF61TsOUdKfHeuTtcyq9mZiYQbW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667719; c=relaxed/simple;
	bh=SCn8FLDHc8sMf1weJgSEQeWHu8jYKgXYjU+x8Dp56I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mOfwHGmBPKUxk8SYPDY7doPa9TLLKkE+HtqC7ehMm+iEgeBbxj03CKZE5gsSPOdsNJpIoAkELaZHMT4LBY4LntGpmAyvbJsjJbz1LFGa45DQCCniS5c/NVsuJHyhlJ//4z2rPePtr7nPDHOZxpsWmgD97o+fecJvHUHGM6SEjeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=we46bD4G; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=we46bD4G; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="we46bD4G";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="we46bD4G"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bde3IvdKh1/jQawQ2o/LDGKyI55PEAEBe4eHJy1OqvA=;
	b=we46bD4GwTLTLLQ5+9czc6PxS41Ct/3FpVH9c1GIsDDHUEeFJrwlIvik+FimIytcNRyK5VJEP
	9pXD4mtNX+EctjdMQgkPthacKucKx5NZaK+0uuyODJYCLCsTN00F7rUvGmOIR4aoDlArSAr5Kej
	0nBVPGzETAQpQ6xTrqAFcU0=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gg8Zv34WYzcbPv;
	Wed, 17 Jun 2026 11:33:27 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bde3IvdKh1/jQawQ2o/LDGKyI55PEAEBe4eHJy1OqvA=;
	b=we46bD4GwTLTLLQ5+9czc6PxS41Ct/3FpVH9c1GIsDDHUEeFJrwlIvik+FimIytcNRyK5VJEP
	9pXD4mtNX+EctjdMQgkPthacKucKx5NZaK+0uuyODJYCLCsTN00F7rUvGmOIR4aoDlArSAr5Kej
	0nBVPGzETAQpQ6xTrqAFcU0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gg8Zm6J5yz1T4L9;
	Wed, 17 Jun 2026 11:33:20 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 69C7040571;
	Wed, 17 Jun 2026 11:41:51 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 11:41:50 +0800
Message-ID: <c1ae7910-6028-4dae-a462-e7464a35028f@huawei.com>
Date: Wed, 17 Jun 2026 11:41:40 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU to
 steering-tag mapping
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <helgaas@kernel.org>, <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca> <20260616105754.784be22d@shazbot.org>
 <20260616172728.GC3577091@ziepe.ca>
 <c913116a-35b4-4934-b78b-8fa0a08a00ae@huawei.com>
 <a81c3479-1749-4b9b-b913-cfb20c621690@app.fastmail.com>
 <e2db72ab-6d51-4d19-8dba-0612207008a3@huawei.com>
 <c3d7ce59-bf5e-40fc-8f0c-6232c58c7495@app.fastmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <c3d7ce59-bf5e-40fc-8f0c-6232c58c7495@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 6/17/2026 11:01 AM, Alex Williamson wrote:
> 
> 
> On Tue, Jun 16, 2026, at 8:33 PM, fengchengwen wrote:
>> On 6/17/2026 9:30 AM, Alex Williamson wrote:
>>> On Tue, Jun 16, 2026, at 7:18 PM, fengchengwen wrote:
>>>> Hi Jason, Alex,
>>>>
>>>> On 6/17/2026 1:27 AM, Jason Gunthorpe wrote:
>>>>> On Tue, Jun 16, 2026 at 10:57:54AM -0600, Alex Williamson wrote:
>>>>>
>>>>>> IMO, this implementation in sysfs more so proves that vfio is the wrong
>>>>>> place for the interface.  vfio has a use case to consume STs, but it
>>>>>> doesn't produce them or own any of the mechanism by which they're
>>>>>> generated.  
>>>>>
>>>>> I would argue only a VFIO user can consume this information so putting
>>>>> it in general sysfs is overkill.
>>>>>
>>>>>> The weak point is whether this bin attribute, exposing an array of
>>>>>> structures, fits within the socially acceptable norms of sysfs.  
>>>>>
>>>>> I'm pretty sure this style of sysfs is not accepted and
>>>>> counter-examples are things that are ancient or slipped through.
>>>>
>>>> After weighing all feedback, I'd like to propose a lightweight single 
>>>> text sysfs node
>>>> design to resolve both your concerns, without introducing binary 
>>>> binattr or masses
>>>> of per-CPU files:
>>>>
>>>> 1. Only create a single r/w text attribute “tph_cpu_st” on Root Ports, no
>>>>    hundreds of separate per-CPU sysfs files;
>>>> 2. Usage flow: echo target cpu_id into the file first, then cat it to fetch
>>>>    formatted human-readable ST/XST text line (cpu_id vm_st vm_xst pm_st pm_xst)
>>>>    for that CPU, e.g.
>>>>       echo 10 > /sys/bus/pci/devices/<BDF>/tph_cpu_st
>>>>       cat /sys/bus/pci/devices/<BDF>/tph_cpu_st
>>>>       and the output will like: 10 2 20 100 120
>>>>    In the case of concurrent access, users can determine whether the first value
>>>>    (cpu_id) is the one they expect by making a judgment.
>>>
>>> That's a terrible workaround for an inherently racy design.  Thanks,
>>
>> This is because the DSM method is slow to invoke and involves many 
>> cores. Therefore,
>> this trade-off is made.
>>
>> I propose another lazy-cached read-only text file design:
>>
>> 1. Only create one read-only sysfs attribute named tph_cpu_all on Root 
>> Port
>>    devices, no write store hook, completely eliminate read-write race 
>> risks;
>> 2. Lazy initialization: All CPU steering tag entries are fetched via 
>> batch
>>    ACPI _DSM calls only on the first userspace read operation, cached 
>> inside
>>    afterwards to avoid duplicate slow firmware interactions;
>> 3. Cache invalidation only happens on Root Port PCI reset events, 
>> including
>>    system cold boot, AER fatal error recovery, userspace manual reset 
>> via sysfs,
>>    downstream hotplug and root port driver re-probe.
>>    No CPU hotplug notification hooks are registered to avoid extra code 
>> complexity;
>> 4. On every sysfs read, iterate over the cached entry list and filter 
>> out
>>    offline CPUs according to the current online CPU mask dynamically, so
>>    only valid active CPU records are printed to userspace;
>> 5. A read-write semaphore protects cached table access to support 
>> concurrent
>>    userspace readers safely;
>> 6. Plain human-readable text output complies with sysfs text-first norms
>>    Jason prefers, no structured binary binattr is introduced;
>>
>> Usage example:
>>    cat /sys/bus/pci/devices/<root-port-bdf>/tph_cpu_all
>>    the output will be: cpu_id vm_st pm_st vm_xst pm_xst
>> 	0 0x00 0x00 0x0000 0x0000
>> 	1 0x02 0x00 0x0005 0x0000
>> 	2 0x01 0x00 0x0003 0x0000
>> 	...
> 
> This is a more complicated, more bloated, less functional version of the same array of structures problem as the bin attribute, just in ascii.  Thanks,

I fully get your criticism that dumping all CPU records as a complete table
is just a variant of the array export design and brings extra unnecessary
complexity.

Now there are only two viable options left for exposing CPU-to-ST mappings:
1. Add a struct bin_attribute on Root Ports to export the full array of CPU
   entries as binary blob;
2. Implement a new VFIO_DEVICE_FEATURE_TPH_CPU_ST feature for on-demand
   CPUs query.

Option 1 introduces a structured array binattr sysfs ABI that Jason has
explicitly stated the community no longer accepts for new additions.

For option 2, all ACPI DSM and steering tag calculation logic lives fully
within the PCI subsystem. VFIO only contains a trivial thin forwarding layer
to call the existing PCI exported helper, no platform metadata generation logic
is moved into VFIO at all. This feature acts as a native auxiliary helper for
virtualized TPH workloads.

Could you kindly reconsider option 2 ?

If the community still prefers option 1 after this discussion, I will fully
rework the binattr implementation and send out v18 following all your review
feedback.

Thanks

> 
> Alex

