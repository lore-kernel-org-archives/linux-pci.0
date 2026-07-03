Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF35C613;
	Fri,  3 Jul 2026 01:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783041415; cv=none; b=SWs4pJAvsGKAWnMzA31mOuTU1fF/te8ccyObCXKcBtDAQi38aQVdAQApTokxXl6W1/aooy3Ekqkc041EUSNrtn7EWxsxG2cy+CamS0+0Ywgt16xotVXPoZz8IJpGtX/uaI7RTA74JxwhVGi6dfVf1h3Gyyz0vgfDizkKXosTbbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783041415; c=relaxed/simple;
	bh=8Jgbd82TiBTGNMpwWVxXMET7Rdf2WgZEFYPIo6okB9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ig6cioNR4BDGttDgHcekKH/nxWA1TGL7tZLN4vTnyUQSkXqgqavzT9TX2rkJNsPxkxVASIdVdTbKY0FRRns5xWOnAPktmBG/jmjZnGvcWG1vENSzdCJ4qHSbbvxZZRg+wET+rED8wSrV8udCwpg0H/ELht/XPMD1tDPuzhR30c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OxDNJRY4; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OxDNJRY4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lctvQk1XlyRBD/f6O2tuVs20FdY69i6+jyFcyQRznbk=;
	b=OxDNJRY46hBzpA1VY7uuJmAMFYspUm7K8/QoqH1yKKBTsAD7E06+hb6qksTEPdBhypnEbrdUY
	8I8dcxm7gmZAUPgzMHIbVOoRDL9VLPSMD4O+SLj2qZ6V1B3XJsbmfivRUXmEZXbG28TOWQdX4EE
	2EYltT34EdP6ZAmNkZUmdE8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4grwbb2M5Nz1T53n;
	Fri,  3 Jul 2026 09:07:55 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7158B2012A;
	Fri,  3 Jul 2026 09:16:48 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Jul 2026 09:16:47 +0800
Message-ID: <7b81caea-709e-45ec-98aa-7e69decd1367@huawei.com>
Date: Fri, 3 Jul 2026 09:16:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 14/18] vfio/pci: Implement VFIO_DEVICE_FEATURE_TPH and
 valid TPH config write support
To: <sashiko-reviews@lists.linux.dev>, Alex Williamson <alex@shazbot.org>
CC: <linux-pci@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-15-fengchengwen@huawei.com>
 <20260702130425.EA4641F00A3A@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260702130425.EA4641F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 7/2/2026 9:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Waking the device to PCI_D0 during TPH configuration writes or ST table programming fails to restore zapped DMA buffers, permanently breaking device DMA.

Raw vfio_pci_set_power_state() does not restore revoked dma-buf mappings, which
theoretically may trigger IOMMU faults for guests. There is a local helper
vfio_lock_and_set_power_state() that takes memory locks and runs
vfio_pci_dma_buf_move(vdev, false) after switching to D0 to rebuild DMA
IOVA mappings.

I’m considering replacing direct vfio_pci_set_power_state(PCI_D0) calls
in TPH write and TPH_ST paths with this wrapper. Could you help confirm
whether this is a valid concern and if this wrapper usage is acceptable here,
or if there are any hidden edge cases I need to handle?


> - [Medium] The `VFIO_DEVICE_FEATURE_SET` operation for TPH fails to copy and validate the userspace payload, breaking forward compatibility.

Will add copy_from_user + zero check in next version.

> 
> Pre-existing issues:
> - [High] Missing bounds checking in PCI capability parsing loops allows a malicious or spoofed PCIe endpoint to overflow the `vconfig` and `pci_config_map` heap buffers.

Pre-existing generic issue, separate cleanup patch later.

Thanks

> --
> 
> commit 6662e41b04cb5eb843722e0409b68031565e33d6
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Implement VFIO_DEVICE_FEATURE_TPH and valid TPH config write support
> 
> This commit adds support for VFIO_DEVICE_FEATURE_TPH in
> vfio_pci_core_feature_tph, allowing GET and SET operations for TPH features.
> It also implements vfio_tph_config_write to support TPH_CTRL modifications once
> TPH is permitted, managing power states as required for writing TPH registers.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index 06d7b2fbf866a..388dd6fed16b5 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -1150,6 +1150,60 @@ static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
>>  				 int count, struct perm_bits *perm,
>>  				 int offset, __le32 val)
>>  {
> [ ... ]
>> +	org_req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
>> +	if (req == org_req)
>> +		goto out; /* Only care about requester enable */
>> +
>> +	ret = vfio_pci_set_power_state(vdev, PCI_D0);
>> +	if (ret)
>> +		goto restore; /* Drop this write */
> 
> [Severity: High]
> Does waking the device to PCI_D0 here miss the required vfio_pci_dma_buf_move()
> call to restore DMA mappings?
> 
> If the device is in a low-power state (like D3hot) and its DMA buffers are
> zapped, forcing it to D0 without restoring the DMA mappings could leave the
> device active but unable to perform DMA, potentially causing IOMMU faults and
> breaking device functionality. Does the same issue also occur in the ioctl path
> for ST table batch programming?
> 
> [ ... ]
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3f11a9624b9c0..14944d3ea86e6 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
> [ ... ]
>> @@ -1607,6 +1609,38 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
>>  	return 0;
>>  }
>>  
>> +static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
>> +				     u32 flags,
>> +				     struct vfio_device_feature_tph __user *arg,
>> +				     size_t argsz)
>> +{
>> +	struct vfio_device_feature_tph tph = {0};
>> +	int ret;
>> +
>> +	if (!pcie_tph_supported(vdev->pdev, false))
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = vfio_check_feature(flags, argsz,
>> +			VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_SET,
>> +			sizeof(tph));
>> +	if (ret <= 0)
>> +		return ret;
>> +
>> +	if (flags & VFIO_DEVICE_FEATURE_SET) {
>> +		vdev->tph_permit = 1;
>> +		return 0;
>> +	}
> 
> [Severity: Medium]
> Does this code silently ignore userspace payloads for the VFIO_DEVICE_FEATURE_SET
> operation by skipping copy and validation?
> 
> Future kernel extensions that add new flags to struct vfio_device_feature_tph
> for the SET operation could be silently ignored by older kernels, which might
> break userspace's ability to safely probe or use new features. Should it verify
> that the payload is zeroed?
> 
> [ ... ]
> 
> While reviewing this code, I also noticed a pre-existing issue in
> vfio_ecap_init() in drivers/vfio/pci/vfio_pci_config.c:
> 
> [Severity: High]
> This is a pre-existing issue, but does the while loop in vfio_ecap_init()
> lack a bounds check for the heap buffers?
> 
> drivers/vfio/pci/vfio_pci_config.c:vfio_ecap_init() {
> [ ... ]
> 	while (loops-- && epos >= PCI_CFG_SPACE_SIZE) {
> [ ... ]
> 		for (i = 0; i < len; i++) {
> 			if (likely(map[epos + i] == PCI_CAP_ID_INVALID))
> 				continue;
> [ ... ]
> 		memset(map + epos, ecap, len);
> 		ret = vfio_fill_vconfig_bytes(vdev, epos, len);
> [ ... ]
> }
> 
> The loop condition only checks that epos >= PCI_CFG_SPACE_SIZE, but never
> verifies that epos + len <= pdev->cfg_size before accessing the heap
> allocations (map and vconfig). Could a malicious or spoofed PCIe endpoint
> provide an ecap with an epos and len that overflows these buffers?
> 

