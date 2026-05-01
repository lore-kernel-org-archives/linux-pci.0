Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54526CA52;
	Fri,  1 May 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777672870; cv=none; b=F7uQwMfIV4uW+qX7lp8lKwjJNxOgbBkr2rK9QJp97PFJaoxbzyYZzRJJ0Ml1neYL0aEhA+tmO+a1OgEC4WSg5tFXRTXU+/R6eHfTNLH/LaoT96x7UtMigQMKmph7X5zuQcNi0vUKF1IUiH2mFJyVjHn4QyHshg3Iz2YY+Yk8k/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777672870; c=relaxed/simple;
	bh=C2zz4hu7GIcOji/Wc7Gg4hhpUn6qU2gT5VmLc1zTtLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pafv42nit91+VqmJQPfqlZ5FC45na7FhDSnO7XKDqy91TrHh0nSc7/ZXtE6iUgP1TNAlvT6fbBUINyjxRlrpYrPQaYKlJ5yGeCEy7qA/94Aee+RLamxwSSeDvQI0F+F/SJmH+BXX3i3pafiq/TxhgGCMWh1Xrt+nphdVwwyefes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cj4UX7Ga; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cj4UX7Ga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777672870; x=1809208870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C2zz4hu7GIcOji/Wc7Gg4hhpUn6qU2gT5VmLc1zTtLs=;
  b=Cj4UX7GaW/oHRX+CpBFR8FlvcE0pl7bXgZxXsw6Y6q0QKIeMF21Oib7n
   Ay4qhuHQkwlMkI96N1uvgkxkcR0psaVuznYekJSH+MTuWCTHy4jgzOAZx
   tSx3nXhDEJTNBZS6HM+BWt2LI66DRAwGVGOP2Myt5+CZDJZteuupMULb2
   rVovKMAvlvYjWl8Vg7WES2Ci+u7cHpN0dZJRwXic/Mi3wJeWSTPbF2dG3
   AsEkyeXGc4YIXcqUFXUXoDeCF2ydhsJmExabklNJZhFu2xhdxucjgX+Ip
   IbseK5TDQTTFPmLvoucN3cCBwkhk0kMp/l4wKb50MrT+SBf9/6ZvrpuxI
   w==;
X-CSE-ConnectionGUID: lOvMYmzvQZqjZliu/1yZIQ==
X-CSE-MsgGUID: HDQIDXw3Rjq0pnl0JOsXzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="78735888"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="78735888"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 15:01:05 -0700
X-CSE-ConnectionGUID: BUSDzGDZTXCZ4ITViRl34g==
X-CSE-MsgGUID: m6nKGh/6Qi2VRP24xmyZ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="238940018"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.150]) ([10.125.109.150])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 15:01:03 -0700
Message-ID: <89876bd2-f1bd-419d-a8ac-83fa0b23cbb7@intel.com>
Date: Fri, 1 May 2026 15:01:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260428182454.464655-1-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260428182454.464655-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 11:24 AM, Fabio M. De Francesco wrote:
> Subject: [PATCH 0/2] PCI/CXL: Recover CXL Downstream Ports from PM Init failure
> 
> CXL r4.0 sec 8.1.5.1 Implementation Note describes a scenario in which a
> Secondary Bus Reset, a Link Down, or Downstream Port Containment on a

I'm not sure if this series covers a Link Down event (i.e. hotplug). As I recall, cxl_reset_bus_function() only happens via sysfs trigger.

DJ


> CXL Downstream Port prevents Port PM Init from completing when ACS
> Source Validation is enabled on the Downstream Port. The spec states
> that another SBR alone does not recover the port and describes a
> software recovery sequence.  
> 
> Patch 1 extends cxl_reset_bus_function(), the helper backing the cxl_bus
> PCI/CXL reset method exposed to userspace via sysfs. It saves, clears,
> and restores ACS Source Validation and Bus Master Enable on the CXL
> Downstream Port around the SBR it issues. This keeps the userspace
> cxl_bus reset path from leaving the port unable to complete PM Init.
> 
> Patch 2 adds a recovery pass during CXL enumeration. For each CXL
> Downstream Port in a memdev's ancestry, the CXL core checks whether PM
> Init has completed. If it has not, regardless of what caused the
> failure, it invokes cxl_reset_bus_function() on the child below the port
> in the hope of restoring the port to a usable state. CXL enumeration
> re-runs after events that tear down and re-probe the memdev, including
> DPC, AER, and Link Down, so those paths reach this recovery.
> 
> This small series is developed from an old RFC v3:
> https://lore.kernel.org/linux-cxl/20260330193347.25072-1-fabio.m.de.francesco@linux.intel.com/
> 
> Fabio M. De Francesco (2):
>   PCI/CXL: Allow PM Init to complete on cxl_bus reset if ACS SV enabled
>   cxl/core: Recover from PM Init failure via cxl_reset_bus_function()
> 
> drivers/cxl/core/pci.c        | 30 ++++++++++++++++++++
>  drivers/cxl/core/port.c       | 22 +++++++++++++++
>  drivers/cxl/cxlpci.h          |  3 ++
>  drivers/pci/pci.c             | 52 ++++++++++++++++++++++++++++++++++-
>  include/linux/pci.h           |  1 + 
>  include/uapi/linux/pci_regs.h |  2 ++
>  6 files changed, 109 insertions(+), 1 deletion(-)
> 

