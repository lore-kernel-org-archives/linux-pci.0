Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076477;
	b=NQ0Q9OfiWMbsJBY6nAX65YE+6LYCWlsXJ4STQnFg6VSoQVeRFTjVtLOpU2V1GGBonj4T
	 jkuI4DyFywnniTPl6PU8WNdudCqDEnTdzXzu8suzbkgoAB+/rRUDxzyMkbaNrgMAQrBFF
	 /AZD2WRUpjUz1wkq+9ix5omFzt8op+axMUQm2LsfObqIScPYXcHEoBS4JP8+0Z8iGql0Q
	 ATh1B28ov8r4+z0LggcJONghTf0x+c64ilOHR66UkMekmXmsRnsJBZW8w2OGOAox9svTu
	 Q1oylOOi7G0+CSqcZ+8mRc7tY+BrC4uCC2xgYXWaqhfNPQfv974DNX+3vgmnCTjv7fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076477;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=gqtvafE9T3fe8llMe+Ya16DLFDJTIf0qbaCAwRFcMno=;
	b=J5lSis2XQZBLMrK43Go79N90+Nx2UZIROcYIwhwtNStVCBg3alcw9ipDbDDgRDmHxUPi
	 NGUTegKEvcSXyea348f7gAzuD1NhWN1F5uDnLx9KtwfswdTPZfrc3R/SAjS7svggoSkfu
	 LRqTtt57NoQVjM0+KDj3pAikyUmhGwSST03hG36I2LOJeIwPZ6lAzOAGWOwbiMIefcQxW
	 cVW3RaYJTXe15j9OqxyO4xmPaDSO+UuesyTmNiQOt8lbL4gBFJp6a/1ysuHHqsfciWr2Q
	 pN93G9TGG7QzldcHDs34uP4HVPsUN6yf5HWModdANHw/+iTJ3Oej36puEjf/vl6Uecg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="sBh/kIqK";
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090B606A320;
	Thu, 19 Nov 2026 08:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5090B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=sBh/kIqK
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gqtvafE9T3fe8llMe+Ya16DLFDJTIf0qbaCAwRFcMno=;
	b=sBh/kIqKXXGeKc+toHcFsugHB8Iz+uTMQV2hD03gQahnJItKib8kBHXNtSTVNlyrQ8fjSmefu
	SnQEo6TBSvTlZhydUwZ55NQll682Jm1DSjIrFDvuIZj5CyOFZsTUx6BYjMHmacN9byJu7ecuCP5
	dqJdIhFU60utclDs5wxNjko=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jVWcz5mS4zLlX9;
	Thu, 19 Nov 2026 16:20:51 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id F2C2840561;
	Thu, 19 Nov 2026 16:21:11 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 16:21:11 +0800
Message-ID: <191f1bc2-52db-4e1a-bd03-bf5e9fd5e553@huawei.com>
Date: Thu, 19 Nov 2026 16:21:11 +0800
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
Subject: Re: [PATCH v21 09/13] vfio/pci: Add basic NO-ST TPH VFIO device
 feature support
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-10-fengchengwen@huawei.com>
 <sashiko-outbox-220757@kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <sashiko-outbox-220757@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 11/18/2026 6:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] vfio/pci: vfio_tph_config_write() fails when
>   pdev->tph_enabled is already set

Fix by following:
1. Reorder the series, moving the "reset TPH state on open/close" patch earlier.
   This clears `tph_enabled` when VFIO gains ownership of the device and resolves
   state split after PCI reset or across user sessions.
2. Inside `vfio_tph_config_write()`, we check `pdev->tph_enabled` before enabling
   a new requester mode. If TPH is already active, we call `pcie_disable_tph()`
   first to avoid -EBUSY when userspace switches directly between TPH_ONLY and
   EXT_TPH without an explicit DISABLE write.

Thanks

> --
> 
> commit e4125940aba8b4e82c51ed4d75d938a51d421022
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Add basic NO-ST TPH VFIO device feature support
> 
> This commit adds VFIO PCI support for PCIe TPH in NO-ST mode, virtualizing
> the TPH extended capability and exposing the VFIO_DEVICE_FEATURE_TPH ioctl
> for userspace opt-in.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index 9914f3ac69aef..3946ed2ec0cfe 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
> [ ... ]
>> +static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
>> +				 int count, struct perm_bits *perm,
>> +				 int offset, __le32 val)
>> +{
>> +	u16 start = vfio_find_cap_start(vdev, pos);
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	u32 org_ctrl, new_ctrl, cap;
>> +	u8 mode, req, org_req;
>> +	__le32 ctrl_val = 0;
>> +	u16 cmd;
>> +	int ret;
>> +
>> +	if (!vdev->tph_opt_in || offset >= PCI_TPH_BASE_SIZEOF ||
>> +		offset < PCI_TPH_CTRL)
>> +		return count;
>> +
>> +	cmd = vfio_pci_memory_lock_and_enable(vdev);
>> +
>> +	/*
>> +	 * Synchronize the CTRL value of the hardware to the virt. Otherwise,
>> +	 * the value will be inconsistent when the device is reset.
>> +	 */
>> +	vfio_user_config_read(pdev, start + PCI_TPH_CTRL, &ctrl_val, 4);
>> +	vfio_default_config_write(vdev, start + PCI_TPH_CTRL, 4, perm,
>> +				  PCI_TPH_CTRL, ctrl_val);
>> +	org_ctrl = le32_to_cpu(ctrl_val);
>> +
>> +	/* Do write operation to virt. */
>> +	ret = vfio_default_config_write(vdev, pos, count, perm, offset, val);
>> +	if (ret != count)
>> +		goto out;
>> +
>> +	/* Reads the TPH_CTRL value after the write operation. */
>> +	new_ctrl = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
>> +	if (new_ctrl == org_ctrl)
>> +		goto out; /* Exit because there is no change. */
>> +
>> +	cap = vdev->tph_vcap;
>> +	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
>> +	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
>> +	if (mode != PCI_TPH_ST_NS_MODE || !(cap & (1u << mode)) ||
>> +		req == 0x2 /* reserved */ ||
>> +		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
>> +		goto out; /* Drop invalid or unsupported write value. */
>> +
>> +	org_req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
>> +	if (req == org_req)
>> +		goto out; /* Only care about requester enable. */
>> +
>> +	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH)
>> +		pcie_enable_tph_ext(pdev, mode, req);
>> +	else if (req == PCI_TPH_REQ_DISABLE)
>> +		pcie_disable_tph(vdev->pdev);
> 
> [Severity: Medium]
> Does pcie_enable_tph_ext() fail here if pdev->tph_enabled is already set?
> 
> pcie_enable_tph_ext() returns -EBUSY whenever pdev->tph_enabled is 1, and
> its return value is ignored.  If userspace switches directly between
> PCI_TPH_REQ_TPH_ONLY and PCI_TPH_REQ_EXT_TPH without an intermediate
> PCI_TPH_REQ_DISABLE write, the hardware PCI_TPH_CTRL register is never
> updated.
> 
> Similarly, if a device reset clears the hardware PCI_TPH_CTRL register to 0
> while pdev->tph_enabled remains 1, subsequent writes of PCI_TPH_REQ_TPH_ONLY
> or PCI_TPH_REQ_EXT_TPH fail with -EBUSY, and writing PCI_TPH_REQ_DISABLE
> exits early at new_ctrl == org_ctrl without calling pcie_disable_tph(),
> leaving TPH unable to be re-enabled.
> 
> Calling pcie_disable_tph(pdev) before pcie_enable_tph_ext() when
> pdev->tph_enabled is set would avoid both issues.
> 

