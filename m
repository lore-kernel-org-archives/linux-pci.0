Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080494;
	b=PHzf5PCexC3SKJSfgC0CQnL4XXY7rPjZK6H2lkdSExKyYck208YetsySqDZN90xGtsOE
	 pZ0d743gikM99jWcLQjsnFkzMEB8y3DCBa/nQVLcO5EAP2uWTmw+WqFxe9uC5ZsAaiWAe
	 +6oR1AD3Wk3yRUzOUNXws73uvpNe4swNTHT53vpzaOjnoH5jRvv9B2knpuKlQ5eG6zvkj
	 5crz5+8zugPWU/u18FHUAtEunj6LV0iFy8utwPCOpIT1D0U0kl7e4F25nbPB3I/bLB6pc
	 wWoS3cFXhBMFgZ+eOHbHzE5Os0SzfQZU0Ek7nCCTERPfJhAXhxEXzMXJDAtv0gpoyOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080494;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=8JvjYlc2t0UMmW9kss/dJ5LI9f7/n0T3IQLgugJRaZ8=;
	b=TT9ceXcivKnaHThd+MW2O0x2hQq1jgJGuPt5jf5Q9lo49z0/LxC9pF6etgOTue7QhSHq
	 rGJicKoRQfODcQCdMVIf1PU26PcCHX2SETySJwwktQ39pZBpQZggUHhyfVAtYap6Bh9UP
	 pk36JyH5nE4KweKhNshS8Dmfgwa4zaEziG/oaFTQnBS+OuP0Wg/HG/36oalQFArc+roLg
	 VWzcZv9ElLUhLJ4lY1AF3pzGqErXhqKxROy+I57ThCmVuV5D5OwXNm6Q9MlPZuwcIZtMH
	 +6VBY4wGzCn/zSIkIby3x8QPnVszbcClIe/2TN0FxlsERCOHn4SLGGf0OWWrS9cCwxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4qYEEsgj;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57925606A324;
	Thu, 19 Nov 2026 09:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57925606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=4qYEEsgj
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8JvjYlc2t0UMmW9kss/dJ5LI9f7/n0T3IQLgugJRaZ8=;
	b=4qYEEsgjuTbQx+J6AidFCYjqO8jVh9fVh/N7nEcEr11B6bd0rpwylzxtT2UNHUGdV7n9eebrZ
	kSa3Kkcrf8I61gCWFWQ5OuzZRowuamQ/rToGZVr5CkkyUuR/NpAlNmY6TuO4JEH9K/ahbOY3X6j
	a9V+ZlipU1eJ4oL1eP6aBoo=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jVY5X6gKnz12LdS;
	Thu, 19 Nov 2026 17:27:12 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 95FE340537;
	Thu, 19 Nov 2026 17:28:04 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 17:28:04 +0800
Message-ID: <1166243c-a1f0-407e-a748-b729ee027e2f@huawei.com>
Date: Thu, 19 Nov 2026 17:27:58 +0800
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
Subject: Re: [PATCH v21 10/13] vfio/pci: Add IV-ST TPH policy and TPH_PROGRAM
 batch programming support
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-11-fengchengwen@huawei.com>
 <sashiko-outbox-220818@kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <sashiko-outbox-220818@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Thanks for this thorough review. We address all 9 findings in v21 as follows:

On 11/18/2026 7:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 9 potential
> issues to consider:
> - [High] vfio/pci: UAF and leak in vfio_pci_tph_dev_deinit() on PCI
>   disconnect

We no longer rely on hardware config reads in deinit to decide cleanup.
We use software state (tph_st_cpu != NULL) as the guard.
Also fix ordering: remove the cpuhp instance first (this synchronizes
against running offline callbacks), then free tph_st_cpu, eliminating
UAF and resource leak when the device is disconnected.

> - [High] vfio/pci: vfio_tph_config_write() drops ST mode and active req
>   updates

We now check both requester type and ST mode for changes, not only requester.
Any change triggers pcie_enable_tph_ext() to synchronize hardware mode and
requester state. We also add auto-disable logic before enabling TPH to avoid
-EBUSY when switching directly between TPH_ONLY / EXT without an explicit
DISABLE write.

> - [Medium] vfio/pci: UAF and NULL deref freeing tph_st_cpu before cpuhp
>   removal

This is covered by the ordering fix above: cpuhp_state_remove_instance_nocalls()
is called before kfree().

> - [Medium] vfio/pci: OOB access on tph_st_cpu from uncached ST table
>   size reads

ST table size is read once at init time and cached in vdev. All index bounds
checks use this cached value, so later corrupted hardware reads cannot cause OOB.

> - [Medium] vfio/pci: missing memory_lock and enable in
>   vfio_pci_tph_cpuhp_offline()

Add vfio_pci_memory_lock_and_enable() / vfio_pci_memory_unlock_and_restore()
around pcie_tph_set_st_entry() inside the offline callback.
This protects MSI-X BAR MMIO access and synchronizes concurrent TPH_CTRL updates
with config write path.

> - [Medium] vfio/pci: missing cpu_online() check in
>   vfio_pci_tph_resolve_st_tag()

We add cpu_online() validation for each CPU source handle inside the VFIO
TPH_PROGRAM handler. Offline CPU IDs are rejected early to create no orphaned
ST entries that can never be cleared by cpuhp.

> - [Medium] vfio/pci: vfio_pci_tph_get_capability() skips
>   pcie_tph_dsm_supported()

IV‑ST and DS‑ST both depend on TPH ST _DSM for CPU-to-ST resolution.
Instead of scattered checks in capability getter, we trim the virtual
capability set centrally when updating tph_vcap: if _DSM is unavailable,
all CPU-source capability bits are cleared, only NO‑ST programming capability
remains advertised. This makes capability reporting consistent across all
entry points.

> - [Low] vfio/pci: race in vfio_pci_tph_dev_init() adding cpuhp node
>   before init

Reorder init flow: allocate and fully fill the tph_st_cpu array with -1
sentinel first, then register the cpuhp instance. This closes the window
where zero-initialized entries are misinterpreted as CPU0 mapping.

> - [Low] vfio/pci: unsigned promotion of -1 when setting tph_st_cpu in
>   program

Fix the ternary promotion bug: cast the sentinel explicitly to s64, so -1
is stored correctly instead of 0xffffffffULL.

Thanks

> --
> 
> commit a348f43d0aba3da4e82aeff21aba4bc617cdcd33
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Add IV-ST TPH policy and TPH_PROGRAM batch programming support
> 
> This commit adds the IV-ST TPH policy to vfio-pci, introduces the
> VFIO_DEVICE_FEATURE_TPH_PROGRAM ioctl for batch programming architected
> steering tag entries, and registers a CPU hotplug offline callback to clear
> steering tags mapped to offlined CPUs.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index 3946ed2ec0cfe..398f8db8b8ff0 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
> [ ... ]
>> @@ -1210,7 +1218,7 @@ static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
>>  	cap = vdev->tph_vcap;
>>  	mode = FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
>>  	req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
>> -	if (mode != PCI_TPH_ST_NS_MODE || !(cap & (1u << mode)) ||
>> +	if (mode > PCI_TPH_ST_IV_MODE || !(cap & (1u << mode)) ||
>>  		req == 0x2 /* reserved */ ||
>>  		(req == PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
>>  		goto out; /* Drop invalid or unsupported write value. */
> 
> [Severity: High]
> Does vfio_tph_config_write() drop ST mode updates and active requester-type
> changes now that PCI_TPH_ST_IV_MODE is allowed?
> 
> Immediately below this check, vfio_tph_config_write() still has:
> 
> drivers/vfio/pci/vfio_pci_config.c:vfio_tph_config_write() {
> 	...
> 	org_req = FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
> 	if (req == org_req)
> 		goto out; /* Only care about requester enable. */
> 
> 	if (req == PCI_TPH_REQ_TPH_ONLY || req == PCI_TPH_REQ_EXT_TPH)
> 		pcie_enable_tph_ext(pdev, mode, req);
> 	else if (req == PCI_TPH_REQ_DISABLE)
> 		pcie_disable_tph(vdev->pdev);
> 	...
> }
> 
> Because writes where req == org_req exit at goto out without updating
> hardware:
> 
> 1. Switching mode between PCI_TPH_ST_NS_MODE and PCI_TPH_ST_IV_MODE while
>    TPH is already enabled is ignored.  Hardware and pdev->tph_mode stay on
>    the old mode, and if pdev->tph_mode remains PCI_TPH_ST_NS_MODE,
>    pcie_tph_set_st_entries() silently skips writing ST entries during
>    VFIO_DEVICE_FEATURE_TPH_PROGRAM.
> 2. Writing PCI_TPH_ST_IV_MODE while req is PCI_TPH_REQ_DISABLE and enabling
>    req in a second write loses the mode selection, because the next
>    vfio_tph_config_write() syncs vconfig[start + PCI_TPH_CTRL] back from the
>    hardware register before applying the second write.
> 3. Changing req between PCI_TPH_REQ_TPH_ONLY and PCI_TPH_REQ_EXT_TPH (or
>    re-enabling TPH after a function reset cleared the hardware register)
>    calls pcie_enable_tph_ext() while pdev->tph_enabled is still set, which
>    fails with -EBUSY unless pcie_disable_tph() is called first.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 05a03aa2bceb0..23ed8ea396575 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
> [ ... ]
>> @@ -1597,12 +1608,116 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
>>  	return 0;
>>  }
>>  
>> -static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
>> +static enum cpuhp_state vfio_tph_cpuhp_state;
>> +static u32 vfio_pci_tph_get_st_table_size(struct vfio_pci_core_device *vdev);
>> +
>> +static int vfio_pci_tph_cpuhp_offline(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	struct vfio_pci_core_device *vdev =
>> +		hlist_entry(node, struct vfio_pci_core_device, tph_cpuhp_node);
>> +	u32 st_size = vfio_pci_tph_get_st_table_size(vdev);
>> +	int i;
>> +
>> +	if (vdev->tph_st_cpu == NULL)
>> +		return 0;
>> +
>> +	mutex_lock(&vdev->tph_lock);
>> +	for (i = 0; i < st_size; i++) {
>> +		if (vdev->tph_st_cpu[i] != (s64)cpu)
>> +			continue;
>> +		pcie_tph_set_st_entry(vdev->pdev, i, 0);
>> +		vdev->tph_st_cpu[i] = -1;
>> +	}
>> +	mutex_unlock(&vdev->tph_lock);
>> +
>> +	return 0;
>> +}
> 
> [Severity: Medium]
> Should vfio_pci_tph_cpuhp_offline() wrap pcie_tph_set_st_entry() in
> vfio_pci_memory_lock_and_enable() and vfio_pci_memory_unlock_and_restore()
> as vfio_pci_core_feature_tph_program() does?
> 
> When the ST table is located in the MSI-X table (PCI_TPH_LOC_MSIX),
> pcie_tph_set_st_entry() performs MMIO writes and reads on the MSI-X BAR,
> which will fail or trigger AER errors if userspace has cleared
> PCI_COMMAND_MEMORY or if the device is in a low-power state or resetting.
> 
> In addition, pcie_tph_set_st_entry() temporarily clears
> PCI_TPH_CTRL_REQ_EN_MASK in PCI_TPH_CTRL and restores pdev->tph_req_type
> under vdev->tph_lock, whereas vfio_tph_config_write() modifies PCI_TPH_CTRL
> and pdev->tph_req_type under vdev->memory_lock without taking
> vdev->tph_lock, so the two paths can race on PCI_TPH_CTRL.
> 
> [ ... ]
> 
>> +static int vfio_pci_tph_dev_init(struct vfio_pci_core_device *vdev)
>>  {
>> -	/* NO-ST only, no capability bits exposed now */
>> +	bool has_arch_st;
>> +	u32 st_size;
>> +	int i, ret;
>> +
>> +	vdev->tph_opt_in = 0;
>> +	vdev->tph_st_cpu = NULL;
>> +
>> +	has_arch_st = vfio_pci_tph_has_architected_st(vdev);
>> +	if (!has_arch_st)
>> +		return 0;
>> +
>> +	ret = cpuhp_state_add_instance_nocalls(vfio_tph_cpuhp_state,
>> +					       &vdev->tph_cpuhp_node);
>> +	if (ret != 0)
>> +		return ret;
>> +
>> +	st_size = vfio_pci_tph_get_st_table_size(vdev);
>> +	vdev->tph_st_cpu = kcalloc(st_size, sizeof(*vdev->tph_st_cpu),
>> +				   GFP_KERNEL);
>> +	if (vdev->tph_st_cpu == NULL) {
>> +		cpuhp_state_remove_instance_nocalls(vfio_tph_cpuhp_state,
>> +						    &vdev->tph_cpuhp_node);
>> +		return -ENOMEM;
>> +	}
>> +	for (i = 0; i < st_size; i++)
>> +		vdev->tph_st_cpu[i] = -1;
>> +
>>  	return 0;
>>  }
> 
> [Severity: Low]
> Can vfio_pci_tph_cpuhp_offline() observe a zero-filled vdev->tph_st_cpu
> array before the initialization loop sets entries to -1?
> 
> CPU0                                    CPU1
> vfio_pci_tph_dev_init()
>   cpuhp_state_add_instance_nocalls(...)
>   vdev->tph_st_cpu = kcalloc(...)
>                                         vfio_pci_tph_cpuhp_offline(0, ...)
>                                           if (vdev->tph_st_cpu == NULL)
>                                           mutex_lock(&vdev->tph_lock)
>                                           vdev->tph_st_cpu[i] == 0
>                                           pcie_tph_set_st_entry(...)
>   for (i = 0; i < st_size; i++)
>     vdev->tph_st_cpu[i] = -1;
> 
> Because 0 is CPU 0's ID rather than the unmapped sentinel (-1), offlining
> CPU 0 in this window races on vdev->tph_st_cpu and treats every
> uninitialized entry as mapped to CPU 0.  Allocating and initializing
> vdev->tph_st_cpu before cpuhp_state_add_instance_nocalls() avoids this.
> 
>> +static void vfio_pci_tph_dev_deinit(struct vfio_pci_core_device *vdev)
>> +{
>> +	bool has_arch_st;
>> +
>> +	has_arch_st = vfio_pci_tph_has_architected_st(vdev);
>> +	if (!has_arch_st)
>> +		return;
>> +
>> +	kfree(vdev->tph_st_cpu);
>> +	vdev->tph_st_cpu = NULL;
>> +	cpuhp_state_remove_instance_nocalls(vfio_tph_cpuhp_state,
>> +					    &vdev->tph_cpuhp_node);
>> +}
> 
> [Severity: High]
> Does vfio_pci_tph_dev_deinit() leak vdev->tph_st_cpu and leave
> vdev->tph_cpuhp_node registered if the PCI device is hot-unplugged or its
> link is down when closed?
> 
> vfio_pci_tph_has_architected_st() calls vfio_pci_tph_get_st_table_size() ->
> pcie_tph_get_st_table_loc(), which reads PCI_TPH_CAP from hardware config
> space.  If the device is disconnected, the config read returns 0xffffffff,
> so reg & PCI_TPH_CAP_LOC_MASK is 0x600 (neither PCI_TPH_LOC_CAP nor
> PCI_TPH_LOC_MSIX) and vfio_pci_tph_has_architected_st() returns false.
> vfio_pci_tph_dev_deinit() then returns early, leaking vdev->tph_st_cpu and
> leaving vdev->tph_cpuhp_node on the global cpuhp list after vdev is freed,
> which causes a use-after-free on the next CPU offline event or module
> unload.  Checking if (!vdev->tph_st_cpu) instead of re-querying hardware
> avoids this.
> 
> [Severity: Medium]
> Even when the device is present, can freeing vdev->tph_st_cpu before
> cpuhp_state_remove_instance_nocalls() cause a use-after-free or NULL
> pointer dereference in vfio_pci_tph_cpuhp_offline()?
> 
> CPU0                                    CPU1
>                                         vfio_pci_tph_cpuhp_offline()
>                                           if (vdev->tph_st_cpu == NULL)
> vfio_pci_tph_dev_deinit()
>   kfree(vdev->tph_st_cpu)
>   vdev->tph_st_cpu = NULL
>                                           mutex_lock(&vdev->tph_lock)
>                                           vdev->tph_st_cpu[i]  <-- UAF / NULL
>   cpuhp_state_remove_instance_nocalls()
> 
> cpuhp_state_remove_instance_nocalls() is what synchronizes against running
> hotplug callbacks, so it needs to run before freeing vdev->tph_st_cpu.
> 
>> +static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
>> +{
>> +	bool has_arch_st;
>> +
>> +	has_arch_st = vfio_pci_tph_has_architected_st(vdev);
>> +	if (!has_arch_st)
>> +		return 0;
>> +
>> +	return VFIO_DEVICE_TPH_CAP_PROG_ST_NONE | VFIO_DEVICE_TPH_CAP_PROG_ST_CPU;
>> +}
> 
> [Severity: Medium]
> Should vfio_pci_tph_get_capability() check pcie_tph_dsm_supported(vdev->pdev)
> before advertising VFIO_DEVICE_TPH_CAP_PROG_ST_CPU?
> 
> Commit "PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH ST
> _DSM" earlier in this series added pcie_tph_dsm_supported() for VFIO, but
> nothing calls it.  Without that check, VFIO_DEVICE_FEATURE_TPH GET reports
> VFIO_DEVICE_TPH_CAP_PROG_ST_CPU even when CONFIG_ACPI is disabled, the
> device is a Root Complex Integrated Endpoint, or the Root Port lacks the
> TPH ST _DSM, and subsequent VFIO_DEVICE_FEATURE_TPH_PROGRAM calls with CPU
> sources will all fail in pcie_tph_get_cpu_st_ext().
> 
>>  static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
>>  				     u32 flags,
>>  				     struct vfio_device_feature_tph __user *arg,
>> @@ -1638,6 +1753,154 @@ static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
>>  	return copy_to_user(arg, &tph, sizeof(tph)) ? -EFAULT : 0;
>>  }
>>  
>> +static u32 vfio_pci_tph_get_src_mask(struct vfio_pci_core_device *vdev)
>> +{
>> +	u32 flags = vfio_pci_tph_get_capability(vdev);
>> +	u32 src_mask = 0;
>> +
>> +	if (flags & VFIO_DEVICE_TPH_CAP_PROG_ST_NONE)
>> +		src_mask |= VFIO_DEVICE_TPH_SRC_NONE;
>> +	if (flags & VFIO_DEVICE_TPH_CAP_PROG_ST_CPU)
>> +		src_mask |= VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
>> +			    VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT;
>> +
>> +	return src_mask;
>> +}
>> +
>> +static u32 vfio_pci_tph_get_st_table_size(struct vfio_pci_core_device *vdev)
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
> 
> [Severity: Medium]
> Can re-reading the ST table size from hardware in
> vfio_pci_tph_get_st_table_size() cause out-of-bounds accesses on
> vdev->tph_st_cpu?
> 
> vdev->tph_st_cpu is allocated once in vfio_pci_tph_dev_init(), but
> vfio_pci_tph_cpuhp_offline() and vfio_pci_core_feature_tph_program() call
> vfio_pci_tph_get_st_table_size() again to bound indices into
> vdev->tph_st_cpu.  If PCI config space becomes inaccessible after
> pcie_tph_get_st_table_loc() succeeds, the second config read inside
> pcie_tph_get_st_table_size() or pci_msix_vec_count() reads all-ones and
> returns 2048 (0x7ff + 1), which can exceed the allocated size of
> vdev->tph_st_cpu and cause out-of-bounds reads and writes.  Caching the
> table size on vdev at allocation time would keep the array bounds
> consistent.
> 
>> +static int vfio_pci_tph_resolve_st_tag(struct pci_dev *pdev, u32 src_bits,
>> +				       u32 src_handle, bool extended, u16 *st)
>> +{
>> +	u8 req_type = extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
>> +	int ret = 0;
>> +
>> +	if (src_bits & VFIO_DEVICE_TPH_SRC_NONE)
>> +		*st = 0;
>> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE)
>> +		ret = pcie_tph_get_cpu_st_ext(pdev, TPH_MEM_TYPE_VM,
>> +					      req_type, src_handle, st);
>> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT)
>> +		ret = pcie_tph_get_cpu_st_ext(pdev, TPH_MEM_TYPE_PM,
>> +					      req_type, src_handle, st);
>> +	else
>> +		ret = -EINVAL;
>> +
>> +	if (ret != 0)
>> +		*st = 0;
>> +
>> +	return ret;
>> +}
> 
> [Severity: Medium]
> Does vfio_pci_tph_resolve_st_tag() allow programming steering tags for CPUs
> that are already offline?
> 
> vfio_pci_core_feature_tph_program() holds cpus_read_lock(), but neither it
> nor pcie_tph_get_cpu_st_ext() -> acpi_get_cpu_uid() checks
> cpu_online(src_handle).  An offline CPU ID still resolves via static ACPI
> processor tables and gets programmed into the ST table and recorded in
> vdev->tph_st_cpu[], where vfio_pci_tph_cpuhp_offline() will never clear it
> (and on LoongArch, passing a possible-but-not-present CPU < nr_cpu_ids
> indexes acpi_core_pic[cpu_logical_map(cpu)] at -1).
> 
> [ ... ]
> 
>> +	if (i > 0) {
>> +		mutex_lock(&vdev->tph_lock);
>> +
>> +		cmd = vfio_pci_memory_lock_and_enable(vdev);
>> +		ret = written = pcie_tph_set_st_entries(pdev, program.start, i,
>> +							tags);
>> +		vfio_pci_memory_unlock_and_restore(vdev, cmd);
>> +
>> +		if (written > 0) {
>> +			for (k = 0; k < written; k++)
>> +				vdev->tph_st_cpu[program.start + k] =
>> +					(tags[k] == 0) ? -1 : src_handle[k];
>> +		}
>> +
>> +		mutex_unlock(&vdev->tph_lock);
>> +	}
> 
> [Severity: Low]
> Does (tags[k] == 0) ? -1 : src_handle[k] store 0xffffffff instead of -1 in
> vdev->tph_st_cpu?
> 
> Because src_handle[k] is a u32 and -1 is an int, the ternary expression has
> type u32, so -1 is converted to 0xffffffffU before being widened to s64
> (4294967295LL instead of -1LL).
> 

