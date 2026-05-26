Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228273D3D09;
	Tue, 26 May 2026 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807675; cv=none; b=NA2vKZzDL1j4kqZCvt8zoAZ8mvdtSA9Nt7wj32MH04803TDRJLDZS1aImrS+ceVDzOkuDcm+j3KJ6RFIMI+xAuHSL3tIBIQeMQ1/qYVAIyDWWMPkZXuXvTcfiaTLKu9HLrmmhiv2soh/MAUkiVqNsc1VeBOF/FTKy/I3yPDf6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807675; c=relaxed/simple;
	bh=2bbe3fhv1+1tAyFtW2OCXIBsNiz7RMFwspwzHeTDrR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eru8458Wf/CvwKkl69ptye7bB7gJXt/hNeKPHWSXx8EACPfKKe5o2nDPjBkS6H0eYOGdQPunrRykwAWpnFKs+m/PLNOSXreH86JzhUp82aoUyq8s1Gkw5dekbpaOzoah1G6T6EF+U6b0IvyaJYBM+04jbFO08oTdS9iPNyt2FrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgkFboK4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgkFboK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779807674; x=1811343674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2bbe3fhv1+1tAyFtW2OCXIBsNiz7RMFwspwzHeTDrR4=;
  b=FgkFboK4eT5vPwmGNR4aFSLkJwj4NJk0IrXB0ufZEGHXrx2WPOpsjOBZ
   FGqNfur2QHft2paJiaRZHm3WD2vnEMmtuL3xcwXmV9SweXoviOhm10CRu
   HPkXY9WQiramtD6SqSQFgNVeJ12hW4kvNq3ng5xcQlP1ty04J6TVveRhq
   360uPUNdB4N+j2x6SaphkLLFKBWGdL8+kIE3nGU7hMGqcnieHzr17RVyg
   0KJkr/IQRp8xT7FcuQIdHEst5aDKMHba4vp6MTOCDYv8qObw8aWe8PHHr
   7K3o+W9lfD7UZ8ZBf/jl+JTDgWnHgNzpAgy0qv97gi/98P23C64bBfeJR
   A==;
X-CSE-ConnectionGUID: GGseEGReSFCE3SsytNDyJA==
X-CSE-MsgGUID: WPZLSbejSVumt71/YvS3Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80471331"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80471331"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:01:14 -0700
X-CSE-ConnectionGUID: Es7aSl05SO+fW5sldNnZCw==
X-CSE-MsgGUID: 8XG4Vqd+Rg+obUY9Y3c/6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="247025753"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:01:12 -0700
Message-ID: <1c79454e-6988-402f-9b8d-e628e8600ed8@intel.com>
Date: Tue, 26 May 2026 08:01:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ACPI/PCI/CXL: Enforce _DEP ordering between ACPI0016
 and ACPI0017
To: Chen Pei <cp0613@linux.alibaba.com>, alison.schofield@intel.com,
 djbw@kernel.org, icheng@nvidia.com, bhelgaas@google.com, rafael@kernel.org,
 lenb@kernel.org, guoren@kernel.org
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260526025118.38935-1-cp0613@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260526025118.38935-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/25/26 7:51 PM, Chen Pei wrote:
> On platforms whose ACPI namespace exposes a CXL host bridge (ACPI0016)
> with an ACPI0017 CXL root device declaring _DEP on the host bridge,
> cxl_acpi can probe before acpi_pci_root has attached the PCI root.
> acpi_pci_find_root() then returns NULL, decoder targets read as 0,
> and no port/endpoint device shows up under /sys/bus/cxl/devices/.
> 
> The root cause is twofold:
> 
>   1. acpi_pci_root_add() never calls acpi_dev_clear_dependencies(),
>      so _DEP suppliers downstream of a PCI root are never released.
> 
>   2. ACPI0016 is not on acpi_honor_dep_ids[], so even when ACPI0017
>      declares _DEP on it, acpi_dev_ready_for_enumeration() bypasses
>      the dep_unmet check and lets cxl_acpi probe early.
> 
> On x86 the bug is usually masked by link order (acpi_pci_root is
> built in and probed before cxl_acpi). On architectures like RISC-V
> that ordering is not guaranteed, so the standard ACPI _DEP mechanism
> must actually work.
> 
> This series fixes both sides and the two patches must be applied
> together; applying only patch 2 would prevent cxl_acpi from ever
> probing on ACPI0016 systems, because the supplier would never clear
> the dependency.
> 
>   Patch 1 makes acpi_pci_root_add() clear _DEP on the supplier once
>           the PCI root bus has been added.
>   Patch 2 adds ACPI0016 to acpi_honor_dep_ids[] so the dependency
>           declared by ACPI0017 is enforced.
> 
> The approach in this series follows the discussion of an earlier
> posting:
> https://lore.kernel.org/linux-cxl/20260514023238.49984-1-cp0613@linux.alibaba.com/
> 
> Chen Pei (2):
>   ACPI: PCI: clear _DEP dependencies after PCI root bridge attach
>   ACPI: scan: honor _DEP for ACPI0016 PCI/CXL host bridge
> 
>  drivers/acpi/pci_root.c | 4 ++++
>  drivers/acpi/scan.c     | 1 +
>  2 files changed, 5 insertions(+)
> 

For the series

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Are Fixes tags needed?

