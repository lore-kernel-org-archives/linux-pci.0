Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD11A0BD0;
	Thu,  9 Jul 2026 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600575; cv=none; b=l4rERJavQQ15CJMrpweEMGUPUyMYnvuHysoHbmOUKs05n2QYzcvzVOtv5K3ZC77Oy2wnUNyBdDtmsuftvmpM/qco6evSl5I/xVR7qPt5Prnkpmp+PETsQmwjaNMq8Gr97w7FfIHxRlUb07yUfEwQuGYu73j5w27eqwGPKwfmpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600575; c=relaxed/simple;
	bh=I3FxDMN53urdgK+dh7/JtbbO5k/e2rnDs7sOQgXI/4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HPICRJ2AM8kLjxnRsG9UDf9I/1ZJnUMpxVGJhECCOcgPSytPxxrTANfYm7xbi0cogERtIvFBIJD3A9XPInu/LdHOAO8H+cviFOU4dcavchLS4VD/vDd7dlybchsH6Wh0FSe50cjtpzA0+97HhPxK5Wml+os6DUNtjUVm8Zm7aCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1j1/oqD1; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1j1/oqD1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xltD8i6BKFseW1B4W1EmsW9uozfSgc6BLF3q62kY4uE=;
	b=1j1/oqD15VwV49lbOTYvwHRJILOhQKzOi2DmSq+t7h+vTxCMhtP1tGR1SJDwdTiHSFTmechjb
	1qTD8uAz2XeMLmQSPsSxAXFcrjoX0T3/qoGA0C+ehHnDoyzs/3QK4ADjmEbt7jX9VsZKraJNSas
	a6LEIoDOdDEUGdM42dwQk94=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gwvNF2k7dz1cyVj;
	Thu,  9 Jul 2026 20:26:53 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id A39E140586;
	Thu,  9 Jul 2026 20:36:06 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 20:36:05 +0800
Message-ID: <b3c5827c-c16e-4cd1-bf13-2ed0220716ba@huawei.com>
Date: Thu, 9 Jul 2026 20:36:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 16/18] vfio/pci: Implement TPH_ST feature for batch ST
 table programming
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-17-fengchengwen@huawei.com>
 <20260708172954.14bff5c4@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708172954.14bff5c4@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/9/2026 7:29 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:22 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Add vfio_pci_core_feature_tph_st() to implement the SET-only
>> VFIO_DEVICE_FEATURE_TPH_ST uAPI for batch TPH ST table programming.
>>
>> Implement helper routines to calculate ST table size and resolve ST tags
>> from multiple sources: NONE, DMABUF, CPU volatile/persistent, and LITERAL.
>>
>> Batch program contiguous ST table entries according to user inputs, support
>> stop-on-zero-ST semantics, and return the number of successfully written
>> entries. Hold memory_lock and ensure device is in D0 state during hardware
>> operations.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_core.c | 119 +++++++++++++++++++++++++++++++
>>  1 file changed, 119 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index ed6bbffa8b26..7251e251824a 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1713,6 +1713,123 @@ static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
>>  	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
>>  }
>>  
>> +static u32 tph_calc_st_size(struct vfio_pci_core_device *vdev)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	u32 loc = pcie_tph_get_st_table_loc(pdev);
>> +	int ret;
>> +
>> +	if (loc == PCI_TPH_LOC_CAP) {
>> +		return pcie_tph_get_st_table_size(pdev);
>> +	} else if (loc == PCI_TPH_LOC_MSIX) {
>> +		ret = pci_msix_vec_count(pdev);
>> +		if (ret < 0)
>> +			return 0;
>> +		return ret;
>> +	} else {
>> +		return 0;
>> +	}
>> +}
>> +
>> +static int tph_get_st_tag(struct pci_dev *pdev, u32 src_bits, u32 src_hndl,
>> +			  bool extended, u16 *tag)
>> +{
>> +	int ret = 0;
>> +	u8 ph;
>> +
>> +	if (src_bits & VFIO_DEVICE_TPH_SRC_NONE)
>> +		*tag = 0;
>> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_DMABUF)
>> +		ret = vfio_pci_dma_buf_get_tph_by_fd(src_hndl, extended,
>> +						     tag, &ph);
>> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE)
>> +		ret = pcie_tph_get_cpu_st_explicit(pdev, TPH_MEM_TYPE_VM,
>> +					extended, src_hndl, tag);
>> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT)
>> +		ret = pcie_tph_get_cpu_st_explicit(pdev, TPH_MEM_TYPE_PM,
>> +					extended, src_hndl, tag);
>> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_LITERAL)
>> +		*tag = src_hndl;
>> +
>> +	if (ret != 0)
>> +		*tag = 0;
>> +
>> +	return ret;
>> +}
>> +
>> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
>> +				u32 flags,
>> +				struct vfio_device_feature_tph_st __user *arg,
>> +				size_t argsz)
>> +{
>> +	u32 permit_flags = VFIO_DEVICE_TPH_SRC_MASK | VFIO_DEVICE_TPH_EXTENDED;
>> +	struct vfio_device_feature_tph_st tph_st = {0};
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	u32 src_bits, st_size;
>> +	bool stop_on_zero_st;
>> +	u32 *src_hndl = NULL;
>> +	void __user *uptr;
>> +	bool extended;
>> +	int ret, i;
>> +	u16 tag;
>> +
>> +	if (!vdev->tph_permit || vdev->tph_policy == VFIO_PCI_TPH_POLICY_NO_ST)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
>> +				 sizeof(tph_st));
>> +	if (ret <= 0)
>> +		return ret;
> 
> Again, not how vfio_check_feature() convetion.

OK, will use: if (ret != 1)

> 
>> +
>> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
>> +		return -EFAULT;
>> +
> 
> MUST validate undefined flags are zero.

The following "if (!(tph_st.flags & permit_flags)" check the undefined flags bit.

> 
>> +	src_bits = tph_st.flags & VFIO_DEVICE_TPH_SRC_MASK;
>> +	if (vdev->tph_policy != VFIO_PCI_TPH_POLICY_LITERAL)
>> +		permit_flags &= ~VFIO_DEVICE_TPH_SRC_LITERAL;
>> +	if (!(tph_st.flags & permit_flags) || !is_power_of_2(src_bits))
>> +		return -EINVAL;
>> +	extended = !!(tph_st.flags & VFIO_DEVICE_TPH_EXTENDED);
>> +	if (extended && !pcie_tph_supported(vdev->pdev, true))
>> +		return -EINVAL;
>> +
>> +	st_size = tph_calc_st_size(vdev);
>> +	if (tph_st.start >= st_size || tph_st.count > st_size - tph_st.start ||
>> +		tph_st.count == 0)
>> +		return -EINVAL;
>> +
>> +	uptr = u64_to_user_ptr(tph_st.dests);
>> +	if (!(src_bits & VFIO_DEVICE_TPH_SRC_NONE)) {
>> +		src_hndl = memdup_array_user(uptr, tph_st.count, sizeof(u32));
>> +		if (IS_ERR(src_hndl))
>> +			return PTR_ERR(src_hndl);
>> +	}
>> +
>> +	down_write(&vdev->memory_lock);
> 
> No, vfio_pci_memory_lock_and_enable().

OK

> 
>> +	ret = vfio_pci_set_power_state(vdev, PCI_D0);
> 
> No, PM runtime get/set, but once again it's already done in the call
> path.

OK, I will remove this invoke

> 
>> +	if (ret)
>> +		goto out;
>> +
>> +	stop_on_zero_st = !!(tph_st.flags & VFIO_DEVICE_TPH_REQUIRE_ST);
>> +	if (tph_st.flags & VFIO_DEVICE_TPH_SRC_NONE)
>> +		stop_on_zero_st = false;
>> +	for (i = 0; i < tph_st.count; i++) {
>> +		ret = tph_get_st_tag(pdev, src_bits, src_hndl ? src_hndl[i] : 0,
>> +				     extended, &tag);
>> +		if (ret || (stop_on_zero_st && tag == 0))
>> +			break;
> 
> Missing bounds check on tag if !extended.

OK, I will check the tag > 0xFF if !extended.

> 
> In IV mode, don't we need to know the vector is enabled?

pcie_tph_set_st_entry()
  -> pci_msix_write_tph_tag(), this function already check msix_enabled:

drivers/pci/msi/msi.c:938:int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
drivers/pci/msi/msi.c-939-{
drivers/pci/msi/msi.c-940-	struct msi_desc *msi_desc;
drivers/pci/msi/msi.c-941-	struct irq_desc *irq_desc;
drivers/pci/msi/msi.c-942-	unsigned int virq;
drivers/pci/msi/msi.c-943-
drivers/pci/msi/msi.c-944-	if (!pdev->msix_enabled)
drivers/pci/msi/msi.c-945-		return -ENXIO;

> 
>> +		ret = pcie_tph_set_st_entry(pdev, tph_st.start + i, tag);
> 
> We're defeating the entire reason we created a batching interface by
> not also implementing a batching interface in the PCI/TPH code.  This
> does a disable before each set.  Thanks,

Yes, it will first disable req and then enable req after write tag
I will try add on batch set tag API in PCI/TPH

Thanks

> 
> Alex
> 
>> +		if (ret)
>> +			break;
>> +	}
>> +	ret = i;
>> +
>> +out:
>> +	up_write(&vdev->memory_lock);
>> +	kfree(src_hndl);
>> +	return ret;
>> +}
>> +
>>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  				void __user *arg, size_t argsz)
>>  {
>> @@ -1736,6 +1853,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  	case VFIO_DEVICE_FEATURE_TPH_RESOLVE:
>>  		return vfio_pci_core_feature_tph_resolve(vdev, flags,
>>  							 arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_TPH_ST:
>> +		return vfio_pci_core_feature_tph_st(vdev, flags, arg, argsz);
>>  	default:
>>  		return -ENOTTY;
>>  	}
> 

