Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795217296;
	b=Yj5hYAN5mTHUDa3EnJmitSjLXDAmZzX075VKW/mpPy2zusgPaFG7LTucaqtXJaSNFosX
	 H9Rx7Ck9cwETQUy+nBYmhqFk4M+W7D3qZNIda9m8ifXUyt9aaagwoNYRZIDW8VFZVvUy7
	 dtHaLysa/W6OCJtJR4ivfQm/TjlDA1VuRyZyxwu/Ezt65Ns3oI/J+VKQ4LZsN7o/zgDB4
	 hLhSOKow0gJrIIuSwFL3fVHAM4jLrg5Afi1BR7fdtVCn31Q02ebjRgvwD/VyY/4nWiHYh
	 c5UC6smfKe7q3iWBOGzjY4njUMEnjM/JTRfxVDULm38akXYEOSD3l6n6hFYWOHiZNoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795217296;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=CPO9nmMT4mstAKBU4CTC3Q9F8oIE4yXnIGKpDlg4Yoc=;
	b=vPOBm6lLjFgdsCOcEvj0HQtphuj6f/HkTvzGmd2/qcdo52Pv3ARlx16c6j5OgZ6Dtno4
	 XcWK+VzTTrr7Hy/lU3iHWthWEmrsmKhASxav1ubMmp+7QaaxmlPiy//5tu1WwpI9atnN3
	 AiM0MTBBT+eGwrA1O4noG03i6Kp0Y9fupBgdFDKsKx9y/uPTT2blrz2cW2rhG0PlWkUlg
	 IHNb8uLgYjUxSd+tngkmLHdG7Xa1heKmaV8i9w4rFZkitIM62gWGdNF+SyVW0yAzhwIiJ
	 /S7um1m/SPoOr9EZ2p4c9lZzDDZroIeo+jJdJ+YIzDDST5fDFHQLD4gOO0rtJJiIG6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cGi7XaBP;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5E606A6A0;
	Fri, 20 Nov 2026 23:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B5E606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cGi7XaBP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795217296; x=1826753296;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=omKcPLxUQu1BKjyWQmPDNLKdY8Rx6Ex/C3EIfYoiBYU=;
  b=cGi7XaBP/85+1QNhubcMjJ0yrGRf837PquNYoVZTS5yYdJ/8Dabyk/VD
   RTFw1NEZH5Z5Fq2jyp7PHn4uVpFmv774vDdkyaVIWsnQlvd/kKAGt5oyD
   E77YvYtG1BIuc5Y1WB/5SXO+VU8k7qI9Bu+cz7KL8Q80tW/fDToFsK1AK
   42S6AApZmCPdlrS4XYQe87bl+7ZdLOLKYyzPy782TmGJfxdM1Zlad6VRA
   QmAe7Eo1QmvrGzCb3tRFm/hcRtN/vwHc1W+gC/JwSLTFjFaE5JUV5JIvF
   sca9EINZ6Lig1poSTGLhXYbwyjjg3fce7W1N7Gw6W7kQBkQzjdawpWSD2
   w==;
X-CSE-ConnectionGUID: ucWVKtidRZq3VZdjXQVf7A==
X-CSE-MsgGUID: BmkovMdNSjScRhsvpBQjzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4147280"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4147280"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 15:28:15 -0800
X-CSE-ConnectionGUID: wQuEKpfvQwyb1/k7/bzV9Q==
X-CSE-MsgGUID: dmm90FEfSiS0LlJa6AemUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="12631371"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 15:28:14 -0800
Message-ID: <1a3738ce-38f7-43a8-9cb3-66de6fca2e0f@intel.com>
Date: Fri, 20 Nov 2026 16:28:12 -0700
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
Subject: Re: [PATCH v17 00/19] PCI/CXL: Add CXL reset support for Type 2
 devices
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <iweiny@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>, Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <5616c825-454e-4eba-9352-b06d98dc123a@intel.com>
 <b35bcc93-9fb0-4fa2-a432-857eaa4dd31b@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <b35bcc93-9fb0-4fa2-a432-857eaa4dd31b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/20/26 12:32 AM, Srirangan Madhavan wrote:
> On 11/16/26 11:11 AM, Dave Jiang wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 11/5/26 11:58 AM, Srirangan Madhavan wrote:
>>> Hi folks,
>>>
>>> This series adds CXL Reset for Type 2 devices through the existing PCI
>>> reset_method and reset sysfs attributes. It disables CXL.cache, performs
>>> supported cache writeback, initiates CXL Reset with Memory Clear, and
>>> restores cached HDM decoder and CXL Device DVSEC state before PCI use
>>> resumes. Active HDM ranges are reserved and CPU caches invalidated before
>>> and after reset. The method remains limited to eligible single-function
>>> devices with both CXL.cache and CXL.mem enabled. CXL bus reset restores
>>> the same cached state and flushes the host and device caches around the
>>> reset.
>>>
>>> The reset sequence follows the CXL 4.0 specification [4], including
>>> CXL.cache disable, optional cache writeback, CXL Reset Memory Clear,
>>> ResetComplete polling, and ResetError reporting. Sections 9.7.2 and 9.7.3
>>> define the completion timeout encodings and reset access restrictions.
>>>
>>> The userspace ABI is the existing PCI reset interface:
>>>
>>>      /sys/bus/pci/devices/.../reset_method
>>>      /sys/bus/pci/devices/.../reset
>>>
>>> Userspace selects "cxl_reset" in reset_method and triggers the reset
>>> through reset. Following Dan's v6 feedback, this uses the PCI interface
>>> instead of adding a memdev-specific sysfs ABI.
>>>
>>> For sysfs reset, the generic PCI path invokes the driver's reset_prepare()
>>> callback when provided and disables PCI I/O, memory decoding, and bus
>>> mastering. The CXL path reserves affected HDM ranges exclusively and
>>> blocks IOMMU translations where applicable. It does not offline memory
>>> or revoke mappings: userspace is expected to offline CXL.mem users before
>>> reset. The reservation enforces this for claimed ranges by failing the
>>> reset while a conflicting resource is claimed [9].
>>>
>>> The global region lock is held from snapshot through restoration. Memory
>>> Clear completion is awaited for the timeout the device advertises, up to
>>> 100 seconds, so the lock can be held for that long plus cache flushes.
>>
>> I think holding it across the bus reset can deadlock with pciehp and a
>> PCI remove. I tested in QEMU with two cxl-type2 devices from Manish's
>> RFC [1].
>>
>> For a device in a pciehp slot, pci_reset_bus_function() ends up in
>> pciehp_reset_slot(), which takes the slot's reset_lock. The reset still
>> holds cxl_rwsem.region at that point.
>>
>> Two other tasks can complete a cycle. pciehp_ist() for that slot can
>> hold reset_lock and wait for pci_rescan_remove_lock in
>> pciehp_unconfigure_device(). A PCI remove of a second Type 2 device can
>> hold pci_rescan_remove_lock while cxl_decoder_detach() waits for
>> cxl_rwsem.region.
>>
>> On v17 as posted, lockdep reports the cycle:
>>
>>    [   60.891789] WARNING: possible circular locking dependency detected
>>    [   60.893014] irq/24-pciehp/103 is trying to acquire lock:
>>    [   60.893367] ffff888072b4f128 (&cxl_memdev_key){+.+.}-{4:4}, at: device_del+0x8d/0x580
>>                   but task is already holding lock:
>>    [   60.894498] ffffffff84699e80 (pci_rescan_remove_lock){+.+.}-{4:4}, at: pciehp_unconfigure_device+0x93/0x210
>>    [...]
>>                   -> #3 (&ctrl->reset_lock){++++}-{4:4}:
>>    [   60.916794]        down_write_nested+0x80/0x170
>>    [   60.917826]        pciehp_reset_slot+0x6c/0xc0
>>    [   60.918893]        pci_reset_hotplug_slot+0x5c/0x90
>>    [   60.919928]        pci_reset_bus_function+0x161/0x330
>>    [   60.920951]        cxl_reset_bus_function+0x1c6/0x280
>>    [   60.921958]        __pci_reset_function_locked+0x96/0x170
>>    [   60.922990]        pci_reset_function+0xc8/0x180
>>    [   60.923977]        reset_store+0x84/0xd0
>>    [...]
>>                   -> #2 (cxl_rwsem.region){++++}-{4:4}:
>>    [...]
>>    [   61.013490] Chain exists of:
>>                     &cxl_memdev_key --> &ctrl->reset_lock --> pci_rescan_remove_lock
>>
>> With a test-only msleep() after cxl_region_quiesce_lock() in
>> pci_cxl_reset_prepare(), it turns into a real hang. The reset, a sysfs
>> remove of the second device and a power off of the first device's slot
>> all got stuck.
>>
>> Two region reads blocked behind the reset as well. A read of
>> region1/commit timed out after 5 s, and cxl list -R stayed in D state in
>> decoders_committed_show().
>>
>> To reproduce, I used Manish's RFC as posted. It allows one cxl-type2 per
>> pxb-cxl, so each device has its own host bridge and window. On q35 with
>> cxl=on, plus the memory backends:
>>
>>    -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=53
>>    -device cxl-rp,id=hb0rp0,bus=cxl.0,chassis=0,slot=0,port=0
>>    -device cxl-type2,bus=hb0rp0,volatile-memdev=t2mem0,id=cxl-t2,fmw-index=0
>>    -device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=191
>>    -device cxl-rp,id=hb1rp0,bus=cxl.1,chassis=0,slot=2,port=0
>>    -device cxl-type2,bus=hb1rp0,volatile-memdev=t2mem1,id=cxl-t2b,fmw-index=1
>>    -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G
>>
>> The guest kernel needs CONFIG_CXL_REGION_INVALIDATION_TEST=y. Without it,
>> the cxl_bus reset fails in an x86 guest with "failed to prepare CXL bus
>> reset ranges: -6".
>>
>> I drove both devices with a small test module based on
>> tools/testing/cxl/test/accel.c. It attaches each firmware-committed
>> region with devm_cxl_probe_mem() and has no reset handlers. Then, with
>> lockdep on:
>>
>>    echo cxl_bus > /sys/bus/pci/devices/0000:36:00.0/reset_method
>>    echo 1 > /sys/bus/pci/devices/0000:36:00.0/reset
>>    echo 0 > /sys/bus/pci/slots/2/power     # second device, 0000:c0:00.0
>>
>> For the hang, add msleep(10000) after cxl_region_quiesce_lock() in
>> pci_cxl_reset_prepare(). Start the cxl_bus reset, remove 0000:c0:00.0
>> through sysfs two seconds later, and power off slot 0 two seconds after
>> that.
>>
>> Separately, pci_cxl_reset_prepare() returns with the quiesce held on its
>> success path only, and cxl_restore_state_after_pci_reset() releases it.
>> With Clang 23 and CONTEXT_ANALYSIS=y passed to make, that gives five
>> cxl_region_quiesce warnings in drivers/pci/cxl.c.
>>
>> [1]: https://lore.kernel.org/all/20261106035911.1280066-1-mhonap@nvidia.com/
>>
>> DJ
> 
> Hi Dave,
> 
> Thank you for the repro. Please let me know your opinion on the following fix.
> It also covers Alison's lock scope question.
> 
> Reordering the locks won't work, since pci_reset_bus_function() itself
> takes reset_lock. So I'd like to drop the region lock before the reset starts,
> and take it only for two short windows:
> 
>   pci_cxl_reset_prepare()
>       lock(region):  cxl_hdm_cache_snapshot(), set reset_pending,
>                      cxl_hdm_ranges_collect() + cxl_hdm_ranges_request()
>       cxl_hdm_quiesce_flush()                      [no lock]
>   pci_reset_bus_function()                         [no region lock]
>   cxl_restore_state_after_pci_reset()
>       lock(region):  cxl_hdm_cache_copy_decoders(), pci_cxl_restore_state(),
>                      clear reset_pending
>       cxl_hdm_quiesce_flush()                      [no lock]
> 
>   cxl_decoder_commit():  reset_pending -> -EBUSY   [next to sanitize_active]
>   disable_hdm():         also update the cached global_ctrl
>   cxl_reset_execute():   same two windows for the DVSEC reset
> 
> With this,
>  - If a region gets torn down mid-reset, the cache is already refreshed
>    (cxl_hdm_cache_refresh_decoder()), so restore just re-reads it with
>    cxl_hdm_cache_copy_decoders(). Patch 17 had that call, and patch 18
>    dropped it when I moved the lock into prepare.
>  - A new commit mid-reset gets -EBUSY. Regions committed before the reset
>    shouldn't be able to come online, since the exclusive
>    request_mem_region() makes the kmem and pmem claims fail, as far as I
>    can tell.


I think the direction looks good.

> 
> Questions
>  1. Is reset_pending in struct cxl_hdm_info, checked in
>     cxl_decoder_commit(), OK?

Yes. 

>  2. Can I keep cxl_hdm_cache_copy_decoders(), now used again, instead of
>     dropping it?

Yes.

>  3. cxl_hdm_ranges_invalidate() and cxl_hdm_quiesce_prepare() assert the
>     region lock is held. To flush outside it I'd relax that and rely on
>     the HPA reservation. OK?

Sounds reasonable. 

> 
> If this plan sounds okay, I can implement it this way in v18 (and rerun
> your reproducer against it)
> 

Sounds good!

