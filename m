Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087849;
	b=nak702jr3QGfk0/zRhvDp8xsL6IsOe8tLampmRfUgJVvt5m3ZWmxE9NM1AKXfd6TcW3c
	 GT+v1n6snx/eylCskEUUWr7k7w8LUv1yG30q/xXtbx27o4WPllECyPN/52tUF2e3Y0O5I
	 VK+JnUKZ+3PlIgR6/N6XLbeFPtgOcG0nSEAsGr96F6Pt+UVIqUWKNLj5nJ2HGMPqEy30F
	 6lj7DICHkZkI/Q+JcpVapFCsA5gvpcO462s1crfR/+HQQjQkLfmON4ybJdiGF2TRGwHPa
	 9a/s8vxqdNqy0yQhtJnKxucaCBHVyy3IbYJJP42Nrxme4t9tuXeRMXi91XGrWsG5vUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087849;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=z0E2lZlV2yoBMZ56bSiufGGAa3c0rIjegx9XME1SsuA=;
	b=q48nJ2Yjc/5g70dQx4MRzWgfkbVCMKbC38lvLl2TedqCBUTeMa/WK54WQfV11cYoM1hT
	 7eDax9UJJ76RpaI1k6MiCevD5xQbs8r/Pj+yQGZZ14uP1N/TqoHXKpVoxQmNAe6VLOubd
	 pZyipE3Udfj0lX29P2KpVS398RgS2r65UtJQ4oJ+4ksSFhsjTGpmeNTVA78dAPapl7H0E
	 cR1AugaaUGhDLtXAck+jbSzV2ot9Y/x4zFIfjH1KzkX+R5+68/xb6VoEzP7nH6J4pCUKd
	 gVK8SOOn3cvxzVYXBlq64vAhmyqjbw/sId8ePC8r1GvZqKomRb6GkrFbtda7pOxCXGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FO7D36Ur;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085DE606A320;
	Thu, 19 Nov 2026 11:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 085DE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FO7D36Ur
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=z0E2lZlV2yoBMZ56bSiufGGAa3c0rIjegx9XME1SsuA=;
	b=FO7D36UrX7bZtaxDXteU563jvlJyGcPLEvuvew7jirOzcsUkDJa7r7jipCvKI8QW9Q9+GAfSX
	OLVaxJqNUhlQrJYkx6dT67m1ValxjILRAyaHmHEePh3QnIslz3nu9q7SbRoGklcUaKb41jl5qMf
	oqfOAoKIJ/3UbJ12SIiCmok=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jVbqG1Ywcz1T4Fp;
	Thu, 19 Nov 2026 19:30:02 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7759D4057D;
	Thu, 19 Nov 2026 19:30:43 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 19:30:42 +0800
Message-ID: <d66eb438-97d3-4f75-9d43-06b994e8edba@huawei.com>
Date: Thu, 19 Nov 2026 19:30:42 +0800
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
Subject: Re: [PATCH v21 12/13] vfio/pci: Reset PCIe TPH state on device open
 and close
To: <sashiko-reviews@lists.linux.dev>
CC: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-13-fengchengwen@huawei.com>
 <sashiko-outbox-220903@kernel.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <sashiko-outbox-220903@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 11/18/2026 8:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [Medium] vfio/pci: pcie_disable_tph() after reset in
>   vfio_pci_core_enable()

We move pcie_disable_tph() before pci_try_reset_function() in
vfio_pci_core_enable().
With tph_enabled cleared before reset, PCI core will not save and
restore stale TPH_CTRL and ST table entries during reset.
The new user session starts with a clean hardware TPH state, and the
subsequent pci_save_state captures this clean state.

> - [Medium] vfio/pci: unsafe TPH teardown order and cpuhp race in
>   vfio_pci_core_disable()

The root issue is use-after-free caused by freeing tph_st_cpu before
draining in-flight CPU hotplug offline callbacks.
We reorder the TPH deinit to run before MSI-X teardown:
- Call pcie_disable_tph() first to block new TPH programming;
- Use cpuhp_state_remove_instance() instead of
  cpuhp_state_remove_instance_nocalls(), which waits for running offline
  handlers to complete;
- Free tph_st_cpu only after all cpuhp callbacks finish.
Since TPH deinit completes before MSI-X is disabled, the cpuhp offline
handlers run while MSI-X is still valid, so the spurious -ENXIO error is
naturally resolved without extra memory lock wrapping inside the callback.

> - [Medium] vfio/pci: stale PCIe TPH state across runtime resets and
>   config writes

This case is already handled by existing VFIO state restore logic. VFIO
restores hardware registers after runtime reset, so we do not need additional
pcie_disable_tph() calls in FLR/hot-reset/ioctl-reset paths.

Thanks

> --
> 
> commit 339ada87f2084ce58d1ead31609b94d5bab56bf3
> Author: Chengwen Feng <fengchengwen@huawei.com>
> 
> vfio/pci: Reset PCIe TPH state on device open and close
> 
> This commit calls pcie_disable_tph() in vfio_pci_core_enable() and
> vfio_pci_core_disable() to reset PCIe TPH state when opening and closing
> a VFIO PCI device.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 049392831b35f..8d3d532cd51ab 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -606,6 +606,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>>  		goto out_disable_device;
>>  
>>  	vdev->reset_works = !ret;
>> +	/* Reset TPH state for new user session */
>> +	pcie_disable_tph(vdev->pdev);
>>  	pci_save_state(pdev);
>>  	vdev->pci_saved_state = pci_store_saved_state(pdev);
>>  	if (!vdev->pci_saved_state)
> 
> [Severity: Medium]
> Should pcie_disable_tph() run before pci_try_reset_function() instead of
> after it?
> 
> If pdev->tph_enabled is still set when entering vfio_pci_core_enable(),
> pci_try_reset_function() calls pci_save_tph_state() before the reset and
> pci_restore_tph_state() after it, writing the stale PCI_TPH_CTRL and
> capability-located Steering Tag table entries back into hardware.
> pcie_disable_tph() then clears only PCI_TPH_CTRL and sets
> pdev->tph_enabled = 0, leaving the restored ST table entries in hardware.
> Because pdev->tph_enabled is now 0, the following pci_save_state() ->
> pci_save_tph_state() returns early without updating the saved buffer, so
> vdev->pci_saved_state retains the stale pre-disable TPH state.
> 
>> @@ -762,6 +764,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>>  
>>  	vfio_pci_zdev_close_device(vdev);
>>  
>> +	/* Reset TPH state on user session exit */
>> +	pcie_disable_tph(vdev->pdev);
>> +
>>  	/*
>>  	 * If we have saved state, restore it.  If we can reset the device,
>>  	 * even better.  Resetting with current state seems better than
> 
> [Severity: Medium]
> Is calling pcie_disable_tph() this late in vfio_pci_core_disable() safe
> against MSI-X teardown and CPU hotplug?
> 
> vfio_pci_set_irqs_ioctl() disables MSI-X and vfio_pci_tph_dev_deinit()
> runs before pcie_disable_tph() is reached here.  Meanwhile,
> vfio_pci_tph_dev_deinit() frees vdev->tph_st_cpu without vdev->tph_lock
> before removing the cpuhp instance:
> 
> CPU0                                  CPU1
> vfio_pci_core_disable()               vfio_pci_tph_cpuhp_offline()
>   vfio_pci_set_irqs_ioctl()
>   ...
>   vfio_pci_tph_dev_deinit()
>                                         if (vdev->tph_st_cpu == NULL)
>     kfree(vdev->tph_st_cpu);
>     vdev->tph_st_cpu = NULL;
>                                         mutex_lock(&vdev->tph_lock);
>                                         vdev->tph_st_cpu[i]
>                                           <-- use-after-free / NULL deref
>     cpuhp_state_remove_instance_nocalls()
> 
> In addition, if a CPU goes offline after vfio_pci_set_irqs_ioctl()
> disables MSI-X on a PCI_TPH_LOC_MSIX device while pdev->tph_enabled is
> still 1, vfio_pci_tph_cpuhp_offline() -> pcie_tph_set_st_entry() ->
> pci_msix_write_tph_tag() fails with -ENXIO and logs a pci_err().
> vfio_pci_tph_dev_init() similarly registers vdev->tph_cpuhp_node before
> allocating and initializing vdev->tph_st_cpu to -1, and
> vfio_pci_tph_cpuhp_offline() calls pcie_tph_set_st_entry() without
> vfio_pci_memory_lock_and_enable().
> 
> [Severity: Medium]
> What happens to pdev->tph_enabled across runtime resets during an active
> user session?
> 
> This patch disables TPH on open and close, but runtime reset paths
> (vfio_pci_ioctl_reset(), vfio_pci_dev_set_hot_reset(), and PCIe/AF FLR in
> vfio_exp_config_write() and vfio_af_config_write()) do not call
> pcie_disable_tph() or reset vdev->tph_st_cpu.  When pdev->tph_enabled is
> 1 across pci_try_reset_function() or pci_reset_bus(), pci_save_tph_state()
> and pci_restore_tph_state() restore PCI_TPH_CTRL after the reset, leaving
> TPH enabled with wiped device-specific ST tables and causing subsequent
> guest writes to PCI_TPH_CTRL in vfio_tph_config_write() to either drop
> ST mode changes when req == org_req or fail in pcie_enable_tph_ext() with
> -EBUSY.  If a reset clears hardware PCI_TPH_CTRL to 0 without restoring
> it while pdev->tph_enabled remains 1, vfio_tph_config_write() reads
> org_req == 0 from hardware, so enabling TPH fails with -EBUSY in
> pcie_enable_tph_ext() while writing PCI_TPH_REQ_DISABLE exits early at
> req == org_req without calling pcie_disable_tph().
> 

