Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6E377EA1;
	Fri, 22 May 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444262; cv=none; b=MSECTb4NBZFl7EqMPgLCHXIXRpV9+IbPRz0P+D03QMX0IDgPdGhhnvBbg3XePJKs2iyAiepsWjQLSDRnDNZlM72/HpEh5lkeKLW773MhOLYaw7CUb7U86E//yra3q81sW65Wq5FU2aVdOtsU/BVywMW+GSVR7hwJ3znHkyWjmdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444262; c=relaxed/simple;
	bh=qoVU470jmBCxtPK/7Iq+kBWK02+dJ3H6OOM949T4ab8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cFJ/XrQb8+HkNQbumVYKBnBijT2eIOwc0FdmDCntxtwBr6qIoi/TCSPnJbtQcZzHShmJR7qGctV0ZHbe9pDm2LQLHCrBcfm7phGM5jOqxLhjkuWw+oaeTFLPStDokIjEHVewUR+I1QZA4ZXfxRwp+4MsA3zOVLT6i/BLD7FhFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6wET1SUv; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6wET1SUv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mWaMWoUjJP4+8JPKo9pXxNpvdJIqdj7AjppGEeDe6Fo=;
	b=6wET1SUvPAXu5G7V72alUKfNM+l9wwTSzls5H14+SAsV7tfAldYxki0L21dmFv1tiLcXKqxjA
	z0/5mZs+vcm72AhlQ18YrrfG17DXvpAydlFtUQ1TbqPpqJI/vpE5fNmHHU7MUPFVoohCdLVvgIU
	msfyB3S5xS3M7Dfag34J8rA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gMLKP4W2MzpStQ;
	Fri, 22 May 2026 17:56:57 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 02F3740569;
	Fri, 22 May 2026 18:04:15 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 18:04:14 +0800
Message-ID: <512bce27-13a2-44a1-aa5b-b5ea77c174ba@huawei.com>
Date: Fri, 22 May 2026 18:04:13 +0800
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
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260521221008.59ddf977@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 5/22/2026 12:10 PM, Alex Williamson wrote:
> On Mon, 18 May 2026 15:17:01 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Add VFIO_DEVICE_FEATURE_TPH_ST to allow userspace to manage PCIe TPH
>> Steering Tag entries.
>>
>> SET: Program contiguous ST entries when ST table resides in TPH Capability
>>      or MSI-X table. U32_MAX CPU ID clears the corresponding ST entry.
>> GET: Retrieve ST values per CPU ID, only available in DS mode.
>>
>> Both operations are only valid when TPH is enabled on the device.
> 
> What?  That doesn't align with the hardware programming model.  The
> specification even suggests that the device should be quiesced or TPH
> disabled during programming of the steering tags for deterministic
> behavior.

As mentioned in the 4/5 commit, obtaining ST must first enable TPH.
Of course, I think it might be necessary to calculate pdev->tph_req_type
during the capability detection phase, so that we can modify ST before
enabling TPH. Do you think such a modification is needed?

> 
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_core.c | 91 ++++++++++++++++++++++++++++++++
>>  include/uapi/linux/vfio.h        | 41 ++++++++++++++
>>  2 files changed, 132 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 0d0140202280..13a22c1d6ea6 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1558,6 +1558,95 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
>>  	return 0;
>>  }
>>  
>> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
>> +					u32 flags,
>> +					struct vfio_device_feature_tph_st __user *arg,
>> +					size_t argsz)
>> +{
>> +	bool is_set = !!(flags & VFIO_DEVICE_FEATURE_SET);
>> +	struct vfio_device_feature_tph_st tph_st;
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	enum tph_mem_type mtype;
>> +	int i, j, ret;
>> +	u32 *cpus;
>> +	u16 st;
>> +
>> +	guard(mutex)(&vdev->tph_lock);
> 
> Wrong place for this lock.  Why do we even need it?  If a user races
> SET/GET with enable/disable, that's their problem.

OK, will fix in next version

> 
>> +
>> +	ret = vfio_check_feature(flags, argsz,
>> +				 VFIO_DEVICE_FEATURE_GET |
>> +				 VFIO_DEVICE_FEATURE_SET,
>> +				 sizeof(tph_st));
>> +	if (ret <= 0)
>> +		return ret;
>> +
>> +	if (!enable_unsafe_tph ||
> 
> Why did we allow the feature to be probe if it can't be used?

OK, will fix in next version

> 
>> +		pcie_tph_enabled_mode(pdev) == PCI_TPH_ST_NS_MODE)
> 
> Here's that ambiguity of reporting NS_MODE for disabled, but as above
> it's a bogus requirement.

OK, will fix in next version

> 
>> +		return -EOPNOTSUPP;
>> +	if (!is_set && pcie_tph_enabled_mode(pdev) != PCI_TPH_ST_DS_MODE)
> 
> Why?  Let the interface be symmetric that GET works regardless of mode.

OK, will remove the restrict

> 
>> +		return -EOPNOTSUPP;
>> +	if (is_set && pcie_tph_get_st_table_loc(pdev) == PCI_TPH_LOC_NONE)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
>> +		return -EFAULT;
>> +
>> +	if (tph_st.count == 0 || tph_st.count > VFIO_TPH_ST_MAX_COUNT ||
>> +		tph_st.flags > VFIO_TPH_ST_MEM_TYPE_PM)
> 
> Wrong operation for a flags field.

Because currently flags only use bit0 (0-VM, 1-PM), this judge make sure
it will return error if userspace passing non-zero in remain bits.

> 
>> +		return -EINVAL;
>> +	if (!is_set && tph_st.index != 0)
> 
> We can only GET index 0?  Why?

Because GET operation don't need index, this judgment make sure
it will return error if userspace passing non-zero index.

> 
>> +		return -EINVAL;
>> +	if (is_set && (tph_st.index >= VFIO_TPH_ST_MAX_COUNT ||
>> +		       tph_st.index + tph_st.count > VFIO_TPH_ST_MAX_COUNT))
> 
> DS can have more that 2048 steering tags.

I check the PCIE protocol, DS mode with ST in pcie-config or msi-x must not
hold > 2048 steering tags.

> 
>> +		return -EINVAL;
>> +
>> +	cpus = memdup_array_user(&arg->data, tph_st.count, sizeof(*cpus));
> 
> Use an __aligned_u64 data_uptr like iommufd does and avoid copying this
> into the kernel.  Isn't this steering tags, why's it named cpus?

we reuse the field which according your previous suggestion:
in GET, user pass in cpus, and vfio will feedback steering tags in cpus.

> 
>> +	if (IS_ERR(cpus))
>> +		return PTR_ERR(cpus);
>> +
>> +	mtype = tph_st.flags & VFIO_TPH_ST_MEM_TYPE_PM ? TPH_MEM_TYPE_PM :
>> +							 TPH_MEM_TYPE_VM;
> 
> Then why did we use two flag bits for this?

VFIO_TPH_ST_MEM_TYPE_PM is just one bit, could you explain the two flag bits?

> 
>> +	if (!is_set) {
>> +		for (i = 0; i < tph_st.count; i++) {
>> +			ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
> 
> My understanding was that GET would return the translated values from a
> previous SET, not translate on the fly.  I think in order to support
> writing STs before enabling TPH, we're going to need to store them
> somewhere anyway so that we can push them to the correct location when
> TPH is enabled.  That means there a buffer for SET/GET regardless of
> the mode that's enabled.

OK, will try to fix

> 
>> +			if (ret)
>> +				goto out;
>> +			cpus[i] = st;
>> +		}
>> +		goto out;
>> +	}
>> +
>> +	for (i = 0; i < tph_st.count; i++) {
>> +		if (cpus[i] == U32_MAX) {
>> +			ret = pcie_tph_set_st_entry(pdev, tph_st.index + i, 0);
> 
> Why do we need a magic value to set it to zero?  Hardware doesn't have
> a "clear ST register value".

So you mean for SET, usespace direct passing steering-tag not cpus in this patch?

> 
>> +			if (ret)
>> +				goto out;
>> +			continue;
>> +		}
>> +
>> +		ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
>> +		if (ret)
>> +			goto out;
>> +		ret = pcie_tph_set_st_entry(pdev, tph_st.index + i, st);
>> +		if (ret)
>> +			goto out;
> 
> Clearly broken for DS mode.

For DS mode:
1\ if ST table in CONFIG or MSI-X, then it could done by this way
2\ if ST table not in CONFIG or MSI-X, then it only need invoke GET, and set by device-specific way.

Thanks

> 
>> +	}
>> +
>> +out:
>> +	if (!is_set && !ret) {
>> +		if (copy_to_user(&arg->data, cpus,
>> +			tph_st.count * sizeof(*cpus)))
>> +			ret = -EFAULT;
>> +	}
>> +	if (is_set && ret) {
>> +		/* Roll back previously programmed entries to 0 */
>> +		for (j = 0; j < i; j++)
>> +			pcie_tph_set_st_entry(pdev, tph_st.index + j, 0);
> 
> The magic value is zero, not U32_MAX.  Thanks,
> 
> Alex
> 
>> +	}
>> +	kfree(cpus);
>> +	return ret;
>> +}
>> +
>>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  				void __user *arg, size_t argsz)
>>  {
>> @@ -1576,6 +1665,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_TPH_ST:
>> +		return vfio_pci_core_feature_tph_st(vdev, flags, arg, argsz);
>>  	default:
>>  		return -ENOTTY;
>>  	}
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5de618a3a5ee..aca39d4e5307 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1534,6 +1534,47 @@ struct vfio_device_feature_dma_buf {
>>   */
>>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>  
>> +/**
>> + * VFIO_DEVICE_FEATURE_TPH_ST - Get/Set PCIe TPH Steering Tag (ST) entries
>> + *
>> + * Provides userspace interface to manage PCIe TPH ST table entries.
>> + * This feature is only available when device TPH is enabled.
>> + *
>> + * Upon VFIO_DEVICE_FEATURE_SET:
>> + *   Program contiguous ST table entries from the starting @index.
>> + *   Valid only for hardware with ST table located in TPH Capability
>> + *   space or MSI-X table. If an entry CPU ID is specified as U32_MAX,
>> + *   the corresponding ST entry will be cleared. @index and @count define
>> + *   the contiguous entry range to be programmed.
>> + *   If any entry programming fails, the operation will roll back and
>> + *   clear all entries that were successfully programmed before the error.
>> + *
>> + * Upon VFIO_DEVICE_FEATURE_GET:
>> + *   Retrieve the ST value mapped to each given CPU ID in the @data array.
>> + *   Userspace fills @data with CPU ID array, the interface returns each
>> + *   CPU's corresponding ST value back in place.
>> + *   Valid only when TPH DS mode is enabled.
>> + *
>> + * @flags: Operation flags (VFIO_TPH_ST_MEM_TYPE_*).
>> + * @index: Starting ST entry index, only valid for FEATURE_SET.
>> + * @count: Number of contiguous entries to access.
>> + * @data: Array of CPU IDs for both SET and GET. On SET it programs ST for
>> + *        each CPU; on GET it returns the mapped ST value of each CPU.
>> + *
>> + * This feature is gated by enable_unsafe_tph module parameter.
>> + */
>> +#define VFIO_DEVICE_FEATURE_TPH_ST	13
>> +
>> +struct vfio_device_feature_tph_st {
>> +	__u32 flags;
>> +#define VFIO_TPH_ST_MEM_TYPE_VM		(0U << 0)
>> +#define VFIO_TPH_ST_MEM_TYPE_PM		(1U << 0)
>> +	__u16 index;
>> +	__u16 count;
>> +#define VFIO_TPH_ST_MAX_COUNT		2048
>> +	__u32 data[] __counted_by(count);
>> +};
>> +
>>  /* -------- API for Type1 VFIO IOMMU -------- */
>>  
>>  /**
> 

