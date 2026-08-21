Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9240926C
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340910; cv=none; b=pmh9P0fkZtUbDd6WjagNUELhEgdS9SCmj+6p4bB4FUEH/biW1ESj03Dj9Qj1YhihVoNmRWMcOzIKKHEegavTBtH38p6PkuAry32MM6eeFDSATyMQhYNWYzxckqe8IQ7A2x7XDYyejwj89CxqPecTkh4y6TQQ+BdgEj4BZOE4l90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340910; c=relaxed/simple;
	bh=i8ESiV6L2plHzn7KxH4mnOYo7aS5K7GloZklEsEE3Ts=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TYjfcsFun55zupHouJ3MRFmcLaOcm+Zo4JJeWUWsrTy8HB/2tbVBs8Jro2nzz4JRba7TPfAwRMoLiT1BPY/7eds7pO1RXgNOWcVGSJ6gRsPOcthNmSYsO9fGFPUO4+Hwl+729dzJie2tDawKEKvab29L7O5R6/btBzLAxZgkczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEIzq/Km; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEIzq/Km"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cccfa32670so22003465ad.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787340908; x=1787945708; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=APoIfiutmOI24Q7s+K9Mw4NYpvb2CDqGTTKGQXs7DgU=;
        b=gEIzq/Kme33Z/1g30JfSIB+I4urXkUlTIl9OnJGNT57cBvAlLEKdx0btozdE3NchFY
         9k5Lf4NXgabOnDItqy4kaQOntLgQrJiT/2ORVlRNSuqeyK4jBSHyS82yu1n3wTg+1Lwq
         lIxjsG+saYVEcmK3rBZ/dCDBbWGMH++4bmgwxIJ6/FJnoYWry6e76rnYgtr+CGjKL64E
         WsYGl5B6mdFKb6ysIzfRZCCCqhqZXTJBcCyNjQR4fPm2IotvRYVpEvngjBmi+CiEJFBo
         VWtZ6bybuW+jARFddTY5byPEwDNdgT1AQOhNOj7CNjMuzM1W4xB1eJG6oypdz0EGiwO1
         M2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787340908; x=1787945708;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=APoIfiutmOI24Q7s+K9Mw4NYpvb2CDqGTTKGQXs7DgU=;
        b=pcw2YOCorU+DlBWsWgZ06vkj6xPDhJHXSGtwAKNkojY8Te0WwaLsf9vYp6pqSjAQkz
         MbETPTfMvVnH6fKvrMWt3SB0kr1CXhw9Ba0WPVSD/9cWN4vLLyQoVbXhKRq1DSOdziBb
         islWXgAA9GeDHyuI88jBoKuHQP4UFA6jOow/5kWf8QVdQWd74xw3F2SKDQTvgBOnt897
         j6lZvVmdOV4E44desm2t2tzeh7OLel5AKKET2ntFUywK/AQV9TRNruLMYVXYAIPdoGQK
         TKd3lSuqhbfu1v2aO8Svbwb69Dq9E6cAh+0HV+/L2EOjxy4YbkVdqdVVcnr114ADyif7
         8E1A==
X-Forwarded-Encrypted: i=1; AHgh+RqzAl2PLh5zKjbfqPiNH8qZoCtblWVoFq4BmnWbrRb3fQNGGQeQ6l8h/iZOOPBzF5h7Q4cNMBGcOsA=@vger.kernel.org
X-Gm-Message-State: AFuF++nIh7BpQxp/tss2rvbXVjbzUZPTFnYdBP48FOMu7ATMHXf+mRGe
	zLBixfEcRUdYdbbcjQfahZ5kOlwmFleB0QVAJTfh8J99lfzZPHE0EXNY4ZVWRXaBKGtnbobClJg
	q1M6QIqB+Tw==
X-Received: from plbjf12.prod.google.com ([2002:a17:903:268c:b0:2ce:9b92:ec60])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e952:b0:2ca:ec6f:aeca
 with SMTP id d9443c01a7336-2d670bf937fmr10710815ad.8.1787340908066; Fri, 21
 Aug 2026 12:35:08 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:35:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260821193502.92431-1-vipinsh@google.com>
Subject: [RFC PATCH 0/1] vfio: circular locking dependency in pci_dev_reset_iommu_prepare()
From: Vipin Sharma <vipinsh@google.com>
To: Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>
Cc: jrhilke@google.com, skhawaja@google.com, tatashin@google.com, 
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I have encountered a reproducible circular locking dependency (lockdep)
warning when performing a device reset via VFIO (e.g. VFIO_DEVICE_RESET ioctl
or kexec live update) on a device whose BARs have been mmapped and faulted.

This issue was introduced in commit f5b16b802174 ("PCI: Suspend iommu function
prior to resetting a device"), which added calls to
pci_dev_reset_iommu_prepare() / pci_dev_reset_iommu_done() inside core PCI
reset routines (pcie_flr(), pci_pm_reset(), etc.).

Patch 1 adds a new selftest in tools/testing/selftests/vfio/ that triggers
this warning reliably on systems with ATS and reset support.

I used Intel DSA device 8086:0b25 with the test in Patch 1.

This issue was identified in the VFIO Live Update series
  https://lore.kernel.org/kvm/20260723181436.GB260824.vipinsh@google.com/

Since issue is independent of Live Update, I am sending this out
separately to not mix two things.

I have uploaded the patch to github also:
  https://github.com/shvipin/linux vfio/lockdep-mmap-fault-device-reset

================================================================================
Lock Hierarchy Analysis (Helped by AI)
================================================================================

1. In VFIO, handling VFIO_DEVICE_RESET (vfio_pci_ioctl_reset()) or bus/hot reset
   acquires down_write(&vdev->memory_lock) to zap active MMIO BAR mappings
   and prevent concurrent MMIO faults during reset.
   Inside memory_lock, it calls pci_try_reset_function() / pcie_flr().

2. Commit f5b16b802174 added pci_dev_reset_iommu_prepare() into pcie_flr().
   pci_dev_reset_iommu_prepare() acquires guard(mutex)(&group->mutex).
   This establishes:
       &vdev->memory_lock --> &group->mutex

3. Meanwhile, during kernel boot or device discovery (iommu_probe_device() /
   bus_iommu_probe()), iommu.c holds &group->mutex while calling
   iommu_setup_dma_ops(), which calls iova_domain_init_rcaches().
   iova_domain_init_rcaches() registers a multi-instance cpuhp handler via
   cpuhp_state_add_instance_nocalls(), acquiring cpus_read_lock().
   This establishes:
       &group->mutex --> cpu_hotplug_lock

4. cpu_hotplug_lock is an outer lock for various kernel subsystems that
   execute callbacks or sysfs/firmware/perf interactions, which eventually
   perform copy_to_user(), copy_from_user(), or filldir() (which can trigger
   a page fault in user memory under mmap_lock).
   This establishes:
       cpu_hotplug_lock --> (kernfs_rwsem / inode->i_rwsem / cpuctx_mutex)
                        --> &mm->mmap_lock

5. When userspace touches an mmapped VFIO BAR, the page fault handler
   (vfio_pci_mmap_huge_fault() / vfio_pci_mmap_page_fault()) executes under
   &mm->mmap_lock and acquires down_read(&vdev->memory_lock).
   This establishes:
       &mm->mmap_lock --> &vdev->memory_lock

Combining (1) through (5) yields the circular dependency cycle:

    &group->mutex
      --> cpu_hotplug_lock
        --> [kernfs_rwsem | i_mutex_dir_key | cpuctx_mutex]
          --> &mm->mmap_lock
            --> &vdev->memory_lock
              --> &group->mutex  <== DEADLOCK DETECTED


================================================================================
Reproductions / Lockdep Traces
================================================================================

I observed this lockdep warning closing via multiple distinct paths:

--- Trace 1: via sysfs / kernfs readdir ---

[  438.457974] WARNING: possible circular locking dependency detected
[  438.477952] vfio_cdev_lockd/17678 is trying to acquire lock:
[  438.484320] (&group->mutex){+.+.}-{4:4}, at: pci_dev_reset_iommu_prepare+0x6e/0x200
[  438.494169] but task is already holding lock:
[  438.501401] (&vdev->memory_lock){++++}-{4:4}, at: vfio_pci_core_ioctl+0x460/0xb20
[  438.511064] which lock already depends on the new lock.
...
[  438.919866] Chain exists of:
[  438.919866]   &group->mutex --> &mm->mmap_lock --> &vdev->memory_lock
...
[  438.999115]  __mutex_lock+0x8c/0xd80
[  438.999122]  pci_dev_reset_iommu_prepare+0x6e/0x200
[  438.999123]  pcie_flr+0x32/0xc0
[  438.999125]  __pci_reset_function_locked+0x84/0x120
[  438.999126]  pci_try_reset_function+0x51/0xe0
[  438.999128]  vfio_pci_core_ioctl+0x72b/0xb20

--- Trace 2: via VFS lookup / microcode loading during kexec ---

[  584.552264] WARNING: possible circular locking dependency detected
[  584.572247] kexec/14239 is trying to acquire lock:
[  584.577754] (&group->mutex){+.+.}-{4:4}, at: pci_dev_reset_iommu_prepare+0x6e/0x1a0
[  584.587602] but task is already holding lock:
[  584.594838] (&vdev->memory_lock){++++}-{4:4}, at: vfio_pci_liveupdate_freeze+0x51/0x100
...
[  584.751130] -> #2 (&type->i_mutex_dir_key#4):
[  584.760319]        lookup_slow+0x26/0x50
[  584.786970]        _request_firmware+0x4ab/0x8c0
[  584.797979]        request_microcode_fw+0xf2/0x510
[  584.834601] -> #1 (cpu_hotplug_lock):
[  584.842183]        cpus_read_lock+0x3b/0xd0
[  584.858957]        iommu_setup_dma_ops+0x175/0x540

--- Trace 3: via perf read / watchdog cpuhp callback ---

[  233.859740] WARNING: possible circular locking dependency detected
[  233.879725] vfio_cdev_lockd/14999 is trying to acquire lock:
[  233.886094] (&group->mutex){+.+.}-{4:4}, at: pci_dev_reset_iommu_prepare+0x6e/0x200
[  233.895948] but task is already holding lock:
[  233.903183] (&vdev->memory_lock){++++}-{4:4}, at: vfio_pci_core_ioctl+0x460/0xb20
...
[  234.030037] -> #3 (&cpuctx_mutex):
[  234.040960]        perf_event_enable+0x18/0xa0
[  234.046126]        lockup_detector_online_cpu+0x22/0x30
[  234.057658]        cpuhp_thread_fun+0x164/0x1e0
[  234.115402] -> #1 (cpu_hotplug_lock):
[  234.122985]        cpus_read_lock+0x3b/0xd0
[  234.139757]        iommu_setup_dma_ops+0x18a/0x560


================================================================================
Potential Solutions Suggested by AI
================================================================================

1. Decouple iommu_setup_dma_ops() from group->mutex in drivers/iommu/iommu.c:
   iommu_setup_dma_ops() only requires struct device * and the domain pointer
   (group->default_domain); it does not mutate any fields in struct iommu_group.
   Moving the iommu_setup_dma_ops() calls after mutex_unlock(&group->mutex) in
   iommu_probe_device(), bus_iommu_probe(), and iommu_group_store_type() breaks
   the initial &group->mutex -> cpu_hotplug_lock dependency.

2. Avoid holding down_write(&vdev->memory_lock) across pci_try_reset_function()
   in VFIO:
   vfio-pci could zap active BAR mappings under memory_lock and set a state
   flag / disable memory decoding, drop memory_lock before calling
   pci_try_reset_function(), and then re-acquire memory_lock to re-enable
   memory. While resetting, any concurrent user fault will see the memory
   disabled condition and return VM_FAULT_SIGBUS safely.

3. Refine synchronization in pci_dev_reset_iommu_prepare():
   Evaluate if attaching to the blocking domain and pausing ATS during device
   reset can be protected using more fine-grained locking or atomic state
   flags without holding the coarse &group->mutex.

Feedback and suggestions on the preferred direction to resolve this would be
greatly appreciated.

Thanks,
Vipin Sharma

Vipin Sharma (1):
  selftests: vfio: Add mmap fault and device reset test

 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/vfio_pci_mmap_reset_test.c | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_mmap_reset_test.c

-- 
2.55.0.766.g2966f0265a-goog
