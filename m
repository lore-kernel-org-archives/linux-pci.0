Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57E1A3029;
	Wed, 15 Jul 2026 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784084977; cv=none; b=u8AMhNDqD3IUMREYwz7/IgoezJIKYnjlVoQulXtB+cdBFZYLTy/1cb4ka8FBz3LPXEU6mb3e4CpBTNN2n6uTSurlLGlTEq024yLNTFj8ibtQIjIergsys8OqdKAfL9mxvt2+sAYqbADIRLq5Q1GkktOwDaD8khgG6HiH4y+MVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784084977; c=relaxed/simple;
	bh=BF5SLO2hnIpIhAtZcj5YHs4FYIZuYhsYin/4s/yn/RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WpSS9sPt+deBYm1jwqbMfx9T2FK2BpdjQ01be4xXcE2rB4z6iBBKPClRUeovqPOefwMckRWrJKJvtIAchFMLesJcW65i9HiMGIkqSitnoV0AWUUmPW4slyStys8HFP7lJDe95C9EBRu0F1Qa9kf7PlKltqfBJNrNKKXC1O8CJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JfTLNYUS; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JfTLNYUS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9O0MTF4ePsrdRfdpjyFbSHNwNNmx8iggG48MITZNpNg=;
	b=JfTLNYUSIwh2rSm7Wj5HgqeTpPWvCo6BSe54JLt9A+jmhYwDzPvdquoPjUD7EEbKutq9WI9iK
	1brEEJWYfwETLfaMvh29+hZatAb9iqR584YwCTRjkGlvUZUK5UjFSuygiaB9zis6cuMZeXRUaYO
	27SegEw9kUxr49kfmqjxyf4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h0LWd0DQmz1cyTS;
	Wed, 15 Jul 2026 11:00:13 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C3E614055B;
	Wed, 15 Jul 2026 11:09:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 15 Jul 2026 11:09:29 +0800
Message-ID: <0fe381d6-8ea9-41d6-baf6-97db48b40aa0@huawei.com>
Date: Wed, 15 Jul 2026 11:09:28 +0800
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

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

I initially added TPH disable logic into VFIO reset paths in v20 to make
all reset scenarios consistent, but after reviewing Sashiko's feedback
and re-checking PCI core state management, I agree we do NOT need extra
pcie_disable_tph() calls in VFIO reset ioctl handlers.

VFIO reset ioctls eventually trigger the PCI state save/restore flow,
which invokes pci_save_tph_state() and pci_restore_tph_state() to handle
TPH capability and control registers properly. TPH configuration state
will be restored to the saved value automatically after reset.

One important exception is the Steering Tag table when located in MSI-X
vector space (PCI_TPH_LOC_MSIX). The pci_save_tph_state() helper only
saves TPH capability registers; it does not back up ST entries stored in
MSI-X table entries. After any PCI reset, those ST values are lost along
with the rest of the MSI-X table and are not restored automatically.

I will add explicit documentation to the VFIO_DEVICE_FEATURE_TPH_ST uAPI
comments stating that userspace must re-program all ST table entries via
this feature after any device reset, as ST entries are not preserved
across PCI resets (especially for MSI-X backed ST tables).

The pcie_disable_tph() calls in vfio_pci_core_enable/disable paths are
still kept for cross-session isolation: they ensure TPH is fully disabled
when a device is released from one user and before it is handed to the
next, preventing leftover TPH configuration leaking across independent
user sessions.

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

