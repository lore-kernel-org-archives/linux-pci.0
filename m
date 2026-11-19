Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087036;
	b=jzb5vJC+PwVBAMWvStQ/5to/VVF2UM8mMFfIao2xO2NgYFsCPbP6ffCWrWxBWYODJHUm
	 NAqF+m2pkNmlcRTsUdSbccqjbk++U8GNQQL+2ibqVXit3cBkcXwWTWqe3C/5sC30X5Uu9
	 e+W2GgdiX4yt0l8zsu1yRWkNyNIq36FJLZa2PCODlW9kiSxOk2Z97ALRQM/oaboRA/6Hp
	 37YdmMoR3jLCY2OrAshDMg1CZqVua9zqS+S37uBlCGsS0MHrN51DzBnnZWR15vIR2J6wP
	 zj0mt0gLqDISWkcPyhBYoItzCufMuPWcufjchllJvM2XHIO/V2+nXeEjDcD03qnH/cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087036;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=FZlWxWQOfTu8MIOnQs8tHPP8BaxZ5f7gPpwsp5HI3JE=;
	b=wU01Ut+Iwp4Hcj2nR7up3qxa8wbZ7tJiwlnMScy1GG+dP0WlSAq4o4NICjl15H3e4+AQ
	 /kv+9PIt+Y1xAS+lTldqgu+/GLRX+vpM9e7VOqs4n8pl9yte9nMgYXkmEfU6BxRqCgVmb
	 TaJJLnDq7sLgSr14bfAPvHfljyoB7hjS6bfUFVIV7Ix43jOWlbXHcZjovS+PinOCZhtVy
	 d/inFzclbgRpQgN6f1jeD0hYVD1Z5Ox4GHxQuVW20cETC/eLBeWhYFmMU2wlueqwRPF8a
	 CtnUzsl1rTPIlKey8kEdLD6hcm1tbXKmE9MaplH7fZ4n1iKmqg+19WKpQD8y6R4LxBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=H1GB+9zF;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D18606A324;
	Thu, 19 Nov 2026 11:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D18606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=H1GB+9zF
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FZlWxWQOfTu8MIOnQs8tHPP8BaxZ5f7gPpwsp5HI3JE=;
	b=H1GB+9zFnW/SvJtslH91Df7ak3Dzog+aP+lyrVw1I7r6dh9GV5S+L03tSEKKGfYwlVytvhFB2
	TODpNqzuAqKhW2Zu+equ7CxRDwUWygOGaeB5xtszGCgHTaKWQ7IgYPgk4ErJG64Tq7WbEN+lc+5
	mOZfGxBxxMjTz1M8ZhJTYCM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jVbX875bQz1prM1;
	Thu, 19 Nov 2026 19:16:56 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AB4640537;
	Thu, 19 Nov 2026 19:17:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 19:17:10 +0800
Message-ID: <dba7bad1-e9d1-4a13-8045-0ea9fd739244@huawei.com>
Date: Thu, 19 Nov 2026 19:17:09 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 11/13] vfio/pci: Add DS-ST TPH policy and TPH_RESOLVE
 capability
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-12-fengchengwen@huawei.com>
 <sashiko-outbox-220836@kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <sashiko-outbox-220836@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Thanks for the review. Here is how we fix these three issues:

On 11/18/2026 7:43 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] vfio/pci: vfio_pci_core_feature_tph_resolve() fails when
>   !has_arch_st

DS‑ST CPU steering tag resolution can work without an architected ST table.
Currently vfio_pci_tph_get_src_mask() only enables CPU source mask when
CAP_PROG_ST_CPU is set, which is gated on architected ST table.
We update the mask check to accept CAP_PROG_ST_CPU *or* CAP_RESOLVE_CPU_ST.
Pure DS‑ST devices with only resolution capability will now accept CPU source
handles for RESOLVE.

> - [Medium] vfio/pci: vfio_tph_config_write() drops ST mode and active
>   req updates

The existing check only compares requester bits and ignores mode.
For DS‑ST, userspace may set DS mode while requester is disabled, then enable
requester in a separate write; the mode is lost.
We compare both requester and mode. Any change triggers pcie_enable_tph_ext()
to sync hardware.
We also auto-disable TPH before enabling a new requester mode to avoid -EBUSY.

> - [Medium] vfio/pci: vfio_pci_tph_get_capability() skips
>   pcie_tph_dsm_supported()

Both CAP_PROG_ST_CPU and CAP_RESOLVE_CPU_ST require TPH ST _DSM for CPU-to-ST
translation.
We trim tph_vcap centrally: if _DSM is not available, clear both CPU-related
capability bits, leaving only NO‑ST capability.
This logic is sufficient for the current series and will be revisited when P2P
support is added in follow-up patches.

Thanks

> --
> 
> commit 5b864ef3e267f2d34a7496c96455a9bee2cc860b
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Add DS-ST TPH policy and TPH_RESOLVE capability
> 
> This commit adds the DS-ST policy level to vfio-pci and introduces the
> VFIO_DEVICE_FEATURE_TPH_RESOLVE ioctl feature for resolving CPU steering
> tags on DS-ST capable devices.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index 398f8db8b8ff0..8e47f84216b0d 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -1218,7 +1218,7 @@ static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
>>  	cap = vdev->tph_vcap;
>>  	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
>>  	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
>> -	if (mode > PCI_TPH_ST_IV_MODE || !(cap & (1u << mode)) ||
>> +	if (mode > PCI_TPH_ST_DS_MODE || !(cap & (1u << mode)) ||
>>  		req == 0x2 /* reserved */ ||
>>  		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
>>  		goto out; /* Drop invalid or unsupported write value. */
> 
> [Severity: Medium]
> Can vfio_tph_config_write() drop or overwrite ST Mode Select updates?
> 
> Right below this check, vfio_tph_config_write() still skips hardware
> updates whenever req == org_req:
> 
> drivers/vfio/pci/vfio_pci_config.c:vfio_tph_config_write() {
>     ...
> 	vfio_user_config_read(pdev, start + PCI_TPH_CTRL, &ctrl_val, 4);
> 	vfio_default_config_write(vdev, start + PCI_TPH_CTRL, 4, perm,
> 				  PCI_TPH_CTRL, ctrl_val);
>     ...
> 	org_req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
> 	if (req == org_req)
> 		goto out; /* Only care about requester enable. */
> 
> 	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH)
> 		pcie_enable_tph_ext(pdev, mode, req);
> 	else if (req == PCI_TPH_REQ_DISABLE)
> 		pcie_disable_tph(vdev->pdev);
>     ...
> }
> 
> If userspace writes PCI_TPH_ST_DS_MODE while the requester is disabled
> (req == org_req == PCI_TPH_REQ_DISABLE) before enabling it in a second
> write, the first write is not committed to hardware and the second write
> clobbers vconfig[start + PCI_TPH_CTRL] from hardware (where mode is still
> 0), enabling the device in NO-ST mode.
> 
> Similarly, changing mode while TPH is already enabled is ignored because
> req == org_req, disabling the requester via pcie_disable_tph() zeroes the
> entire hardware PCI_TPH_CTRL register including ST Mode Select, and
> switching req between PCI_TPH_REQ_TPH_ONLY and PCI_TPH_REQ_EXT_TPH while
> enabled fails in pcie_enable_tph_ext() with -EBUSY because pdev->tph_enabled
> is already set.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 23ed8ea396575..049392831b35f 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1710,12 +1710,17 @@ static void vfio_pci_tph_dev_deinit(struct vfio_pci_core_device *vdev)
>>  static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
>>  {
>>  	bool has_arch_st;
>> +	u32 cap = 0;
>>  
>>  	has_arch_st = vfio_pci_tph_has_architected_st(vdev);
>> -	if (!has_arch_st)
>> -		return 0;
>> +	if (has_arch_st)
>> +		cap |= VFIO_DEVICE_TPH_CAP_PROG_ST_NONE |
>> +		       VFIO_DEVICE_TPH_CAP_PROG_ST_CPU;
>>  
>> -	return VFIO_DEVICE_TPH_CAP_PROG_ST_NONE | VFIO_DEVICE_TPH_CAP_PROG_ST_CPU;
>> +	if (vdev->tph_vcap & PCI_TPH_CAP_ST_DS)
>> +		cap |= VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST;
>> +
>> +	return cap;
>>  }
> 
> [Severity: Medium]
> Should vfio_pci_tph_get_capability() check pcie_tph_dsm_supported(vdev->pdev)
> before advertising VFIO_DEVICE_TPH_CAP_PROG_ST_CPU and
> VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST?
> 
> Commit "PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH
> ST _DSM" earlier in this series added pcie_tph_dsm_supported() to check
> whether the root port exposes the ACPI TPH _DSM method, but nothing calls
> it.  On systems without CONFIG_ACPI or without that _DSM on the root port,
> VFIO_DEVICE_FEATURE_TPH GET advertises CPU steering tag support that will
> always fail when invoked.
> 
>> @@ -1901,6 +1906,50 @@ static int vfio_pci_core_feature_tph_program(struct vfio_pci_core_device *vdev,
>>  	return ret;
>>  }
>>  
>> +static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device *vdev,
>> +			u32 flags,
>> +			struct vfio_device_feature_tph_resolve __user *arg,
>> +			size_t argsz)
>> +{
>> +	struct vfio_device_feature_tph_resolve resolve;
>> +	u32 user_flags, src_mask;
>> +	bool extended;
>> +	u16 tag = 0;
>> +	int ret;
>> +
>> +	if (!vdev->tph_opt_in || !(vdev->tph_vcap & PCI_TPH_CAP_ST_DS))
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
>> +				 sizeof(resolve));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	if (copy_from_user(&resolve, arg, sizeof(resolve)))
>> +		return -EFAULT;
>> +
>> +	user_flags = resolve.flags;
>> +	extended = !!(user_flags & VFIO_DEVICE_TPH_EXTENDED);
>> +	if (extended && !pcie_ext_tph_supported(vdev->pdev))
>> +		return -EOPNOTSUPP;
>> +	user_flags &= ~VFIO_DEVICE_TPH_EXTENDED;
>> +
>> +	src_mask = vfio_pci_tph_get_src_mask(vdev) & ~VFIO_DEVICE_TPH_SRC_NONE;
>> +	if (user_flags & ~src_mask || !is_power_of_2(user_flags))
>> +		return -EINVAL;
> 
> [Severity: High]
> Does vfio_pci_core_feature_tph_resolve() always fail with -EINVAL on DS-ST
> devices that do not also have an architected ST table?
> 
> vfio_pci_tph_get_src_mask() only checks VFIO_DEVICE_TPH_CAP_PROG_ST_CPU,
> which is gated on vfio_pci_tph_has_architected_st(vdev), and ignores
> VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST:
> 
> drivers/vfio/pci/vfio_pci_core.c:vfio_pci_tph_get_src_mask() {
> 	u32 flags = vfio_pci_tph_get_capability(vdev);
> 	u32 src_mask = 0;
> 
> 	if (flags & VFIO_DEVICE_TPH_CAP_PROG_ST_NONE)
> 		src_mask |= VFIO_DEVICE_TPH_SRC_NONE;
> 	if (flags & VFIO_DEVICE_TPH_CAP_PROG_ST_CPU)
> 		src_mask |= VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
> 			    VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT;
> 
> 	return src_mask;
> }
> 
> When a DS-ST device has PCI_TPH_LOC_NONE (storing steering tags in
> device-specific MMIO or firmware rather than an architected ST table),
> vfio_pci_tph_get_src_mask() returns 0, so src_mask is 0 and every
> VFIO_DEVICE_FEATURE_TPH_RESOLVE call is rejected with -EINVAL.
> Checking (flags & (VFIO_DEVICE_TPH_CAP_PROG_ST_CPU |
> VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST)) in vfio_pci_tph_get_src_mask() would
> allow CPU source resolution when only VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST
> is supported.
> 

