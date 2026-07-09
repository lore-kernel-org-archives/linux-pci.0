Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB4B39B97B;
	Thu,  9 Jul 2026 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599382; cv=none; b=muGDZ3tfAhC5i5itSXi3Jgj0SEgem8KdaXFccrZgfXNsSCqIJXvAbNLbOLXkdM71AyUhJ/gXQGIjhbBMBSFS8PXZv9vfinJxupPV4x3CRXk1IxMCDoGUq3S7XUnGUnCPi6502Ma2Dt7x8H9rjfsz8cm9UraYJKUDFPrui0/igJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599382; c=relaxed/simple;
	bh=wt6sk6eOZRDlqFP4e1Sjl2LxiTzkjikCZBqX5U+2DqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ke6OyjHFnfMCngs73qr5fQLuBWQ25/WQvPNHOuYego0ZErHLRI9OBftGcb8qqgx0IWTdeq5F3NtZjt5uUl8tex5mKS6OT4XL+dpbbXC6arDkIivs+oRomq4qp37KC9m1sOt6PbAiEwjvwonUYfBCf7L008jGk4gwsFqon+ys/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=abnsgbEn; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="abnsgbEn"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=npJk41h+c2/IzLwn5EAqim2A7IxtM7FQKUeBr7XVmUc=;
	b=abnsgbEnljb0vtTlYcBFWyVe5TERtNF2rOey+DXhtpG80WIGYbyBbrb3AZbL565jZ1kPWiCqS
	fe0tkKJ73Zf0HjQMzUYvtzh8Tx1DMjGA0oaS9i/yMuI73ChYnPH5lb5qtMrfa5L/rPEw/qo7YGz
	SPenna72AtIlVusLLsTdEZ8=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gwtxK22srzRhQS;
	Thu,  9 Jul 2026 20:07:01 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id B019140579;
	Thu,  9 Jul 2026 20:16:14 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 20:16:14 +0800
Message-ID: <9e8912a6-a819-445c-a257-535a7bd7d867@huawei.com>
Date: Thu, 9 Jul 2026 20:16:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 14/18] vfio/pci: Implement VFIO_DEVICE_FEATURE_TPH and
 valid TPH config write support
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-15-fengchengwen@huawei.com>
 <20260708173036.6be23aae@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708173036.6be23aae@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 7/9/2026 7:30 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:20 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Implement vfio_pci_core_feature_tph() to handle VFIO_DEVICE_FEATURE_TPH:
>> - SET permits TPH feature usage for the device;
>> - GET reports available TPH capabilities according to tph_policy and
>>   root-port DSM support.
>>
>> Previously VFIO dropped all writes to the TPH capability register.
>> Now implement vfio_tph_config_write() to support legitimate TPH_CTRL
>> modification after TPH feature is permitted.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_config.c | 54 ++++++++++++++++++++++++++++++
>>  drivers/vfio/pci/vfio_pci_core.c   | 36 ++++++++++++++++++++
>>  include/linux/vfio_pci_core.h      |  1 +
>>  3 files changed, 91 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index 06d7b2fbf866..388dd6fed16b 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -1150,6 +1150,60 @@ static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
>>  				 int count, struct perm_bits *perm,
>>  				 int offset, __le32 val)
>>  {
>> +	u16 start = vfio_find_cap_start(vdev, pos);
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	u32 org_ctrl, new_ctrl, cap;
>> +	u8 mode, req, org_req;
>> +	__le32 org_val = 0;
>> +	bool extended;
>> +	int ret;
>> +
>> +	if (!vdev->tph_permit)
> 
> We need to work on this variable name, tph_opt_in or something.

OK, I will try

> 
>> +		return count;
>> +
>> +	down_write(&vdev->memory_lock);
> 
> Why is memory_lock involved in this sequence?  Taking the write lock
> doesn't enable memory if it's already disabled, nor do we test the
> memory state.

The core vfio config rw framework does not provide native mutual exclusion for
PCI config space registers, concurrent writes to TPH_CTRL control fields may
race and create inconsistent hardware state. My original intention to add
memory_lock was to serialize these control register writes, I will add something
like tph_lock for this.

> 
>> +
>> +	org_ctrl = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
>> +	vfio_default_config_read(vdev, pos, count, perm, offset, &org_val);
>> +
>> +	ret = vfio_default_config_write(vdev, pos, count, perm, offset, val);
>> +	if (ret != count)
>> +		goto out;
>> +
>> +	new_ctrl = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
>> +	if (new_ctrl == org_ctrl)
>> +		goto out; /* Only care about changes in TPH_CTRL. */
> 
> We didn't need memory_lock for any of this.

OK, will use another lock

> 
>> +
>> +	cap = le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CAP]);
>> +	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
>> +	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
>> +	if (mode > PCI_TPH_ST_DS_MODE || !(cap & (1u << mode)) || req == 0x2 ||
>> +		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
>> +		goto restore; /* Drop invalid or unsupported write value */
> 
> Nor did we need memory_lock for this.

OK, will use another lock

> 
>> +
>> +	org_req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
>> +	if (req == org_req)
>> +		goto out; /* Only care about requester enable */
> 
> What if mode is changed while enabled, don't we create an inconsistent
> state?

Nice catch, I will add such logic for mode changed after enabled tph,
the logic could be just drop such write.

> 
>> +
>> +	ret = vfio_pci_set_power_state(vdev, PCI_D0);
> 
> We already did a runtime PM resume before calling vfio_pci_config_rw(),
> why do we need this?

OK, will remove it

> 
>> +	if (ret)
>> +		goto restore; /* Drop this write */
>> +
>> +	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH) {
>> +		extended = !!(req == PCI_TPH_REQ_EXT_TPH);
>> +		ret = pcie_enable_tph_explicit(pdev, mode, extended);
>> +		if (ret)
>> +			goto restore;
>> +	} else if (req == PCI_TPH_REQ_DISABLE) {
>> +		pcie_disable_tph(vdev->pdev);
>> +	}
> 
> This sequence is really the only thing that appears to need memory_lock
> and it should be using vfio_pci_memory_lock_and_enable() along with
> vfio_pci_memory_unlock_and_restore().

So how about just use vfio_pci_memory_lock_and_enable() and extend its
range (so we could drop tph_lock in this way)?

> 
>> +
>> +	goto out;
>> +
>> +restore:
>> +	vfio_default_config_write(vdev, pos, count, perm, offset, org_val);
>> +out:
>> +	up_write(&vdev->memory_lock);
>>  	return count;
>>  }
>>  
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3f11a9624b9c..14944d3ea86e 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -30,6 +30,7 @@
>>  #include <linux/sched/mm.h>
>>  #include <linux/iommufd.h>
>>  #include <linux/pci-p2pdma.h>
>> +#include <linux/pci-tph.h>
>>  #include <linux/seq_file.h>
>>  #if IS_ENABLED(CONFIG_EEH)
>>  #include <asm/eeh.h>
>> @@ -610,6 +611,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>>  		goto out_disable_device;
>>  
>>  	vdev->reset_works = !ret;
>> +	vdev->tph_permit = false;
>>  	pci_save_state(pdev);
>>  	vdev->pci_saved_state = pci_store_saved_state(pdev);
>>  	if (!vdev->pci_saved_state)
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
> 
> That's not the convention for testing vfio_check_feature() return.

I will use:
	if (ret != 1)
		return ret;

> 
>> +
>> +	if (flags & VFIO_DEVICE_FEATURE_SET) {
> 
> 		if (tph.flags)
> 			return -EINVAL;

OK

> 
>> +		vdev->tph_permit = 1;
>> +		return 0;
>> +	}
>> +
> 
> 	if (!vdev->tph_permit)
> 		return -EINVAL;

OK

> 
>> +	tph.flags = VFIO_DEVICE_TPH_CAP_DMABUF;
>> +	if (vdev->tph_policy != VFIO_PCI_TPH_POLICY_NO_ST &&
>> +		pcie_tph_dsm_supported(vdev->pdev))
>> +		tph.flags |= VFIO_DEVICE_TPH_CAP_CPU;
>> +	if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_LITERAL)
>> +		tph.flags |= VFIO_DEVICE_TPH_CAP_LITERAL;
> 
> These should also account for the device capabilities, CPU is not
> supported unless the device supports somewhere to program CPU values,
> ie. IV or DS mode.  Same for LITERAL, not exposed unless the device has
> a way to use it, (IV or DS) and POLICY_LITERAL.  Thanks,

OK, for Literal we must make sure it ST table size > 0

Thank

> 
> Alex
> 
>> +
>> +	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
>> +}
>> +
>>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  				void __user *arg, size_t argsz)
>>  {
>> @@ -1625,6 +1659,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_TPH:
>> +		return vfio_pci_core_feature_tph(vdev, flags, arg, argsz);
>>  	default:
>>  		return -ENOTTY;
>>  	}
>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>> index a0641286dd90..9a6e82c5c00c 100644
>> --- a/include/linux/vfio_pci_core.h
>> +++ b/include/linux/vfio_pci_core.h
>> @@ -150,6 +150,7 @@ struct vfio_pci_core_device {
>>  	struct rw_semaphore	memory_lock;
>>  	struct list_head	dmabufs;
>>  	u8			tph_policy;
>> +	bool			tph_permit;
>>  };
>>  
>>  enum vfio_pci_io_width {
> 

