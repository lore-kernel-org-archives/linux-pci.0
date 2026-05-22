Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158673546EF;
	Fri, 22 May 2026 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442757; cv=none; b=G5vA3kEn0vugILctNKj4UBqX31QvnPwSh7befXu0nyiuvAFmLT2CADJTE07lFlK1ilohNkqY72wa5/AOT4kUMJOQU1pDizWJp44J2+GkfpSM5Ylkq6Ym/C621t3rcABGiLGCsi+45orkHLuxpAoDvGsrLHFfB5lCtHwWRIvqH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442757; c=relaxed/simple;
	bh=gzvPsvTMo0uNOB3nKRAAOE8N06fF1Fym2tL/apRExkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XMKM0RcfOibx69sayfLwsHcrtbNpYZFVdYUpJngZc3imK04xQerc5tekzw3kfeQC0H5Z0iGx+bBwDI+zp/dndk1SlIiULYdxXwYOwtShHQrxjn5JoG4lCMRrsFXEgIHc8GOADnY+x1sW6amTdjNgqAVJyLlcj15jmdJfnjUsuQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NbYB1hOm; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NbYB1hOm"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=18IpQFK6dTM2RZyRkp5IVjRuUDySq0z04o+aIeuNoFI=;
	b=NbYB1hOmuews3BbtG6xcgYMrJ08x0U4MuYYHf058N1h3k/QSldFoIkSoBMuuntO3yt7hgYDK1
	nMX11vQnyhbQ7KA2PgzEa0A8hTOSYYAuGNfyEJsqcFhWU464byOFCaSt4fV9B+CPCE8lQRrNbU2
	ESrhALoN9mW8lRaKYNPJvvU=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gMKly5cq9zmVXS;
	Fri, 22 May 2026 17:31:26 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 950A540571;
	Fri, 22 May 2026 17:39:10 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 17:39:09 +0800
Message-ID: <60e77af2-557c-4a6c-8235-ab7142da77f5@huawei.com>
Date: Fri, 22 May 2026 17:39:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/5] vfio/pci: Add PCIe TPH configuration space
 virtualization
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
 <20260518071701.25177-5-fengchengwen@huawei.com>
 <20260521221015.73a17820@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260521221015.73a17820@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 5/22/2026 12:10 PM, Alex Williamson wrote:
> On Mon, 18 May 2026 15:17:00 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Add support for virtualizing the PCIe TPH (Transaction Processing Hints)
>> control register. TPH may break platform isolation, so add a module
>> parameter "enable_unsafe_tph" to allow administrators to globally control
>> this feature.
>>
>> TPH control register writes are mediated to only allow valid mode settings,
>> and TPH is automatically disabled when VFIO takes ownership of the device
>> or when userspace closes the device file descriptor.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci.c        | 13 ++++++++++++-
>>  drivers/vfio/pci/vfio_pci_config.c | 28 ++++++++++++++++++++++++++++
>>  drivers/vfio/pci/vfio_pci_core.c   | 16 +++++++++++++++-
>>  include/linux/vfio_pci_core.h      |  4 +++-
>>  4 files changed, 58 insertions(+), 3 deletions(-)
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
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index a10ed733f0e3..6da35c2313b9 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -22,6 +22,7 @@
>>  
>>  #include <linux/fs.h>
>>  #include <linux/pci.h>
>> +#include <linux/pci-tph.h>
>>  #include <linux/uaccess.h>
>>  #include <linux/vfio.h>
>>  #include <linux/slab.h>
>> @@ -35,6 +36,8 @@
>>  	((offset >= PCI_BASE_ADDRESS_0 && offset < PCI_BASE_ADDRESS_5 + 4) || \
>>  	 (offset >= PCI_ROM_ADDRESS && offset < PCI_ROM_ADDRESS + 4))
>>  
>> +extern bool enable_unsafe_tph;
>> +
>>  /*
>>   * Lengths of PCI Config Capabilities
>>   *   0: Removed from the user visible capability list
>> @@ -313,6 +316,30 @@ static int vfio_virt_config_read(struct vfio_pci_core_device *vdev, int pos,
>>  	return count;
>>  }
>>  
>> +static int vfio_pci_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
>> +				     int count, struct perm_bits *perm,
>> +				     int offset, __le32 val)
>> +{
>> +	u32 data = le32_to_cpu(val);
>> +
>> +	guard(mutex)(&vdev->tph_lock);
>> +
>> +	if (!enable_unsafe_tph)
>> +		return count;
>> +
>> +	if (offset != PCI_TPH_CTRL)
>> +		return count;
>> +
>> +	/* Only permit write TPH mode. */
>> +	data &= PCI_TPH_CTRL_MODE_SEL_MASK;
>> +	if (data == PCI_TPH_ST_IV_MODE || data == PCI_TPH_ST_DS_MODE)
>> +		pcie_enable_tph(vdev->pdev, data);
>> +	else if (data == PCI_TPH_ST_NS_MODE)
>> +		pcie_disable_tph(vdev->pdev);
>> +
>> +	return count;
>> +}
> 
> I don't understand the virtualization here, the Requester Enable bits
> control what's actually enabled, not the Mode Selection bits.  All
> three of these are valid modes that can be enabled, why aren't they
> toggled by the value written to PCI_TPH_CTRL_REQ_EN_MASK?

OK, will fix in next version
{
	...
	mode = data & PCI_TPH_CTRL_MODE_SEL_MASK;
	req_en = data & PCI_TPH_CTRL_REQ_EN_MASK;
	if (req_en && (mode == PCI_TPH_ST_IV_MODE || mode == PCI_TPH_ST_DS_MODE))
		pcie_enable_tph(vdev->pdev, data);
	else if (!req_en)
		pcie_disable_tph(vdev->pdev);
	...
}

> 
> Isn't this patch ordering wrong, why are we allowing tph to be enabled
> and disabled before we've provided a mechanism to set/get steering tags?

Regarding patch order: TPH must be enabled first before accessing steering tag entries.
The tag query interfaces rely on runtime TPH state and request type info stored in device struct,
which is only initialized after successful TPH enabling. So current order is functional necessary.

> 
>> +
>>  static struct perm_bits direct_ro_perms = {
>>  	.readfn = vfio_direct_config_read,
>>  };
>> @@ -1121,6 +1148,7 @@ int __init vfio_pci_init_perm_bits(void)
>>  	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
>>  	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
>>  	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
>> +	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_pci_tph_config_write;
>>  	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
>>  
>>  	if (ret)
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 050e7542952e..0d0140202280 100644
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
>> +bool enable_unsafe_tph;
>>  
>>  static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
>>  {
>> @@ -771,6 +773,11 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>>  #endif
>>  	vfio_pci_dma_buf_cleanup(vdev);
>>  
>> +	/* Disable TPH when userspace closes the device FD */
>> +	mutex_lock(&vdev->tph_lock);
>> +	pcie_disable_tph(vdev->pdev);
>> +	mutex_unlock(&vdev->tph_lock);
>> +
> 
> We generally don't need to lock on device close, there's nothing it can
> race with.  Also this should happen in the below function after the
> device is known to be back in D0.

I'll remove unnecessary mutex lock in device close path as there is no concurrent race risk.
Also adjust TPH disable invocation to after device returns to D0 state.

> 
> In general the tph_lock seems more like it's protecting PCI-core since
> tph enable/disable doesn't serialize itself.

The tph_lock is designed to serialize all userspace triggered TPH operations on the same device.

> 
>>  	vfio_pci_core_disable(vdev);
>>  
>>  	mutex_lock(&vdev->igate);
>> @@ -2132,6 +2139,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>>  	mutex_init(&vdev->igate);
>>  	spin_lock_init(&vdev->irqlock);
>>  	mutex_init(&vdev->ioeventfds_lock);
>> +	mutex_init(&vdev->tph_lock);
>>  	INIT_LIST_HEAD(&vdev->dummy_resources_list);
>>  	INIT_LIST_HEAD(&vdev->ioeventfds_list);
>>  	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
>> @@ -2151,6 +2159,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
>>  	struct vfio_pci_core_device *vdev =
>>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
>>  
>> +	mutex_destroy(&vdev->tph_lock);
>>  	mutex_destroy(&vdev->igate);
>>  	mutex_destroy(&vdev->ioeventfds_lock);
>>  	kfree(vdev->region);
>> @@ -2240,6 +2249,9 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
>>  	if (!disable_idle_d3)
>>  		pm_runtime_put(dev);
>>  
>> +	/* Disable TPH when taking over ownership of the device */
>> +	pcie_disable_tph(pdev);
>> +
> 
> Seems like a vfio_pci_core_enable() operation, why do we care if it's
> enabled here?  Thanks,

For TPH disable during device takeover: VFIO ownership transfer triggers device reset,
which clears hardware TPH registers and ST tables. We call pcie_disable_tph to synchronize
software state with hardware reset status.

Thanks

> 
> Alex
> 
>>  	ret = vfio_register_group_dev(&vdev->vdev);
>>  	if (ret)
>>  		goto out_power;
>> @@ -2605,11 +2617,13 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
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
>> index 89165b769e5c..741d5bcc7ba3 100644
>> --- a/include/linux/vfio_pci_core.h
>> +++ b/include/linux/vfio_pci_core.h
>> @@ -142,6 +142,7 @@ struct vfio_pci_core_device {
>>  	struct notifier_block	nb;
>>  	struct rw_semaphore	memory_lock;
>>  	struct list_head	dmabufs;
>> +	struct mutex		tph_lock;
>>  };
>>  
>>  enum vfio_pci_io_width {
>> @@ -157,7 +158,8 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>>  				      const struct vfio_pci_regops *ops,
>>  				      size_t size, u32 flags, void *data);
>>  void vfio_pci_core_set_params(bool nointxmask, bool is_disable_vga,
>> -			      bool is_disable_idle_d3);
>> +			      bool is_disable_idle_d3,
>> +			      bool is_enable_unsafe_tph);
>>  void vfio_pci_core_close_device(struct vfio_device *core_vdev);
>>  int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
>>  void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
> 

