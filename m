Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439923C4FA;
	Wed,  3 Jun 2026 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780446901; cv=none; b=ApvTfvH5vEuODmx0rQVM83ys9k1FwCbcC68vl0rjr61NX6oRpq65XH2oz6ICx2s2JJc5qxntxneYA33doKYuRBDB/TGoZfArHTgj4t+crCb4cICzwcB8RVXsIL83YTL7LOH1SvLi6uw+iWpq9UjihxRSZ8Z0XWLS+7gf0RATF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780446901; c=relaxed/simple;
	bh=MpMy5Yp4Beb9pMOhlHv+mlf0JFPt14SWV8Lpr8c+tAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eob2u8IRKGGeCKg58f6gU4zruE9rBlzNGK3kEubXP6THyWt2gkpczdtzzsJOaVMKsqsDtd13PP2UEL3lSVeLymOOwfEW/nrkpR/NqK7UAP5xH1H3tFwhTpkNPvcsc7arSzVL9218Sb7VkX8KCHQfHdlcrc+85UTnwg7yJcLWass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Eo9xx0Kj; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Eo9xx0Kj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fpUsxheRKc4Ux8F3sC8Xw6FZAYMrQ57a984N8NIBuRU=;
	b=Eo9xx0KjbITqbYhqCNb0wBVoHK3175c47KX9pLQzKq0z8TdB8dPSObc5EMjX7CyqmoIYIjrQ5
	AMXh+2QYk50YPeFyOHPpxB8p0/tXX0nhjsINhE1YVwCBoPddYVuxpYE4HAErZhUVkPI9WDlnSO8
	N6bRRYcXg9H7+I3cEb757JA=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gVT6H73gQzmV7S;
	Wed,  3 Jun 2026 08:27:03 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id E8C1340563;
	Wed,  3 Jun 2026 08:34:54 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Jun 2026 08:34:54 +0800
Message-ID: <3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>
Date: Wed, 3 Jun 2026 08:34:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
 <20260601095840.3aaaa508@shazbot.org>
 <59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
 <20260602170847.75bd159d@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260602170847.75bd159d@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 6/3/2026 7:08 AM, Alex Williamson wrote:
> On Tue, 2 Jun 2026 22:46:13 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
>> On 6/1/2026 11:58 PM, Alex Williamson wrote:
>>>
>>>
>>>  - Patch 2/ sets tph_cap to zero if TPH cannot be enabled, but this is
>>>    never propagated to vfio-pci to drop the TPH capability from the
>>>    capability chain.
>>>
>>>  - Patch 3/ exposing the enum to callers is a bit ugly, maybe we should
>>>    retain pci_enable_tph() as the "auto" wrapper, resulting in no
>>>    change to existing users, and add _ext and _std wrappers.
>>>
>>>  - Patch 4/ same, multiple wrappers keeps the "auto" api cleaner.  Also
>>>    note that auto is broken before TPH is enabled when tph_req_type is
>>>    zero.
>>>
>>>  - Patch 6/:
>>>    - mutex_init/destroy belong in vfio_pci_core_init_dev/release_dev()
>>>    - Re-order to avoid forward declarations.
>>>    - vfio_check_feature() does not require declaring PROBE as a
>>>      supported op.
>>>    - pcie_tph_set_st_entry() can write to MMIO space without testing
>>>      for or enabling device memory or power state.
>>>    - tph_init allocates shadow table regardless of opt-in for tph
>>>      support.
>>>    - Redundant tests for count/index in feature function.
>>>    - Duplicate memcpy/kfree in feature function.
>>>
>>>  - Patch 7/:
>>>    - Unclear why it's vfio-pci's responsibility to provide this
>>>      translation interface.
>>>    - PROBE is unnecessary for vfio_check_feature().
>>>    - Array size conversion is strange.
>>>
>>>  - Patch 8/:
>>>    - default config read handles emulated bits.  Clear the bit if
>>>      necessary in vconfig, use p_setd() to mark PCI_TPH_CAP_EXT_TPH
>>>      virtualized, read-only.
>>>    - Follow examples like vfio_pm_config_write, vfio_vpd_config_write,
>>>      vfio_exp_config_write, etc.  Set the virtualized and writable
>>>      bits, perform default config write, evaluate if anything was
>>>      enabled, effect the change in hardware via kernel APIs.
>>>    - pcie_disable_tph() happens after the restore state is recorded.
>>>    - TPH capability becomes read/write, an ABI change to the user, with
>>>      only a host-based opt-in.  Seems like the userspace driver also
>>>      needs to opt-in to the ABI change.
>>>    - Memory enable not assured for pcie_tph_set_st_entry().
>>>    - Sashiko notes there are existing hazards in the tph_enabled
>>>      storage unit relative to multiple bitfields that can be updated
>>>      concurrently.  The problem is worse with this exposed through
>>>      vfio-pci.  
>>
>> Thanks for review, all your comments are resolved in v15:
> 
> Not everything.  At a glance I can see that v15 is still pushing for
> vfio-pci to provide the interface to translate CPU IDs to steering
> tags, despite my push back above that it doesn't seem within vfio-pci's
> scope to provide a CPU ID -> ST interface.

This translation helper is required to handle varied TPH configurations,
including cases where ST entries live inside device private registers
instead of MSI-X or TPH capability space.

Prior discussion with Jason (
ref: https://lore.kernel.org/all/20260414151125.GF2577880@ziepe.ca/)
indicated VFIO-PCI is the correct component for per-device TPH
implementation.

Production high-speed NICs from multiple vendors rely on this CPU-to-ST
mapping logic for DPDK optimized polling I/O; removing this helper would
render the whole TPH userspace control feature unusable for existing
target workloads.

Therefore, I believe it is appropriate to support it.

> 
> The host-only opt-in issue above also doesn't appear to be addressed or
> rebutted.

enable_unsafe_tph host opt-in already fully gates all new TPH ABI:
TPH cap + feature ioctl are completely hidden from userspace when off,
no userspace opt-in needed.

> 
> Typically v15 would be an indication that a series is coming to
> maturity, but with the quick cadence and lack of discussion throughout
> this development, I'm not even sure we've arrived at a proper uAPI for
> this feature.  Thanks,

Sorry for sending frequent quick updates without leaving adequate window
for list review.

This feature originates from an earlier ARM prototype posted last year for
DPDK TPH acceleration scenarios. Based on that foundational exploration,
this series has refined the interface through continuous upstream review
feedback.

All recent rapid iterations are code improvements and review fixes.

Thanks

> 
> Alex

