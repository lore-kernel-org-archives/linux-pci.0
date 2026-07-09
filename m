Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACB40BCB6;
	Thu,  9 Jul 2026 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599647; cv=none; b=nmV7sawE2njb1UHpKrmYSrBWCB5vXEYhlzLUYAm3hzKb+UrEyIXaJPYxRT27zKn76dafSr/Wj164j9wSfhB8ZwkG9GlWOQbWQsAfnvSt3guMjqi04rtDh3ojgCMZp8uxiG+JLjbX/B/gxmSjtrlf9KQtne/vsskmKMUTrzOzH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599647; c=relaxed/simple;
	bh=5uW5InlbDcEn9JQ9EtoUbvYsc6CJu8iXl0aIJKkpVUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RBKzdnt6Qtjr6I6qZul9aEMf4y+IfHS6tVIjM+t29Fe8/SScFkm9Uimbo/p3AKk7JkjfIQXHarm7Nf5qedy9ZVQCWN8ksRhIU791bYC44zKRbKcqK5OLiYI4PgYLkJ/9ZN9FKYLSDZHPcVBUml6lLwQzMxTiDy10DQEc5xhJ5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=T4+binM/; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="T4+binM/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bN74CJXas4xbBrm76ad5iOMyctClI0oPu6K3/qxBxQY=;
	b=T4+binM/mQu7/4YcV4B8WfEv+MNUD4TbLJs7Tu8IiSvIS3rH+tECwmKuy60qVEgWzfr2Qe/nH
	aIoS3zGTK7XBo3H0MjtuDuDQ5mpEuzwNIx9DypbYJoL0WaMlkUpQJndQ8I3RWS8yPoN63g1Vdl7
	yjjHaGiRPRDcOUm8fPLeMtw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gwv2P6yh5zRhQS;
	Thu,  9 Jul 2026 20:11:25 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 69C5C4058C;
	Thu,  9 Jul 2026 20:20:39 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 20:20:38 +0800
Message-ID: <dad40817-9c87-494c-86b2-e0e2b75e60e7@huawei.com>
Date: Thu, 9 Jul 2026 20:20:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 15/18] vfio/pci: Implement TPH_RESOLVE feature for
 DMABUF and CPU source resolving
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-16-fengchengwen@huawei.com>
 <20260708173106.21d26a9a@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708173106.21d26a9a@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/9/2026 7:31 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:21 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Add vfio_pci_core_feature_tph_resolve() to implement the
>> VFIO_DEVICE_FEATURE_TPH_RESOLVE GET-only uAPI.
>>
>> Resolve PH/ST values from two supported sources:
>> - DMABUF fd: retrieve stored TPH metadata via dmabuf helper
>> - CPU ID: fetch ST tag from platform via PCIe TPH core helper
>>
>> Gate supported source types dynamically according to the tph_policy level:
>> No-ST/IV modes only permit DMABUF resolution, while DS+ modes additionally
>> allow CPU volatile/persistent sources.
> 
> RESOLVE is not an oracle, it's not only the sources that can be
> resolved, but whether the user has a means to use the value.  RESOLVE
> should not return a LITERAL unless the device supports DS mode or
> supports IV mode AND we're in POLICY_LITERAL.  Thanks,

Got it. My current RESOLVE logic only filters allowed sources by policy,
but does not check whether the device can actually use the resolved ST.

I will fix it: ST will only be reported when the hardware supports IV/DS
ST table capability, even under LITERAL policy.

Thanks

> 
> Alex
> 
>  
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_core.c | 75 ++++++++++++++++++++++++++++++++
>>  1 file changed, 75 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 14944d3ea86e..ed6bbffa8b26 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1641,6 +1641,78 @@ static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
>>  	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
>>  }
>>  
>> +static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
>> +			u32 flags,
>> +			struct vfio_device_feature_tph_resolve __user *arg,
>> +			size_t argsz)
>> +{
>> +	const u32 permit_src_mask[] = {
>> +		[VFIO_PCI_TPH_POLICY_NO_ST] = VFIO_DEVICE_TPH_SRC_DMABUF,
>> +		[VFIO_PCI_TPH_POLICY_IV_ST] = VFIO_DEVICE_TPH_SRC_DMABUF,
>> +		[VFIO_PCI_TPH_POLICY_DS_ST ... VFIO_PCI_TPH_POLICY_LITERAL] =
>> +					VFIO_DEVICE_TPH_SRC_DMABUF |
>> +					VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
>> +					VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT,
>> +	};
>> +	u32 permit_flags = permit_src_mask[vdev->tph_policy] |
>> +			   VFIO_DEVICE_TPH_EXTENDED;
>> +	struct vfio_device_feature_tph_resolve resolve = {0};
>> +	enum tph_mem_type mtype;
>> +	bool extended;
>> +	u32 src_bits;
>> +	u16 tag = 0;
>> +	u8 ph = 0;
>> +	int ret;
>> +
>> +	if (!vdev->tph_permit)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
>> +				 sizeof(resolve));
>> +	if (ret <= 0)
>> +		return ret;
>> +
>> +	if (copy_from_user(&resolve, arg, sizeof(resolve)))
>> +		return -EFAULT;
>> +
>> +	src_bits = resolve.flags & VFIO_DEVICE_TPH_SRC_MASK;
>> +	if (!(resolve.flags & permit_flags) || !is_power_of_2(src_bits))
>> +		return -EINVAL;
>> +	extended = !!(resolve.flags & VFIO_DEVICE_TPH_EXTENDED);
>> +	if (extended && !pcie_tph_supported(vdev->pdev, true))
>> +		return -EINVAL;
>> +
>> +	resolve.valid = 0;
>> +	resolve.ph = 0;
>> +	resolve.st = 0;
>> +
>> +	if (src_bits & VFIO_DEVICE_TPH_SRC_DMABUF) {
>> +		ret = vfio_pci_dma_buf_get_tph_by_fd(resolve.src, extended,
>> +						     &tag, &ph);
>> +		if (ret)
>> +			return ret;
>> +		resolve.ph = ph;
>> +		resolve.valid = VFIO_DEVICE_TPH_VALID_PH;
>> +		if (vdev->tph_policy >= VFIO_PCI_TPH_POLICY_DS_ST) {
>> +			resolve.st = tag;
>> +			resolve.valid |= VFIO_DEVICE_TPH_VALID_ST;
>> +		}
>> +		goto out;
>> +	}
>> +
>> +	mtype = (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE) ?
>> +			TPH_MEM_TYPE_VM : TPH_MEM_TYPE_PM;
>> +	ret = pcie_tph_get_cpu_st_explicit(vdev->pdev, mtype, extended,
>> +					   resolve.src, &tag);
>> +	if (ret)
>> +		return ret;
>> +	resolve.valid = VFIO_DEVICE_TPH_VALID_ST;
>> +	resolve.st = tag;
>> +
>> +out:
>> +	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
>> +}
>> +
>>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  				void __user *arg, size_t argsz)
>>  {
>> @@ -1661,6 +1733,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>>  	case VFIO_DEVICE_FEATURE_TPH:
>>  		return vfio_pci_core_feature_tph(vdev, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_TPH_RESOLVE:
>> +		return vfio_pci_core_feature_tph_resolve(vdev, flags,
>> +							 arg, argsz);
>>  	default:
>>  		return -ENOTTY;
>>  	}
> 

