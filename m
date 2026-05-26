Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A700B3C09F7;
	Tue, 26 May 2026 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779776975; cv=none; b=bLoq83JyFfMSpv/AmAB5FZPkt+1lygWoCuD6y2nVTz4vh4lxS4c6SkBHWqp7PoDLtlkuqoVsaZgGq3Nr2gPsfJrGGAjutAqFRRr4Ez9znqyYoD2vezB7t6Wmq/LLKXN16EYd4vLKpDWAzsLqmup9pWGckw2urFaDqB1OBTwEIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779776975; c=relaxed/simple;
	bh=myc9srhre8R2a2/GTSs/nvUGqfo++Ll/SKMOUuaQqgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=POCx6v3boKQ6486vtL9MVFwqrCs/H83ho7RvOvvZo/IQGRYMQ28lLbgu+izeSYkUXTcNGfKR5y4/xgH+CqWyrq7irxSPt7idjix0HQ0/1LirDtvWsuxGafDdlXksor+BL1iNpD+2YbtSwnyqc+5MJ4L7VyadjC3BQAwXXLuG1ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ceBt+Vuq; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ceBt+Vuq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Um3vskZODifbfeUX6kCi4lUUt/2FPn9XXLI2b92pr4A=;
	b=ceBt+VuqqaBj/KSRKlBrJylsd3/VMfAx5/0EQHQZ13GK4xJYzODPHcLuiRG0sF+slPJNGweMl
	zcGAwmmi8n8SXpTbqKJluV4WmsM5ifyt1G6UvckgGdi2XWDvG++lhV+FB9Q1raVjFuS6mmuwykx
	vbvNeSAtSj22pnfhhFoiZOg=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gPjMd1TvvzpSvR;
	Tue, 26 May 2026 14:22:05 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 508AF20104;
	Tue, 26 May 2026 14:29:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 14:29:28 +0800
Message-ID: <4e1055e9-3e75-4cf7-a5c6-ccffe9c1b585@huawei.com>
Date: Tue, 26 May 2026 14:29:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/5] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for TPH
 ST entry management
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
 <20260518071701.25177-6-fengchengwen@huawei.com>
 <20260521221008.59ddf977@shazbot.org>
 <512bce27-13a2-44a1-aa5b-b5ea77c174ba@huawei.com>
 <20260522082730.3d843a7f@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260522082730.3d843a7f@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 5/22/2026 10:27 PM, Alex Williamson wrote:
> On Fri, 22 May 2026 18:04:13 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
> 
>> On 5/22/2026 12:10 PM, Alex Williamson wrote:
>>> On Mon, 18 May 2026 15:17:01 +0800
>>> Chengwen Feng <fengchengwen@huawei.com> wrote:
>>>   
>>>> Add VFIO_DEVICE_FEATURE_TPH_ST to allow userspace to manage PCIe TPH
>>>> Steering Tag entries.
>>>>
>>>> SET: Program contiguous ST entries when ST table resides in TPH Capability
>>>>      or MSI-X table. U32_MAX CPU ID clears the corresponding ST entry.
>>>> GET: Retrieve ST values per CPU ID, only available in DS mode.
>>>>
>>>> Both operations are only valid when TPH is enabled on the device.  
>>>
>>> What?  That doesn't align with the hardware programming model.  The
>>> specification even suggests that the device should be quiesced or TPH
>>> disabled during programming of the steering tags for deterministic
>>> behavior.  
>>
>> As mentioned in the 4/5 commit, obtaining ST must first enable TPH.
>> Of course, I think it might be necessary to calculate pdev->tph_req_type
>> during the capability detection phase, so that we can modify ST before
>> enabling TPH. Do you think such a modification is needed?
> 
> I think a uAPI that doesn't align with the recommended programming
> order of the specification, potentially resulting in non-deterministic
> behavior is bogus.
> 
>>>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>>>> ---
>>>>  drivers/vfio/pci/vfio_pci_core.c | 91 ++++++++++++++++++++++++++++++++
>>>>  include/uapi/linux/vfio.h        | 41 ++++++++++++++
>>>>  2 files changed, 132 insertions(+)
>>>>
>>>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>>>> index 0d0140202280..13a22c1d6ea6 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_core.c
>>>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>>>> @@ -1558,6 +1558,95 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
>>>> +					u32 flags,
>>>> +					struct vfio_device_feature_tph_st __user *arg,
>>>> +					size_t argsz)
>>>> +{
>>>> +	bool is_set = !!(flags & VFIO_DEVICE_FEATURE_SET);
>>>> +	struct vfio_device_feature_tph_st tph_st;
>>>> +	struct pci_dev *pdev = vdev->pdev;
>>>> +	enum tph_mem_type mtype;
>>>> +	int i, j, ret;
>>>> +	u32 *cpus;
>>>> +	u16 st;
>>>> +
>>>> +	guard(mutex)(&vdev->tph_lock);  
>>>
>>> Wrong place for this lock.  Why do we even need it?  If a user races
>>> SET/GET with enable/disable, that's their problem.  
>>
>> OK, will fix in next version

I still keep the lock which used to protect the ST table shadow

>>
>>>   
>>>> +
>>>> +	ret = vfio_check_feature(flags, argsz,
>>>> +				 VFIO_DEVICE_FEATURE_GET |
>>>> +				 VFIO_DEVICE_FEATURE_SET,
>>>> +				 sizeof(tph_st));
>>>> +	if (ret <= 0)
>>>> +		return ret;
>>>> +
>>>> +	if (!enable_unsafe_tph ||  
>>>
>>> Why did we allow the feature to be probe if it can't be used?  
>>
>> OK, will fix in next version

done in v12

>>
>>>   
>>>> +		pcie_tph_enabled_mode(pdev) == PCI_TPH_ST_NS_MODE)  
>>>
>>> Here's that ambiguity of reporting NS_MODE for disabled, but as above
>>> it's a bogus requirement.  
>>
>> OK, will fix in next version

done in v12

>>
>>>   
>>>> +		return -EOPNOTSUPP;
>>>> +	if (!is_set && pcie_tph_enabled_mode(pdev) != PCI_TPH_ST_DS_MODE)  
>>>
>>> Why?  Let the interface be symmetric that GET works regardless of mode.  
>>
>> OK, will remove the restrict

done in v12

>>
>>>   
>>>> +		return -EOPNOTSUPP;
>>>> +	if (is_set && pcie_tph_get_st_table_loc(pdev) == PCI_TPH_LOC_NONE)
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
>>>> +		return -EFAULT;
>>>> +
>>>> +	if (tph_st.count == 0 || tph_st.count > VFIO_TPH_ST_MAX_COUNT ||
>>>> +		tph_st.flags > VFIO_TPH_ST_MEM_TYPE_PM)  
>>>
>>> Wrong operation for a flags field.  
>>
>> Because currently flags only use bit0 (0-VM, 1-PM), this judge make sure
>> it will return error if userspace passing non-zero in remain bits.
> 
> This should be a mask to test undefined bits are not set, not a value
> comparison.

done in v12

> 
>>>> +		return -EINVAL;
>>>> +	if (!is_set && tph_st.index != 0)  
>>>
>>> We can only GET index 0?  Why?  
>>
>> Because GET operation don't need index, this judgment make sure
>> it will return error if userspace passing non-zero index.
> 
> The interface is not symmetric.

Referring to your suggestion, I redesigned the interface (v12).

supporting two mutually exclusive operation modes:
    1. Raw table read/write: Operate shadow ST table, sync updates to hardware
       TPH capability or MSI-X table. Failed batch write triggers entry
       rollback to keep hardware consistent.
    2. CPU ID lookup: Query translated steering tag by specified memory type,
       pure read-only without modifying ST table.

The first operation (raw table) is symmetric.

>  
>>>> +		return -EINVAL;
>>>> +	if (is_set && (tph_st.index >= VFIO_TPH_ST_MAX_COUNT ||
>>>> +		       tph_st.index + tph_st.count > VFIO_TPH_ST_MAX_COUNT))  
>>>
>>> DS can have more that 2048 steering tags.  
>>
>> I check the PCIE protocol, DS mode with ST in pcie-config or msi-x must not
>> hold > 2048 steering tags.
> 
> The MSI-X storage location is limited to 2048, but DS mode doesn't
> necessarily use either of these storage locations.
> 
>>>> +		return -EINVAL;
>>>> +
>>>> +	cpus = memdup_array_user(&arg->data, tph_st.count, sizeof(*cpus));  
>>>
>>> Use an __aligned_u64 data_uptr like iommufd does and avoid copying this
>>> into the kernel.  Isn't this steering tags, why's it named cpus?  
>>
>> we reuse the field which according your previous suggestion:
>> in GET, user pass in cpus, and vfio will feedback steering tags in cpus.
> 
> Perhaps this was over stated, but aligning to the generic uAPI name
> since it's dual-purpose would seem to make sense.
>  
>>>> +	if (IS_ERR(cpus))
>>>> +		return PTR_ERR(cpus);
>>>> +
>>>> +	mtype = tph_st.flags & VFIO_TPH_ST_MEM_TYPE_PM ? TPH_MEM_TYPE_PM :
>>>> +							 TPH_MEM_TYPE_VM;  
>>>
>>> Then why did we use two flag bits for this?  
>>
>> VFIO_TPH_ST_MEM_TYPE_PM is just one bit, could you explain the two flag bits?
> 
> My bad, I overlooked that they're both shifted by 0.  Typically we
> wouldn't define both the 0 and 1 value, only the latter.
>  
>>>> +	if (!is_set) {
>>>> +		for (i = 0; i < tph_st.count; i++) {
>>>> +			ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);  
>>>
>>> My understanding was that GET would return the translated values from a
>>> previous SET, not translate on the fly.  I think in order to support
>>> writing STs before enabling TPH, we're going to need to store them
>>> somewhere anyway so that we can push them to the correct location when
>>> TPH is enabled.  That means there a buffer for SET/GET regardless of
>>> the mode that's enabled.  
>>
>> OK, will try to fix

done in v12

>>
>>>   
>>>> +			if (ret)
>>>> +				goto out;
>>>> +			cpus[i] = st;
>>>> +		}
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < tph_st.count; i++) {
>>>> +		if (cpus[i] == U32_MAX) {
>>>> +			ret = pcie_tph_set_st_entry(pdev, tph_st.index + i, 0);  
>>>
>>> Why do we need a magic value to set it to zero?  Hardware doesn't have
>>> a "clear ST register value".  
>>
>> So you mean for SET, usespace direct passing steering-tag not cpus in this patch?
> 
> How does this work with Zhiping's series where there might be TPH values
> exposed through the dma-buf to support p2p DMA?  Where would that level
> of TPH programming occur?

My patch set has two basic functions:
1. Obtain the ST corresponding to the specified CPU.
2. Set and read the ST table.

Zhiping's patchset is used to cache the P2P data to an Lx cache in the GPU, it
include two part:
1. Set the ST corresponding to a DMABUF of the GPU (the ST is obtained in another
   way and is not in the kernel).
2. Set the ST to the ST table of the MLX NIC.

The two can be unified to some extent, as long as the following two points are met:
1. An interface is provided to obtain whether the req_tph_type is normal or extend.
   In this way, the 8-bit ST or 16-bit ST of the GPU can be selected based on the
   type.
2. An interface is provided to obtain the target ST index. In this way, the
   corresponding ST index can be directly written based on my patchset.

The following uses the setting of the ST cache stash for P2P as an example:
1. The application obtains the ST corresponding to a DMABUF of the GPU in other ways.
   The ST can be 8-bit or 16-bit or both.
2. The application calls the VFIO interface to obtain the req_tph_type supported by
   the NIC device (whether only 8-bit or 16-bit is supported).
3. The application determines which ST to be selected based on 1 and 2.
4. The application calls the interface to obtain the target ST index. This interface
   may be provided by the vendor driver.
5. The application calls the SET ST ENTRY VFIO interface to set the ST to the NIC.

>  
>>>> +			if (ret)
>>>> +				goto out;
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
>>>> +		if (ret)
>>>> +			goto out;
>>>> +		ret = pcie_tph_set_st_entry(pdev, tph_st.index + i, st);
>>>> +		if (ret)
>>>> +			goto out;  
>>>
>>> Clearly broken for DS mode.  
>>
>> For DS mode:
>> 1\ if ST table in CONFIG or MSI-X, then it could done by this way
>> 2\ if ST table not in CONFIG or MSI-X, then it only need invoke GET, and set by device-specific way.
> 
> The SET only after enable model is broken, DS mode needs to support
> SET, where GET returns the host translations.  Thanks,

done in v12

BTW, there are two points I would like to retain:
1. Whether to allocate temporary cache in ioctl—I retained it in version v12
   because the interface supports batch operations, and copying only a portion
   each time would affect performance.
2. After the device is taken over and released by vfio, I still maintained the
   call to pcie_disable_tph in v12 because this ensures that the software state
   remains consistent with the hardware state.

Thanks

> 
> Alex

