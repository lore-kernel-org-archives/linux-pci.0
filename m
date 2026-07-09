Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D4379C32;
	Thu,  9 Jul 2026 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597260; cv=none; b=AfLeSo2F9MKnXhF8Obu1XBiIcoO6tyzfNCKT9gceoLxyG5pygnIJoGNZskQsbgt9CO/7krMWGDU5uhDpxqrxQFx26rCkcnCz2UAC8ez+VzGI0jEgG7BGnhsVnl4nSQjZxuIrJjJslbCld7NrOmnSy9A4fcmOjqz72hRZ7rMACIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597260; c=relaxed/simple;
	bh=FHrDlkrRjdOi33vFhwepsd9AkgF+dmss0uOzvOG2IGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ghwMe5+nVkQ7g47Xfe4QlFepMXyJrJ+B/6LkIQC+PG/Xoc96K+6eJSVDXAxY7Uj0IpQSQa+6thPWyOqkHq0bqH/+PH0J/fWKl4LoYuNKvLmHi6TdhfVat1Gg28vhgmpf0/+VMjb8TQRZeomS94tenRFLhxMrWmrZZKs6Hmv5cv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mCEae15t; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mCEae15t"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kAwH566p+bzKlmSM3SbiC5fBtpMIEBFI20SGPrKDoJA=;
	b=mCEae15tlDbKrbo3shjEofcI6v8RfK8sITEOVS2odfJRKkVvyyDDeq75YF0DCSR93yyUsGecQ
	7cokVuSAZ4aGUKAzTXCqa1nU32qNloOX4u48Hm6gFbn4L8K1lKXcF4g/975+JTfr7Eyc/MZSWth
	siR4ljicjAGIqubHF+aKMxI=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gwt8X27psz1K96m;
	Thu,  9 Jul 2026 19:31:40 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id BD8E84057A;
	Thu,  9 Jul 2026 19:40:53 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 19:40:53 +0800
Message-ID: <9092fc02-1ecb-46b7-870f-3560bdb426ca@huawei.com>
Date: Thu, 9 Jul 2026 19:40:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 11/18] vfio/pci: Virtualize PCIe TPH capability
 registers
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-12-fengchengwen@huawei.com>
 <20260708173128.687525c6@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708173128.687525c6@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 7/9/2026 7:31 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:17 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Implement virtualization and policy masking for PCIe TPH extended
>> capability:
>> - Split TPH config space permissions: keep header read-only, mark
>>   TPH_CTRL and ST-table entries virtually writable.
>> - Adjust virtual TPH capability bits according to hardware capability
>>   and tph_policy, hiding unsupported modes.
>> - Silently discard all write operations.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_config.c | 72 ++++++++++++++++++++++++++++++
>>  1 file changed, 72 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index 5c6ab172df6c..06d7b2fbf866 100644
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
>> +		return -ENOMEM;
>> +
>> +	p_setd(perm, 0, ALL_VIRT, NO_WRITE);
>> +	p_setd(perm, PCI_TPH_CAP, ALL_VIRT, NO_WRITE);
>> +
>> +	p_setd(perm, PCI_TPH_CTRL, ALL_VIRT,
>> +	       PCI_TPH_CTRL_MODE_SEL_MASK | PCI_TPH_CTRL_REQ_EN_MASK);
> 
> This makes the control bits virtualized, writable with no backing
> support yet.

I will gate all TPH config space virtualization and masking logic behind
the VFIO_DEVICE_FEATURE_TPH SET opt-in check. Without explicit opt-in,
TPH_CTRL and ST table entries will remain read-only to avoid exposing
writable virtual bits with no functional backing.

> 
>> +
>> +	/* Per PCI specification: There is an upper limit of 64 entries
>> +	 * when the ST table is located in the TPH Requester Extended
>> +	 * Capability structure.
>> +	 * And the pci_ext_cap_length[PCI_EXT_CAP_ID_TPH] is 0xFF, so the
>> +	 * following operation is fine.
>> +	 */
> 
> Wrong multi-line comment style.  Also 0xFF for cap length doesn't
> really explain why this is fine.  You are however highlighting that the
> above perm bits alloc of size 0xFF is not fine.

I will try to fix the length

> 
>> +	for (i = 0; i < 64; i++)
>> +		p_setw(perm, PCI_TPH_BASE_SIZEOF + i * sizeof(u16),
>> +		       (u16)ALL_VIRT, (u16)ALL_WRITE);
>> +
>> +	return 0;
>> +}
>> +
>> +static void vfio_tph_capability_adjust(struct vfio_pci_core_device *vdev,
>> +				       int pos)
> 
> Precedent is vfio_update_tph_vconfig_bytes(...)

OK

> 
>> +{
>> +	__le32 *vptr = (__le32 *)&vdev->vconfig[pos + PCI_TPH_CAP];
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	u32 val = le32_to_cpu(*vptr);
>> +	bool need_adjust = false;
> 
> Just write it back unconditionally, not worth tracking.

OK

> 
> However, any modification to the capability needs to be gated by the
> device feature opt-in, so this might be better handled in a readfn
> rather than managed through permission bits.

OK, I will try that in v20

> 
>> +
>> +	if (!pcie_tph_supported(pdev, true)) {
>> +		/* Remove extend TPH if root-port don't support */
>> +		val &= ~PCI_TPH_CAP_EXT_TPH;
>> +		need_adjust = true;
>> +	}
>> +
>> +	if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_NO_ST) {
>> +		/* Report only No-ST mode supported */
>> +		val &= ~(PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS |
>> +			 PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
>> +		need_adjust = true;
>> +	} else if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_IV_ST) {
>> +		/* Report only No-ST and IV modes supported */
>> +		val &= ~PCI_TPH_CAP_ST_DS;
>> +		/* Remove ST location and size if dev don't support IV mode */
> 
> s/don't/doesn't/

ok

> 
>> +		if (!(val & PCI_TPH_CAP_ST_IV))
>> +			val &= ~(PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
>> +		need_adjust = true;
>> +	}
>> +
>> +	if (need_adjust)
>> +		*vptr = cpu_to_le32(val);
>> +}
>> +
>> +static int vfio_find_cap_start(struct vfio_pci_core_device *vdev, int pos);
> 
> ??

I will move vfio_find_cap_start in front of this new function.

> 
>> +static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
>> +				 int count, struct perm_bits *perm,
>> +				 int offset, __le32 val)
>> +{
>> +	return count;
>> +}
>> +
>>  /*
>>   * Initialize the shared permission tables
>>   */
>> @@ -1101,6 +1168,7 @@ void vfio_pci_uninit_perm_bits(void)
>>  
>>  	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
>>  	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
>> +	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
>>  }
>>  
>>  int __init vfio_pci_init_perm_bits(void)
>> @@ -1121,6 +1189,8 @@ int __init vfio_pci_init_perm_bits(void)
>>  	/* Extended capabilities */
>>  	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
>>  	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
>> +	ret |= init_pci_ext_cap_tph_perm(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
>> +	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_tph_config_write;
>>  	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
>>  	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
>>  
>> @@ -1704,6 +1774,8 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
>>  		ret = vfio_fill_vconfig_bytes(vdev, epos, len);
>>  		if (ret)
>>  			return ret;
>> +		if (ecap == PCI_EXT_CAP_ID_TPH && !hidden)
> 
> Never hidden.  Thanks,

OK

Thanks

> 
> Alex
> 
>> +			vfio_tph_capability_adjust(vdev, epos);
>>  
>>  		/*
>>  		 * If we're just using this capability to anchor the list,
> 

