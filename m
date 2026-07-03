Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910831F30A9;
	Fri,  3 Jul 2026 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042970; cv=none; b=nJN82iinRnqJOGXEnYSbj+FwqGAh9nThdlTQpkJOpZAyjRwTRAYCsGBz+Py8uWEhz61pAZ/Mw+kIdDIUrpECuaAtw0YD1g59BYKGIQMizL4M6SEpn9EPNN96ZhDDpKz3y4Hka86fM6OJLewiYs25yWtNcivPGqeDQ5cjS19mk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042970; c=relaxed/simple;
	bh=KFzTXcqUXhm7FX4qZ7OpxIir07gpdzE5BGWUXD4PVGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EssxtN68HQ6/q+hjlCBkhx0GClUGyEiP0Z9rAjhX9A1IxtbuzdbrBRm/1lBDHq+2t5iHMV/x0P6ogJ+S+dVI6Sm3lZyQ86VeX63a+hpUenQCsiroW4nCfZ3VAosPXKvDLW7GDaaoenoEyUfXrIOQycO4QZJA8gu7ZXC0uGwo8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3wQ6Pdr+; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3wQ6Pdr+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QK/BOn7ZMeKzE8Yh8XNcA3mmassY6oW2knmONYjHwn0=;
	b=3wQ6Pdr+0xczd2qydHl8uNGOV9Dvns5jwhj/WiFSoayhYEC1m61olsn9S8OSCjBp7zU7QgxM+
	Kt/RmeO32cDg3uCCq9K+aJxLw3nyOLtWM+5L+7hY2iOhCId5N8daocl4SDoWxaD7dPo2RcGxD74
	4Pru6+r8YkG6mf0rC1ZOJOs=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4grx8z1HsvzLltS;
	Fri,  3 Jul 2026 09:33:23 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id E04604058D;
	Fri,  3 Jul 2026 09:42:33 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Jul 2026 09:42:33 +0800
Message-ID: <50bf37a0-bdc2-45fb-ad9a-7190c96a5971@huawei.com>
Date: Fri, 3 Jul 2026 09:42:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 16/18] vfio/pci: Implement TPH_ST feature for batch ST
 table programming
To: <sashiko-reviews@lists.linux.dev>, Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <helgaas@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-17-fengchengwen@huawei.com>
 <20260702130413.7D1781F000E9@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260702130413.7D1781F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/2/2026 9:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> - [High] TPH policy bypass due to flawed bitwise validation of uAPI flags.

Read bug, will fix in v20

> - [High] Error codes during batch programming are overwritten, converting failures into silent successes.

False positive because the ioctl return 0 means no entry was programed

> - [High] The ioctl bypasses the TPH policy restrictions for IV_ST, allowing userspace to program CPU ST tags when forbidden.

False positive because TPH_ST could also allowed when tph_policy=IV_ST
(allowd src: NONE/DMABUF/CPU)

> - [High] Programming MSI-X TPH entries without ensuring PCI Memory Space Enable (MSE) is active can cause fatal Machine Check Exceptions (MCE).

Two possible options to resolve this I think:
1. Add explicit MSE read/validation inside vfio_pci_core_feature_tph_st() before
   each pcie_tph_set_st_entry() call, returning -EIO when memory space is disabled.
2. Move the MSE guard into the shared pcie_tph_set_st_entry() helper in pci/tph.c,
   so all callers automatically inherit the safety check without duplicate logic.

Could reviewers advise which approach is preferred here, or confirm whether this
MSE validation is required at all for the TPH batch programming path?

> - [Medium] Missing strict rejection of undefined/reserved bits in uAPI flags.
> - [Medium] Missing dma_resv_lock in vfio_pci_dma_buf_get_tph_by_fd() leads to unprotected access to dmabuf state.

The above two are both pre-commits' bug, will fix in v20

Thanks

> --
> 
> commit 7b7176f5f74da5cf5059e3ca3ebda10567316f68
> Author: Chengwen Feng <fengchengwen@huawei.com>
> Subject: vfio/pci: Implement TPH_ST feature for batch ST table programming
> 
> This commit adds vfio_pci_core_feature_tph_st() for batch programming
> of TPH ST table entries. It introduces helpers for calculating ST table
> size and resolving tags. The ioctl iterates over user-provided handles
> to look up and write tags while holding the memory lock and keeping the
> device in D0.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index ed6bbffa8b26a..7251e251824a8 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1713,6 +1713,123 @@ static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
>>  	return copy_to_user(arg, &resolve, sizeof(resolve)) ? -EFAULT : 0;
>>  }
>>  
> [ ... ]
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
> 
> [Severity: Medium]
> Does this path safely access the dmabuf state?
> 
> Looking at the callee:
> vfio_pci_dma_buf_get_tph_by_fd()
>    vfio_pci_dma_buf_get_pci_tph(dmabuf, ...)
> 
> It appears the dmabuf is accessed without acquiring its reservation
> lock (dmabuf->resv). Could this lead to data races when accessing
> the TPH metadata if it changes concurrently?
> 
>> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE)
> [ ... ]
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
>> +
>> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
>> +		return -EFAULT;
>> +
>> +	src_bits = tph_st.flags & VFIO_DEVICE_TPH_SRC_MASK;
>> +	if (vdev->tph_policy != VFIO_PCI_TPH_POLICY_LITERAL)
>> +		permit_flags &= ~VFIO_DEVICE_TPH_SRC_LITERAL;
> 
> [Severity: High]
> Is this missing a restriction for the VFIO_PCI_TPH_POLICY_IV_ST
> policy?
> 
> In vfio_pci_core_feature_tph_resolve(), the IV_ST policy strictly
> limits allowed sources to VFIO_DEVICE_TPH_SRC_DMABUF. However, here
> permit_flags is initialized to VFIO_DEVICE_TPH_SRC_MASK and only
> LITERAL is explicitly removed. Could this allow userspace to program
> CPU ST tags when the device policy forbids it?
> 
>> +	if (!(tph_st.flags & permit_flags) || !is_power_of_2(src_bits))
>> +		return -EINVAL;
> 
> [Severity: High]
> Can this bitwise validation be bypassed if a user sets a forbidden
> source flag along with a permitted flag?
> 
> If VFIO_DEVICE_TPH_EXTENDED is included in permit_flags and
> provided in tph_st.flags, the bitwise AND evaluates to non-zero,
> satisfying the first condition. If only one forbidden source bit is
> set, is_power_of_2() also passes, completely bypassing the policy
> restrictions.
> 
> (Note: This same validation pattern appears to be present in
> vfio_pci_core_feature_tph_resolve() as well).
> 
> [Severity: Medium]
> Does this logic ignore undefined or reserved bits in tph_st.flags
> instead of strictly rejecting them?
> 
> If userspace passes uninitialized garbage in the upper bits, the kernel
> won't return -EINVAL, potentially breaking forward compatibility for
> future extensions.
> 
>> +	extended = !!(tph_st.flags & VFIO_DEVICE_TPH_EXTENDED);
> [ ... ]
>> +	for (i = 0; i < tph_st.count; i++) {
>> +		ret = tph_get_st_tag(pdev, src_bits, src_hndl ? src_hndl[i] : 0,
>> +				     extended, &tag);
>> +		if (ret || (stop_on_zero_st && tag == 0))
>> +			break;
>> +		ret = pcie_tph_set_st_entry(pdev, tph_st.start + i, tag);
> 
> [Severity: High]
> Is it safe to program MSI-X TPH entries without ensuring the PCI
> Memory Space Enable (MSE) bit is active?
> 
> While this function ensures the device is in the D0 power state,
> userspace can dynamically disable PCI_COMMAND_MEMORY. Since
> pcie_tph_set_st_entry() performs direct MMIO writes to the BAR,
> could executing this unconditionally on a disabled BAR result in an
> Unsupported Request (UR) and a fatal Machine Check Exception (MCE)?
> 
>> +		if (ret)
>> +			break;
>> +	}
>> +	ret = i;
> 
> [Severity: High]
> Does this unconditional assignment destroy the error code if the
> loop breaks early?
> 
> If tph_get_st_tag() or pcie_tph_set_st_entry() fails on the very
> first iteration, ret will hold a negative error code (like
> -EINVAL). When the loop breaks, ret = i; overwrites it with 0,
> causing the ioctl to silently return success to userspace.
> 
>> +
>> +out:
>> +	up_write(&vdev->memory_lock);
>> +	kfree(src_hndl);
>> +	return ret;
>> +}
> 

