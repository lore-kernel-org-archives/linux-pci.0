Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AD3A381C;
	Thu,  9 Jul 2026 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598195; cv=none; b=oA8gwNaimqk0xVYgdkgZDnkrnWFOCbj51Ii78JyapAP3K+XpFKT8ZW0vZTlPqzFNB4nlZr5uekwUQ7uwAZ1iZlrVlR2Fv7dGUTLqTK+EBqJvJOMrMJwP1kP18Ni40MtSBBXrH0idqrqoRdczOaEeIeSf5L/x6AEG38HbWwEobzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598195; c=relaxed/simple;
	bh=qvsyr3S0XdCwFibEQqhLX/EoaOs2fc1lL3GepgyBAqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XJc4jupCJtTI3o+kb1AqMKb+rCsVzog8YpJ6gaPeVeTto4jfFgazoUpyVRG+dW7GBRCYi4v6x4km6k+7lxmThyO10xQy4oMoF54lSxk3Jy8pGHX8LzMobt/rE3X1GSagrtk++H66sIrAkFqjMB63rRoFzJUcYgAFXh41AOD/YDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aXMO65W/; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aXMO65W/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kwnm1bkmZyvgtZIMwLdwcwo9Qy9Vt6QNIkHJWDSVBZA=;
	b=aXMO65W/On5kg1eGkltwndqZ8SDc9+haV8d4oRA6HxtYGuOdSthcrhW7x6M6+o0EKuZKOc/tb
	kIqSseDnlP9Rg0bjjmHv2ju0P/rAb5owJ/gyqj/RQecgtue0a7/T5pOW2MYjRic6zlOmPJS+8n1
	KLUoVINjpq8GcMy/tPO/aIk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gwtVK3VL2z1prLD;
	Thu,  9 Jul 2026 19:47:05 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 3154740579;
	Thu,  9 Jul 2026 19:56:22 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 19:56:21 +0800
Message-ID: <548acc4a-c9c2-458e-8f0a-0822f7a7c2ab@huawei.com>
Date: Thu, 9 Jul 2026 19:56:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/18] vfio/pci: Introduce VFIO_DEVICE_FEATURE_TPH
 family uapi for PCI TPH control
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-14-fengchengwen@huawei.com>
 <20260708173101.236cd0b9@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708173101.236cd0b9@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 7/9/2026 7:31 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:19 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Add user API definitions for PCI TPH device feature set, including three
>> feature IDs:
>> - VFIO_DEVICE_FEATURE_TPH: Global TPH enable and capability query
>> - VFIO_DEVICE_FEATURE_TPH_RESOLVE: Resolve PH/ST from specified source
>>   (GET only)
>> - VFIO_DEVICE_FEATURE_TPH_ST: Batch program ST table entries (SET only)
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  include/uapi/linux/vfio.h | 62 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 62 insertions(+)
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5de618a3a5ee..ed04b6280cd6 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1534,6 +1534,68 @@ struct vfio_device_feature_dma_buf {
>>   */
>>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>  
>> +/* PCIe TPH device feature definitions for VFIO_DEVICE_FEATURE ioctl */
>> +#define VFIO_DEVICE_FEATURE_TPH		13
>> +#define VFIO_DEVICE_FEATURE_TPH_RESOLVE	14
>> +#define VFIO_DEVICE_FEATURE_TPH_ST	15
>> +
>> +/*
>> + * VFIO_DEVICE_FEATURE_TPH - Control and query PCI TPH capabilities
>> + *
>> + * SET: Opt-in to TPH feature; flags must be zero.
> 
> We clearly need to define what it actually means to opt-in, as this
> series is not implementing it as it should be defined.  The user needs
> to opt-in via this feature before we modify the device ABI in any way.
> The extent to which the user may enable TPH features is bound both by
> the device capabilities and the module parameters set by the system
> admin.

I will add full documentation describing the mandatory opt-in rule: users
must call SET on this feature before any TPH virtualization or TPH_RESOLVE/
TPH_ST ioctl access is allowed. Without opt-in, TPH config space registers
remain raw read-only and related TPH feature ioctls return -ENOTSUPP.
Also clarify the dual capability bound: exposed TPH functions are limited by
both hardware native TPH capability and host-wide tph module policy.

> 
>> + * GET: Return supported TPH capability bits in flags.
>> + */
>> +struct vfio_device_feature_tph {
>> +	__u32 flags;
>> +};
>> +
>> +/* Capability bits returned by GET on VFIO_DEVICE_FEATURE_TPH */
>> +#define VFIO_DEVICE_TPH_CAP_DMABUF	(1u << 0) /* DMABUF sources resolvable */
>> +#define VFIO_DEVICE_TPH_CAP_CPU		(1u << 1) /* CPU sources resolvable via _DSM */
>> +#define VFIO_DEVICE_TPH_CAP_LITERAL	(1u << 2) /* LITERAL ST source supported */
>> +
>> +/*
>> + * VFIO_DEVICE_FEATURE_TPH_RESOLVE - Resolve PH/ST tag value from source
>> + * Note: GET only
>> + */
>> +struct vfio_device_feature_tph_resolve {
>> +	__u32 flags;	/* IN: source type + namespace modifiers */
>> +	__u32 src;	/* IN: dma-buf fd or CPU ID based on flags */
>> +	__u8 valid;	/* OUT: bitmap indicating valid output fields */
>> +#define VFIO_DEVICE_TPH_VALID_PH (1u << 0) /* ph holds valid processing hint */
>> +#define VFIO_DEVICE_TPH_VALID_ST (1u << 1) /* st holds valid steering tag */
>> +	__u8 ph;	/* OUT: TPH processing hint */
>> +	__u16 st;	/* OUT: raw steering tag value */
>> +};
>> +
>> +/*
>> + * VFIO_DEVICE_FEATURE_TPH_ST - Batch program architected ST table entries
>> + * Return value: number of successfully written entries
>> + * Note: SET only
>> + */
>> +struct vfio_device_feature_tph_st {
>> +	__u32 flags;		/* IN: source type + namespace modifiers */
>> +	__u16 start;		/* IN: first ST table index / MSI-X vector */
>> +	__u16 count;		/* IN: number of contiguous entries to program */
>> +	__aligned_u64 dests;	/* IN: user pointer to array of source u32 values */
>> +};
>> +
>> +/* Common flags shared by TPH_RESOLVE and TPH_ST features */
>> +#define VFIO_DEVICE_TPH_SRC_NONE           (1u << 0) /* TPH_ST only: set ST=0 */
>> +#define VFIO_DEVICE_TPH_SRC_DMABUF	   (1u << 1) /* src = dma-buf fd */
>> +#define VFIO_DEVICE_TPH_SRC_CPU_VOLATILE   (1u << 2) /* src = volatile memory CPU ID */
>> +#define VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT (1u << 3) /* src = persistent memory CPU ID */
>> +#define VFIO_DEVICE_TPH_SRC_LITERAL        (1u << 4) /* TPH_ST only: src = raw literal ST */
>> +#define VFIO_DEVICE_TPH_EXTENDED           (1u << 30) /* Use extended 16-bit ST namespace */
>> +#define VFIO_DEVICE_TPH_REQUIRE_ST         (1u << 31) /* TPH_ST only: fail if resolved ST=0 */
> 
> I don't see the value in jumping to the end of the flags field for
> these last two.  Adding DMABUF is a good change from the proposal, but
> I wouldn't go out of our way to try to preserve some grouping of source
> flags from modifiers.

I will move VFIO_DEVICE_TPH_EXTENDED and VFIO_DEVICE_TPH_REQUIRE_ST down
from bits 30/31 to lower unused positions, remove artificial separation
between source-type flags and modifier flags for cleaner grouping.
> 
> We also seem to have avoided any statement or decision to what extent
> our uAPI is defined by the current implementation.  Particularly the
> ordering of TPH_ST versus manipulating the control bits in config space
> are entirely undefined here.
> 
> We're also not addressing that the TPH_ST policy counters the overall
> feature policy to return 0/-errno and not updating the documentation to
> bring that to the forefront.  Thanks,

Two undefined behaviors will be explicitly documented:
- Execution order and priority between VFIO_DEVICE_FEATURE_TPH_ST batch
  programming and direct userspace writes to TPH_CTRL config registers;
- Error return rules when requested operation exceeds current tph_policy
  level (Literal mode blocked under policy <= 2 returns -ENOTSUPP).

Both will be fix in v20.

Thanks

> 
> Alex
> 
>> +
>> +/* Mask for mutually exclusive source type bits, only one may be set */
>> +#define VFIO_DEVICE_TPH_SRC_MASK	(VFIO_DEVICE_TPH_SRC_NONE | \
>> +					 VFIO_DEVICE_TPH_SRC_DMABUF | \
>> +					 VFIO_DEVICE_TPH_SRC_CPU_VOLATILE | \
>> +					 VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT | \
>> +					 VFIO_DEVICE_TPH_SRC_LITERAL)
>> +
>>  /* -------- API for Type1 VFIO IOMMU -------- */
>>  
>>  /**
> 

