Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E62E65D;
	Mon, 15 Jun 2026 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781487106; cv=none; b=CcFaNWssJRtE0a2rP6e78XzQIdol6kLke4BEmlrk33cmdf7a8HOU+F5LvBF1byhm8S2odDJsX1QTigZZi0isP1y8uz6ixUa1272V8kGCVOE63nPrPLd3n3xaLrd3rZj1btJ+GStShjTj9OjkyQTqll7gYPQNk3KCRgyWCwQRz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781487106; c=relaxed/simple;
	bh=8Qro0uEQM8Yfx6XlESBcfUe22TUsulPasj+Iz83LMrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bcduqNaNsNUgdTbaSMVpgBV2m6V8njGc5eUX5FMEJcRRD+clgtp0JDr7ol8JLoEWf+rt7VWTThTjzMd/j3ZmpPMZe53Ye6ng2TNBPluSYkh4AazaLpYC977UEsIBV/oyr3IYRWs0yaFSIyTx/lSy/EL4s/MZA4gSncbe1Vbu9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gQnx+ilo; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gQnx+ilo"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=O+3RrIlH01ukY9Wd1sMuPwvd416OdkQhnQzniDTrR4s=;
	b=gQnx+ilo9RUnryb2N7xKYPHu6lWlRtA91zwlfirY8UpDlv2EGks1frlY9U/jQzZtfcPNpFXSa
	qZ0fXXVuHcJ7x7rryGGmB4uQX/g879tLXZqdN/X6z7Qn8M7xg/IGR4u8Xkp6MW/SYxo9tInAA/J
	8EDyBFxkwis28Tm6LTsZUi4=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gdsp36kF2z1cyQd;
	Mon, 15 Jun 2026 09:23:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id CDF354056F;
	Mon, 15 Jun 2026 09:31:35 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 09:31:35 +0800
Message-ID: <f0122494-e8d0-4389-9165-ab94eeb249cc@huawei.com>
Date: Mon, 15 Jun 2026 09:31:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 10/12] vfio/pci: Add TPH_CPU_ST to query CPU's TPH
 steering tag
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260604132804.28678-11-fengchengwen@huawei.com>
 <20260604135523.D6A841F00893@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260604135523.D6A841F00893@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 6/4/2026 9:55 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] VFIO feature probing is broken for `VFIO_DEVICE_FEATURE_TPH_CPU_ST` due to premature capability check.
> 
> Pre-existing issues:
> - [High] Data race on bitfields in `struct vfio_pci_core_device` due to unsynchronized updates to `tph_permit`.
> --

Thanks for the review.

I will fix both issues in v17:
1. Change tph_permit from bitfield to an independent bool variable.
   Single-byte access is atomic, which resolves the lockless data race completely.
2. Adjust code order: move the tph_permit permission check after vfio_check_feature,
   so that VFIO_DEVICE_FEATURE_PROBE can work normally for TPH_CPU_ST.

Thanks

> 
> commit 8e85ddd8531d274e066b704c2d380e850a4df8e5
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Add TPH_CPU_ST to query CPU's TPH steering tag
> 
> This commit adds a new read-only VFIO device feature
> VFIO_DEVICE_FEATURE_TPH_CPU_ST to allow userspace to query PCIe TPH
> Steering Tags by CPU ID. It implements a batch query logic and is
> double-gated by a module parameter and a per-device tph_permit flag.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index ae05343701f76..7c6e3e1213d3e 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
> [ ... ]
>> @@ -1535,6 +1536,72 @@ static int vfio_pci_core_feature_tph_enable(struct vfio_pci_core_device *vdev,
>>  	return 0;
>>  }
>>  
>> +static int vfio_pci_core_feature_tph_cpu_st(struct vfio_pci_core_device *vdev,
>> +			u32 flags,
>> +			struct vfio_device_feature_tph_cpu_st __user *arg,
>> +			size_t argsz)
>> +{
>> +	struct vfio_device_feature_tph_cpu_st cpu_st;
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	enum tph_mem_type mtype;
>> +	void __user *uptr;
>> +	bool extended;
>> +	int i, ret;
>> +	u32 *cpus;
>> +	u16 *sts;
>> +	u16 st;
>> +
>> +	if (!vdev->tph_permit)
> 
> [Severity: High]
> This is a pre-existing issue, but does the tph_permit flag suffer from a data
> race due to being packed in a bitfield without locking?
> 
> The tph_permit flag is packed as a bitfield (bool tph_permit:1;) alongside
> other volatile device state flags like bardirty and needs_reset in
> struct vfio_pci_core_device.
> 
> The vfio_pci_core_feature_tph_enable() ioctl modifies vdev->tph_permit
> without holding any device-level locks:
> 
>     if (!vdev->tph_permit)
>         vdev->tph_permit = 1;
> 
> Since bitfield modifications are compiled into non-atomic read-modify-write
> operations on the underlying word, executing the TPH enable ioctl
> concurrently with other state changes (such as vdev->bardirty = true; in
> vfio_pci_core_write(), which is executed under memory_lock read-side) could
> cause a data race. Can this silently overwrite and drop state changes,
> potentially causing the device to malfunction due to missed resets
> or unflushed BARs?
> 
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
>> +				 sizeof(cpu_st));
> 
> [Severity: Medium]
> Will this early tph_permit check break VFIO feature probing for
> VFIO_DEVICE_FEATURE_TPH_CPU_ST?
> 
> Because the dynamic permission check intercepts the call first, probing
> TPH_CPU_ST will incorrectly fail with -EOPNOTSUPP unless the user has
> already dynamically enabled TPH via VFIO_DEVICE_FEATURE_TPH_ENABLE.
> 
> vfio_check_feature() handles VFIO_DEVICE_FEATURE_PROBE operations, which
> userspace uses to discover if the kernel understands a feature ioctl.
> Moving the tph_permit check after vfio_check_feature() would resolve this,
> as PROBE returns 0 immediately.
> 
>> +	if (ret <= 0)
>> +		return ret;
> 

