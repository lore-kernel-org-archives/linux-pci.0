Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6B344DBE
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370390; cv=none; b=L2HQKD58Pgwejxa7nfMbZ5Cb0WOpzK/fZGtrKVx6s62LujQHpJAD11p77JQ8w+lPbEvmw/oSxX/5LU75vLefrs+7eOF3U4kxTdOkq0whOuTfGcOJQRdciMTlLpCAz+zpP95RoZMH99CjgAl+yBP9TPD4/wxjX7o8wS8nJuN6BzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370390; c=relaxed/simple;
	bh=Ddp8gdV7b/YGz8c5J+oogvikAZJWJvRSRvSQ3OKmrNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dr2C6SJ3Es/AhcJBUl/SlSk3EdO9p5b1NdWCIqMdEqqkQm3KRayEcnPtRHf9E5c6l2+R8VeGkq+g2yUSpc4Wp+Ik4mRVivpT6RvTlvsdXxAjMzU+dLj04J2+wBz3kouKoPsISM+LRm8x32sP3IEq2IVFUIC0kCyCpIN7LBSrv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UO4ax2AN; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UO4ax2AN"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1LjnOU7jZgv2+sEGPg3yMjcsa0TNQcRAVnoTPeSBY4Y=;
	b=UO4ax2AN4SmKkkq+Q+QBqCWvFnnfoUnOLwh+ntx+1i6/JYWlpVa53jJ9TJNUcdcHrx+pobiYm
	AxOBaG5e15cJGb97HSbnb+zVPbbPBgSG4zHrZnUbn5zScGwJ4qioRBh0yk7QY3pR/Co9Txc0Myp
	uJt8SEo+CfDeNT7wdgRTAa4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fX86Y6GrDzpSw3;
	Fri, 13 Mar 2026 10:47:49 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C74A2022B;
	Fri, 13 Mar 2026 10:53:04 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 10:53:03 +0800
Message-ID: <3214ce2b-d4d2-407f-bf8a-9b524d0191b7@huawei.com>
Date: Fri, 13 Mar 2026 10:53:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about the cpu_uid parameter of acpi_evaluate_dsm() in
 PCI/TPH
To: Wei Huang <wei.huang2@amd.com>, "VanTassell, Eric"
	<Eric.VanTassell@amd.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "wangzhou1@hisilicon.com"
	<wangzhou1@hisilicon.com>, "wanghuiqiang@huawei.com"
	<wanghuiqiang@huawei.com>, liuyonglong <liuyonglong@huawei.com>,
	<linux-pci@vger.kernel.org>
References: <6fcb2596-0139-4023-8492-542956f376ea@huawei.com>
 <d435d988-5535-48d1-9819-8ee218a8501c@amd.com>
 <662df479-1971-4763-b1fb-864be9f992b5@huawei.com>
 <b83c3d0b-2e40-440b-befa-8cc2983b3e12@amd.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <b83c3d0b-2e40-440b-befa-8cc2983b3e12@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 1/8/2026 5:09 AM, Wei Huang wrote:
> 
> 
> On 1/6/26 7:21 PM, fengchengwen wrote:
>> Hi Wei,
>>
>> On 1/7/2026 4:57 AM, Huang2, Wei wrote:
>>> On 12/23/25 8:58 PM, fengchengwen wrote:
>>>> Hi Wei, Eric,
>>>>
>>>> I noticed that you submitted a commit [1] that supports PCI/TPH. We want to evaluate
>>>> whether this feature is supported on the Kunpeng platform. Currently, we have
>>>> encountered a problem. Please confirm it. Thank you.
>>>>
>>>>
>>>> The problem:
>>>> 1. In pcie_tph_get_cpu_st() function, the input parameter cpu_uid is directly
>>>>    transferred to the dsm method as the ACPI parameter.
>>>>     int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>>>> 			unsigned int cpu_uid, u16 *tag)
>>>>     {
>>>>     	...
>>>> 	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
>>>> 		*tag = 0;
>>>> 		return -EINVAL;
>>>> 	}
>>>>     	...
>>>>     }
>>>>     static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
>>>> 				  union st_info *st_out)
>>>>     {
>>>>     	...
>>>> 	/* DWORD: target UID */
>>>> 	arg3[1].integer.type = ACPI_TYPE_INTEGER;
>>>> 	arg3[1].integer.value = cpu_uid;
>>>>         ...
>>>> 	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 7,
>>>> 				    TPH_ST_DSM_FUNC_INDEX, &in_obj);
>>>>     }
>>>
>>> Correct. According to _DSM ECN, the input is defined as: "If the target
>>> is a processor, then this field represents the ACPI Processor UID of the
>>> processor as specified in the MADT. If the target is a processor
>>> container, then this field represents the ACPI Processor UID of the
>>> processor container as specified in the PPTT"
>>>
>>>> 2. In the Broadcom driver implementation [2], cpu_uid is obtained based on
>>>>    cpumask_first(irq->cpu_mask), the returned value is the logical ID of a CPU core,
>>>>    which is generated and managed by the Linux kernel. E.g. [0,255] if the system has
>>>>    256 logical CPU core.
>>>
>>> Correct.
>>>
>>>> 3. In order to obtain ST (steer-tag), we need to get physical core info (e.g. MPIDR in
>>>>    Kunpeng platform), The problem is how does the ACPI know the physical core info
>>>>    corresponding to the logical ID of the CPU core? The ACPI don't know how the logical
>>>>    ID definition.
>>>
>>> This was a problem we encountered. "Fortunately" the mapping between
>>> logic ID and ACPI _UID is similar on AMD platform. We didn't encounter
>>> too many issues in this area.
>>
>> Okay, so for AMD platform, the logic ID equal ACPI_UID, so there is no need to convert
>> the logic ID to ACPI_UID (as we see in the code the cpu_uid was directly passed to dsm).
>>
>>>
>>>> 4. One of my guess is that ACPI reports the SRAT table and reports the system CPU core
>>>>    information in sequence. Is it based on this sequence to search for the corresponding
>>>>    physical core information in the ACPI when process above DSM method?
>>>
>>> So you don't seem to be concerned with logic_id <=> acpi_uid. Instead,
>>> you want to know how does ACPI convert the acpi_uid into a corresponding
>>> phys_id when it receives an _DSM call, right? If this is the case, I
>>
>> Yes, there are two part:
>> 1) The first is PCI driver convert logic_id to acpi_uid.
>>    Because the logic_id may not equal acpi_uid in Kunpeng platform,
>>    This is our biggest puzzle, but it's clear now: we need another patch
>>    do the converation if following _DSM ECN.
> 
> Let me know your findings on Kunpeng platform. If there is a need to tweak code for this area, we can do it together.
> 
>> 2) The ACPI convert acpi_uid to it's phy_id(e.g. MPIDR)
>>
>>> think system firmware already knows about it. If you look at MADT table,
>>> which is also available on ARM platform, the Type 0xB processor
>>> structure should already have such info.
>>
>> Yes, the MADT table seemed could do that.
>>
>>
>> Thank you for your clarification.
>>
>> Currently, this feature only support in host kernel, from your slide [1], your team was
>> developing TPH virtualization, do you have any public channels (like slack) that we can
>> participate in?
> 
> Yes, a prototype was completed. I have a code base sitting in a private github tree. Give me a bit time to clean up and I will share it with you and the public as soon as possible (ping me if it lags behind).

Kindly ping.

I am not clear about the specific solution. I guess your changes might involve vfio-pci and qemu.
Could you please send the modifications to vfio-pci for review first, so that the host userspace
(such as DPDK) can also move forward based on this?

Thanks

> 
>>
>> We also want to enable this feature in DPDK, ps: it already has such commit [2] but seemed has no progress.
>>
> 
> I was aware of this code, but didn't follow closely. Let me forward it to AMD related team and maybe they can help to test and push it forward.
> 
>> [1] https://lpc.events/event/19/contributions/2249/attachments/1919/4103/SDCI_TPH_LPC_2025_Slides_Final.pdf
>> [2] https://mails.dpdk.org/archives/dev/2025-June/318908.html
>>
>>

