Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC91EB19B;
	Mon, 15 Jun 2026 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486801; cv=none; b=Yng8QecCjwKDhApq2JsFfKtweL/75dh0/zli1pHvCcx1eYrFxVjUaMkdGXr/rkg6WSm2UDBLkUL1koJmARqS0mJ9XyBIZ4OxeV2FmZY7nIkL8BIJk9+rvcHmRNETaoLFpQko+f5s0Zj6wGmghuuBMA4PsFdeZdrZce09rXRtbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486801; c=relaxed/simple;
	bh=MynTN/j/Elu7Isl5o1OmE54sQkEEZuFIOdk5QNWTtok=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jU6HIaAxkLAgbnryi8xmB65IwrDrf7uMG/+0BNgF/wMzrQzrlG4S4cTh4lPdEsK3TTnq206egKkqg/gFEUEsE7kVepQ/eLOLAX/a4x0lFOQ1xr1GMpQIip8+VE2P/E4GDQt4qUn3agXb4UUKhOw/e7TjGOEDyctUo68W3NVH99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HZJYxjak; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HZJYxjak; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HZJYxjak";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HZJYxjak"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wHjq3Q9Ijh0RF30tM2eiUI7AhlsnKbUAGXPI8uhsb68=;
	b=HZJYxjak66cgxCAyEZGIAYq5HxeMdU6qUQcx0AR13MujXq0WoLBWlO5XcBA7MfD1/euzD3C5o
	I2olO/+0Ss3JAkEFjeVIstbu16EjIZnzR117SmFVFvvfOyKxZ9TsJHO2dp+wwEjDWlHpvBJ0nj6
	hiefLD1MmoOpebZKNl0tW78=
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gdsrz36BFz1BFMY;
	Mon, 15 Jun 2026 09:26:11 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wHjq3Q9Ijh0RF30tM2eiUI7AhlsnKbUAGXPI8uhsb68=;
	b=HZJYxjak66cgxCAyEZGIAYq5HxeMdU6qUQcx0AR13MujXq0WoLBWlO5XcBA7MfD1/euzD3C5o
	I2olO/+0Ss3JAkEFjeVIstbu16EjIZnzR117SmFVFvvfOyKxZ9TsJHO2dp+wwEjDWlHpvBJ0nj6
	hiefLD1MmoOpebZKNl0tW78=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gdsh30nWXzpTKG;
	Mon, 15 Jun 2026 09:18:27 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1551540672;
	Mon, 15 Jun 2026 09:26:26 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 09:26:25 +0800
Message-ID: <42b0a9ac-f384-4129-b718-636fd392a703@huawei.com>
Date: Mon, 15 Jun 2026 09:26:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 09/12] vfio/pci: Add TPH_ENABLE feature skeleton and
 unsafe module parameter
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260604132804.28678-10-fengchengwen@huawei.com>
 <20260604135424.750F21F0089A@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260604135424.750F21F0089A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 6/4/2026 9:54 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Lockless modification of the `tph_permit` bitfield causes a C11 data race with adjacent bitfields, potentially corrupting device state.
> - [Medium] The `tph_permit` flag is not cleared when the device is closed, leaking the enabled state to subsequent users of the device.

Thanks for the feedback.

I'll address these two points in v17:
- Change tph_permit to a standalone bool to fix the bitfield data race, no lock needed.
- Reset tph_permit on device close to prevent state leakage across sessions.

Thanks

> --
> 
> commit d0a7c28453cdbf1699133633ce00cd13507a2648
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Add TPH_ENABLE feature skeleton and unsafe module parameter
> 
> This commit introduces the framework for PCIe TPH (Transaction Processing
> Hints) support in VFIO. It adds a global enable_unsafe_tph module parameter
> and a new VFIO_DEVICE_FEATURE_TPH_ENABLE uapi to allow userspace to set a
> per-device tph_permit flag.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3f8d093aacf8a..ae05343701f76 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
> 
> [ ... ]
> 
>> @@ -1516,6 +1517,24 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
>>  	return 0;
>>  }
>>  
>> +static int vfio_pci_core_feature_tph_enable(struct vfio_pci_core_device *vdev,
>> +					    u32 flags, size_t argsz)
>> +{
>> +	int ret;
>> +
>> +	if (!enable_unsafe_tph)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
>> +	if (ret <= 0)
>> +		return ret;
>> +
>> +	if (!vdev->tph_permit)
>> +		vdev->tph_permit = 1;
> 
> [Severity: High]
> Does setting this bitfield without a lock cause a read-modify-write data
> race with adjacent bitfields?
> 
> Looking at struct vfio_pci_core_device, tph_permit shares the same memory
> word as pm_intx_masked and pm_runtime_engaged. Since C compilers implement
> bitfield assignments via read-modify-write operations, could a concurrent
> lockless update here overwrite a state change made elsewhere?
> 
> For example, vfio_pci_core_runtime_suspend() updates vdev->pm_intx_masked
> without holding any locks. If the ioctl and runtime PM suspend execute
> concurrently, it seems one could overwrite the other's state change, which
> could cause the kernel to fail to unmask INTx interrupts during resume.
> 
> [Severity: Medium]
> Is there a mechanism to clear this flag when the device is closed?
> 
> Because struct vfio_pci_core_device is tied to the PCI device lifetime and
> is not reallocated between sessions, it appears a subsequent user opening
> the device will inherit tph_permit = 1.
> 
> While hardware state might be cleaned up on close in functions like
> vfio_pci_core_disable() or vfio_pci_tph_deinit(), could failing to clear
> vdev->tph_permit bypass the userspace opt-in requirement for future sessions,
> allowing a VMM that never called VFIO_DEVICE_FEATURE_TPH_ENABLE to configure
> ST tables?
> 
>> +
>> +	return 0;
>> +}
>> +
>>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  				void __user *arg, size_t argsz)
>>  {
> 
> [ ... ]
> 
>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>> index 2ebba746c18f7..5f32830766a0f 100644
>> --- a/include/linux/vfio_pci_core.h
>> +++ b/include/linux/vfio_pci_core.h
> 
> [ ... ]
> 
>> @@ -127,6 +127,7 @@ struct vfio_pci_core_device {
>>  	bool			needs_pm_restore:1;
>>  	bool			pm_intx_masked:1;
>>  	bool			pm_runtime_engaged:1;
>> +	bool			tph_permit:1;
>>  	struct pci_saved_state	*pci_saved_state;
>>  	struct pci_saved_state	*pm_save;
>>  	int			ioeventfds_nr;
> 

