Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9041D4606;
	Fri,  3 Jul 2026 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783039905; cv=none; b=bW2ZTnOBjgzIGNUfo0EUq8EIToQk19BeZKnCDwwiLx+oCCYVAYtwx92KsEZt+HilFP22C1R3iMtj0oKlX9v2VoO/kSYvHjEQLoUWUDTUKdT8SlP3nM343C5eeJcm50JeYzNFyW5/cvKR+SKSnDJQxdJ6Z8Qe4gzfl+9KxT8diDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783039905; c=relaxed/simple;
	bh=Gpz1rYSNWNaTS+A5zRNo5P+td+nlUMUPa/xfq1B/cTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=abn60tCBS+MH0Gz6qex6jEpKQFBMGIa0fJKi2x+i1Mkswm5IvQav1KffNer+jhTPiZPRcGDzQmSOju5hd+tL8Iw2rCWblvQMUhEgDKyQsNuguD1VmOSoKiO5WF1CMQcPXlhkMjVE6/nGNukCxFr3OZPnUgQwRs+SUamS6sLEGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c7BXrWNU; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c7BXrWNU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ericW9Gt1+BueOa7uP3mnnG00WliJ4w3XvTiVRYrxcw=;
	b=c7BXrWNUi27lPBb93eYpdYrRfD+pSPSap5C9h0iuI1fZyTyW5bNc9LuzYCEP0sp/zS7JWA/c5
	g796VE5KfuATIkH/Dxpxil90BBBx+I7L93B8kvRsX3nCyJh1rbb4aLJ2raCdelABv/oIwfVCM7O
	0Z609XWuxiAra9SeMJGsKfU=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4grw2m4MHyz12LFj;
	Fri,  3 Jul 2026 08:42:56 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D1E834058F;
	Fri,  3 Jul 2026 08:51:38 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Jul 2026 08:51:38 +0800
Message-ID: <6ba50569-650b-400e-8d07-9d52abe3f98b@huawei.com>
Date: Fri, 3 Jul 2026 08:51:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 11/18] vfio/pci: Virtualize PCIe TPH capability
 registers
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-12-fengchengwen@huawei.com>
 <20260702130414.5DA5A1F00A3D@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260702130414.5DA5A1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Thanks for the review.

On 7/2/2026 9:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Critical] Out-of-bounds read and write on the `perm->virt` and `perm->write` kernel heap buffers due to unvalidated dynamic hardware TPH capability length.

TPH perm buffer OOB: Safe per PCI spec, ST table capped at 64 entries,
all permission setup stays under 0xFF limit, VFIO access validates perm
ranges.

> 
> Pre-existing issues:
> - [Critical] Missing bounds check in `vfio_ecap_init` can lead to a heap buffer overflow when handling extended capabilities with dynamically parsed lengths.

vfio_ecap_init overflow: Pre-existing generic issue for all dynamic ecaps,
not introduced by this patch; I think we need another patch for this (not
in this serial).

Thanks

> --
> 
> commit 78dd911822344404c5af18d9dd92fb51e5d34a18
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Virtualize PCIe TPH capability registers
> 
> This patch implements virtualization and policy masking for the PCIe TPH
> extended capability. It splits configuration space permissions to keep the
> header read-only while marking TPH_CTRL and ST-table entries as virtually
> writable, and adjusts virtual capability bits based on hardware support.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index 5c6ab172df6c0..06d7b2fbf866a 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -1086,6 +1086,73 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
>>  	return 0;
>>  }
>>  
>> +/* Permissions for TPH extended capability */
>> +static int __init init_pci_ext_cap_tph_perm(struct perm_bits *perm)
>> +{
>> +	int i;
>> +
>> +	if (alloc_perm_bits(perm, pci_ext_cap_length[PCI_EXT_CAP_ID_TPH]))
> 
> [Severity: Critical]
> Does this code under-allocate the permission bits if the capability length
> is dynamically larger than 256 bytes?
> 
> Because pci_ext_cap_length[PCI_EXT_CAP_ID_TPH] is 0xFF, alloc_perm_bits()
> will allocate a fixed 256-byte buffer. If vfio_ext_cap_len() calculates a
> dynamically larger TPH capability size based on a device's ST table, it
> appears subsequent user space reads or writes past offset 255 could cause an
> out-of-bounds heap access when vfio_default_config_read() or
> vfio_default_config_write() calls memcpy() against perm->virt and perm->write.
> 
>> +		return -ENOMEM;
>> +
>> +	p_setd(perm, 0, ALL_VIRT, NO_WRITE);
> 
> [ ... ]
> 
>> @@ -1704,6 +1774,8 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
>>  		ret = vfio_fill_vconfig_bytes(vdev, epos, len);
>>  		if (ret)
>>  			return ret;
>> +		if (ecap == PCI_EXT_CAP_ID_TPH && !hidden)
>> +			vfio_tph_capability_adjust(vdev, epos);
> 
> [Severity: Critical]
> This is a pre-existing issue, but could the dynamically calculated length lead
> to a heap buffer overflow here?
> 
> If a faulty or malicious device advertises a large ST table size,
> vfio_ext_cap_len() can calculate a length where epos + len significantly
> exceeds pdev->cfg_size. Since there appears to be no bounds check before:
> 
> drivers/vfio/pci/vfio_pci_config.c:vfio_ecap_init() {
>     ...
>     memset(map + epos, ecap, len);
>     ret = vfio_fill_vconfig_bytes(vdev, epos, len);
>     ...
> }
> 
> could this overflow the vdev->pci_config_map and vdev->vconfig heap buffers?
> 
>>  
>>  		/*
>>  		 * If we're just using this capability to anchor the list,
> 

