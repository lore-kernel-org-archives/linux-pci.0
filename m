Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671B369D7E
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407394; cv=none; b=rFg8ELn1xrWGfxSEWkSftoW3DVeY/zVQjDjagEmG+NRFHUcjQTnsexvFSmVjHKlWljkIvMYQmBDcvAPiViJ1vd6N1+1nnvgT+cWp7fzeqyx3NUDI+a8fncc9Ompp+BUaXSgBpmtLAE/7sdtq6oLqTccvqqyx0tJSu0pFWXYPRJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407394; c=relaxed/simple;
	bh=RlvVvn5qAXkYGJYYl58HpoiHe5YmE4xf+shwtXQwg6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMyFJhA6jx28WqUiA8qCMN7J/CvoifwOvjmJzcJcKOTDQp2WRMVfOFrlyz+BUMquXSsNnKtHokAZa7obsWn4ygyyZ7nQ4XI43UWUsC3ej4kPe6qVNGM78UkGBQUcktX1fcXPuqljCaMx9slZCNBziAslGrx1qSWm9i+Ozu+9X9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fua23LFh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fua23LFh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so7132092a91.1
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779407385; x=1780012185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9YniZzyspPzB3Asse1mx2Hj/g3w5skrEnZ18omBiuI=;
        b=fua23LFhU0FREIBmFVIV03opkNafLLry2xaKUbr1de3yZu1iY/1pVrttjdxmR+d456
         umPRTjKaOkjpVzg5+Bxy65AWImDeMI3IV0dhqgzJz3LglKDVyYXrw3zRNQP7JMrrT4gn
         EwLicDD85PRVHernq6YJFQMwqE4+c8A5L3hBXGOa+35UmFHWyGUbcOgWrLEXHgM5DucU
         Mwlw6i7sVCywvG2VKfj7eYQSYg1SxdAKPx/1BsyvqRa0/vWss1YpJCkoL636JwyxlFPS
         ARFnjkFpgFor2UQcE7pgtsDpvYg+e0YHB2gwut5KvGNiDbpFWUvz0lhD0PA3mA/+rw6k
         Q5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779407385; x=1780012185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9YniZzyspPzB3Asse1mx2Hj/g3w5skrEnZ18omBiuI=;
        b=jnHL+tnkV3fsRUModNk3aZoI1xDDqBm3pzaHP/3Smr5xiBFwRPf6hu5uzOekFYjkHe
         jw4Pz3FaLNl/LoZa9MtpAx48cRjXSLsp4qXUbXCdtnZg05GCvGnvmpk4Cc0ujr5xjDsW
         G2NaF6Nu8ZFECVg3Oz6ZzuKneSlvCmEGEUyE/37L9jd1TsrEzbwKBHpo3v/HFwjSp9Tt
         TECs/73vTrsq0d1mBa1Vfo5+NhrZ6YKp87xZzPXxVNF484OTISjUdq6azKLgBYZG2yix
         AUSsivEH9N3G4yebWKMmoM27oH5sCF4FDwRO1OA/oNBQ6YuKGIoFL28j3xcVdeI2/CmN
         H7Sg==
X-Forwarded-Encrypted: i=1; AFNElJ97L4T4p+ZwGOZnQND6ZPjV0Lba779gnVDnEmNI5JNdFM3GimEojgJPE2VWaTArAlppatt8XWvoOdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJl4Mu+gibRNHux5wSosHRQSpDNSKYqO2K9H2Gx5W2jR4En/D3
	RuWvtFN4JKJ8z6XhXlfZwC2xENxIpDxrJ4EmJMct4hojA/ss0pUZR9HiAXU6qg8fjw==
X-Gm-Gg: Acq92OGvjbb4PtONSb4fAEZuzDNIZM9NWjx4e3EZAbJ2l+NosHJ4vBU8XCuw+2fJOJk
	lzzTiiZtRWTT6Nd3nsuZYqNqSf0hCpdw2ZYDrmnv+0WZ+T5k/k5mRbQBqcvi0dSwZBIO5OyXIGa
	zrE+W78MDPcDiDIbW/uRWHcSUt9nhrcwhHihH3aiEDHbCLr6E1WdLKB6hlmIr1WunEU1+rj4Yzv
	x9GwYglVSMPPNU0NlU9aPwOGICRgKFVKIsJXn803UD0VgP1EGjiqaGzQF9oFDfwQIPJTZyfjgmp
	DYkbvzyuqNy2wqkkC34BCwE6zvVGV2MRqppu6FmoEnyKtgcXbNOaHhHPi8HzWnrJo0RVqoL8Lre
	Nv7177nFUV8SnHsqUjgrU96Mpnl6d32FAgy5Ycw4NsUJhLbr94RRiHEjjqC2xzxHRnDIPTwUXG+
	qOfmRIFhfRcFhsbIOd/TiDgVJWSTuhFVYUf6PUdXY3LVwuT+Ufwigs3ePAFDkC7K6FgYXYhpYLc
	OINMNAPyGU=
X-Received: by 2002:a17:903:15c7:b0:2bd:3d5b:e87c with SMTP id d9443c01a7336-2beb076fc3cmr10276655ad.37.1779407384623;
        Thu, 21 May 2026 16:49:44 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb13b414esm3978545ad.67.2026.05.21.16.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:49:44 -0700 (PDT)
Date: Thu, 21 May 2026 23:49:40 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, ajayachandra@nvidia.com,
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com,
	apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net,
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com,
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com,
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com,
	lukas@wunner.de, michal.winiarski@intel.com, parav@nvidia.com,
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org,
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com,
	rppt@kernel.org, saeedm@nvidia.com, skhan@linuxfoundation.org,
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com,
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v4 02/16] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <ag-aFA1BJxdJMywr@google.com>
References: <20260511234802.2280368-1-vipinsh@google.com>
 <20260511234802.2280368-3-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511234802.2280368-3-vipinsh@google.com>

On 2026-05-11 04:47 PM, Vipin Sharma wrote:

> +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
> +{
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +	struct vfio_pci_core_device *vdev;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	pdev = vdev->pdev;
> +
> +	guard(mutex)(&device->dev_set->lock);
> +
> +	/*
> +	 * Userspace must disable interrupts on the device prior to freeze so
> +	 * that the device does not send any interrupts until new interrupt
> +	 * handlers have been established by the next kernel.
> +	 */
> +	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
> +		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
> +		return -EINVAL;
> +	}
> +
> +	guard(rwsem_write)(&vdev->memory_lock);
> +
> +	/*
> +	 * Userspace must make sure device is not in the lower power state for
> +	 * live update. We may relax this in future.
> +	 */
> +	if (pdev->current_state != PCI_D0) {
> +		pci_err(pdev, "Freeze failed! Device not in D0 state.\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Reset is a temporary measure to provide kernel after kexec a clean
> +	 * device while VFIO live update work is under development and not
> +	 * fully supported.  It will go away once continuous DMA support is
> +	 * added to device preservation.
> +	 */
> +	vfio_pci_zap_bars(vdev);
> +	ret = pci_load_saved_state(pdev, vdev->pci_saved_state);
> +	if (ret)
> +		return ret;
> +	pci_clear_master(pdev);
> +	vfio_pci_core_try_reset(vdev);

I am seeing the following lockdep splat get triggered by this reset when
testing with this commit using vfio_pci_liveupdate_kexec_test. It seems to be
related to taking memory_lock above.

[ 2710.299017][T75672] ======================================================
[ 2710.305908][T75672] WARNING: possible circular locking dependency detected
[ 2710.312797][T75672] 7.1.0-dbg-DEV #59 Tainted: G S
[ 2710.319077][T75672] ------------------------------------------------------
[ 2710.325967][T75672] kexec/75672 is trying to acquire lock:
[ 2710.331474][T75672] ff46fd4fdbaeef08 (&group->mutex){+.+.}-{4:4}, at: pci_dev_reset_iommu_prepare+0x6e/0x1a0
[ 2710.341336][T75672]
[ 2710.341336][T75672] but task is already holding lock:
[ 2710.348574][T75672] ff46fd501f9a19a8 (&vdev->memory_lock){++++}-{4:4}, at: vfio_pci_liveupdate_freeze+0x51/0x100
[ 2710.358764][T75672]
[ 2710.358764][T75672] which lock already depends on the new lock.
[ 2710.358764][T75672]
[ 2710.369031][T75672]
[ 2710.369031][T75672] the existing dependency chain (in reverse order) is:
[ 2710.377916][T75672]
[ 2710.377916][T75672] -> #4 (&vdev->memory_lock){++++}-{4:4}:
[ 2710.385675][T75672]        down_read+0x3d/0x150
[ 2710.390235][T75672]        vfio_pci_mmap_huge_fault+0xb9/0x160
[ 2710.396091][T75672]        __do_fault+0x46/0x140
[ 2710.400734][T75672]        do_pte_missing+0x4c3/0xff0
[ 2710.405803][T75672]        handle_mm_fault+0x7c4/0xb30
[ 2710.410961][T75672]        fixup_user_fault+0x115/0x270
[ 2710.416209][T75672]        vaddr_get_pfns+0x1a1/0x390
[ 2710.421286][T75672]        vfio_pin_pages_remote+0x148/0x4d0
[ 2710.426959][T75672]        vfio_pin_map_dma+0xcc/0x260
[ 2710.432116][T75672]        vfio_iommu_type1_ioctl+0xda4/0xec0
[ 2710.437884][T75672]        __se_sys_ioctl+0x71/0xc0
[ 2710.442790][T75672]        do_syscall_64+0x15f/0x710
[ 2710.447788][T75672]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 2710.454074][T75672]
[ 2710.454074][T75672] -> #3 (&mm->mmap_lock){++++}-{4:4}:
[ 2710.461489][T75672]        down_read_killable+0x48/0x180
[ 2710.466821][T75672]        mmap_read_lock_killable+0x12/0x50
[ 2710.472505][T75672]        lock_mm_and_find_vma+0x11d/0x130
[ 2710.478093][T75672]        do_user_addr_fault+0x3a0/0x6c0
[ 2710.483521][T75672]        exc_page_fault+0x68/0xa0
[ 2710.488423][T75672]        asm_exc_page_fault+0x26/0x30
[ 2710.493669][T75672]        filldir+0xe2/0x190
[ 2710.498047][T75672]        ext4_readdir+0xb47/0xcf0
[ 2710.502950][T75672]        iterate_dir+0x84/0x160
[ 2710.507677][T75672]        __se_sys_getdents+0x74/0x120
[ 2710.512929][T75672]        do_syscall_64+0x15f/0x710
[ 2710.517919][T75672]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 2710.524202][T75672]
[ 2710.524202][T75672] -> #2 (&type->i_mutex_dir_key#4){++++}-{4:4}:
[ 2710.532478][T75672]        down_read+0x3d/0x150
[ 2710.537030][T75672]        lookup_slow+0x26/0x50
[ 2710.541675][T75672]        link_path_walk+0x42c/0x580
[ 2710.546743][T75672]        path_openat+0xd1/0xde0
[ 2710.551466][T75672]        do_file_open_root+0x114/0x250
[ 2710.556798][T75672]        file_open_root+0x89/0xb0
[ 2710.561703][T75672]        kernel_read_file_from_path_initns+0xba/0x130
[ 2710.568342][T75672]        _request_firmware+0x4ab/0x8c0
[ 2710.573677][T75672]        request_firmware_direct+0x36/0x50
[ 2710.579356][T75672]        request_microcode_fw+0xf2/0x510
[ 2710.584869][T75672]        reload_store+0x197/0x230
[ 2710.589766][T75672]        kernfs_fop_write_iter+0x13f/0x1d0
[ 2710.595452][T75672]        vfs_write+0x2be/0x3b0
[ 2710.600097][T75672]        ksys_write+0x73/0x100
[ 2710.604735][T75672]        do_syscall_64+0x15f/0x710
[ 2710.609723][T75672]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 2710.616009][T75672]
[ 2710.616009][T75672] -> #1 (cpu_hotplug_lock){++++}-{0:0}:
[ 2710.623591][T75672]        cpus_read_lock+0x3b/0xd0
[ 2710.628499][T75672]        __cpuhp_state_add_instance+0x19/0x40
[ 2710.634443][T75672]        iova_domain_init_rcaches+0x1ef/0x230
[ 2710.640385][T75672]        iommu_setup_dma_ops+0x175/0x540
[ 2710.645891][T75672]        iommu_device_register+0x188/0x220
[ 2710.651564][T75672]        intel_iommu_init+0x35a/0x440
[ 2710.656811][T75672]        pci_iommu_init+0x16/0x40
[ 2710.661713][T75672]        do_one_initcall+0xf5/0x3a0
[ 2710.666786][T75672]        do_initcall_level+0x82/0xa0
[ 2710.671953][T75672]        do_initcalls+0x43/0x70
[ 2710.676672][T75672]        kernel_init_freeable+0x152/0x1d0
[ 2710.682266][T75672]        kernel_init+0x1a/0x130
[ 2710.686996][T75672]        ret_from_fork+0x16b/0x310
[ 2710.691991][T75672]        ret_from_fork_asm+0x1a/0x30
[ 2710.697151][T75672]
[ 2710.697151][T75672] -> #0 (&group->mutex){+.+.}-{4:4}:
[ 2710.704478][T75672]        __lock_acquire+0x14c6/0x2800
[ 2710.709729][T75672]        lock_acquire+0xd3/0x2c0
[ 2710.714542][T75672]        __mutex_lock+0x8f/0xcd0
[ 2710.719349][T75672]        pci_dev_reset_iommu_prepare+0x6e/0x1a0
[ 2710.725461][T75672]        pcie_flr+0x32/0xc0
[ 2710.729842][T75672]        __pci_reset_function_locked+0x84/0x120
[ 2710.735954][T75672]        vfio_pci_core_try_reset+0x96/0xe0
[ 2710.741630][T75672]        vfio_pci_liveupdate_freeze+0x89/0x100
[ 2710.747653][T75672]        luo_file_freeze+0xba/0x280
[ 2710.752725][T75672]        luo_session_serialize+0x69/0x190
[ 2710.758321][T75672]        liveupdate_reboot+0x19/0x30
[ 2710.763490][T75672]        kernel_kexec+0x2f/0xa0
[ 2710.768220][T75672]        __se_sys_reboot+0xfd/0x210
[ 2710.773301][T75672]        do_syscall_64+0x15f/0x710
[ 2710.778284][T75672]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 2710.784568][T75672]
[ 2710.784568][T75672] other info that might help us debug this:
[ 2710.784568][T75672]
[ 2710.794663][T75672] Chain exists of:
[ 2710.794663][T75672]   &group->mutex --> &mm->mmap_lock --> &vdev->memory_lock
[ 2710.794663][T75672]
[ 2710.807543][T75672]  Possible unsafe locking scenario:
[ 2710.807543][T75672]
[ 2710.814863][T75672]        CPU0                    CPU1
[ 2710.820106][T75672]        ----                    ----
[ 2710.825352][T75672]   lock(&vdev->memory_lock);
[ 2710.829904][T75672]                                lock(&mm->mmap_lock);
[ 2710.836620][T75672]                                lock(&vdev->memory_lock);
[ 2710.843682][T75672]   lock(&group->mutex);
[ 2710.847798][T75672]
[ 2710.847798][T75672]  *** DEADLOCK ***
[ 2710.847798][T75672]
[ 2710.855818][T75672] 7 locks held by kexec/75672:
[ 2710.860457][T75672]  #0: ffffffff90a81330 (system_transition_mutex){+.+.}-{4:4}, at: __se_sys_reboot+0xe4/0x210
[ 2710.870554][T75672]  #1: ffffffff90e1d0c0 (luo_session_global.outgoing.rwsem){+.+.}-{4:4}, at: luo_session_serialize+0x1f/0x190
[ 2710.882043][T75672]  #2: ff46fd50602b7ae0 (&session->mutex){+.+.}-{4:4}, at: luo_session_serialize+0x4f/0x190
[ 2710.891972][T75672]  #3: ff46fd500bec0788 (&luo_file->mutex){+.+.}-{4:4}, at: luo_file_freeze+0x65/0x280
[ 2710.901463][T75672]  #4: ff46fd509d8106a8 (&new_dev_set->lock){+.+.}-{4:4}, at: vfio_pci_liveupdate_freeze+0x36/0x100
[ 2710.912086][T75672]  #5: ff46fd501f9a19a8 (&vdev->memory_lock){++++}-{4:4}, at: vfio_pci_liveupdate_freeze+0x51/0x100
[ 2710.922701][T75672]  #6: ff46fd4fd416c1f0 (&dev->mutex){....}-{4:4}, at: pci_dev_trylock+0x25/0x60
[ 2710.931676][T75672]
[ 2710.931676][T75672] stack backtrace:
[ 2710.937439][T75672] CPU: 193 UID: 0 PID: 75672 Comm: kexec Tainted: G S                  7.1.0-dbg-DEV #59 PREEMPTLAZY
[ 2710.937442][T75672] Tainted: [S]=CPU_OUT_OF_SPEC
[ 2710.937442][T75672] Hardware name: Google Izumi-EMR/izumi, BIOS 0.20251023.0-0 10/23/2025
[ 2710.937443][T75672] Call Trace:
[ 2710.937446][T75672]  <TASK>
[ 2710.937448][T75672]  dump_stack_lvl+0x54/0x70
[ 2710.937453][T75672]  print_circular_bug+0x2e1/0x300
[ 2710.937455][T75672]  check_noncircular+0xf9/0x120
[ 2710.937456][T75672]  ? __bfs+0x129/0x200
[ 2710.937458][T75672]  __lock_acquire+0x14c6/0x2800
[ 2710.937460][T75672]  ? __lock_acquire+0x1240/0x2800
[ 2710.937463][T75672]  ? pci_dev_reset_iommu_prepare+0x6e/0x1a0
[ 2710.937465][T75672]  lock_acquire+0xd3/0x2c0
[ 2710.937466][T75672]  ? pci_dev_reset_iommu_prepare+0x6e/0x1a0
[ 2710.937468][T75672]  ? lock_is_held_type+0x76/0x100
[ 2710.937471][T75672]  ? pci_dev_reset_iommu_prepare+0x6e/0x1a0
[ 2710.937473][T75672]  __mutex_lock+0x8f/0xcd0
[ 2710.937473][T75672]  ? pci_dev_reset_iommu_prepare+0x6e/0x1a0
[ 2710.937475][T75672]  ? lockdep_hardirqs_on_prepare+0x151/0x210
[ 2710.937477][T75672]  ? _raw_spin_unlock_irqrestore+0x35/0x50
[ 2710.937482][T75672]  pci_dev_reset_iommu_prepare+0x6e/0x1a0
[ 2710.937484][T75672]  pcie_flr+0x32/0xc0
[ 2710.937485][T75672]  __pci_reset_function_locked+0x84/0x120
[ 2710.937487][T75672]  vfio_pci_core_try_reset+0x96/0xe0
[ 2710.937489][T75672]  vfio_pci_liveupdate_freeze+0x89/0x100
[ 2710.937490][T75672]  luo_file_freeze+0xba/0x280
[ 2710.937492][T75672]  luo_session_serialize+0x69/0x190
[ 2710.937493][T75672]  liveupdate_reboot+0x19/0x30
[ 2710.937495][T75672]  kernel_kexec+0x2f/0xa0
[ 2710.937496][T75672]  __se_sys_reboot+0xfd/0x210
[ 2710.937497][T75672]  ? check_object+0x1ee/0x390
[ 2710.937500][T75672]  ? lock_release+0xef/0x350
[ 2710.937501][T75672]  ? kmem_cache_free+0x1b5/0x520
[ 2710.937506][T75672]  ? _raw_spin_unlock_irqrestore+0x35/0x50
[ 2710.937508][T75672]  ? kmem_cache_free+0x1b5/0x520
[ 2710.937509][T75672]  ? __x64_sys_close+0x3d/0x80
[ 2710.937510][T75672]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 2710.937511][T75672]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 2710.937512][T75672]  do_syscall_64+0x15f/0x710
[ 2710.937514][T75672]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 2710.937515][T75672] RIP: 0033:0x7fa57e4f2513
[ 2710.937519][T75672] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 89 fa b8 a9 00 00 00 bf ad de e1 fe be 69 19 12 28 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 f7 d8 48 8b 0d db 2c 07 00 64 89 01 48
[ 2710.937520][T75672] RSP: 002b:00007ffd16943748 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
[ 2710.937523][T75672] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa57e4f2513
[ 2710.937524][T75672] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000fee1dead
[ 2710.937526][T75672] RBP: 00007ffd16943a60 R08: 0000000000000009 R09: 00007fa57e5672e0
[ 2710.937527][T75672] R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffd169438e0
[ 2710.937528][T75672] R13: 0000000000000000 R14: 00007ffd169438e0 R15: 0000000000000001
[ 2710.937532][T75672]  </TASK>

> +	pci_restore_state(pdev);
> +	return 0;
>  }
