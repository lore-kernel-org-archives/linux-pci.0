Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08925785D;
	Fri,  9 Oct 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566165; cv=none; b=Boa2RGQZ5ECzzjxagbeT4JuarvwJKOf1Wl8esH6Ck2oCploqRm6jF15NaE8r336EvClCewYAmi889etrqmZ9G11edNqe4110p6t9s+ge32nJ5pzfp8ph2rl3gU64y7CIVfGtTBi7PHFd8BQHj3JHFU5OEUKwycTRDd3BE+t25nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566165; c=relaxed/simple;
	bh=UGLjJOR25af7v3izatmL0Eubuh6NBItPWREXP0u9O3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnSULtN2zaQ2PRJ6T35iKF7zGNTmFIjPpzrfn8Hpqp5kze752hII/OEtaZSS8yM2IULBU8BjMdB9x075RPaF7NdD+hEN6YopuvQ31/wcfYY6JmZnrc3Ay/ZY6pOpnh/RyfUemCUFq2eWhNa9tXa1Sh/fTd2OdLPtf5K3VeHzqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOqbHfIy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOqbHfIy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791566164; x=1823102164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UGLjJOR25af7v3izatmL0Eubuh6NBItPWREXP0u9O3w=;
  b=lOqbHfIyxuHTGjT1qMvf9Box6Ya81+M354Kwtza90+LrPHjIQrvaMmdl
   Zx6t38N3x8r52N1TBQgCBycH/HbslpXIK4EqUXqstp2DkTMAr6IigOJY/
   g3bE6JJFlpuD5zliEqy/vLzZN4gZksa2FVlzAuoAFv/MYjAIihuSimPPD
   /ln2x6PKNk8GJikY+1tzvzcAjrqkQiY4Mebb/LBp5xKjim9IbDu9YTefn
   ky179GN1dFBi0VUmI6C9RzcCO5Wx3vN/e9Vk6TSf/Ts+3BNdKVXX2ZEnS
   Sy0poHo+wfg1fSvo264+eNtWoZ6ovUSAWrHqSE7RWGVWlYwVbQI1IvXMc
   Q==;
X-CSE-ConnectionGUID: DVCDkvmSRumrR5wYNPFfKA==
X-CSE-MsgGUID: ZAHhWyaoRguos+QfezSGqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="256373"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="256373"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 10:16:02 -0700
X-CSE-ConnectionGUID: rFjaDgx/SyWGXwz5mowsSw==
X-CSE-MsgGUID: J4ndXQm5QqS0vo9UmxdGBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="711441"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.99]) ([10.125.109.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 10:16:00 -0700
Message-ID: <cb76e150-df33-46f9-b69b-bc5513a269bc@intel.com>
Date: Fri, 9 Oct 2026 10:15:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cxl: Fix link latency calculations and QTG latency
 units
To: Koichiro Den <den@valinux.co.jp>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, Terry Bowman <terry.bowman@amd.com>,
 Alejandro Lucero <alucerop@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20261009045452.1107921-1-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261009045452.1107921-1-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/8/26 9:54 PM, Koichiro Den wrote:
> Hi,
> 
> This small series intends to correct the FlitLatency portion of the link
> latency calculation, as per Intel CXL Type 3 Memory Device Software
> Guide 1.1, and restore picosecond latency units for the QTG _DSM input.
> 
> The first two issues were found while debugging a QEMU guest. The third
> issue was spotted while looking through the code that uses the coord
> values. I haven't tested it on real hardware.
> 
> Best regards,
> Koichiro Den
> 
> 
> Koichiro Den (3):
>   cxl/port: Convert PCIe link latency to nanoseconds
>   cxl: Account for link width in latency calculation
>   cxl/acpi: Convert QTG _DSM latencies to picoseconds
> 
>  drivers/cxl/acpi.c      | 10 ++++++++--
>  drivers/cxl/core/pci.c  | 22 ++++++++--------------
>  drivers/cxl/core/port.c |  3 +++
>  drivers/pci/pci.c       | 23 ++++++++++++++++++-----
>  include/linux/pci.h     |  2 +-
>  5 files changed, 38 insertions(+), 22 deletions(-)
> 
> 
> base-commit: 71392a644e88c6bb921cdf12cb2b00adec070fe4

Thanks for the fix!
For the series:
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

