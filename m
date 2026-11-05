Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905943;
	b=ugMZ16jUMKRWHKApvHowyx7/EgSqV3VcPhXCJXuUEl0IDQ+N/CAbDNYKjkZDC9Nqi4nx
	 ll5S9XucKemaisqWZMVAXKv+6ne70ELWZdQct6nEuaeTxpPnDvR7TanzWAGXZIeyafOPH
	 nhN+ncVA7TZqxg2sbOevTaxL0XFpYDW+48oWOEb6mBpL1/PdPRGqipOz6o2R56uAHuIBx
	 CiekeH24nAxRdE5aEL/S5O/BsdqrOIs1gIsJqP4dh0HgEzI/UTkAB+AvMpg9XA5hIqfix
	 CzkHmWWG8my3FJ40w7rT0jcCZH/HELtgzv6hrlg+WB5HKToRmrqB6g97AOfC/utPtvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QH8EWm3WpJvKmm+3SH11RyockHxBeCCGhqou8vP+rPk=;
	b=OQphc3erNpG83g6RzULYPot+SWgXopWRgfh0u/lQA8c/qvzUTQEqhllC4F1CpiggYPsB
	 oLbatBqTkadFdmD8J28clp26Vpt2H/zDwBnzS00ghOXg3uCZ7rS1brr0XXnc/qdEAIgwL
	 0f/i43Kpjo59Q6xeZwkYJgoO9CxLak8SCyQoy9+T0CQLjRw0XcDRRd5pVZxKOq+JBSg4a
	 YZmozVU9jh/T6y90her3jkqpzC9iDdG7cVJ4Kdmu3PBr657hVza7rRFjJKANunsIx+HYJ
	 XQg8vpF3LrUnaXYje/aBEZ3adaih+Dlm38RwhFpXuyyOt1lhjW0PJ5xNzUyihjWLXDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B0MNLtWQ;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1049606A32C
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1049606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B0MNLtWQ
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso945323a12.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 11:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793905942; x=1794510742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QH8EWm3WpJvKmm+3SH11RyockHxBeCCGhqou8vP+rPk=;
        b=B0MNLtWQGjDmicRxY8nTu69DmYdME/D2jJN8rX+nGAlTMa5/iKX0Zivd7mhh+flPfs
         xy3ZoNN4HgIKW4K4+mbAoNWhsSmDgb1P3WgIZCjZvecSakD2rB4XrTL8WwonQtbvNgZ8
         h8p2WNu5k95YFljALG1jMJJ03s4qGmEUPwOwManEDxZ+GcL/xuiqjJVeLqmp+5UyzAW6
         9EH7p2MmwcpUJDnOC5R25PxQkZi+0TuqQnMBjToaTQ/j5/LnlqaqNQd3J93XCaF2MN6H
         E7WHw7qCt48+ehLyUoviWDEPPA7ju+e/24ge/Nj8T6fML4Ui3s4IgQMHHYqUJVnOXFuq
         B5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793905942; x=1794510742;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QH8EWm3WpJvKmm+3SH11RyockHxBeCCGhqou8vP+rPk=;
        b=MN7KZpQx+bgdAzqeO2E3m4+aWoXtDWpiKaWFk6ZpuG9zapMwG8mBG5SJbtcCWP8FKY
         AEMIUQZDLtzn7aTj4N6dz1r3NawiLcWxZjp6DS4CKpToODohs6W65VdD9ReZnO1rFvf0
         w53n+flHjnyzCc6ltIKoGgBNfy0FW1aN+V6AgNuXcd392Ks077iACxJWCZEh6Zb4sPZW
         3coY9WfXqvLHnsPErLSgSoRI8FojsNJmQ2MfFjJ/vtOfWEu9oGjeyctWg9bzydZrFNZX
         dyI9/NSp1D6l44cJ0H9eX/ByQA5nDKhmEUiWdoEIDla0PqhsN7WoATZ7bvYuDXnFyYte
         vPMw==
X-Forwarded-Encrypted: i=1; AKwUvBzyWjfiMHi2JAMWbEJPIRPndm5knWVP3LwOl/UOGVNU1g479ELZTgS7sU86amnrsBEFIY6Oxz6U8XA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9l823VQrzgdjE//NT1w0LMVvgqH/UDA88tsDfxcy3e262JDCvY
	ndexEKjSKBddq6qh5E3qtFmthkYXURUhv8yzrRHqe+N0pyK1vyL1riwDHCH94RVcvg==
X-Gm-Gg: AYBFou0FGyFmdAVcCmMDxoryxMdbgru1KiYHdoEvr5h6Rb2ptSO2j9G6G+SDdkj+0ZD
	NyUInWfGdgMXTTeG7eDXHPQQ+iHOK/E8HA6AItZXDYTnsnR14yhEuzd8vyNIeCb+8YoNFkPc7Qa
	kYCUXVYbuVyGdF2FDBrpVUWaAwTRA8w77g5P1n5ofglxtJnVXC+HFmxQmf3XxgQ4CBzDWHAuk60
	lAf/DLJdjVfotkGn6WDMQElkPc14W9SavV6vjiFhnbIuCxE3llOuIFwlc7BLZxbxIgnsHScugn0
	aAO7OvzltvRY0p/xwGSYjzhA9dJLqs1tBSTvB/qo2YmbGCDbgvF8yyXd2YzcrJB/bFMvCyUo1vA
	auaDs7T7wtgsnkZ+mx9SxQUuINeXkS2NWpliZ2ZwEIJ2K7XVphGRuUsnMmMqy0XrW0/9w6Vmdln
	EcX5yOS/ekCqFkkwBymm4sui1qwvpniCCz/7xTzl5YQCHIxb3kGLkV8CPM/JEou2FXqomlfNL0V
	EGo8dAOiEaGQXtq+2hAKjQdTAz5uXfi9H4ThwtcLqlW9jX12jNYSuradD4tguc/dyIG2EhjYvM1
	lZuIqcgb723t1FOIx0D8E8MhSqeGp7yuZc3gAWUWskhGTBwRd5aLJw2f/qyYwHgS
X-Received: by 2002:a17:90b:268a:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3ae89769d66mr17879218a91.41.1793905941532;
        Thu, 05 Nov 2026 11:12:21 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm5401592a91.0.2026.11.05.11.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:12:20 -0800 (PST)
Date: Thu, 5 Nov 2026 19:12:17 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com,
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com,
	chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net,
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com,
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com,
	kees@kernel.org, kevin.tian@intel.com, leon@kernel.org,
	leonro@nvidia.com, lukas@wunner.de, mattev@meta.com,
	michal.winiarski@intel.com, parav@nvidia.com,
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org,
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com,
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com,
	schnelle@linux.ibm.com, skhan@linuxfoundation.org,
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com,
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <auzVEUpFEoWltpVg@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102153656.1431701-8-vipinsh@google.com>

On 2026-11-02 07:36 AM, Vipin Sharma wrote:
>  * TOCTOU synchronization: vfio_pci_dev_is_frozen() is checked locklessly
>    on entry to the ioctl, read/write and mmap paths, and re-checked under
>    a lock that freeze() holds before any operation that could change the
>    device or vconfig: under vdev->igate in vfio_pci_ioctl_set_irqs() and
>    around every config-space write in vfio_pci_config_rw_single(), under
>    vdev->memory_lock in vfio_pci_runtime_pm_entry(),
>    vfio_pci_ioctl_reset() and the SR-IOV enable path of
>    vfio_pci_core_sriov_configure(), and under dev_set->lock in
>    vfio_pci_dev_set_hot_reset(). A racing operation thus either completes
>    before freeze() takes its snapshot or fails, while existing BAR mmaps,
>    ioeventfds and dma-bufs keep working. Serializing config writes on
>    igate covers the PCI_COMMAND, INTx disable emulation, power state and
>    FLR paths at one point (the INTx disable emulation now uses the
>    igate-held __vfio_pci_intx_mask() and __vfio_pci_intx_unmask()
>    helpers), and also serializes the irq_type and virq_disabled accesses
>    of config writes with VFIO_DEVICE_SET_IRQS.

I think there's a simpler way to do this. Checking the frozen flag
locklessly and then re-checking it under whichever lock covers each
path spreads the synchronization across igate, memory_lock and
dev_set->lock. That makes it hard to convince yourself every path that
can change the device is covered. It also makes every config space
write take igate, for all vfio-pci users, even when
CONFIG_VFIO_PCI_LIVEUPDATE=n.

Instead, I suggest adding a per-device rw_semaphore to struct
vfio_device in the VFIO core, e.g. liveupdate_rwsem, that protects a
liveupdate_frozen flag:

 - vfio_device_fops_unl_ioctl(), vfio_device_fops_read() and
   vfio_device_fops_write() take liveupdate_rwsem for read and fail
   with -EIO if the device is frozen. That covers every device ioctl in
   one place, including the ones handled by the VFIO core
   (VFIO_DEVICE_FEATURE, VFIO_DEVICE_GET_REGION_INFO and
   VFIO_DEVICE_{ATTACH,DETACH}_IOMMUFD_PT). This patch doesn't block
   the last two at all today.

 - freeze() and unfreeze() take liveupdate_rwsem for write, before any
   other lock, and flip the flag. preserve() doesn't need it since it
   only serializes state that doesn't change after the device is
   opened.

Putting this in the VFIO core also means other VFIO drivers can reuse
it if they add Live Update support in the future.

The lock order then becomes:

  liveupdate_rwsem -> dev_set->lock -> igate -> memory_lock

freeze() can still take igate and memory_lock to check irq_type,
pm_runtime_engaged and sriov_active. But the ioctl, read and write
paths no longer need to re-check anything under those locks. So you
can drop the igate change in vfio_pci_config_rw_single(), the
open-coded vfio_pci_zap_and_down_write_memory_lock() in
vfio_pci_runtime_pm_entry() and vfio_pci_ioctl_reset(), and the
smp_load_acquire()/smp_store_release() pair.

Two paths still need their own handling because they don't go through
the device's file:

 - vfio_pci_core_sriov_configure() is reached through sysfs. Take
   liveupdate_rwsem for read around the frozen check and the
   sriov_active update.

 - VFIO_DEVICE_PCI_HOT_RESET issued on one device also resets the other
   devices in its dev_set. Keep the check in
   vfio_pci_dev_set_hot_reset() under dev_set->lock. freeze() sets the
   flag while holding both liveupdate_rwsem and dev_set->lock, so
   holding either one is enough to read it. Please don't take the other
   devices' liveupdate_rwsem there, since that would invert the lock
   order relative to freeze().

I don't think mmap needs to be blocked at all. Creating a new mapping
doesn't change the device or any of the state that gets preserved, and
existing mappings already keep working while the device is frozen.
Leaving mmap alone also avoids taking liveupdate_rwsem under mmap_lock,
which could deadlock: the ioctl, read and write paths can fault on user
memory (taking mmap_lock) while holding liveupdate_rwsem for read, and
freeze() may be waiting for the write lock. Please update the comment
in freeze() and the DOC section to match.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 9914f3ac69ae..1f1ac7a798aa 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -644,10 +644,10 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
>  
>  		if (virt_intx_disable && !vdev->virq_disabled) {
>  			vdev->virq_disabled = true;
> -			vfio_pci_intx_mask(vdev);
> +			__vfio_pci_intx_mask(vdev);
>  		} else if (!virt_intx_disable && vdev->virq_disabled) {
>  			vdev->virq_disabled = false;
> -			vfio_pci_intx_unmask(vdev);
> +			__vfio_pci_intx_unmask(vdev);
>  		}
>  	}

With the rwsem, config writes no longer need igate, so this change
isn't needed. If config writes and VFIO_DEVICE_SET_IRQS really do race
on irq_type and virq_disabled today, that's unrelated to Live Update.
Please send it as a separate fix.

Lastly, please add the freeze infrastructure and the checks in their
own commit ahead of this one, e.g. "vfio: Add infrastructure to freeze
devices for Live Update". Then this patch only has to implement
freeze() and unfreeze() on top of it, which will make both easier to
review.
