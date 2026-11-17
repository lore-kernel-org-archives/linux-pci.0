Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794952746;
	b=dUWppZQw4nM6rhx9jlSQ5VB3i3eCDQv8OzT30FGg9XGkN0NPjjVFCtoUkLp80M3YR7JA
	 EkBW3+Sv7ujSA2BmMEQAof/Htu69LWkP7Cjz2vo4LBh6olBnY75EZnO9hgHZ7X/G0lzqK
	 svWSvcgMzhAkIjuwnODbvjOpLs1kYIRdLqPmz9KzVllPunh9TniB03h+CxRbtZnMRGhEj
	 s0T4W2T91+YANdj/o3SNPj1QM+3nEBMXr+RLWndtfe55vbLYTKaXlEJF7mGUUuGofJ9i/
	 Son69a3vXeZXMEZp2GGX/CHSyTSJuuoHHT0HyIhrnHleLSWQ6zl6sCX/UKv0po1pJ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794952746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6ppas4HZ2NGOZcFcrTWA/+6VjpboNZmJZl+VQIcgy64=;
	b=l4/iA7M6RUGp0cfspuMwctUyzd9UZUGdSlCLVrT/s1+PB1NQ6BalaVD+p9F9aYWaRNKG
	 v4ri6HLqiN6uoWzI9bj9Vg+t+1MzSbwZoFz0g6DqNZOXrHhB3/p8tSShtFjKIawAX1xpS
	 f7aSLgEy4RA0YQAJk2t2ZpwBce+0Z6F0PZTgDfpturFF5/eEQYhJBA6UUT8t3SKpSYGd6
	 xjBbdZz+nZ7aVZNWTMbFrcVeg4/gBqXCQULRdsQ8B1F2Dh6iTE0Xb6Skg/14IXrhu8jaw
	 AF3XwYXQSHXMRutTpeeacoMb6XxB9MZWs+qex/paHGfM/Azw7KlxTfLlG82GOwt3JiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EfJXDMRe;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F1606A32F
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 21:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B28F1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EfJXDMRe
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed3f563739so21505ad.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 13:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794952745; x=1795557545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ppas4HZ2NGOZcFcrTWA/+6VjpboNZmJZl+VQIcgy64=;
        b=EfJXDMRe6em8z635NUEChDgMdqWOKqo0Ntv8rvsuf/jUawXGDGUYrN9oAIqxv1+c0U
         ZENiouw7xqD64r/dkBosaSnCVTs5QOI8dP8jqaoMnGyIHsAv5DAoyCovx0fieD13wagD
         UjV8/gdiVoChlZxwDASL07PfN1GyMbRWcyVl6jwlymYaGWs2bhlIHwLr1yyQXZ4cR8y9
         KtZrqL5WlnWD6iJ1pKsZCa2RHH6jbyLcG30nTBHmV3sf/MINwUM/StzUdO484WOWfkP4
         U61AJKGxSjv4tnnVb4bvEcfbFPIllJKH6t7RrFpnDC+nwYAFsHDYMBaCLf7UQsJX1Iqw
         26rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794952745; x=1795557545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ppas4HZ2NGOZcFcrTWA/+6VjpboNZmJZl+VQIcgy64=;
        b=dDWI83JwMvfnIbIYpyt4ERKViO6SGR9Gmq93/4J940NDmy+sv9GUpWTELgzucbfGIQ
         g2CrHNzeqgwEB6ealCSd+vsB9RGMWe8t/TYyQMlJG5xPweRPV0iy6W33iteEFFHZ/OUX
         4q4lBZU15eJo86nnQCC6AaV/MdlwkPH2Duyq/R3K9g/Bcz6txq/fVKoDxcB/oCgpcCVO
         kf5OC2V90m0jHm/iJqdsOeRDWcaiPAVTyP3oV+ywDFtplrF2QMBBw1tVnFxFOWF0tQ1+
         8YxJ8p99RDuSwQgkn1SL70Y+V+1T6aSfxJnFAEygdHQ1gNpqAiwM7b66gKl6HxcIF9/o
         QrjA==
X-Forwarded-Encrypted: i=1; AL+hErFyayw8s2kTHhSiTJvC9K4YPcrwldNBlMxia1swT+PEQSZ3Gu/e/qAcWU5lRxyvI5C4f9AH9yVoUXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mGoKbqlxi2+BN+Oa12MXeEVEx2/FAnY2JktLrTlAhugC2drUa
	QJ/kLCj/33UsBgkqigGO+v/Iz4gquyuPrqsXj9hbqeeNSFNm9z0DuzBtFx71mudIMA==
X-Gm-Gg: AZFdTZdH9hCuvt/lK2lcqQM4g2MQMH+EqZkN+2/dk9aHZqnJqpz182flF3lIgqfluaz
	ejuP/vIWXNffPYIxgID0P82TVw5s+HoMuAHERfSKeErU0lOScybSFHVy4BJSZZxECLqznUuSPQT
	Fpz6Xpy+CxeIK6ORXRZ8K0bQmKYr3FNB9YigEBrhO8BmwDchURie0v4BKSwhqIHQEu9HfaXmlHe
	XVrhYnXR+4yokPx7ua0xFcoLKKv0CbE3OScvu3g8xDvRLKkqbsmWBFwEVAPE1sT++W0cBrskW4U
	DBWVeZb6mi2neSh56CAWi/S0UvcA+3DPEj4VhRq6SuFTvxCmyrM+ZVYBADQTb3PaCuQMnE5SJ8l
	obSEghEWBc1ROCSypQfWl76fPBToMkh8PfkY3o1kBkTdaxCy/WaccEF3zEGkO1wtz7ITjj2hjS+
	9n/aHcwKWDEHhBQjFnYhC7/lIhi4AsrS3DXiVY0SPYbrkkiBUYT+wQZpod+2EHCGWxz794oJzzE
	z/BInysDtxrkVW8fRj7jJNGKMjffZbv1YPJ7SWDP/qbEiw/YHzmbmJVJBgOuUBQq8d9lO6QsaUi
	9gVoI77QLRNBF2patStf20jVQafA0V9aRAqEyRhzfdIWOCQHYu1i01RojlrOfU/w2LqE/DKSLut
	IRHjYeaaAdR+W
X-Received: by 2002:a17:903:3d0e:b0:2df:96ca:d7c7 with SMTP id d9443c01a7336-2eff98e2025mr646525ad.10.1794952744396;
        Tue, 17 Nov 2026 13:59:04 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff623c4c6sm2756405ad.54.2026.11.17.13.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 13:59:03 -0800 (PST)
Date: Tue, 17 Nov 2026 13:59:00 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20261117003405.GA4153658.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
 <auzVEUpFEoWltpVg@google.com>
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
In-Reply-To: <auzVEUpFEoWltpVg@google.com>

On Thu, Nov 05, 2026 at 07:12:17PM +0000, David Matlack wrote:
> On 2026-11-02 07:36 AM, Vipin Sharma wrote:
> >  * TOCTOU synchronization: vfio_pci_dev_is_frozen() is checked locklessly
> >    on entry to the ioctl, read/write and mmap paths, and re-checked under
> >    a lock that freeze() holds before any operation that could change the
> >    device or vconfig: under vdev->igate in vfio_pci_ioctl_set_irqs() and
> >    around every config-space write in vfio_pci_config_rw_single(), under
> >    vdev->memory_lock in vfio_pci_runtime_pm_entry(),
> >    vfio_pci_ioctl_reset() and the SR-IOV enable path of
> >    vfio_pci_core_sriov_configure(), and under dev_set->lock in
> >    vfio_pci_dev_set_hot_reset(). A racing operation thus either completes
> >    before freeze() takes its snapshot or fails, while existing BAR mmaps,
> >    ioeventfds and dma-bufs keep working. Serializing config writes on
> >    igate covers the PCI_COMMAND, INTx disable emulation, power state and
> >    FLR paths at one point (the INTx disable emulation now uses the
> >    igate-held __vfio_pci_intx_mask() and __vfio_pci_intx_unmask()
> >    helpers), and also serializes the irq_type and virq_disabled accesses
> >    of config writes with VFIO_DEVICE_SET_IRQS.
> 
> I think there's a simpler way to do this. Checking the frozen flag
> locklessly and then re-checking it under whichever lock covers each
> path spreads the synchronization across igate, memory_lock and
> dev_set->lock. That makes it hard to convince yourself every path that
> can change the device is covered. It also makes every config space
> write take igate, for all vfio-pci users, even when
> CONFIG_VFIO_PCI_LIVEUPDATE=n.
> 
> Instead, I suggest adding a per-device rw_semaphore to struct
> vfio_device in the VFIO core, e.g. liveupdate_rwsem, that protects a
> liveupdate_frozen flag:
> 
>  - vfio_device_fops_unl_ioctl(), vfio_device_fops_read() and
>    vfio_device_fops_write() take liveupdate_rwsem for read and fail
>    with -EIO if the device is frozen. That covers every device ioctl in
>    one place, including the ones handled by the VFIO core
>    (VFIO_DEVICE_FEATURE, VFIO_DEVICE_GET_REGION_INFO and
>    VFIO_DEVICE_{ATTACH,DETACH}_IOMMUFD_PT). This patch doesn't block
>    the last two at all today.
> 
>  - freeze() and unfreeze() take liveupdate_rwsem for write, before any
>    other lock, and flip the flag. preserve() doesn't need it since it
>    only serializes state that doesn't change after the device is
>    opened.
> 
> Putting this in the VFIO core also means other VFIO drivers can reuse
> it if they add Live Update support in the future.
> 
> The lock order then becomes:
> 
>   liveupdate_rwsem -> dev_set->lock -> igate -> memory_lock
> 
> freeze() can still take igate and memory_lock to check irq_type,
> pm_runtime_engaged and sriov_active. But the ioctl, read and write
> paths no longer need to re-check anything under those locks. So you
> can drop the igate change in vfio_pci_config_rw_single(), the
> open-coded vfio_pci_zap_and_down_write_memory_lock() in
> vfio_pci_runtime_pm_entry() and vfio_pci_ioctl_reset(), and the
> smp_load_acquire()/smp_store_release() pair.
> 
> Two paths still need their own handling because they don't go through
> the device's file:
> 
>  - vfio_pci_core_sriov_configure() is reached through sysfs. Take
>    liveupdate_rwsem for read around the frozen check and the
>    sriov_active update.
> 
>  - VFIO_DEVICE_PCI_HOT_RESET issued on one device also resets the other
>    devices in its dev_set. Keep the check in
>    vfio_pci_dev_set_hot_reset() under dev_set->lock. freeze() sets the
>    flag while holding both liveupdate_rwsem and dev_set->lock, so
>    holding either one is enough to read it. Please don't take the other
>    devices' liveupdate_rwsem there, since that would invert the lock
>    order relative to freeze().
> 
> I don't think mmap needs to be blocked at all. Creating a new mapping
> doesn't change the device or any of the state that gets preserved, and
> existing mappings already keep working while the device is frozen.
> Leaving mmap alone also avoids taking liveupdate_rwsem under mmap_lock,
> which could deadlock: the ioctl, read and write paths can fault on user
> memory (taking mmap_lock) while holding liveupdate_rwsem for read, and
> freeze() may be waiting for the write lock. Please update the comment
> in freeze() and the DOC section to match.
> 

Thanks for suggestion, this is indeed simpler.

> > diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> > index 9914f3ac69ae..1f1ac7a798aa 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -644,10 +644,10 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
> >  
> >  		if (virt_intx_disable && !vdev->virq_disabled) {
> >  			vdev->virq_disabled = true;
> > -			vfio_pci_intx_mask(vdev);
> > +			__vfio_pci_intx_mask(vdev);
> >  		} else if (!virt_intx_disable && vdev->virq_disabled) {
> >  			vdev->virq_disabled = false;
> > -			vfio_pci_intx_unmask(vdev);
> > +			__vfio_pci_intx_unmask(vdev);
> >  		}
> >  	}
> 
> With the rwsem, config writes no longer need igate, so this change
> isn't needed. If config writes and VFIO_DEVICE_SET_IRQS really do race
> on irq_type and virq_disabled today, that's unrelated to Live Update.
> Please send it as a separate fix.
> 

This will go away.

> Lastly, please add the freeze infrastructure and the checks in their
> own commit ahead of this one, e.g. "vfio: Add infrastructure to freeze
> devices for Live Update". Then this patch only has to implement
> freeze() and unfreeze() on top of it, which will make both easier to
> review.

Sounds good. Thanks for the review.
