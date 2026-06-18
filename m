Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F971258CE7;
	Thu, 18 Jun 2026 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781822178; cv=none; b=Bc24fUskNI8BY1Nubcfiyr++mQMo7umTCwLaSeybMFKXWyBy/pMiQqT8j71slYGKkab+gmrFP86J2BLK7yCs1rBxS1MAruNE3Y/wVTz8aQkouACrugz4XINTw97G1OMZsIN+HAkRq5P3yc9Gos0J+D7cF4W7XG/2fEH7+82W/G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781822178; c=relaxed/simple;
	bh=98nmdQz52Z8bD9bBGVDuLHb5UY+aMOtt+qxoHvlAfJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgowvuEVzdI9NvTEr63OvvUcmRoRaaRoDCJBtCKCe4DGXdySFnGm4/ZCY+J8uvzE7fkme+6J3havC+FPItH/a/fNT5RXi3NXcieQ2j46ie81dK0BBB4A5+gucKZnoqoEskSwEh87HL+v6fcH1qmOaRt2itDxIAzjy0YkxhXtkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQI7Kcec; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQI7Kcec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781822176; x=1813358176;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=98nmdQz52Z8bD9bBGVDuLHb5UY+aMOtt+qxoHvlAfJw=;
  b=EQI7KcechlgXnyGebteAv+z+Z3nF3anDDMhZ6Qn/rnXw8+LZQB1wChgU
   JbisURC9PjIUFyfT0uKe96cffDPcykBuAu+r8RMD6NYY4KBrHKmdNqntm
   9/OtGpBkkUJ2OLCmstwINBo11DCceN0vQnPx6VbQ3lf5t0bs0+roXHv5h
   0Ei5mXHmyxeUJ8VK5KV4PkuTdpyBaL4RCmocTzi8REif8r9SqtdIyrf7X
   i9N6cqnjaE13c9CEjLzsTzM5bGmWET91iMNimD/AM9HETnepdBe9TDJOv
   nnChE74CI08VZOZqikizsqkCIX6HZQBKAf0ompNstNagfPtnAlMX8GsHW
   A==;
X-CSE-ConnectionGUID: Jw4+s2oFSM2UT/EdLH+AdQ==
X-CSE-MsgGUID: nSa3eB2tQeeUHSQ7evJ5TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="86356087"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="86356087"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 15:36:16 -0700
X-CSE-ConnectionGUID: oQib7BWdQXaEx5u+Zz8avg==
X-CSE-MsgGUID: rvuWArhIRE6n+9RUvUjBTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="242108309"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.229]) ([10.125.111.229])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 15:36:15 -0700
Message-ID: <44550e87-d5b6-49d9-9e41-a8d19e79a9f0@intel.com>
Date: Thu, 18 Jun 2026 15:36:14 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] PCI/CXL: Add RDPAS support for CXL.io
To: "Dan Williams (nvidia)" <djbw@kernel.org>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: terry.bowman@amd.com, bhelgaas@google.com, jic23@kernel.org
References: <20260618170723.2010490-1-dave.jiang@intel.com>
 <6a34533a43730_299c3a10060@djbw-dev.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6a34533a43730_299c3a10060@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/26 1:21 PM, Dan Williams (nvidia) wrote:
> Dave Jiang wrote:
>> v2:
>> - Added multiple DSP per RCEC support.
>> - Added boundary checks for reading MMIO
>> - Addressed issues raised by shashiko
>> - See individual patches for detailed changes
>>
>> The series add RCEC Downstream Port Assocation Structure (RDPAS) parsing
>> support to CXL.io. RDPAS is an ACPI table that is part of the CXL Early
>> Discovery Table (CEDT) defined in CXL specification r4.0 9.18.1.5. It
>> provides the mapping between RCEC and downstream ports. With RDPAS, the
>> error device can be directly found when an error is reported on RCEC,
>> without walking a number of RCiEP in order to determine which one reported
>> the error. While CXL.cachemem is supported by RDPAS, there is no easy way
>> to discover the source id of the error and therefore finding the Linux PCI
>> object for the RCiEP. The intention here is to accelerate the discovery
>> of the error by directly locating the error device with the given
>> information.
> 
> Can you clarify why this "acceleration" matters in practice, especially
> when Linux needs to be prepared for the RDPAS to not be present? Did
> RDPAS ever ship on a CXL platform?
> 
>> This series is based on top of Terry's CXL error protocol series [1].
>> Looking for comments on the series WRT if it makes sense to add on top
>> of Terry's error handling for RCH/RCD devices.
> 
> What is the correlation with Terry's CXL.cachemem protocol series when
> this implementation claims to only support CXL.io and Terry's series is
> about CXL.cachemem protocol errors?

That's my misunderstanding. For some reason I was thinking all CXL errors are routed through the new mechanism. Given that it really doesn't help .cachemem anyways, I think we can just drop the series as it doesn't really buy us anything. I did discover that the RDPAS structure in ACPI needs to be updated as there was a spec error in r3.0 that was corrected in r4.0 but the linux version is still based on the incorrect one. I've sent a PR [1] to ACPICA to correct that.

[1]: https://github.com/acpica/acpica/pull/1201



