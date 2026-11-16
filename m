Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856264;
	b=Honbaesg+z4jyZMXDaXM0fvzlHum199hFirMd2UysLHh+F5aLbiHUpnX4WzCE9Rn/oac
	 g+bhKaUWa/p/8S+RkZdnG0enqgn88XPsyXVx+kirX28y7iE3/jFMfYTemTDgHrzBywUPl
	 pP/m9gh82WKVKzJyY+AauEgnZzbW/lmAIe7cZgZ9Pd73EEyDaZBX6jnC/WnbpUvb+wAM+
	 45BtseEfMxEUaPxqAhPQx5U5lY1Y2fyRfInhSs+d7pcOQ7vCiBOQrYgq599f4Xa9AJSDL
	 OeaEPKzW76hUd/FWb9cG6+KY3AerWO4sfA11kIthbgT1ORVebOJumoXeUTKjOGbbw2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856264;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MP0jpTY9LnaMv+FuhHr1fqOh6qia1t305qae8DAZuCY=;
	b=NqBTqwA1nwOZ3QUs8WoCT9w1jDK36fkuQ0MlhqXa31FzrL0x8XjsUf6PzKQgLfpEUwH5
	 aROA15t+3wSAaF1xLawJtuxi3mAc2BBbcTmH46aQfYxF88q8Tg+eTt0ImJdUEpOw/ONoa
	 Eyx8echk5PpC0WIvjEs8LXoEMDWNYUVK2Bmpi/2DPJWJZCzML/huPjPj+XgkQtR1fAxtE
	 rcPhNhtxOsUpEZd6oFnch0xwQBtoMzBxjw3DsBC0GcIXt0IcA1JezcZcGj3kpqTEIvET1
	 rVCMxR/WEM/dbFpGXpkX0Ci6W3Ukj526aV1bnUBvK9BcHTxeK2M98SHR2usCt6XxfGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aAJe2jaB;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AF606A336;
	Mon, 16 Nov 2026 19:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 627AF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aAJe2jaB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794856264; x=1826392264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tTH2yYv0RoFv7DNoNzyxWTxTn/pZUD0Ygwt7ezZtpdE=;
  b=aAJe2jaBQ96CvD0YIaI9MngFdFaxvtQIC6cKuUbjG++ff4CLUYLZKUT8
   /gaMwr7DqSCjV1U0zxgLry9+cNrenUzTS/F3J/WdYr+KCZwgV4+jBoLiZ
   DO9h/GV2oaeIQ7bZT1wrLJ4HEvvkjKFtZB6JAY44fTIu7S5jfQco6T4JY
   NId7DQVvTsynsYHx7glEXmxDIHwdsjZzJDMdoPhGtCCccgFebQk5Uv63Z
   rsL6vSBt3zQ74qs+6kWQBsMH8u+4FetVEC0qhlW+/Cv6ljZkrMwZ0+wzE
   /YzPohvR/dP4Mk/uJXmsmDgMAVlr2V6FMF8Jh7tx27qVsnTeD4AH2DYmA
   g==;
X-CSE-ConnectionGUID: KPxAvjeQR5Kaif5jHvBMjg==
X-CSE-MsgGUID: csLUeK+zQ4qMcjEcrgQ7SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3711793"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3711793"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 11:11:03 -0800
X-CSE-ConnectionGUID: ux9f4A7UQBSug+6ZLw7B7Q==
X-CSE-MsgGUID: qTRYJ6ZeTuKdWwOegtxqfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9641465"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.118]) ([10.125.108.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 11:11:01 -0800
Message-ID: <5616c825-454e-4eba-9352-b06d98dc123a@intel.com>
Date: Mon, 16 Nov 2026 12:11:00 -0700
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
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/26 11:58 AM, Srirangan Madhavan wrote:
> Hi folks,
> 
> This series adds CXL Reset for Type 2 devices through the existing PCI
> reset_method and reset sysfs attributes. It disables CXL.cache, performs
> supported cache writeback, initiates CXL Reset with Memory Clear, and
> restores cached HDM decoder and CXL Device DVSEC state before PCI use
> resumes. Active HDM ranges are reserved and CPU caches invalidated before
> and after reset. The method remains limited to eligible single-function
> devices with both CXL.cache and CXL.mem enabled. CXL bus reset restores
> the same cached state and flushes the host and device caches around the
> reset.
> 
> The reset sequence follows the CXL 4.0 specification [4], including
> CXL.cache disable, optional cache writeback, CXL Reset Memory Clear,
> ResetComplete polling, and ResetError reporting. Sections 9.7.2 and 9.7.3
> define the completion timeout encodings and reset access restrictions.
> 
> The userspace ABI is the existing PCI reset interface:
> 
>     /sys/bus/pci/devices/.../reset_method
>     /sys/bus/pci/devices/.../reset
> 
> Userspace selects "cxl_reset" in reset_method and triggers the reset
> through reset. Following Dan's v6 feedback, this uses the PCI interface
> instead of adding a memdev-specific sysfs ABI.
> 
> For sysfs reset, the generic PCI path invokes the driver's reset_prepare()
> callback when provided and disables PCI I/O, memory decoding, and bus
> mastering. The CXL path reserves affected HDM ranges exclusively and
> blocks IOMMU translations where applicable. It does not offline memory
> or revoke mappings: userspace is expected to offline CXL.mem users before
> reset. The reservation enforces this for claimed ranges by failing the
> reset while a conflicting resource is claimed [9].
> 
> The global region lock is held from snapshot through restoration. Memory
> Clear completion is awaited for the timeout the device advertises, up to
> 100 seconds, so the lock can be held for that long plus cache flushes.

I think holding it across the bus reset can deadlock with pciehp and a
PCI remove. I tested in QEMU with two cxl-type2 devices from Manish's
RFC [1].

For a device in a pciehp slot, pci_reset_bus_function() ends up in
pciehp_reset_slot(), which takes the slot's reset_lock. The reset still
holds cxl_rwsem.region at that point.

Two other tasks can complete a cycle. pciehp_ist() for that slot can
hold reset_lock and wait for pci_rescan_remove_lock in
pciehp_unconfigure_device(). A PCI remove of a second Type 2 device can
hold pci_rescan_remove_lock while cxl_decoder_detach() waits for
cxl_rwsem.region.

On v17 as posted, lockdep reports the cycle:

  [   60.891789] WARNING: possible circular locking dependency detected
  [   60.893014] irq/24-pciehp/103 is trying to acquire lock:
  [   60.893367] ffff888072b4f128 (&cxl_memdev_key){+.+.}-{4:4}, at: device_del+0x8d/0x580
                 but task is already holding lock:
  [   60.894498] ffffffff84699e80 (pci_rescan_remove_lock){+.+.}-{4:4}, at: pciehp_unconfigure_device+0x93/0x210
  [...]
                 -> #3 (&ctrl->reset_lock){++++}-{4:4}:
  [   60.916794]        down_write_nested+0x80/0x170
  [   60.917826]        pciehp_reset_slot+0x6c/0xc0
  [   60.918893]        pci_reset_hotplug_slot+0x5c/0x90
  [   60.919928]        pci_reset_bus_function+0x161/0x330
  [   60.920951]        cxl_reset_bus_function+0x1c6/0x280
  [   60.921958]        __pci_reset_function_locked+0x96/0x170
  [   60.922990]        pci_reset_function+0xc8/0x180
  [   60.923977]        reset_store+0x84/0xd0
  [...]
                 -> #2 (cxl_rwsem.region){++++}-{4:4}:
  [...]
  [   61.013490] Chain exists of:
                   &cxl_memdev_key --> &ctrl->reset_lock --> pci_rescan_remove_lock

With a test-only msleep() after cxl_region_quiesce_lock() in
pci_cxl_reset_prepare(), it turns into a real hang. The reset, a sysfs
remove of the second device and a power off of the first device's slot
all got stuck.

Two region reads blocked behind the reset as well. A read of
region1/commit timed out after 5 s, and cxl list -R stayed in D state in
decoders_committed_show().

To reproduce, I used Manish's RFC as posted. It allows one cxl-type2 per
pxb-cxl, so each device has its own host bridge and window. On q35 with
cxl=on, plus the memory backends:

  -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=53
  -device cxl-rp,id=hb0rp0,bus=cxl.0,chassis=0,slot=0,port=0
  -device cxl-type2,bus=hb0rp0,volatile-memdev=t2mem0,id=cxl-t2,fmw-index=0
  -device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=191
  -device cxl-rp,id=hb1rp0,bus=cxl.1,chassis=0,slot=2,port=0
  -device cxl-type2,bus=hb1rp0,volatile-memdev=t2mem1,id=cxl-t2b,fmw-index=1
  -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G

The guest kernel needs CONFIG_CXL_REGION_INVALIDATION_TEST=y. Without it,
the cxl_bus reset fails in an x86 guest with "failed to prepare CXL bus
reset ranges: -6".

I drove both devices with a small test module based on
tools/testing/cxl/test/accel.c. It attaches each firmware-committed
region with devm_cxl_probe_mem() and has no reset handlers. Then, with
lockdep on:

  echo cxl_bus > /sys/bus/pci/devices/0000:36:00.0/reset_method
  echo 1 > /sys/bus/pci/devices/0000:36:00.0/reset
  echo 0 > /sys/bus/pci/slots/2/power     # second device, 0000:c0:00.0

For the hang, add msleep(10000) after cxl_region_quiesce_lock() in
pci_cxl_reset_prepare(). Start the cxl_bus reset, remove 0000:c0:00.0
through sysfs two seconds later, and power off slot 0 two seconds after
that.

Separately, pci_cxl_reset_prepare() returns with the quiesce held on its
success path only, and cxl_restore_state_after_pci_reset() releases it.
With Clang 23 and CONTEXT_ANALYSIS=y passed to make, that gives five
cxl_region_quiesce warnings in drivers/pci/cxl.c.

[1]: https://lore.kernel.org/all/20261106035911.1280066-1-mhonap@nvidia.com/

DJ
