Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF39368D74;
	Tue, 12 May 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578877; cv=none; b=p0z3FsYlqhJ5nit23UaBsAvA0WQ1jOtCNNoYPfB8kWzP8RxbE/TvJHGfhRTXfSHA3zYS5WPR0yv3TbRXqAL93ZFif1j6dE4MjQoqJ8hwJ7MoOaWgYo2N5oj3NlmYOd+Vg9/FII5vhEh1N0UmiAlGePNiuaC8Fesr+7YOBtIbKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578877; c=relaxed/simple;
	bh=TD/uQhYfNNqbky60IjTXxfu97cQkBJ5T6wq4GPz9nXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F8cIZ48RLTD+LTNVOD9rD4TeVeFMSeq0QErJKbjyInLLgMu9XCPm4tqNRzdgxT2qvuEfa2YoPfvwTcx9W86t8JeajaC2A3v63qVPxGNmpZX671RXGHapyAH42BvRZVgYyK/SXSPEXs+nXSZgTtwWEBl6m1uWn7lD8TQxxrPO6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=q1tZh0OB; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="q1tZh0OB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QO2skF3KWzQFNvi0eIWisVr5Y3H4Gn9xx4M6GfAxYy4=;
	b=q1tZh0OBa4Rm8eMWTNgDOdWsdVqbcUgeYhLuofIc/cQ55r4D2zQGWKicET5ur/2Pxnav0sLDP
	3i4CBQu9i+jBM3FMcPb4gKalkeZAsaeKPGIaP09dwNzoSilXztjaP4LNBMGZcXO9U1ruATLPYj5
	L5qxnILWsEkswl2/K+pgT0A=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gFBGs5Wyyz1T4G1;
	Tue, 12 May 2026 17:33:25 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id B6477201E9;
	Tue, 12 May 2026 17:41:05 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 17:41:05 +0800
Message-ID: <d515105c-d206-41ff-8e78-63d42ae38af3@huawei.com>
Date: Tue, 12 May 2026 17:41:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] vfio/pci: Add PCIe TPH interface with capability
 query
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260508064053.37529-1-fengchengwen@huawei.com>
 <20260508064053.37529-5-fengchengwen@huawei.com>
 <20260508164003.70918c0c@shazbot.org>
 <f1f11651-c86d-47a9-974c-da0b3d423657@huawei.com>
 <20260510223626.0ba9dc0b@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260510223626.0ba9dc0b@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Hi Alex,

Thank you for the detailed and insightful review. I agree with your points and have addressed them in the v9 patchset I just sent.

In v9:
- We use only VFIO_DEVICE_FEATURE for TPH ST management, with no custom ioctl.
- The interface supports contiguous index/count batches as you suggested.
- No redundant op field; set/get is handled by the feature flags.
- The TPH security model is simplified to a single module parameter.
- All your UAPI suggestions have been fully implemented.

For userspace reference, the DPDK counterpart patch that uses this new interface is available here:
https://patchwork.dpdk.org/project/dpdk/patch/20260512092302.23735-2-fengchengwen@huawei.com/

Please review the v9 when you have a chance.
Thanks again for your guidance!

Thanks,
Chengwen

On 5/11/2026 12:36 PM, Alex Williamson wrote:
> On Sat, 9 May 2026 11:28:03 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
>> On 5/9/2026 6:40 AM, Alex Williamson wrote:
>>> On Fri, 8 May 2026 14:40:50 +0800
>>> Chengwen Feng <fengchengwen@huawei.com> wrote:
>>>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>>>> index 0c771064c0b8..40bf5aa9fd0b 100644
>>>> --- a/drivers/vfio/pci/vfio_pci.c
>>>> +++ b/drivers/vfio/pci/vfio_pci.c
>>>> @@ -60,6 +60,12 @@ static bool disable_denylist;
>>>>  module_param(disable_denylist, bool, 0444);
>>>>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
>>>>  
>>>> +#ifdef CONFIG_PCIE_TPH
>>>> +static bool enable_unsafe_tph_ds_mode;
>>>> +module_param(enable_unsafe_tph_ds_mode, bool, 0444);
>>>> +MODULE_PARM_DESC(enable_unsafe_tph_ds_mode, "Enable UNSAFE TPH device-specific (DS) mode. This mode provides weak isolation, cannot be safely used for virtual machines. If you do not know what this is for, step away. (default: false)");
>>>> +#endif
>>>> +  
>>>
>>> Why is the "unsafe" aspect of this keyed on mode rather than storage
>>> location?
>>>
>>> Currently the user cannot enable TPH, the capability is read-only, but
>>> the user does have direct access to the MSI-X table.  We rely on an
>>> agreement that the user needs to use SET_IRQS to allocate host vectors
>>> and we use interrupt remapping as protection against abuse, but there's
>>> no mediation of STs written directly to the MSI-X table.  If the device
>>> supports IV mode with ST in the MSI-X table, nothing prevents the user
>>> from writing those ST entries directly to the MSI-X table.  Therefore
>>> doesn't it have the same security concern as DS mode?  
>>
>>
>> Agree, from this perspective, even if it is in MSI-X table, it is still unsafe.
>> So TPH is unsafe as a whole, not just DS mode.
>>
>>>
>>> Further, config space lives in the device and various devices are known
>>> to have alternate means for accessing their config space.
>>> Virtualization of config space is more to present the device in the VM
>>> address space and bridge features between guest and host.  It's not
>>> great as a security barrier.
>>>
>>> Maybe it's really neither the mode nor storage location, and we need to
>>> decide if TPH as a whole introduces any new security considerations.  
>>
>> I will adjust the module parameter to control TPH globally instead of
>> only DS mode.
> 
> I'm not convinced that's the right solution either.  It's a usage
> barrier if the TPH capability isn't exposed R/W, but does it guarantee
> the device won't make use of such TLPs anyway?  If the device has
> config space backdoors or can otherwise be manipulated to send these
> hints, a vfio-pci module option is just security theater.  It's also a
> burden for users and for each variant driver for devices supporting TPH.
> 
> We do however need to consider how changing the behavior of the
> capability affects existing users, like QEMU.  We may need to consider
> two device features, one that only supports SET with no payload to
> enable virtualized access to the TPH capability and another that
> provides the ST handling interface.
> 
>>> It seems arguable whether we can actually prevent a device from
>>> including arbitrary STs on TLPs in any case and maybe we're really
>>> only exposing a curated programming interface.
>>>
>>> ...  
>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>> index 5de618a3a5ee..81da2bd0c21b 100644
>>>> --- a/include/uapi/linux/vfio.h
>>>> +++ b/include/uapi/linux/vfio.h  
>>
>> ...
>>
>>>> +#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)
>>>> +  
>>>
>>> This seems like the wrong shape to me and introduces yet another
>>> ioctl multiplexer.  We already have that via the device feature
>>> interface. I'd propose this only needs one new DEVICE_FEATURE
>>> ioctl, TPH_ST.  The uAPI would look like:
>>>
>>> struct vfio_device_feature_tph_st {
>>> 	__u32 flags;
>>> #define VFIO_TPH_ST_MEM_TYPE_PM	(1 << 0)
>>> 	__u16 index;
>>> 	__u16 count;
>>> 	__u32 data[]; /* host CPU# on SET, ST value on GET */
>>> }
>>>
>>> The user can SET multiple STs at once that have the same mem_type
>>> (assuming that's a reasonable limitation).  On SET, each {cpu#,  
>>
>> Agree, using the same mem_type for a batch is a good idea.
>>
>> Because it could set multiple index, so how about:
>>
>> struct vfio_pci_tph_entry {
>> 	__u32 cpu;
>> 	__u16 val;	/* ST index on SET, ST value on GET */
>> 	__u16 reserved;
>> }
> 
> In the structure I proposed the user can set/get contiguous index
> ranges according to index and count, where the data field can then just
> be a u32 array.  Why does the user need to be able to set/get
> arbitrary, non-contiguous indexes?
> 
> In a VM use case we'd likely be trapping individual writes, therefore
> we'd be intercepting one index at a time.
>  
>> struct vfio_device_feature_tph_st {
>> 	__u32 op;
>> #define VFIO_TPH_OP_GET_ST	0
>> #define VFIO_TPH_OP_SET_ST	1
> 
> The vfio device feature interface already handles set/get, we don't
> need this.
> 
>> 	__u32 flags;
>> #define VFIO_TPH_ST_MEM_TYPE_PM	(1 << 0)
>> 	__u16 count;
>> 	__u16 reserved1;
>> 	struct vfio_pci_tph_entry ents[];
>> }
>>
>>> mem_type} is translated to a host value and stored internally.  A
>>> GET  
>>
>> Should we store internally? How about writing directly to the device?
> 
> Perhaps we should, but I think we need a flag to indicate whether we're
> virtualizing a write to hardware (capability or MSI-X table) or SET'ing
> an index that userspace will later retrieve for DS mode via GET.
> Otherwise we don't know until the mode bits are written which location,
> if any, the capability is actually using.  For example the device can
> support either MSI-X or capability locations, but enable DS mode.  For
> consistency though, it might make sense to write to an internal table
> regardless.  Thanks,
> 
> Alex

