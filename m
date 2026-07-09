Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0B424660;
	Thu,  9 Jul 2026 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600773; cv=none; b=VqpnIdEmJDBFarVwXGuaXaBhZ6KdJO4iWup2iTRx/Q1BIxFveEOlgG9Y52Tt1DAVXwRctMHozSAJHj8kIU+67dZEhidwFjFU1IXJOcP0TWW6aAOl6o1Ql5lVDrhI/fsS3COd45pr74JGNGJjgfqteoa6qIdt9BTOWx9gRt/oB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600773; c=relaxed/simple;
	bh=RZ8VjDklG/jzIcIcYaBb3OzMYd/YgJHyt56veG+RMsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y+GJtCXtafnwP7hlXlPKwtzqEkS57SpPx2iGYbHomcBQ9JjcwxTeFNQ97DXDin3xcjSachxmW2nU1MpKgBcSBKkPgtUbxpXSjJNZFPk1y48NqQw4FLX5SzVppS2h7HHRQ52gBKwrifRQ7yWAEfXUpkeEAh7ydqM9BLMYXanemHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dA2zXK/M; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dA2zXK/M"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IJ8deCNBpt+7i94SRWOOCRLpkE+NC9fmOvAWjZIqzss=;
	b=dA2zXK/MGkYJ/hTvP78vCbhdEwyW6AXx9Aro/SnINH+SMa74hBKM6E6Tk9uEKwchP34sRjfPx
	MX1zAStsxFls1YFxBTG93qsxz8MIcsrf+nwwpLbJMDxdIP8Tub3NWM6Ji1ZY9fG2xf/2eiiuB07
	vvrh/m/7jkDGETfWYwVdMtQ=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwvS35MBYzKm73;
	Thu,  9 Jul 2026 20:30:11 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id F3A2440586;
	Thu,  9 Jul 2026 20:39:28 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 20:39:28 +0800
Message-ID: <60bc4baf-47c5-4457-8a35-373925c9fd80@huawei.com>
Date: Thu, 9 Jul 2026 20:39:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 17/18] vfio/pci: Reset hardware TPH state on device
 enable/disable
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-18-fengchengwen@huawei.com>
 <20260708172944.685c3cea@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708172944.685c3cea@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/9/2026 7:29 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:23 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> VFIO allows user space to enable and modify PCI TPH state, but device
>> reset only clears hardware TPH registers, while the software TPH state
>> maintained in pci/tph.c remains stale.
> 
> It's saved and restored, why is it "stale"?  It seems more that the
> interface simply doesn't meet our use case.
> 
> What about resets through vfio-pci interfaces, should TPH be
> automatically disabled?  Thanks,

The PCI saved state only covers hardware registers, the internal software
context inside pci/tph.c won’t be cleared by device reset. This leaves stale
TPH enable state across VFIO user sessions.

I will also add TPH disable logic into VFIO device reset path to keep all
reset scenarios consistent.

Thanks

> 
> Alex 
> 
>> Fix the stale state leakage by explicitly disabling TPH in core enable
>> and disable paths:
>> - In vfio_pci_core_enable(), clear leftover TPH state from previous
>>   user sessions before device initialization.
>> - In vfio_pci_core_disable(), revert any user-modified TPH state
>>   when releasing the device.
>>
>> This ensures consistent TPH hardware and software state for each
>> user session and avoids residual state contamination.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_core.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 7251e251824a..5a14439d1ccb 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -612,6 +612,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>>  
>>  	vdev->reset_works = !ret;
>>  	vdev->tph_permit = false;
>> +	/* Reset TPH status on new user session */
>> +	pcie_disable_tph(vdev->pdev);
>>  	pci_save_state(pdev);
>>  	vdev->pci_saved_state = pci_store_saved_state(pdev);
>>  	if (!vdev->pci_saved_state)
>> @@ -759,6 +761,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>>  
>>  	vfio_pci_zdev_close_device(vdev);
>>  
>> +	/* Reset TPH status on exit user session */
>> +	pcie_disable_tph(vdev->pdev);
>> +
>>  	/*
>>  	 * If we have saved state, restore it.  If we can reset the device,
>>  	 * even better.  Resetting with current state seems better than
> 

