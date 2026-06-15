Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817ED2AD2C;
	Mon, 15 Jun 2026 03:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495841; cv=none; b=he7i4ZHuKO7haoFVgVZj5MOebDkunYmARiT5pHI1fps/H9dJX6evYHkh5ctYqFbpnld7i2iCfYJPz5G2z5Vni9oXmkkZlB1qtR/EOXnLWfzomsOgnv4DTMA+B2QF8KlzHsZIX3RrBMGJEmgKom/Tpy9Op9t8u+vRcuKJmG8y5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495841; c=relaxed/simple;
	bh=hmEZLOUCNMYZvTrP3sV9QfQ2DDagvRzxb6xxkcW6onU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X3/XVaAud1kg0fqHqRxiAJzQvj8ww5tU9I0FGrZ1cw4Ehp+KCKfuXo35W3T40rQ1hQ0s/NnegAQqwU66CF172CUJg6iDIL1d0mxeuxhpUZfU59jHMwDuUc3c0N8/hx4tBD49TxgpTFuyY4kmPxV8DB64ldX3CIwTu+a9zBce4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4WE2juLL; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4WE2juLL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vdO5ZFCSlMTmcU3+Wbk1cMucfrDRbTdHei1R6ymJZfM=;
	b=4WE2juLLeD6kC+JhbUf/QoUPtaCYi2YUkpnvI98mn4zGJhffsD0CHkjhxXbxxy7QE8CGd4FFD
	8HQRqnDC2M9bByK42wJVGPPsmUPGLNFGpmhWasIdDlOY0WLQh98EBfaTyZKO0Z0cTj8yu7LyLRA
	EFT6pjx70+SP4sSy8C2tzuY=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gdx163zsnznTbY;
	Mon, 15 Jun 2026 11:48:26 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id A6CE34056E;
	Mon, 15 Jun 2026 11:57:15 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 11:57:15 +0800
Message-ID: <077d70d2-8b25-43f9-95ce-aa9d5e6831db@huawei.com>
Date: Mon, 15 Jun 2026 11:57:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 12/12] vfio/pci: Virtualize PCIe TPH capability
 registers
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260604132804.28678-13-fengchengwen@huawei.com>
 <20260604140509.BF1A41F00893@smtp.kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260604140509.BF1A41F00893@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 6/4/2026 10:05 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> 
> New issues:
> - [Critical] Concurrent config writes cause Double-Free/Use-After-Free in power management saved state.

will use memory_lock to protect the power management

> - [High] Missing virtual configuration rollback on power state transition failure.

will do rollback in v17

> - [High] Missing virtualization of TPH Capability Header leaks the physical Next Capability Pointer to the guest.

will done in v17

> - [High] Race condition (TOCTOU) allows concurrent config writes to corrupt virtual state and silently lose write requests.

Will use tph_lock to protect the concurrent config write.

> - [Medium] Silent failure when programming TPH shadow ST table entries into hardware.

I don't think we need this, the device's state is ok for write I think

Thanks

> 
> Pre-existing issues:
> - [High] Out-of-bounds write in extended capability parsing loop due to missing boundary checks.
> --
> 
> commit 32f3411184cca80f87b3f32db73925b8e64d5792
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Virtualize PCIe TPH capability registers
> 
> This commit virtualizes TPH extended capability registers, splitting
> permissions so the header is read-only and the control register is writable.
> It restricts ST-table programming to a specific feature and syncs the
> cached shadow table to hardware upon enablement.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index 5c6ab172df6c0..23c32aa5842fa 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -1086,6 +1086,109 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
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
>> +	p_setd(perm, PCI_TPH_CAP, ALL_VIRT, NO_WRITE);
> 
> [Severity: High]
> Does this miss virtualizing the TPH Capability Header at offset 0?
> 
> Other capabilities use p_setd(perm, 0, ALL_VIRT, NO_WRITE) to ensure the
> guest reads the virtualized header instead of the physical one. Without this,
> could guest reads to the TPH capability header fall through to physical
> hardware, leaking the physical Next Capability Pointer and breaking VFIO's
> ability to hide capabilities?
> 
> [ ... ]
> 
>> +static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
>> +				 int count, struct perm_bits *perm,
>> +				 int offset, __le32 val)
>> +{
>> +	int req_en_byte = PCI_TPH_CTRL + 1;
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	__le32 org_val = 0;
>> +	bool extended;
>> +	u8 mode, req;
>> +	int i, ret;
>> +	u16 start;
>> +	u32 data;
>> +
>> +	if (!vdev->tph_permit)
>> +		return count;
>> +
>> +	/* Back up the original values in order rollback when fail */
>> +	if (offset <= req_en_byte && offset + count > req_en_byte)
>> +		vfio_default_config_read(vdev, pos, count, perm, offset,
>> +					 &org_val);
>> +
>> +	ret = vfio_default_config_write(vdev, pos, count, perm, offset, val);
>> +	if (ret != count)
>> +		return ret;
> 
> [Severity: High]
> Can this create a race condition where concurrent writes corrupt the virtual
> state?
> 
> Modifying vconfig via vfio_default_config_write() happens before acquiring
> vdev->tph_lock. If two threads concurrently write to the control register,
> both modify vconfig unprotected. If the first thread acquires the lock but
> fails to program hardware, its rollback would blindly overwrite the second
> thread's new state in vconfig.
> 
> When the second thread subsequently acquires the lock, wouldn't it read the
> reverted vconfig value (the first thread's old state) and write it to
> hardware, effectively discarding the second thread's write while returning
> success?
> 
>> +
>> +	/* Skip if write range does not cover Requester Enable byte */
>> +	if (offset > req_en_byte || offset + count <= req_en_byte)
>> +		return count;
>> +
>> +	ret = vfio_pci_set_power_state(vdev, PCI_D0);
> 
> [Severity: Critical]
> Does calling vfio_pci_set_power_state() without a serializing lock expose a
> double-free vulnerability?
> 
> If a guest VM concurrently writes to the TPH control register while the
> physical device is in D3hot, both threads can evaluate needs_restore = true.
> After the first thread transitions the device to D0, both threads will
> concurrently execute pci_load_and_free_saved_state(pdev, &vdev->pm_save).
> 
> Since pci_load_and_free_saved_state() has no internal locking and directly
> frees the shared pointer, could this concurrent execution cause a double-free
> in the host kernel?
> 
>> +	if (ret)
>> +		return count;
> 
> [Severity: High]
> Is a rollback of the virtual configuration missing in this error path?
> 
> If the power state transition fails, the function returns count (indicating
> success to userspace) but fails to roll back vconfig using the org_val backed
> up earlier. Doesn't this leave vconfig falsely indicating that the TPH
> Requester is configured while the physical hardware remains unprogrammed?
> 
>> +
>> +	mutex_lock(&vdev->tph_lock);
>> +
>> +	start = vfio_find_cap_start(vdev, pos);
>> +	data = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
>> +	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, data);
>> +	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, data);
>> +
>> +	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH) {
>> +		extended = !!(req == PCI_TPH_REQ_EXT_TPH);
>> +		ret = pcie_enable_tph_explicit(pdev, mode, extended);
>> +		if (!ret && vdev->tph_st_shadow) {
>> +			for (i = 0; i < vdev->tph_st_entries; i++)
>> +				pcie_tph_set_st_entry(pdev, i,
>> +						      vdev->tph_st_shadow[i]);
> 
> [Severity: Medium]
> Should the return value of pcie_tph_set_st_entry() be checked here?
> 
> If programming any ST entry fails, such as from hardware rejection or
> inaccessible registers, the failure appears to be silently ignored. Could
> this leave the hardware partially programmed while userspace is told the
> operation succeeded?
> 
>> +		}
> 
> [ ... ]
> 
>> @@ -1704,6 +1810,8 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
>>  		ret = vfio_fill_vconfig_bytes(vdev, epos, len);
> 
> [Severity: High]
> This is a pre-existing issue, but could this capability parsing loop allow
> out-of-bounds heap corruption?
> 
> If a malicious hardware device or hotplugged peripheral provides a malformed
> capability list with a large length near the end of the PCIe config space,
> epos + len can exceed pdev->cfg_size. This would cause a buffer overflow in
> memset() and vfio_fill_vconfig_bytes(), corrupting the heap-allocated
> vdev->pci_config_map and vdev->vconfig buffers.
> 
>>  		if (ret)
>>  			return ret;
>> +		if (ecap == PCI_EXT_CAP_ID_TPH && !hidden)
>> +			vfio_tph_mask_ext_tph_bit(vdev, epos);
> 

