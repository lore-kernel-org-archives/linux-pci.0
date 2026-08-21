Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB5352F95;
	Fri, 21 Aug 2026 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278181; cv=none; b=kWDi8Z2Ux7qckOF5y+C3Y49JAjo1mUIobdri2uUxNPeJF9QKcVCHt5X/mhzrfRPCXoBRnowosnd7+VNIJ7XmxRc+qyLeoOE7MqPLS34Xkw4RqLmOKBrz8em6bG3ICvfkeD5tU3zphUuBLN6UId84vOfXvdM5V/COdscAUE8Du4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278181; c=relaxed/simple;
	bh=C42Fxi+EP5/Clmm6Nl6D+S2Nk//X8c54I9cXhIguMws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf1b2i/MOoSEGtEMHVHV5RVFTfU+FVpMBoIZrk1GJInF/TGLLD6hom6DDFvkUyEnLTao5ygi3DZygKjgyDmSYiHcNOBSXXDdR3enXHHhwzl5WaD2U2nYCZQJ5IjQVm2qhP09GTSTNsFmLFJh4OpXzfY4JhkSkKiVO3yqdPOf5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/B4xfRm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/B4xfRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787278179; x=1818814179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C42Fxi+EP5/Clmm6Nl6D+S2Nk//X8c54I9cXhIguMws=;
  b=X/B4xfRm7lxMvLK95jgkVYhiXv6SbRGf9ab4nN+NrCGRaNbRfIv6/jhp
   +ZScSWwt1cDoc6NJ9zJxxriLLq60PJtIptG79rgvCEvYteIZb+VvUFIs8
   YRhk89lokkqOzhGwi963Xp2DbnjHsH/MFyJuceblBL5MtOTmTN48ofegD
   axKmiMJVM060sdWt7lP88iYyJOWlOKZn711p4MfJu85dawX6CITan4Asm
   13WHMkvb3ys8DXM1UGLuP9HFRFYH0jOvtCVMqXEsdR9PWfe5mMytNKgtv
   1aZX/AWKzyU1yjdH4k+n/6LLXWjHzFEuU9BZWQ1FrKGepx8AHmcxxLB63
   A==;
X-CSE-ConnectionGUID: wsoo4T5hTgKk1pHxSGmgMA==
X-CSE-MsgGUID: pDr09e5rQA2H8oovmRXwVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="98980531"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="98980531"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 19:09:38 -0700
X-CSE-ConnectionGUID: dQ4BsQUqRV61VIDY00Qx/Q==
X-CSE-MsgGUID: mt/rhD2nT8Sa4/NEaF0ekQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261931313"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 19:09:35 -0700
Message-ID: <599aea14-4690-4f4a-9cb7-6308f7b1a9df@linux.intel.com>
Date: Fri, 21 Aug 2026 10:09:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Ensure ATS disabled via quirk before notifying
 IOMMU drivers
To: David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Woodhouse <dwmw2@infradead.org>, Guchun Chen <guchun.chen@amd.com>,
 Joerg Roedel <jroedel@suse.de>, Raghavendra Rao Ananta <rananta@google.com>,
 Pranjal Shrivastava <praan@google.com>
References: <20260817202823.2172548-1-dmatlack@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260817202823.2172548-1-dmatlack@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/26 04:28, David Matlack wrote:
> Ensure that PCI devices always have ATS disable via quirk before IOMMU
> drivers are notified about the device. Fix this by converting the
> existing quirks from final to header fixups and changing the quirk logic
> to set a new no_ats bit in struct pci_dev that prevents pci_dev.ats_cap
> from ever getting set.
> 
> Use header fixups instead of early fixups since not enough of struct
> pci_dev is set up in during early fixups: quirk_amd_harvest_no_ats()
> needs subsystem_device and subsystem_vendor to be set.
> 
> This change ensures that pci_ats_supported() always takes quirks into
> account during iommu_ops.probe_device(), when IOMMU drivers are notified
> about devices, and that pci_ats_supported() returns the same value when
> the device is released in iommu_ops.release_device().
> 
> The Intel IOMMU driver uses pci_ats_supported() in probe/release to
> determine whether to add/remove a device from a tracking rbtree. This
> strict reliance on pci_ats_supported() remaining constant between probe
> and release was introduced by commit 89436f4f5412 ("iommu/vt-d: Fix
> WARN_ON in iommu probe path"). Because FINAL quirks evaluate too late
> (in pci_bus_add_device()), pci_ats_supported() evaluated to true during
> IOMMU probe but false during release. This mismatch bypassed the rbtree
> removal upon device release, leading to a later use-after-free.
> 
> Note that this fix only matters for PCI devices created after IOMMU bus
> notifiers are set up (e.g. hot-plugged devices and VFs).
> 
> Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devices")
> Fixes: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
> Fixes: 3f1271b54edc ("PCI: Mark all AMD Navi10 and Navi14 GPU ATS as broken")
> Closes:https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
> Reviewed-by: Pranjal Shrivastava<praan@google.com>
> Tested-by: Pranjal Shrivastava<praan@google.com>
> Signed-off-by: David Matlack<dmatlack@google.com>
> ---
> v4:
>   - Rebase onto tip of Linus' tree
>   - Add Pranjal's Reviewed-by and Tested-by tags
> 
> v3:https://lore.kernel.org/linux-pci/20260403222750.1215002-1- 
> dmatlack@google.com/
> v2:https://lore.kernel.org/linux-pci/20260327211649.3816010-1- 
> dmatlack@google.com/
> v1:https://lore.kernel.org/linux-pci/20260223184017.688212-1- 
> dmatlack@google.com/
> 
> Cc: Raghavendra Rao Ananta<rananta@google.com>
> Cc: David Woodhouse<dwmw2@infradead.org>
> Cc: Lu Baolu<baolu.lu@linux.intel.com>
> Cc: Andy Shevchenko<andriy.shevchenko@linux.intel.com>
> 
>   drivers/pci/ats.c    |  2 +-
>   drivers/pci/quirks.c | 50 ++++++++++++++++++++++----------------------
>   include/linux/pci.h  |  1 +
>   3 files changed, 27 insertions(+), 26 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
