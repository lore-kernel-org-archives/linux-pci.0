Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468F3403F4
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684791; cv=none; b=oZI6NNgkAUEuD+9mUr8HwmsTxt13fkBssVd0uKOxP47XaLos7ZC7+N0N3wddfYZ+Mjmb5wsMTBj07WaPLB1ua5Phfr35QRIRkjizQM9mzr0Gym1POIUdciXz0J9FFV6sX8FCRvThjO5s9E67B3F0lJNhpjSRT+0fUg1MMUoUvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684791; c=relaxed/simple;
	bh=WBxo+qxQB+oazWupMa1sVuIzijsEHLVSJFnnE70gEeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIUWItAVNLz9ZYaMKTvztcUHyDjCBkd6+ufgkZyHwRF4sZemHRAqLmnT9OO1diEYqqnugS7NuYc86b+rh/ZjN976cbwJvnuWqGEI8+QdLqpezX1uiQzvqxQQUvSIDLC7ykJA2zOJfgwmKqpbf4u4FG+/6CSDZgsDrR8dCUJ/72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MlBBmjbe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlBBmjbe"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccf2360620so2262005ad.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787684788; x=1788289588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9OJDooK2zLq4X43we9Ud5DH06s8WHcjJ/xQ521Bg6s=;
        b=MlBBmjbeQOC9BF5lDRE4KKAhC0TSSspAiXmaw/WmMJAMQDAINmsNSaanqT9k62p36d
         gRP4di5VTM6GhyyRbXWBcIs5JPkzdPkmDsdda2WE8zkbuiIPMMePHFcUf+zKPuxkrvx1
         jLjvzLRucHTyrqtteFnmjKX4MTxSpKfP7fk7DeIDzv+3gowtyQ6wqyHCczZRddaIwiWi
         awirulu5eyanH/rYdeCpiIDx1Bn6cLCaYEU9wIheMZta/w1iruBfmN6K7oLyNi68HDmS
         p7tMRuGttoiHIaVIsfgbAm1bW9c6clv9kpgD1rF757q7VIboAD7hfo8j32eNQ9cqcgEn
         Jd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684788; x=1788289588;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9OJDooK2zLq4X43we9Ud5DH06s8WHcjJ/xQ521Bg6s=;
        b=fs0PbYzJzzn1d5rSkQPJFfuErqkfG3GDqX4odAxqg7BaxDxfy/B06kbn025bHrhJsY
         z71MMw6H1bOoB2gePqGMRLbDzqo2ZYpf10W1L7AxMC2KsU00iDpsDNgpwKWjAKN5wYdm
         LBpUnZx8Yk79NKVbMeSonUwkG2nP5kN7wfKGNfh8Ugx/VcJvjQEGvlVyvP9Y9+RGTeV/
         KR7IFXLh6ENhX8VRbmlcXbKHQzfkiFXrlumWxk2iB1UwprS0kUjuj9OC9ufwt1TV/OhE
         LhcVOh2QUidVxcgoAaBGz8qrTl5dynPiP5Xs81blA8ioGFocn8qn/vfpusR0u/rOcaXu
         nRHA==
X-Forwarded-Encrypted: i=1; AHgh+RonXDKGzwNXS5qQZlt8S/Kb5/HP+bfVUR4C9zKr+lQNHkSFZ/sjBq8FNiuZNIOu0NMunp5Dom0YOSM=@vger.kernel.org
X-Gm-Message-State: AFuF++m9yKsPawXYuMboZ+WkaMhaNSqVen9QbH+eLPjpD9PpLeauPKGy
	VSeaMC7YqkH0YFbZPbgBTZ9zRwyULE+OHnM4XhKWXkFGjmP8WsOrjm5SAGxdhHzZgw==
X-Gm-Gg: AR+sD11etU5TUhTE0+te8CuLXA8QIgWBfQd7s5MVjx1SJW8D8NQeMz9ShaUMBuekC18
	AczeqrnZWp0Tz6Oww9CHK+a+/GnqJgXiCMxzua9uidvq475Yrp6ydbkBO1T6Qe4lD4HK4iyLHM+
	XjsvPEFffYkmiYJA4fn/24+TdjIjRD0li0afm30YyMfldma0nwsdgxyz3z/9tNjDHBKHj0ZCIV8
	Meie05quqUp736MPEm7uvg0pC2UsS9VAa32BA++iTjpcPBhkp+hzszLj9+DtiF2/z95Kas1Sh+J
	d/e0Us5w/iFT8qR8YMc8XRP227rmG59RSmdYH6zXy2yHPtuTJwLdXRQ3Nj8hEwTJEdfLEEWvZlO
	SgdDhJTunjwCmn0TfkPQhyA/oQMXqJ6X5ZezUJoeOmycYXxmiVv0bxw/eaIGpajgqNmu68grfAN
	QilrjroULAGrmR7RzlZ931jtiO9dg0T4f7SI4Rz9YRIQBgKwhrX/FDZXwzlRrfJPUX9oGx3j3sS
	+ELG/wwIFihHzogHAFTVrPc4vtdYQ==
X-Received: by 2002:a17:903:2f8f:b0:2d3:78c2:1f19 with SMTP id d9443c01a7336-2d707b94eaemr6381315ad.9.1787684787703;
        Tue, 25 Aug 2026 12:06:27 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7049772ffsm1405355ad.20.2026.08.25.12.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:06:26 -0700 (PDT)
Date: Tue, 25 Aug 2026 19:06:23 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, jrhilke@google.com,
	skhawaja@google.com, tatashin@google.com,
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] vfio: circular locking dependency in
 pci_dev_reset_iommu_prepare()
Message-ID: <ao3nr1-t0DxANAyC@google.com>
References: <20260821193502.92431-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821193502.92431-1-vipinsh@google.com>

On 2026-08-21 12:35 PM, Vipin Sharma wrote:

> ================================================================================
> Potential Solutions Suggested by AI
> ================================================================================
> 
> 1. Decouple iommu_setup_dma_ops() from group->mutex in drivers/iommu/iommu.c:
>    iommu_setup_dma_ops() only requires struct device * and the domain pointer
>    (group->default_domain); it does not mutate any fields in struct iommu_group.
>    Moving the iommu_setup_dma_ops() calls after mutex_unlock(&group->mutex) in
>    iommu_probe_device(), bus_iommu_probe(), and iommu_group_store_type() breaks
>    the initial &group->mutex -> cpu_hotplug_lock dependency.

Are there any other code paths that rely on group->mutex -->
mm->mmap_lock ordering? If so fixing this one case wouldn't help.

> 2. Avoid holding down_write(&vdev->memory_lock) across pci_try_reset_function()
>    in VFIO:
>    vfio-pci could zap active BAR mappings under memory_lock and set a state
>    flag / disable memory decoding, drop memory_lock before calling
>    pci_try_reset_function(), and then re-acquire memory_lock to re-enable
>    memory. While resetting, any concurrent user fault will see the memory
>    disabled condition and return VM_FAULT_SIGBUS safely.

This would change the userspace-visible behavior of faulting on a VFIO
device BAR from "block until reset is done and the succeed" to "fail
with SIGBUS". And it would allow VFIO to access VFIO device BARs during
the reset through vfio_pci_core_iowrite*().

But I think we can extend this idea to solve those problems by
introducing a wait queue for tasks to sit on while a device is being
reset.

e.g. Something like this (completely untested and partially written by AI):

From: David Matlack <dmatlack@google.com>
Date: Tue, 25 Aug 2026 18:37:52 +0000
Subject: [PATCH] vfio/pci: Avoid circular locking dependency during device reset

Avoid a circular locking dependency during VFIO device reset by dropping
vdev->memory_lock prior to calling PCI reset functions
(pci_try_reset_function() and pci_reset_bus()). Introduce an explicit reset
state flag (vdev->resetting) and wait queue (vdev->reset_done_wq) to stall
concurrent BAR page faults and MMIO accesses during reset without holding
vdev->memory_lock across PCI reset operations.

Export a new helper function vfio_pci_core_try_reset() to consolidate the
common reset sequence across vfio_pci_ioctl_reset() and PCI config space
FLR handlers.

Export a new helper function vfio_pci_core_down_read_memory_lock() to
encapsulate acquiring down_read(&vdev->memory_lock) while waiting on
vdev->reset_done_wq if a reset is in progress.

Holding vdev->memory_lock across pci_try_reset_function() or pci_reset_bus()
causes a lock inversion between vdev->memory_lock and the IOMMU group
mutex (group->mutex). PCI reset functions invoke
pci_dev_reset_iommu_prepare(), which acquires group->mutex. However,
vdev->memory_lock is acquired inside page fault context
(vfio_pci_mmap_huge_fault()), placing vdev->memory_lock below mm->mmap_lock
in the locking hierarchy. Meanwhile, operations holding group->mutex (such
as sysfs interactions or IOMMU domain operations) can fault on user memory,
placing group->mutex above mm->mmap_lock. This establishes the circular
locking chain:

  group->mutex --> mm->mmap_lock --> vdev->memory_lock --> group->mutex

Simply dropping vdev->memory_lock before calling PCI reset routines would
alter userspace-visible behavior by causing concurrent BAR page faults
during reset to fail with VM_FAULT_SIGBUS rather than stalling until reset
completes.

Preserve the stalling behavior while resolving the deadlock:
1. In vfio_pci_core_try_reset(), set vdev->resetting = true under
   vdev->memory_lock, zap BAR mmaps, and drop vdev->memory_lock before
   calling pci_try_reset_function().
2. In vfio_pci_core_down_read_memory_lock(), if vdev->resetting is true, drop
   memory_lock and sleep uninterruptibly on vdev->reset_done_wq via wait_event().
3. Upon reset completion, clear vdev->resetting = false and wake up the wait
   queue.

Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a device")
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 20 +++---------
 drivers/vfio/pci/vfio_pci_core.c   | 51 ++++++++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_rdwr.c   |  4 +--
 include/linux/vfio_pci_core.h      |  4 +++
 4 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69ae..4980f53c21ca 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -907,14 +907,8 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 						 pos - offset + PCI_EXP_DEVCAP,
 						 &cap);
 
-		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
-			vfio_pci_zap_and_down_write_memory_lock(vdev);
-			vfio_pci_dma_buf_move(vdev, true);
-			pci_try_reset_function(vdev->pdev);
-			if (__vfio_pci_memory_enabled(vdev))
-				vfio_pci_dma_buf_move(vdev, false);
-			up_write(&vdev->memory_lock);
-		}
+		if (!ret && (cap & PCI_EXP_DEVCAP_FLR))
+			vfio_pci_core_try_reset(vdev);
 	}
 
 	/*
@@ -992,14 +986,8 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 						pos - offset + PCI_AF_CAP,
 						&cap);
 
-		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
-			vfio_pci_zap_and_down_write_memory_lock(vdev);
-			vfio_pci_dma_buf_move(vdev, true);
-			pci_try_reset_function(vdev->pdev);
-			if (__vfio_pci_memory_enabled(vdev))
-				vfio_pci_dma_buf_move(vdev, false);
-			up_write(&vdev->memory_lock);
-		}
+		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP))
+			vfio_pci_core_try_reset(vdev);
 	}
 
 	return count;
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6a184588ff23..ba5405f9980e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1315,15 +1315,12 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
-static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
-				void __user *arg)
+int vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
 {
 	int ret;
 
-	if (!vdev->reset_works)
-		return -EINVAL;
-
 	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	vdev->resetting = true;
 
 	/*
 	 * This function can be invoked while the power state is non-D0. If
@@ -1337,13 +1334,29 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	vfio_pci_set_power_state(vdev, PCI_D0);
 
 	vfio_pci_dma_buf_move(vdev, true);
+	up_write(&vdev->memory_lock);
+
 	ret = pci_try_reset_function(vdev->pdev);
+
+	down_write(&vdev->memory_lock);
+	vdev->resetting = false;
+	wake_up_all(&vdev->reset_done_wq);
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(vfio_pci_core_try_reset);
+
+static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
+				void __user *arg)
+{
+	if (!vdev->reset_works)
+		return -EINVAL;
+
+	return vfio_pci_core_try_reset(vdev);
+}
 
 static int vfio_pci_ioctl_get_pci_hot_reset_info(
 	struct vfio_pci_core_device *vdev,
@@ -1742,6 +1755,19 @@ void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev, u16 c
 	up_write(&vdev->memory_lock);
 }
 
+void vfio_pci_core_down_read_memory_lock(struct vfio_pci_core_device *vdev)
+{
+	while (1) {
+		down_read(&vdev->memory_lock);
+		if (!vdev->resetting)
+			return;
+
+		up_read(&vdev->memory_lock);
+		wait_event(vdev->reset_done_wq, !vdev->resetting);
+	}
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_down_read_memory_lock);
+
 static unsigned long vma_to_pfn(struct vm_area_struct *vma)
 {
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
@@ -1788,8 +1814,9 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
 	if (is_aligned_for_order(vma, addr, pfn, order)) {
-		scoped_guard(rwsem_read, &vdev->memory_lock)
-			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+		vfio_pci_core_down_read_memory_lock(vdev);
+		ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+		up_read(&vdev->memory_lock);
 	}
 
 	dev_dbg_ratelimited(&vdev->pdev->dev,
@@ -2198,6 +2225,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 		return ret;
 	INIT_LIST_HEAD(&vdev->dmabufs);
 	init_rwsem(&vdev->memory_lock);
+	init_waitqueue_head(&vdev->reset_done_wq);
 	xa_init(&vdev->ctx);
 
 	return 0;
@@ -2577,6 +2605,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 			break;
 		}
 
+		vdev->resetting = true;
 		vfio_pci_dma_buf_move(vdev, true);
 		vfio_pci_zap_bars(vdev);
 	}
@@ -2599,14 +2628,22 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
 		vfio_pci_set_power_state(vdev, PCI_D0);
 
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
+		up_write(&vdev->memory_lock);
+
 	ret = pci_reset_bus(pdev);
 
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
+		down_write(&vdev->memory_lock);
+
 	vdev = list_last_entry(&dev_set->device_list,
 			       struct vfio_pci_core_device, vdev.dev_set_list);
 
 err_undo:
 	list_for_each_entry_from_reverse(vdev, &dev_set->device_list,
 					 vdev.dev_set_list) {
+		vdev->resetting = false;
+		wake_up_all(&vdev->reset_done_wq);
 		if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev))
 			vfio_pci_dma_buf_move(vdev, false);
 		up_write(&vdev->memory_lock);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 7f14dd46de17..4313972e35ef 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -43,7 +43,7 @@ int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
 			bool test_mem, u##size val, void __iomem *io)	\
 {									\
 	if (test_mem) {							\
-		down_read(&vdev->memory_lock);				\
+		vfio_pci_core_down_read_memory_lock(vdev);		\
 		if (!__vfio_pci_memory_enabled(vdev)) {			\
 			up_read(&vdev->memory_lock);			\
 			return -EIO;					\
@@ -69,7 +69,7 @@ int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
 			bool test_mem, u##size *val, void __iomem *io)	\
 {									\
 	if (test_mem) {							\
-		down_read(&vdev->memory_lock);				\
+		vfio_pci_core_down_read_memory_lock(vdev);		\
 		if (!__vfio_pci_memory_enabled(vdev)) {			\
 			up_read(&vdev->memory_lock);			\
 			return -EIO;					\
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..152662be3795 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -148,6 +148,8 @@ struct vfio_pci_core_device {
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
+	bool			resetting;
+	wait_queue_head_t	reset_done_wq;
 	struct list_head	dmabufs;
 };
 
@@ -171,6 +173,8 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
 extern const struct pci_error_handlers vfio_pci_core_err_handlers;
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn);
+int vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev);
+void vfio_pci_core_down_read_memory_lock(struct vfio_pci_core_device *vdev);
 long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
 		unsigned long arg);
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,

> 
> 3. Refine synchronization in pci_dev_reset_iommu_prepare():
>    Evaluate if attaching to the blocking domain and pausing ATS during device
>    reset can be protected using more fine-grained locking or atomic state
>    flags without holding the coarse &group->mutex.

I don't know enough about this part of the kernel to say, but this would
directly address the new lock ordering dependency vdev->memory_lock -->
group->mutex introduced by commit f5b16b802174 ("PCI: Suspend iommu function
prior to resetting a device"), which is what led to this lockdep error.
