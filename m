Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049414E2F2;
	Thu,  4 Jun 2026 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538338; cv=none; b=WOKo4E6FMvMMOkVIPAR6ngiqChSrJN0kNONRv4oq66zEEocYz2fUWoT6we3fasNpknh9nuyioaI8M/1OHFlyH2eRvzkZim7WjCtDtvt7fHNrexkzYUFKJ7tek4bQGzNxmAEhLTIeg4m8xsYf8u5aOZ3PiYmliuuA+8c6rCEXbz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538338; c=relaxed/simple;
	bh=AWrk6qbRk2esWnw3BEpFRx0QX78ZU/TDTy2DZAAKbOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UdGdyzS//FXQDqoj/ItrrRl10oDjMM7D56trZTLHPikaWmH0A82CtB74HXz6HnMWp1XbwB52BSp94JwHuOxxYqR28A6gSzjpnyt4DfDGxc1y6YfbRpONG2TeWiv1OYSq9bBOWCiKRnfpH+tB3KbkvUZbbpu3YlOAm3+RIDjaSo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ipLxnOFF; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ipLxnOFF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ws99umNVRPL3Go0arWQp0vENqpuyDLVRFlp3o0o3fmk=;
	b=ipLxnOFFP5YwRilb022uk2AObESqFJt3okA5+tQ1kHV2ze/Kgls5EkhRi28Tan7i/wEOiVPal
	gc6778BVqPTyccti2A7h0+CiHMW/FhiFsatNf2MYQ49QeqxixyCZ6M9ncfnaDbj8MrkOiesdNFT
	CKlIL81A2NG5Xrz4NMkq3v4=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gW6wZ5Jg6zmV7F;
	Thu,  4 Jun 2026 09:50:54 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 52C5440571;
	Thu,  4 Jun 2026 09:58:46 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 09:58:45 +0800
Message-ID: <ef57c73e-cb9d-46bc-a04b-a168a3f279ef@huawei.com>
Date: Thu, 4 Jun 2026 09:58:45 +0800
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
 <3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>
 <20260603115828.21216c0f@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260603115828.21216c0f@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 6/4/2026 1:58 AM, Alex Williamson wrote:
> On Wed, 3 Jun 2026 08:34:53 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
> 
>> On 6/3/2026 7:08 AM, Alex Williamson wrote:
>>> On Tue, 2 Jun 2026 22:46:13 +0800
>>> fengchengwen <fengchengwen@huawei.com> wrote:  
>>>> On 6/1/2026 11:58 PM, Alex Williamson wrote:  
>>>>>
>>>>>
>>>>>  - Patch 2/ sets tph_cap to zero if TPH cannot be enabled, but this is
>>>>>    never propagated to vfio-pci to drop the TPH capability from the
>>>>>    capability chain.
>>>>>
>>>>>  - Patch 3/ exposing the enum to callers is a bit ugly, maybe we should
>>>>>    retain pci_enable_tph() as the "auto" wrapper, resulting in no
>>>>>    change to existing users, and add _ext and _std wrappers.
>>>>>
>>>>>  - Patch 4/ same, multiple wrappers keeps the "auto" api cleaner.  Also
>>>>>    note that auto is broken before TPH is enabled when tph_req_type is
>>>>>    zero.
>>>>>
>>>>>  - Patch 6/:
>>>>>    - mutex_init/destroy belong in vfio_pci_core_init_dev/release_dev()
>>>>>    - Re-order to avoid forward declarations.
>>>>>    - vfio_check_feature() does not require declaring PROBE as a
>>>>>      supported op.
>>>>>    - pcie_tph_set_st_entry() can write to MMIO space without testing
>>>>>      for or enabling device memory or power state.
>>>>>    - tph_init allocates shadow table regardless of opt-in for tph
>>>>>      support.
>>>>>    - Redundant tests for count/index in feature function.
>>>>>    - Duplicate memcpy/kfree in feature function.
>>>>>
>>>>>  - Patch 7/:
>>>>>    - Unclear why it's vfio-pci's responsibility to provide this
>>>>>      translation interface.
>>>>>    - PROBE is unnecessary for vfio_check_feature().
>>>>>    - Array size conversion is strange.
>>>>>
>>>>>  - Patch 8/:
>>>>>    - default config read handles emulated bits.  Clear the bit if
>>>>>      necessary in vconfig, use p_setd() to mark PCI_TPH_CAP_EXT_TPH
>>>>>      virtualized, read-only.
>>>>>    - Follow examples like vfio_pm_config_write, vfio_vpd_config_write,
>>>>>      vfio_exp_config_write, etc.  Set the virtualized and writable
>>>>>      bits, perform default config write, evaluate if anything was
>>>>>      enabled, effect the change in hardware via kernel APIs.
>>>>>    - pcie_disable_tph() happens after the restore state is recorded.
>>>>>    - TPH capability becomes read/write, an ABI change to the user, with
>>>>>      only a host-based opt-in.  Seems like the userspace driver also
>>>>>      needs to opt-in to the ABI change.
>>>>>    - Memory enable not assured for pcie_tph_set_st_entry().
>>>>>    - Sashiko notes there are existing hazards in the tph_enabled
>>>>>      storage unit relative to multiple bitfields that can be updated
>>>>>      concurrently.  The problem is worse with this exposed through
>>>>>      vfio-pci.    
>>>>
>>>> Thanks for review, all your comments are resolved in v15:  
>>>
>>> Not everything.  At a glance I can see that v15 is still pushing for
>>> vfio-pci to provide the interface to translate CPU IDs to steering
>>> tags, despite my push back above that it doesn't seem within vfio-pci's
>>> scope to provide a CPU ID -> ST interface.  
>>
>> This translation helper is required to handle varied TPH configurations,
>> including cases where ST entries live inside device private registers
>> instead of MSI-X or TPH capability space.
>>
>> Prior discussion with Jason (
>> ref: https://lore.kernel.org/all/20260414151125.GF2577880@ziepe.ca/)
>> indicated VFIO-PCI is the correct component for per-device TPH
>> implementation.
>>
>> Production high-speed NICs from multiple vendors rely on this CPU-to-ST
>> mapping logic for DPDK optimized polling I/O; removing this helper would
>> render the whole TPH userspace control feature unusable for existing
>> target workloads.
>>
>> Therefore, I believe it is appropriate to support it.
> 
> The citation is only describing that vfio should provide a way to
> program the steering tags.  That's not the issue I'm raising.

Sorry, it's my fault. The interface from CPU to ST is strongly related to
the user-space usage of TPH. If we place it in something like sysfs, it
might not be focused, so it's placed here.

> 
> The proposed uAPI has morphed from one where the user provides CPU IDs,
> which are translated to STs and written to the device or returned to
> support device specific implementations, to one where raw STs are used.
> 
> I think this was a result of my question of how this interface
> integrates with the concurrently proposed interface where drivers can
> expose TPH values for a dmabuf.  Suddenly the user is managing raw TPH
> values and what used to be an integrated feature of performing CPU ID
> to ST value, with necessary ugliness of exposing that raw ST value for
> device specific support, becomes largely a standalone translation
> interface, which might be more generically implemented elsewhere in the
> kernel.  It largely loses any direct association to the vfio aspect of
> the device.
> 
> The interface now looks more like one where raw STs are provided to
> vfio-pci through various sources.  It then becomes unclear why vfio-pci
> itself is necessarily one of those sources.

According to section 7.5.3.15 in the PCIe protocol, "TPH Completer Supported
- Value indicates Completer support for TPH or Extended TPH. Applicable only
to Root Ports and Endpoints." This means that the steering-tag can be sent to
the host CPU or another device (that is, in the P2P scenario).

It is considered that the current implementation is flexible, and it can handle
both of the preceding two scenarios.
- For the stash to the host CPU, the steering-tag value can be obtained through
  the CPU_ST.
- For the stash to another device, the steering-tag value can be obtained in other
  ways (non-kernel mode).

Once the steering-tag value is obtained, the following question arises: how to
write the value to the device?
- If the device supports the standard ST table (for example, in the configuration
  space or MSI-X table), the ST_CONFIG interface is called to write the value.
- If the device does not support the standard ST table, the driver completes the
  operation by itself.

I will add this PCIe-spec based design description into v16 cover letter.

> 
>>> The host-only opt-in issue above also doesn't appear to be addressed or
>>> rebutted.  
>>
>> enable_unsafe_tph host opt-in already fully gates all new TPH ABI:
>> TPH cap + feature ioctl are completely hidden from userspace when off,
>> no userspace opt-in needed.
> 
> I'd argue that opt-in on the host doesn't mean we should ignore the ABI
> change to userspace.  There's an entire virtualization stack that needs
> to be built on this change, intercepting writes to the TPH control
> register, MSI-X vectors, and capability ST entries.  The host opt-in is
> a global switch, it might enable your userspace driver, but it might
> also break QEMU, where writes to the TPH capability had been dropped
> previously.  A per instance opt-in, gated by the host opt-in, allows
> seamless integration of the new feature.

Fully understand, I will:

- Introduce new VFIO_DEVICE_FEATURE_TPH_ENABLE as per-device opt-in; each
  vfio_pci_device defaults tph_abi_enable = false.
- With enable_unsafe_tph disabled globally: TPH cap remains read-only, all
  new TPH feature ops are hidden completely, consistent with legacy kernel.
- When enable_unsafe_tph is enabled but userspace does not SET this new
  feature: TPH capability keeps read-only, all guest writes to TPH_CTRL are
  silently dropped same as original implementation, existing QEMU runs with
  zero modification and no regression.
- Only after userspace explicitly SET VFIO_DEVICE_FEATURE_TPH_ENABLE on
  specific device: TPH_CTRL gets WRITE permission and full TPH uAPIs become
  available for that single device.

> 
>>> Typically v15 would be an indication that a series is coming to
>>> maturity, but with the quick cadence and lack of discussion throughout
>>> this development, I'm not even sure we've arrived at a proper uAPI for
>>> this feature.  Thanks,  
>>
>> Sorry for sending frequent quick updates without leaving adequate window
>> for list review.
>>
>> This feature originates from an earlier ARM prototype posted last year for
>> DPDK TPH acceleration scenarios. Based on that foundational exploration,
>> this series has refined the interface through continuous upstream review
>> feedback.
>>
>> All recent rapid iterations are code improvements and review fixes.
> 
> The issue is that feedback like above is represented as if it's been
> addressed and changelogs are scant on details, requiring significant,
> repeated effort to understand the actual changes between iterations.
> The issues raised and interface design require discussion, not simply
> assertions that it's correct and addressed.  Thanks,

I apologize for sparse changelog content and insufficient design discussion
along quick version iterations. Starting from v16 submission:
- Slow down patch posting cadence and reserve enough time for community
  design discussion before sending new revision.
- Enrich detailed per-patch changelog items to explicitly list every review
  induced UAPI and code modification for easier tracking.

Thanks

> 
> Alex

