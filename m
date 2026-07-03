Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041918DB2A;
	Fri,  3 Jul 2026 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783038981; cv=none; b=JOxM206/JA3pv3oSnzWFF+bAwKo0iVTrCOKgXr9JeuuGnH7NH6LUy6ht9Rmr70LfYwZ7thGE5Ig4QQnETfnuKMu5rdFtTMJctEzZ0UZmsJblOD1DiqmTXgK2ZS1iLGIuuUDs1cq5d0tR6CYLXmAwN71xbK9oTH1xlUR0PPLXom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783038981; c=relaxed/simple;
	bh=HQOl5f+3BFXxdbqHvPxam/utoMEvo8BUmmSaeT0HYNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mI3W5DBOp/OKw8J8XfFFOaGjzBsn6151+CCtPcNDvYnd6vgn6UKHi4Ih9kmt+JVMx8qecxQ5hPsqws3MHq6UnUoswy9o8V2NUHTQIiY6WinPSQr1QkKAsU1aF2tdHqa3WEePzlBx8WiynD14RqonLSFQv8zu7UBRYzItOVqmGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=w3GpvQQ5; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="w3GpvQQ5"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ks18hZZIQFp1HIdQaDajUBkbfQZ3RKQTkJwHEed0hmg=;
	b=w3GpvQQ5ZdlgY/RW5aI8QLtdzoZMKkMbRA5STbEjActyvnoewk4v4RI0I2hDbX6oCNrKV/s+n
	/R/w2/jHYUGL69wALiROuh5o4F1iIXDXvMu5uuMgb6lqnP/XhnssdQ2L6s7e2doMx3znU8p6X5j
	/tA9ZTFcTTyRQzAVcWJy96w=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4grvhz3bLTz12LFj;
	Fri,  3 Jul 2026 08:27:31 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id B567D40572;
	Fri,  3 Jul 2026 08:36:13 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Jul 2026 08:36:13 +0800
Message-ID: <3c7bf42e-9ff7-4bf2-a0d1-71e93c3cfdd1@huawei.com>
Date: Fri, 3 Jul 2026 08:36:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 09/18] vfio/pci: Hide TPH capability when TPH is
 unsupported
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-10-fengchengwen@huawei.com>
 <20260702130039.87A7B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260702130039.87A7B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 7/2/2026 9:00 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Hiding the TPH capability by returning a length of 0 unintentionally grants the guest raw read/write access to the physical TPH registers.

After checking the full vfio_ecap_init logic, this is a false positive risk
report.

When vfio_ext_cap_len() returns 0 for unsupported TPH ecap, the !len branch
takes over:
1. It allocates minimal PCI_CAP_SIZEOF length and marks hidden=true;
2. memset(map + epos, PCI_EXT_CAP_ID_TPH, len) populates pci_config_map,
   so these offsets are never marked PCI_CAP_ID_INVALID;
3. Accesses to TPH range hit the dedicated TPH ecap permission table
   with vfio_tph_config_write handler which discards all writes,
   never falling back to unassigned_perms raw physical write.

The hidden flag erases the capability ID in virtual config space so guests
cannot enumerate TPH, while full permission isolation is retained for all
config offsets of this ecap. No raw hardware bypass vulnerability exists
with current implementation.

Thanks

> --
> 
> commit 1d6f16c85a6a295f7dee447fc8d7ac56c232977a
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Hide TPH capability when TPH is unsupported
> 
> Check the device negotiated TPH support status before parsing the TPH
> extended capability. Return zero length to hide the capability from
> userspace if TPH is disabled during topology negotiation.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index a10ed733f0e3a..5c6ab172df6c0 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
> [ ... ]
>> @@ -1450,6 +1451,8 @@ static int vfio_ext_cap_len(struct vfio_pci_core_device *vdev, u16 ecap, u16 epo
>>  		byte &= PCI_DPA_CAP_SUBSTATE_MASK;
>>  		return PCI_DPA_BASE_SIZEOF + byte + 1;
>>  	case PCI_EXT_CAP_ID_TPH:
>> +		if (!pcie_tph_supported(pdev, false))
>> +			return 0;
> 
> [Severity: High]
> Does hiding the capability by returning 0 here inadvertently grant the guest
> raw read/write access to the physical TPH registers?
> 
> When a length of 0 is returned in vfio_ext_cap_len(), the VFIO capability
> parsing loop skips mapping the capability. This leaves the physical offsets
> marked as PCI_CAP_ID_INVALID in vdev->pci_config_map.
> 
> Guest accesses to unmapped offsets fall back to unassigned_perms:
> 
> static struct perm_bits unassigned_perms = {
> 	.readfn = vfio_raw_config_read,
> 	.writefn = vfio_raw_config_write
> };
> 
> This allows a guest to perform raw writes directly to the physical device
> using vfio_raw_config_write(), bypassing VFIO isolation.
> 
> Could a malicious guest use this raw access to manually enable TPH and
> configure Steering Tags to steer DMA to arbitrary CPU caches?
> 
>>  		ret = pci_read_config_dword(pdev, epos + PCI_TPH_CAP, &dword);
>>  		if (ret)
>>  			return pcibios_err_to_errno(ret);
> 

