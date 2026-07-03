Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A621FECCD;
	Fri,  3 Jul 2026 01:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783041982; cv=none; b=BGlwpoL9EWGL1iYig7pPjQ1+iM1p10saOMZm5X6J/diwpKlzHgXm+7TZLzSybf+R9ruv/R/p3SopC+CleBHsNO9KerwmBdjGRbYxHV1w+QWbA/+q10nPkMKQwD0xNa0+r78yINIb2fUfAa5t2hHzviu1o9w9wdRIfebXCZrDdQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783041982; c=relaxed/simple;
	bh=kANR6HAeMSE0R73yzILTwXkdt5izW1pky7VlS/Xcp7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M/JnFiZB1NGWEgM4HJvpN4VWT5yZP4lw+f1O9qQJd/jkfdwapPz9PebB9n4uFu0w6df7ELM07ZvRj1ZqrAPXR3CmNoO5G+5Ht1ZV5eXeAgcqRPrLK9fnmsJCACj0mhs1KTwTy2Hu9RjvDyZKRd9G7ul5HJ34kUv3ECe9Fky+XR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MwmErFPa; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MwmErFPa"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oo+2U0R5IyAIDOI6Z1Q1GrIkLDY7NRig+R3oj+rdV4Y=;
	b=MwmErFPaQsqHqAlGVeL4mDHvdbOZIJMzTFZ2uIJp8p9A0pIi0M7olZTIcSnaP+KVYRqxJY+ef
	JPt4lEp2P6lsNJYlpKaPulR4bB2zzKUsc8bHrdkSncRWsn5UBiP6vjXoluz8RiF/aoL+eOvLcNx
	GBq/2VvyZWtsKESghcv6yS4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4grwp575nRz1K9bp;
	Fri,  3 Jul 2026 09:17:01 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A3C74055B;
	Fri,  3 Jul 2026 09:26:11 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Jul 2026 09:26:10 +0800
Message-ID: <ed05c3e7-8316-4669-87f1-46305336872d@huawei.com>
Date: Fri, 3 Jul 2026 09:26:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 15/18] vfio/pci: Implement TPH_RESOLVE feature for
 DMABUF and CPU source resolving
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-16-fengchengwen@huawei.com>
 <20260702130040.BBAB51F00A3A@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260702130040.BBAB51F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/2/2026 9:00 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Flawed bitwise logic in flag validation allows userspace to bypass TPH policy restrictions and breaks forward UAPI compatibility.

Real bug, will fix in v20

> 
> Pre-existing issues:
> - [High] Missing reservation lock `dma_resv_lock` before calling `vfio_pci_dma_buf_get_pci_tph` leads to a data race and lockdep assertion failure.
> - [Medium] The VFIO_DEVICE_FEATURE_TPH SET operation fails to validate that the provided payload flags are zero, breaking forward compatibility.

Pre-commits bug, will fix in v20

Thanks

> --
> 
> commit 0733cb5339faa744645461c3f2055477418d1f5e
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Implement TPH_RESOLVE feature for DMABUF and CPU source resolving
> 
> This commit adds vfio_pci_core_feature_tph_resolve() to implement the
> VFIO_DEVICE_FEATURE_TPH_RESOLVE GET-only uAPI. It resolves PH/ST values 
> from two supported sources: DMABUF fds and CPU IDs, dynamically gating 
> source types based on the tph_policy level.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 14944d3ea86e6..ed6bbffa8b26a 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1641,6 +1641,78 @@ static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
>>  	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
>>  }
> 
> [Severity: Medium]
> This is a pre-existing issue in vfio_pci_core_feature_tph() just above this
> new code, but does the SET operation properly validate the user payload?
> 
> When VFIO_DEVICE_FEATURE_SET is passed, the function exits early without
> reading the user's struct vfio_device_feature_tph payload via 
> copy_from_user():
> 
> vfio_pci_core_feature_tph() {
>     if (flags & VFIO_DEVICE_FEATURE_SET) {
>         vdev->tph_permit = 1;
>         return 0;
>     }
> }
> 
> Does this silently ignore any non-zero flags in the payload, potentially
> breaking UAPI forward compatibility if new flags are added later?
> 
>> +static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
>> +			u32 flags,
>> +			struct vfio_device_feature_tph_resolve __user *arg,
>> +			size_t argsz)
>> +{
> 
> [ ... ]
> 
>> +	if (copy_from_user(&resolve, arg, sizeof(resolve)))
>> +		return -EFAULT;
>> +
>> +	src_bits = resolve.flags & VFIO_DEVICE_TPH_SRC_MASK;
>> +	if (!(resolve.flags & permit_flags) || !is_power_of_2(src_bits))
>> +		return -EINVAL;
> 
> [Severity: High]
> Does this validation logic correctly reject unsupported flags?
> 
> Since permit_flags unconditionally includes VFIO_DEVICE_TPH_EXTENDED,
> wouldn't any user payload that sets VFIO_DEVICE_TPH_EXTENDED along with
> an unpermitted flag bypass this check entirely? The bitwise AND would be
> non-zero, making the NOT condition false and bypassing the policy rejection.
> 
> Could this be updated to use a strict subset check instead? For example:
>     if ((resolve.flags & ~permit_flags) || !is_power_of_2(src_bits))
> 
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
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does calling 
> vfio_pci_dma_buf_get_tph_by_fd() here trigger a lockdep splat?
> 
> Looking at vfio_pci_dma_buf_get_tph_by_fd() in
> drivers/vfio/pci/vfio_pci_dmabuf.c, it delegates directly to
> vfio_pci_dma_buf_get_pci_tph() without acquiring the dma_resv_lock:
> 
> vfio_pci_dma_buf_get_tph_by_fd() {
>     dmabuf = dma_buf_get(fd);
>     ...
>     ret = vfio_pci_dma_buf_get_pci_tph(dmabuf, extended, tag, ph);
> }
> 
> However, vfio_pci_dma_buf_get_pci_tph() expects the reservation lock
> to be held, and asserts it:
> 
> vfio_pci_dma_buf_get_pci_tph() {
>     dma_resv_assert_held(priv->dmabuf->resv);
> }
> 
> Could this lead to unprotected concurrent reads of the priv struct fields
> and a data race if the lock is not taken?
> 
> [ ... ]
> 

