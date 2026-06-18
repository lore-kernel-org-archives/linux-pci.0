Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C942FA0DF;
	Thu, 18 Jun 2026 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813535; cv=none; b=gpobdVxaKqHI0yLmtpiraMNUbfxrHpZduhVxEVBr8tv5fk0CPD9teUYBxWVHFlcDrCMvEnijekN93HghFGR55zZievyQmpn0prhUzf5UV9EEE9gsgamIK7GlGx+FgEOaJL7zFKd1zKQ1onn6xKJmM8ZoAFpxYvVlrIDPbRHFhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813535; c=relaxed/simple;
	bh=73BJVF/fpFCDfS8QAZYC2uQrF61DJUty5fv/FX75Clk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTlqQqDhdr8ThYi1hT5UUIRKhPvkLXKMWO0SYretxK99RFwrQd2/JJQ9YriHblIBV/RklDUqwfQbhJSXG6uFPZRWeG23vfHOUzO7f+tir1vAa/EStHCLKzPyWFB1X5Ji+hjv0/BxEr/sC4jMGgQ3EYBV1/c2tAQPCirN2VchdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuPty3Nl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuPty3Nl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781813534; x=1813349534;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=73BJVF/fpFCDfS8QAZYC2uQrF61DJUty5fv/FX75Clk=;
  b=WuPty3NlSAUVHSlmNm56LH+L+2iab9hnhb88kKw0muyuVDvBpc70/q/n
   sE9oXdWYrQZCobGIo3+k/ukTqBr6ILURlWTDO2hNy2cG4q4udtF1eXyFV
   4K51IREFMp2zcnU4gRbvKTQYJR/65TIJAHnLBEkRQEHR9ZSyAuJboNjIs
   5UFqUjTA1h8H9Ah8FGkog8ElHCEUgre+k8nVjtVZNQdqkCcFSYwfGYRCZ
   uBDdlwtpbKcdxm4KX9piWVD4BOfWaAZaNb03P3AvrF3Q8haiT1WWqVwOt
   VatsHnXigvkO+07Lx5bzwavxHyceP7s0NJMMyst6Khc+5iM+waJFydu7y
   g==;
X-CSE-ConnectionGUID: UFJdmFF6QxiCJQX/Ez2Aew==
X-CSE-MsgGUID: GkS9XxDWTC2WGa7H+Karvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="86580484"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="86580484"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 13:12:13 -0700
X-CSE-ConnectionGUID: JqsdSNBrSD6l93M3F2lSPw==
X-CSE-MsgGUID: sxViEc6rRH+sdRUiSLVYLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="244304817"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.229]) ([10.125.111.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 13:12:12 -0700
Message-ID: <46531f24-c3c7-42b7-8caa-864f4d939227@intel.com>
Date: Thu, 18 Jun 2026 13:12:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] PCI/CXL: Add RDPAS support for CXL.io
To: "Bowman, Terry" <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, jic23@kernel.org, djbw@kernel.org
References: <20260618170723.2010490-1-dave.jiang@intel.com>
 <5c12d5db-15a3-4669-aa94-61583b1265e1@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <5c12d5db-15a3-4669-aa94-61583b1265e1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/18/26 12:05 PM, Bowman, Terry wrote:
> On 6/18/2026 12:07 PM, Dave Jiang wrote:
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
>>
>> This series is based on top of Terry's CXL error protocol series [1].
>> Looking for comments on the series WRT if it makes sense to add on top
>> of Terry's error handling for RCH/RCD devices.
>>
>> [1]: https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowman@amd.com/T/#t
>>
> 
> I was considering whether this could possibly be reused for other RCEC–RCRB use 
> cases and lifted into the AER core as a generalized solution. However, as far as I 
> know, only CXL aggregates RCiEP reporting using the RCEC SBDF and leveraging RDPAS.
> 
> I think this will provide a useful alternative to walking the RCEC’s associated RCiEPs and
> should improve performance with scale.
> 
> It may be worth clarifying whether this supports both RCH and VH modes. Also
> consider updating the problem statement to note that the current RCEC RCiEP
> walk processes the RCH downstream ports of *all* RCiEPs associated with the RCEC.

This currently is only the RCH path. Does it really do anything for VH? Unless there are RCiEP devices that are CXL in the future by platform providers?

> 
> -Terry
> 
>>
>> Dave Jiang (2):
>>   PCI/CXL: Add RDPAS parsing support
>>   PCI/CXL: Enable usage of RDPAS to shortcut error device discovery
>>
>>  drivers/cxl/acpi.c             |   5 +
>>  drivers/pci/pcie/aer_cxl_rch.c | 271 ++++++++++++++++++++++++++++++++-
>>  include/cxl/ras.h              |  18 +++
>>  3 files changed, 291 insertions(+), 3 deletions(-)
>>  create mode 100644 include/cxl/ras.h
>>
>>
>> base-commit: a558d1571c0b3bb6b4a830cb2cd8f128cc5ef3e1
> 

