Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8823D12CDA5;
	Wed, 17 Jun 2026 02:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663642; cv=none; b=qPRT0bXJMfqnU0CmQVEK4uVXzcTMJPxpQh/YncHJvlK2V2oYPdZeH92byrb3G1qTpM6FvlQYvKTJVXhwZO0iAulA4m9r5/zWV6COKYGH3UMWdxak3WSOmzhrDlUnZ26mPXShcDGdBxx2RHHN4t0QlYmSKPJj7i4WIyNZPnVk+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663642; c=relaxed/simple;
	bh=Ak9X7zSEfU+j/q4AqpyIuwAwKvY+FIig8V8wuRVclj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OhE9EpG5fcsgpAmjq4S/bk1lIqpqJvLZBR+puT2fCRDL/l2509oPexvlYrahxlQ6b4sIAsrsUJhKiZN/hZsE9sKCF84hDmxMhdJewiQgs+knA00teQYgWhvAJmwwYps6SKtwLONgKvlh9KrXsX8WcYJSS4V+WRCcDv8JFNWRqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HOcwI0ew; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HOcwI0ew"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KA1mZuTqS2IqKIfdtfvtz1bVOfDlv3v1wkmz8B0CnqA=;
	b=HOcwI0ewAjB7DB0HNINdCWnAYg8l1geH+1kLhZYzFL7esO0Vods4fQel2d6ic5B+cV/ctoips
	HYhVSFkIlFu0dSWyo4iw+iwQ/8yPgJ8QqWndPEbO427m55jPDw6QPgsw74imWtdeHzV1t3DnAfX
	A8LgnBf+HfceBlSffaKr9NM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gg7525Drxz1K9dS;
	Wed, 17 Jun 2026 10:25:58 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C0A6F40563;
	Wed, 17 Jun 2026 10:33:55 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 10:33:55 +0800
Message-ID: <e2db72ab-6d51-4d19-8dba-0612207008a3@huawei.com>
Date: Wed, 17 Jun 2026 10:33:54 +0800
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
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <a81c3479-1749-4b9b-b913-cfb20c621690@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 6/17/2026 9:30 AM, Alex Williamson wrote:
> On Tue, Jun 16, 2026, at 7:18 PM, fengchengwen wrote:
>> Hi Jason, Alex,
>>
>> On 6/17/2026 1:27 AM, Jason Gunthorpe wrote:
>>> On Tue, Jun 16, 2026 at 10:57:54AM -0600, Alex Williamson wrote:
>>>
>>>> IMO, this implementation in sysfs more so proves that vfio is the wrong
>>>> place for the interface.  vfio has a use case to consume STs, but it
>>>> doesn't produce them or own any of the mechanism by which they're
>>>> generated.  
>>>
>>> I would argue only a VFIO user can consume this information so putting
>>> it in general sysfs is overkill.
>>>
>>>> The weak point is whether this bin attribute, exposing an array of
>>>> structures, fits within the socially acceptable norms of sysfs.  
>>>
>>> I'm pretty sure this style of sysfs is not accepted and
>>> counter-examples are things that are ancient or slipped through.
>>
>> After weighing all feedback, I'd like to propose a lightweight single 
>> text sysfs node
>> design to resolve both your concerns, without introducing binary 
>> binattr or masses
>> of per-CPU files:
>>
>> 1. Only create a single r/w text attribute “tph_cpu_st” on Root Ports, no
>>    hundreds of separate per-CPU sysfs files;
>> 2. Usage flow: echo target cpu_id into the file first, then cat it to fetch
>>    formatted human-readable ST/XST text line (cpu_id vm_st vm_xst pm_st pm_xst)
>>    for that CPU, e.g.
>>       echo 10 > /sys/bus/pci/devices/<BDF>/tph_cpu_st
>>       cat /sys/bus/pci/devices/<BDF>/tph_cpu_st
>>       and the output will like: 10 2 20 100 120
>>    In the case of concurrent access, users can determine whether the first value
>>    (cpu_id) is the one they expect by making a judgment.
> 
> That's a terrible workaround for an inherently racy design.  Thanks,

This is because the DSM method is slow to invoke and involves many cores. Therefore,
this trade-off is made.

I propose another lazy-cached read-only text file design:

1. Only create one read-only sysfs attribute named tph_cpu_all on Root Port
   devices, no write store hook, completely eliminate read-write race risks;
2. Lazy initialization: All CPU steering tag entries are fetched via batch
   ACPI _DSM calls only on the first userspace read operation, cached inside
   afterwards to avoid duplicate slow firmware interactions;
3. Cache invalidation only happens on Root Port PCI reset events, including
   system cold boot, AER fatal error recovery, userspace manual reset via sysfs,
   downstream hotplug and root port driver re-probe.
   No CPU hotplug notification hooks are registered to avoid extra code complexity;
4. On every sysfs read, iterate over the cached entry list and filter out
   offline CPUs according to the current online CPU mask dynamically, so
   only valid active CPU records are printed to userspace;
5. A read-write semaphore protects cached table access to support concurrent
   userspace readers safely;
6. Plain human-readable text output complies with sysfs text-first norms
   Jason prefers, no structured binary binattr is introduced;

Usage example:
   cat /sys/bus/pci/devices/<root-port-bdf>/tph_cpu_all
   the output will be: cpu_id vm_st pm_st vm_xst pm_xst
	0 0x00 0x00 0x0000 0x0000
	1 0x02 0x00 0x0005 0x0000
	2 0x01 0x00 0x0003 0x0000
	...

Thanks

> 
> Alex

