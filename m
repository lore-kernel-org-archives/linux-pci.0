Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53711338596;
	Fri,  6 Mar 2026 03:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767419; cv=none; b=XBsiD4A0WrWtpep+y3PD/9GXPcTta0bdLsR6nzmGhq81kOA8spU+k4//pDPdetXAAPjKRFpEvTVjnM6CJ8ccPqsDYtS8S44+ZxXTBLBFIeVzqswvepAbu8n5GHAQ6jyizNCvHllA4FH71nHFb0a2EfbIhAZjw+aOY/alwoZ9X+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767419; c=relaxed/simple;
	bh=tA9L12xlCsrK8dz+Fq8CyoLAozPl60QyKkM4A17q6sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soGaHBlzHmcUoiW/f0OofXE0htijnZkVjfb+MgfhHCDKEii/+BgUlkv2g5p8DmqHHrwEaemuJbBpa5wmKCtBq4r9GHdYrPHuyN5j53BfAL2L3dGNNv1aubL43iVv//+FuMFNFpGIlxVh8YEomJlOz5KYWk4SvRoshAf5YjHM+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhO4g1Px; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhO4g1Px"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772767418; x=1804303418;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tA9L12xlCsrK8dz+Fq8CyoLAozPl60QyKkM4A17q6sA=;
  b=XhO4g1PxV4DIs7shKiRk7kywQ1zR1eT+KOkbZOotLwJ2rq/twk8ORfOl
   bhv1Rg/N4KrtQKvOHb7ATJnjtQ6dBoX+xof5pnQeL2OYd3Yrjt4Wefor+
   L7hx6OXdruDNEMt+lY5L/dj+Cy96quPwTj97PN81SWskW3oib/OsWk7yE
   PVrAOwlxsvqVftKyYHnWGPL6pkK38tLwGblotekdKPZ6rOrYydiNokMDJ
   fNDOzTKY3XbBxcRna1O5XQ9OaL5jhbq2+WlI9AnqLpm5fO56Ap90J8UOe
   FMESXdnq5FFo5bMYJrO8+Fb4WTeeZ6l5OouJq6yrWAV1qm2VpT7qMCgMg
   w==;
X-CSE-ConnectionGUID: sdsD2uywS0W99uMf+VB/mQ==
X-CSE-MsgGUID: GRLpPI7kTUm5xAD+4CHK9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="61446875"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="61446875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 19:23:38 -0800
X-CSE-ConnectionGUID: jD6OhW6aQNqpuQRqlhrT5g==
X-CSE-MsgGUID: ucmj+6C0SJKG4sfPqTw1Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223016462"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 19:23:34 -0800
Message-ID: <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
Date: Fri, 6 Mar 2026 11:22:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, praan@google.com,
 kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com,
 kevin.tian@intel.com, miko.lenczewski@arm.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260305153911.GT972761@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/26 23:39, Jason Gunthorpe wrote:
> On Wed, Mar 04, 2026 at 09:21:42PM -0800, Nicolin Chen wrote:
>> +	/*
>> +	 * ATC timeout indicates the device has stopped responding to coherence
>> +	 * protocol requests. The only safe recovery is a reset to flush stale
>> +	 * cached translations. Note that pci_reset_function() internally calls
>> +	 * pci_dev_reset_iommu_prepare/done() as well and ensures to block ATS
>> +	 * if PCI-level reset fails.
>> +	 */
>> +	if (!pci_reset_function(pdev)) {
>> +		/*
>> +		 * If reset succeeds, set BME back. Otherwise, fence the system
>> +		 * from a faulty device, in which case user will have to replug
>> +		 * the device to invoke pci_set_master().
>> +		 */
>> +		pci_dev_lock(pdev);
>> +		pci_set_master(pdev);
>> +		pci_dev_unlock(pdev);
>> +	}
> I thought we talked about this, the iommu driver cannot just blindly
> issue a reset like this, the reset has to come from the actual device
> driver through the AERish mechanism. Otherwise the driver RAS is going
> to explode.
> 
> The smmu driver should immediately block the STE (reject translated
> requests) to protect the system before resuming whatever command
> submissio n has encountered the error.
> 
> You could delegate the STE change to the interrupted command
> submission to avoid doing it from a ISR, that makes alot of sense
> because the submission thread is already operating a cmdq so it could
> stick in a STE invalidation command, possibly even in place of the
> failed ATC command.
> 
> I think I'd break this up into smaller steps, just focus on this STE
> mechanism at start and have any future attach callback fix the STE.
> 
> Then we can talk about how to properly trigger the PCI RAS flow and so
> on.

I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
invalidation timeout is a generic challenge across all IOMMU
architectures that support PCI ATS. Would it be feasible to implement a
common 'fencing and recovery' mechanism in the IOMMU core so that all
IOMMU drivers could benefit?

Thanks,
baolu
