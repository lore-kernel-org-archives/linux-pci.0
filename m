Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18406364949;
	Wed, 27 May 2026 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875650; cv=none; b=UyNia5ZtubF9si1qjLRcvQodwCIR046/Nl1VmTiTcowOY0Ka49d5aeNzMJ8k13Zfv/ce2/GSLI55xBWwNOKpOn+U1iMR2SsBmxauc/jOb6LqiCHp62v6s8erbillpG7q/NqsNSv/iqo+gp70RfR743KEAE2lknNrmakryecW1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875650; c=relaxed/simple;
	bh=9rNdOVTwYMyQDSfrfGn600Sf9wAYnl7F5gi+JGK8mMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PjnUxsuQBuPTZV/W8J7JbfvMAn2iSWwYx1uUHB8Q0oWcmK9T03EkAE9pgp15OT2F6U0x4Y/b5SbSlUS4eukD3TYnvnWDDMfq8NdnS5M5gabQnRHNnRwsHB2wXJc61SC+dOUSEEBlkmNwC+prZ032QDQ/wsMkd4cB6fCTvMKaios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SmSedmMj; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SmSedmMj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iAxek0WBZYd9tiEMir+1POAa7bAlJ0opMsmwoKq+H78=;
	b=SmSedmMjvaAG/XV8SCunUXE8E1Soysbeiz5GPd0D8oey2IH34qfj/BXVKl7R49N2ABsootygw
	lj/Q2RXAumNhtOpJzcSD/TpJboaBlTvCx8tnyDoMWdAyRXbR60J40+/GxFys3AI2H7W+7P0ujPD
	DQgAP6ACFJS6Oa/6yNEvfa0=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gQPrr0G2RzLlT6;
	Wed, 27 May 2026 17:46:20 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BF4F40571;
	Wed, 27 May 2026 17:54:05 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 17:54:04 +0800
Message-ID: <8d68d5a7-b69e-423a-a10d-1a299a3e4ce3@huawei.com>
Date: Wed, 27 May 2026 17:54:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/6] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for PCIe
 TPH steering tag management
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260526040830.52854-1-fengchengwen@huawei.com>
 <20260526040830.52854-6-fengchengwen@huawei.com>
 <20260526164254.622b339c@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260526164254.622b339c@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 5/27/2026 6:42 AM, Alex Williamson wrote:
> On Tue, 26 May 2026 12:08:29 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Add new userspace device feature to access and maintain PCIe TPH Steering
>> Tag table entries, supporting two mutually exclusive operation modes:
>> 1. Raw table read/write: Operate shadow ST table, sync updates to hardware
>>    TPH capability or MSI-X table. Failed batch write triggers entry
>>    rollback to keep hardware consistent.
>> 2. CPU ID lookup: Query translated steering tag by specified memory type,
>>    pure read-only without modifying ST table.
>>
>> Introduce enable_unsafe_tph module parameter to gate this non-isolated TPH
>> related feature. All operations are protected by per-device mutex, shadow
>> table lifecycle is managed along device init/release.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci.c      |  13 ++-
>>  drivers/vfio/pci/vfio_pci_core.c | 176 ++++++++++++++++++++++++++++++-
>>  include/linux/vfio_pci_core.h    |   6 +-
>>  include/uapi/linux/vfio.h        |  49 +++++++++
>>  4 files changed, 240 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 0c771064c0b8..6d73668459cf 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -60,6 +60,12 @@ static bool disable_denylist;
>>  module_param(disable_denylist, bool, 0444);
>>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
>>  
>> +#ifdef CONFIG_PCIE_TPH
>> +static bool enable_unsafe_tph;
>> +module_param(enable_unsafe_tph, bool, 0444);
>> +MODULE_PARM_DESC(enable_unsafe_tph, "Enable PCIe TPH (Transaction Processing Hints) support. It may break platform isolation. If you do not know what this is for, step away. (default: false)");
>> +#endif
>> +
>>  static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
>>  {
>>  	switch (pdev->vendor) {
>> @@ -257,12 +263,17 @@ static int __init vfio_pci_init(void)
>>  {
>>  	int ret;
>>  	bool is_disable_vga = true;
>> +	bool is_enable_unsafe_tph = false;
>>  
>>  #ifdef CONFIG_VFIO_PCI_VGA
>>  	is_disable_vga = disable_vga;
>>  #endif
>> +#ifdef CONFIG_PCIE_TPH
>> +	is_enable_unsafe_tph = enable_unsafe_tph;
>> +#endif
>>  
>> -	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
>> +	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3,
>> +				 is_enable_unsafe_tph);
>>  
>>  	/* Register and scan for devices */
>>  	ret = pci_register_driver(&vfio_pci_driver);
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 050e7542952e..6fc7496cb8dd 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/sched/mm.h>
>>  #include <linux/iommufd.h>
>>  #include <linux/pci-p2pdma.h>
>> +#include <linux/pci-tph.h>
>>  #if IS_ENABLED(CONFIG_EEH)
>>  #include <asm/eeh.h>
>>  #endif
>> @@ -41,6 +42,7 @@
>>  static bool nointxmask;
>>  static bool disable_vga;
>>  static bool disable_idle_d3;
>> +static bool enable_unsafe_tph;
>>  
>>  static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
>>  {
>> @@ -1551,6 +1553,159 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
>>  	return 0;
>>  }
>>  
>> +static int vfio_pci_tph_st_shadow_size(struct vfio_pci_core_device *vdev)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	u32 loc = pcie_tph_get_st_table_loc(pdev);
>> +	int ret;
>> +
>> +	if (loc == PCI_TPH_LOC_CAP) {
>> +		return pcie_tph_get_st_table_size(pdev);
>> +	} else if (loc == PCI_TPH_LOC_MSIX) {
>> +		ret = pci_msix_vec_count(pdev);
>> +		if (ret < 0)
>> +			return 0;
>> +		return ret;
>> +	} else {
>> +		return 0;
>> +	}
>> +}
>> +
>> +static int vfio_pci_tph_op_raw_table(struct vfio_pci_core_device *vdev,
>> +				     bool is_get,
>> +				     struct vfio_device_feature_tph_st *arg)
>> +{
>> +	void __user *uptr = u64_to_user_ptr(arg->data_uptr);
>> +	size_t sz = arg->count * sizeof(u16);
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	int i, idx, ret;
>> +	u16 *sts;
>> +
>> +	if (!vdev->tph_st_shadow)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (arg->flags & ~VFIO_TPH_ST_OP_TYPE_MASK)
>> +		return -EINVAL;
>> +	if (arg->count == 0 || arg->index >= vdev->tph_st_entries ||
>> +		arg->count > vdev->tph_st_entries ||
>> +		arg->index + arg->count > vdev->tph_st_entries)
>> +		return -EINVAL;
>> +
>> +	if (is_get) {
>> +		ret = copy_to_user(uptr, &vdev->tph_st_shadow[arg->index], sz);
>> +		if (ret)
>> +			return -EFAULT;
>> +		return 0;
>> +	}
>> +
>> +	sts = memdup_array_user(uptr, arg->count, sizeof(u16));
>> +	if (IS_ERR(sts))
>> +		return PTR_ERR(sts);
>> +
>> +	if (pcie_tph_enabled_mode(vdev->pdev) < 0) {
>> +		memcpy(&vdev->tph_st_shadow[arg->index], sts, sz);
>> +		kfree(sts);
>> +		return 0;
>> +	}
>> +
>> +	for (i = 0; i < arg->count; i++) {
>> +		idx = arg->index + i;
>> +		ret = pcie_tph_set_st_entry(pdev, idx, sts[i]);
>> +		if (ret)
>> +			goto rollback;
>> +	}
>> +
>> +	memcpy(&vdev->tph_st_shadow[arg->index], sts, sz);
>> +	kfree(sts);
>> +	return 0;
>> +
>> +rollback:
>> +	while (i-- > 0) {
>> +		idx = arg->index + i;
>> +		pcie_tph_set_st_entry(pdev, idx, vdev->tph_st_shadow[idx]);
>> +	}
>> +	kfree(sts);
>> +	return ret;
>> +}
>> +
>> +static int vfio_pci_tph_op_cpu_query(struct vfio_pci_core_device *vdev,
>> +				     struct vfio_device_feature_tph_st *arg)
>> +{
>> +	void __user *uptr = u64_to_user_ptr(arg->data_uptr);
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	enum tph_mem_type mtype;
>> +	int i, ret;
>> +	u32 *cpus;
>> +	u16 st;
>> +
>> +	if (arg->flags & ~(VFIO_TPH_ST_OP_TYPE_MASK | VFIO_TPH_ST_MEM_TYPE_MASK))
>> +		return -EINVAL;
>> +	if (arg->count == 0 || arg->count > nr_cpu_ids || arg->index != 0)
>> +		return -EINVAL;
>> +
>> +	cpus = memdup_array_user(uptr, arg->count, sizeof(u32));
>> +	if (IS_ERR(cpus))
>> +		return PTR_ERR(cpus);
>> +
>> +	mtype = (arg->flags & VFIO_TPH_ST_MEM_TYPE_MASK) == VFIO_TPH_ST_MEM_TYPE_VM ?
>> +		TPH_MEM_TYPE_VM : TPH_MEM_TYPE_PM;
>> +	for (i = 0; i < arg->count; i++) {
>> +		ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
>> +		if (ret)
>> +			goto out;
>> +		cpus[i] = st;
>> +	}
>> +
>> +	ret = copy_to_user(uptr, cpus, arg->count * sizeof(u32));
>> +out:
>> +	kfree(cpus);
>> +	return ret;
>> +}
>> +
>> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
>> +					u32 flags,
>> +					struct vfio_device_feature_tph_st __user *arg,
>> +					size_t argsz)
>> +{
>> +	struct vfio_device_feature_tph_st tph_st;
>> +	bool is_get, is_set;
>> +	u32 op_type;
>> +	int ret;
>> +
>> +	if (!enable_unsafe_tph)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = vfio_check_feature(flags, argsz,
>> +				 VFIO_DEVICE_FEATURE_GET |
>> +				 VFIO_DEVICE_FEATURE_SET |
>> +				 VFIO_DEVICE_FEATURE_PROBE,
>> +				 sizeof(tph_st));
>> +	if (ret <= 0)
>> +		return ret;
>> +
>> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
>> +		return -EFAULT;
>> +
>> +	op_type = tph_st.flags & VFIO_TPH_ST_OP_TYPE_MASK;
>> +	is_get = !!(flags & VFIO_DEVICE_FEATURE_GET);
>> +	is_set = !!(flags & VFIO_DEVICE_FEATURE_SET);
>> +
>> +	guard(mutex)(&vdev->tph_lock);
>> +
>> +	switch (op_type) {
>> +	case VFIO_TPH_ST_OP_RAW_TABLE:
>> +		if (is_set && is_get)
>> +			return -EINVAL;
>> +		return vfio_pci_tph_op_raw_table(vdev, is_get, &tph_st);
>> +	case VFIO_TPH_ST_OP_CPU_QUERY:
>> +		if (is_set)
>> +			return -EOPNOTSUPP;
>> +		return vfio_pci_tph_op_cpu_query(vdev, &tph_st);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  				void __user *arg, size_t argsz)
>>  {
>> @@ -1569,6 +1724,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>> +	case VFIO_DEVICE_FEATURE_TPH_ST:
>> +		return vfio_pci_core_feature_tph_st(vdev, flags, arg, argsz);
>>  	default:
>>  		return -ENOTTY;
>>  	}
>> @@ -2132,12 +2289,23 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>>  	mutex_init(&vdev->igate);
>>  	spin_lock_init(&vdev->irqlock);
>>  	mutex_init(&vdev->ioeventfds_lock);
>> +	mutex_init(&vdev->tph_lock);
>> +	vdev->tph_st_entries = vfio_pci_tph_st_shadow_size(vdev);
>> +	vdev->tph_st_shadow = NULL;
>> +	if (vdev->tph_st_entries) {
>> +		vdev->tph_st_shadow = kcalloc(vdev->tph_st_entries, sizeof(u16),
>> +					      GFP_KERNEL);
>> +		if (!vdev->tph_st_shadow)
>> +			return -ENOMEM;
>> +	}
>>  	INIT_LIST_HEAD(&vdev->dummy_resources_list);
>>  	INIT_LIST_HEAD(&vdev->ioeventfds_list);
>>  	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
>>  	ret = pcim_p2pdma_init(vdev->pdev);
>> -	if (ret && ret != -EOPNOTSUPP)
>> +	if (ret && ret != -EOPNOTSUPP) {
>> +		kfree(vdev->tph_st_shadow);
>>  		return ret;
>> +	}
>>  	INIT_LIST_HEAD(&vdev->dmabufs);
>>  	init_rwsem(&vdev->memory_lock);
>>  	xa_init(&vdev->ctx);
>> @@ -2153,6 +2321,8 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
>>  
>>  	mutex_destroy(&vdev->igate);
>>  	mutex_destroy(&vdev->ioeventfds_lock);
>> +	mutex_destroy(&vdev->tph_lock);
>> +	kfree(vdev->tph_st_shadow);
>>  	kfree(vdev->region);
>>  	kfree(vdev->pm_save);
>>  }
>> @@ -2605,11 +2775,13 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
>>  }
>>  
>>  void vfio_pci_core_set_params(bool is_nointxmask, bool is_disable_vga,
>> -			      bool is_disable_idle_d3)
>> +			      bool is_disable_idle_d3,
>> +			      bool is_enable_unsafe_tph)
>>  {
>>  	nointxmask = is_nointxmask;
>>  	disable_vga = is_disable_vga;
>>  	disable_idle_d3 = is_disable_idle_d3;
>> +	enable_unsafe_tph = is_enable_unsafe_tph;
>>  }
>>  EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
>>  
>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>> index 89165b769e5c..ae8e7011ab8e 100644
>> --- a/include/linux/vfio_pci_core.h
>> +++ b/include/linux/vfio_pci_core.h
>> @@ -142,6 +142,9 @@ struct vfio_pci_core_device {
>>  	struct notifier_block	nb;
>>  	struct rw_semaphore	memory_lock;
>>  	struct list_head	dmabufs;
>> +	struct mutex		tph_lock;
>> +	u16			*tph_st_shadow;
>> +	u16			tph_st_entries;
>>  };
>>  
>>  enum vfio_pci_io_width {
>> @@ -157,7 +160,8 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>>  				      const struct vfio_pci_regops *ops,
>>  				      size_t size, u32 flags, void *data);
>>  void vfio_pci_core_set_params(bool nointxmask, bool is_disable_vga,
>> -			      bool is_disable_idle_d3);
>> +			      bool is_disable_idle_d3,
>> +			      bool is_enable_unsafe_tph);
>>  void vfio_pci_core_close_device(struct vfio_device *core_vdev);
>>  int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
>>  void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5de618a3a5ee..c76196f93660 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1534,6 +1534,55 @@ struct vfio_device_feature_dma_buf {
>>   */
>>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>>  
>> +/**
>> + * VFIO_DEVICE_FEATURE_TPH_ST - Manage PCIe TPH Steering Tag entries
>> + *
>> + * Provides userspace interface to manage PCIe TPH ST table entries.
>> + *
>> + * @flags: Composite control flags
>> + *  Operation type[bit0~3]: Exclusive operation selection
>> + *  Attribute bits[bit4~31]: Additional property parameters
>> + *
>> + * @index: Start entry offset, only valid for raw table operation
>> + * @count: Number of consecutive entries to operate
>> + * @data_uptr: Aligned userspace data buffer pointer
>> + *
>> + * VFIO_TPH_ST_OP_RAW_TABLE type:
>> + *   Access raw ST table entry directly.
>> + *   Attribute bits are ignored in this operation.
>> + *   Userspace data buffer stores 16-bit raw steering tag values.
>> + *   SET writes entries, and GET reads existing raw ST entries back to user
>> + *   buffer.
>> + *
>> + * VFIO_TPH_ST_OP_CPU_QUERY type:
>> + *   Resolve ST tag from CPU ID, only supports GET operation.
>> + *   Attribute bits carry memory type info.
>> + *   Userspace data buffer provides 32-bit CPU IDs, kernel returns translated
>> + *   16-bit ST tag according to specified memory type. No modification to ST
>> + *   table during query.
>> + *
>> + * This feature is gated by enable_unsafe_tph module parameter.
>> + */
>> +#define VFIO_DEVICE_FEATURE_TPH_ST	13
>> +
>> +struct vfio_device_feature_tph_st {
>> +	__u32 flags;
>> +
>> +/* Operation type field */
>> +#define VFIO_TPH_ST_OP_TYPE_MASK	0xFu
>> +#define VFIO_TPH_ST_OP_RAW_TABLE	0x0u
>> +#define VFIO_TPH_ST_OP_CPU_QUERY	0x1u
>> +
>> +/* Attribute bits for CPU query operation type */
>> +#define VFIO_TPH_ST_MEM_TYPE_MASK	(1u << 4)
>> +#define VFIO_TPH_ST_MEM_TYPE_VM		(0u << 4)
>> +#define VFIO_TPH_ST_MEM_TYPE_PM		(1u << 4)
>> +
>> +	__u16 index;
>> +	__u16 count;
>> +	__aligned_u64 data_uptr;
>> +};
> 
> This is already a multiplexed ioctl, don't add another level of
> multiplexing, use two separate features.

done in v13

> 
> If the user is now handling the raw ST, we don't need GET support on
> the ST entry feature.

done in v13

> 
> The CPU lookup/xlate feature is on pretty thin standing for why it
> needs to be implemented in vfio-pci.  I think it's largely here because
> there's no other obvious place for it and a sysfs implementation would
> be massive if we need 2 (vm/pm) * 2 (8/16-bit) * NR_CPUS attributes per
> root port.

Yes

> 
> As noted in the previous patch, there still seem to be gaps in the
> virtualization and user ownership of the TPH mode enabled on the
> device.  The interface proposed here doesn't seem to fully support
> emulation of the TPH capability from a virtualization perspective.
> Thanks,

v13 support virtualize TPH request type.

By v13:
1\ Userspace could query device TPH request type
2\ Userspace decide use which request type: standard(8bit) or extended(16bit)
3\ Userspace query CPU'st based on TPH request type and memory type
4\ Userspace set device's ST table entry if ST location in CAP or MSIX
5\ Userspace enable device's TPH with request type

If device support standard and extended, then usespace could chose anyone
of them.

Thanks

> 
> Alex

