Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D6439448F;
	Fri,  9 Oct 2026 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582597; cv=none; b=UAnO4r4jo3UkRyzP3ge8e7obu8za0HOxHxlVEsnmjuW2yI183b5NkqSoM1ENceM2YeLU3BCvdfUBcV8OuxhpEaX/RJ4WIzo4BH6ddYH9csk12DdLenbipehctQef/pX2z1dPi4EdvrBeymKwXZRlqYq8N1fYi29/1KACjDtpK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582597; c=relaxed/simple;
	bh=Kt+EaokHc+LBIbHph85M7DOGw9QfF7g48tkUbB+t8xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SL4Q3Lu2c4Abl7J3krvyZ8gk9igK9ZiX04Q90Gmls9QK9Z1U1FnzCFY01gRQ+uoaN26U5HMEDoRQ9q67LZoTDajkjWPOzwKTOcKEDdSsESmULMCbO3dTncD7x3jXy1GdUyToubPOaLNiZB/DaNbESBDkM79GUXSd5ufGlJZO+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IaHK+gqp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IaHK+gqp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791582596; x=1823118596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kt+EaokHc+LBIbHph85M7DOGw9QfF7g48tkUbB+t8xE=;
  b=IaHK+gqpju0ZcCFbMn031lmgQriYSLlVj3wEa58i/cPhXJ8/4d+LQMd3
   iO/Z+k6p3lLf3AsqOPAG56/8Bo4b/ipwfc3Ta/vNn8ZkQWcU2iKNYMaNo
   cAioPTuUSZvD3F+4gC4M5w+3wYBih5dR9CmqOjEWTrgMsLovnHRoeZf2J
   0wGrY3HJ9vVps4Y0lP6Jzzgrh9gqqba77gFVFj5TKqhUa58uW95+IM1bt
   jbhdWPYyLalukYNrPV6f3duwy/3G4q0QFEq1vDX/VY2dYjVtiafeIWL/x
   xLsNNaX967LRFghYOPtrLAJ01hoGf4LIGhOr3XPOzaXgsq5Z/d1sCFH5s
   A==;
X-CSE-ConnectionGUID: 11K7ypCgSP2w+7h13QLUQw==
X-CSE-MsgGUID: s9d9B+EjRKaBBTAGCW6N8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="293049"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="293049"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 14:49:55 -0700
X-CSE-ConnectionGUID: WVV4S8U2QieUEAL/iMtc1w==
X-CSE-MsgGUID: cAOWbxIBQ4W5fBa4CZ0hXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="501412"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 14:49:54 -0700
Message-ID: <af00b5c8-76af-499c-b8ba-0a2f51398c2a@intel.com>
Date: Fri, 9 Oct 2026 14:49:52 -0700
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

Applied to cxl/next:
2658c66a5efb
db4503d4575c
16440d6e4bf1

