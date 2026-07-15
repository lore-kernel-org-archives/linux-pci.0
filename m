Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5040348C78;
	Wed, 15 Jul 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100755; cv=none; b=ZzBzvJKa5ZRLVD+EAiibUpghPLcerR/+qcamGGdgSHpQ1ZyKDVrEPNUaT55pFfb1kNgN+ipprqdoCRKQf6xDah20sJjoCGTys6MZbYRuposkvF4RhYX1FlTVgBfyIt0qDXJmLClqCx1/bVQB9A4UTZfYaTvQS+jz3+vtEcK4mTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100755; c=relaxed/simple;
	bh=OjS9tokFABB+d5eR2JMPpkESEL2SdOLbHPohg4+yP/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JIao/0rXBdI973TLCeL1KFscXYwOFnrHtyl2nCrZfL9scafT676ZebakV9gfrEgYEsynQnjz0mGXRnziPh5/M3QxOif2I+cD4rZIf/eCL6dbovs7Z8kJCaIlDkvF3+j9lT/KMjvhsKU+RJfPqn9OKCZLQ0LGEkO3h80DZe+mhSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KW66kTDx; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KW66kTDx"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WZB1bL1yOc1IiYk9ev+rKFg4EaUjYHyraaIG38ewn2w=;
	b=KW66kTDxVcFYNs19sMN7t0azfc3iExpjSbcj7yuczKzF0+i4W/fNtQnbxe0+ptvLmmqT/88jX
	FBk/MlhrIKFx8KcpfyakRFql1sO/9m9C6G3UkwEMBGpSTM2y+GrAdcxWxXcszPrMmh+XiDl/krH
	U7pdvFx3sq+z8WLJlW20RnM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h0SM83t5Jz1T4Mc;
	Wed, 15 Jul 2026 15:23:16 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 12F4340538;
	Wed, 15 Jul 2026 15:32:27 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 15 Jul 2026 15:32:26 +0800
Message-ID: <2fbef56c-d6a7-45bd-9940-b350b28816e7@huawei.com>
Date: Wed, 15 Jul 2026 15:32:25 +0800
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
 <0fe381d6-8ea9-41d6-baf6-97db48b40aa0@huawei.com>
 <20260714222313.2fc9069f@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260714222313.2fc9069f@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 7/15/2026 12:23 PM, Alex Williamson wrote:
> On Wed, 15 Jul 2026 11:09:28 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
>> On 7/9/2026 7:29 AM, Alex Williamson wrote:
>>> On Thu, 2 Jul 2026 20:42:23 +0800
>>> Chengwen Feng <fengchengwen@huawei.com> wrote:
>>>   
>>>> VFIO allows user space to enable and modify PCI TPH state, but device
>>>> reset only clears hardware TPH registers, while the software TPH state
>>>> maintained in pci/tph.c remains stale.  
>>>
>>> It's saved and restored, why is it "stale"?  It seems more that the
>>> interface simply doesn't meet our use case.
>>>
>>> What about resets through vfio-pci interfaces, should TPH be
>>> automatically disabled?  Thanks,  
>>
>> I initially added TPH disable logic into VFIO reset paths in v20 to make
>> all reset scenarios consistent, but after reviewing Sashiko's feedback
>> and re-checking PCI core state management, I agree we do NOT need extra
>> pcie_disable_tph() calls in VFIO reset ioctl handlers.
>>
>> VFIO reset ioctls eventually trigger the PCI state save/restore flow,
>> which invokes pci_save_tph_state() and pci_restore_tph_state() to handle
>> TPH capability and control registers properly. TPH configuration state
>> will be restored to the saved value automatically after reset.
>>
>> One important exception is the Steering Tag table when located in MSI-X
>> vector space (PCI_TPH_LOC_MSIX). The pci_save_tph_state() helper only
>> saves TPH capability registers; it does not back up ST entries stored in
>> MSI-X table entries. After any PCI reset, those ST values are lost along
>> with the rest of the MSI-X table and are not restored automatically.
> 
> False.  It's not restored as a separate TPH operation, the ST
> upper/lower is stored in the MSI-X vector control register, which is
> restored from kernel state (without a separate save-state function)
> via:
> 
> __pci_restore_msix_state()
> 	pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);

That's great. Thanks for pointing that out.

>  
>> I will add explicit documentation to the VFIO_DEVICE_FEATURE_TPH_ST uAPI
>> comments stating that userspace must re-program all ST table entries via
>> this feature after any device reset, as ST entries are not preserved
>> across PCI resets (especially for MSI-X backed ST tables).
> 
> Only DS is not saved and restored.

Should this be explicitly document in the uAPI?

Thanks

> 
> Alex

