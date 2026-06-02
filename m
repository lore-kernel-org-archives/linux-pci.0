Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381E32142B;
	Tue,  2 Jun 2026 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411578; cv=none; b=tRj/yeLp68wWWWsdiLiS3IjOPmNxQbDZ6AMJvKzvCzooCMiU/TJykIAi4PJZb6Q0seQSkocFc2WiSLMv3W10OzD+JRxfa9hnZNB77CC2yH3aJvVVLz9z8+J2vnLt5xa32Hre8ystj9JoveXiUxD588fywKKm2Z/PuTf6zLC4MNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411578; c=relaxed/simple;
	bh=yPuT24pTgM930tMGXEijNuqym7rFhbCeTahhG0J3W2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sE3+/n7I/olhCfAyj2EplBG5xOYmcar//aPV9kRtprQ0QJGeo3q+vBgk3HrC3ydVi2CHXpou18ocpx9g7E//s+4zJWC0C8G0MfqQG5GHwDzMAHLJ3Uo5iyZi3hO5F27Amm4QPJJSFaE3ieHqMQgiSGnAckUtQuvFl0Wt+by6OXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lXD4NyzL; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lXD4NyzL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MHGoKu5qPFdFfnQIPDL214r7TSVR6hhJbEEg2apeXzM=;
	b=lXD4NyzLDFEsnNv8BqMFLxQA88zPfZoQqZQZG8FCDQ3eTbe66K6LzHXm/TxUzLZwLxPEqycl7
	/zUipaKIK8MLjFdFHdyd0ZbbwRyS+OSXCEIuqVJpaLCuC4gThZgirRfMvW4cf26oOqH6jc5w/cx
	0ppMtogARHzwfhuP4TEtPEA=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gVD333JtfzmV7c;
	Tue,  2 Jun 2026 22:38:23 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A2D040565;
	Tue,  2 Jun 2026 22:46:14 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 22:46:13 +0800
Message-ID: <59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
Date: Tue, 2 Jun 2026 22:46:13 +0800
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
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260601095840.3aaaa508@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Hi Alex,

On 6/1/2026 11:58 PM, Alex Williamson wrote:
> On Thu, 28 May 2026 20:46:41 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> This patchset enables userspace control over PCIe TPH steering tags,
>> motivated by the following considerations:
>>
>> 1. Why userspace needs the capability to control steering tags:
>>    When PCIe devices are fully owned by userspace workloads such as DPDK
>>    and SPDK, only userspace has full knowledge of core binding policies
>>    and traffic distribution strategies. Without this series, userspace
>>    cannot enable TPH or configure steering tags, leaving built-in PCIe
>>    performance optimizations unused in high-throughput polling I/O
>>    scenarios.
>>
>> 2. Why this interface must be implemented in VFIO:
>>    VFIO is the standard, secure community solution for granting full
>>    PCIe device ownership to userspace. Existing kernel TPH interfaces
>>    are designed purely for in-kernel drivers. For user-owned devices,
>>    VFIO provides the only isolated and correct path to expose per-device
>>    TPH management.
>>
>> TPH supports both IV and DS modes. Since both modes could introduces
>> cross-VM isolation risks such as untrusted guests programming arbitrary
>> steering tags to impact other domains:
>> 1. If ST location in MSI-X table, untrusted guests may program the
>>    MSI-X table.
>> 2. If ST don't locate in MSI-X or CAP, untrusted guests may program the
>>    device-specific register.
>> So a new module parameter `enable_unsafe_tph` is added. It defaults to
>> off, and blocks all unsafe TPH operations when disabled.
>>
>> Based on earlier RFC work by Wathsala Vithanage
>>
>> ---
>> v14:
>> - Return PCI_TPH_LOC_NONE when !CONFIG_PCIE_TPH accord Alex's comment
>> - Fix Sashiko comments:
>>   - Clear ST shadow state across user session
>>   - Fix out-of-bounds byte masking in vfio_pci_tph_config_read
>> v13:
>> - Fix Alex's comments:
>>   - Add virtualize of TPH request type
>>   - Adopt two feature
> 
> 
>  - Patch 2/ sets tph_cap to zero if TPH cannot be enabled, but this is
>    never propagated to vfio-pci to drop the TPH capability from the
>    capability chain.
> 
>  - Patch 3/ exposing the enum to callers is a bit ugly, maybe we should
>    retain pci_enable_tph() as the "auto" wrapper, resulting in no
>    change to existing users, and add _ext and _std wrappers.
> 
>  - Patch 4/ same, multiple wrappers keeps the "auto" api cleaner.  Also
>    note that auto is broken before TPH is enabled when tph_req_type is
>    zero.
> 
>  - Patch 6/:
>    - mutex_init/destroy belong in vfio_pci_core_init_dev/release_dev()
>    - Re-order to avoid forward declarations.
>    - vfio_check_feature() does not require declaring PROBE as a
>      supported op.
>    - pcie_tph_set_st_entry() can write to MMIO space without testing
>      for or enabling device memory or power state.
>    - tph_init allocates shadow table regardless of opt-in for tph
>      support.
>    - Redundant tests for count/index in feature function.
>    - Duplicate memcpy/kfree in feature function.
> 
>  - Patch 7/:
>    - Unclear why it's vfio-pci's responsibility to provide this
>      translation interface.
>    - PROBE is unnecessary for vfio_check_feature().
>    - Array size conversion is strange.
> 
>  - Patch 8/:
>    - default config read handles emulated bits.  Clear the bit if
>      necessary in vconfig, use p_setd() to mark PCI_TPH_CAP_EXT_TPH
>      virtualized, read-only.
>    - Follow examples like vfio_pm_config_write, vfio_vpd_config_write,
>      vfio_exp_config_write, etc.  Set the virtualized and writable
>      bits, perform default config write, evaluate if anything was
>      enabled, effect the change in hardware via kernel APIs.
>    - pcie_disable_tph() happens after the restore state is recorded.
>    - TPH capability becomes read/write, an ABI change to the user, with
>      only a host-based opt-in.  Seems like the userspace driver also
>      needs to opt-in to the ABI change.
>    - Memory enable not assured for pcie_tph_set_st_entry().
>    - Sashiko notes there are existing hazards in the tph_enabled
>      storage unit relative to multiple bitfields that can be updated
>      concurrently.  The problem is worse with this exposed through
>      vfio-pci.

Thanks for review, all your comments are resolved in v15:

- Patch2: Hide TPH capability in vfio ext cap chain when TPH unsupported
  via vfio_ext_cap_len returning zero.
- Patch3/4: Preserve original pcie_enable_tph() auto API intact, add
  _explicit helper for vfio; fix auto enable corner case with zero req_type.
- Patch6: relocate tph init/destroy to core init/release dev, remove redundant
  PROBE, range check, duplicate kfree; add power check for set_st_entry; shadow
  allocated only with host opt-in + hw TPH present.
- Patch7: drop redundant translation helper, unused PROBE, weird array size
  conversion.
- Patch8: emulate EXT_TPH bit via vconfig + p_setd readonly; follow standard
  vfio config write flow(vconfig first then hw sync); reorder disable_tph after
  save_state; new TPH ABI gated solely by host-side enable_unsafe_tph; add
  pre-write device state check.

v15 posted for further review.

Thanks

> 
> Thanks,
> Alex

