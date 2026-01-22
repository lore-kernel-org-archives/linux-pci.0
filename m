Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2B34A3AC;
	Thu, 22 Jan 2026 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044667; cv=none; b=EZjO+/4KuwzQE0u5TkhEus2ujE7DwbnpxZsp8oyH2fZ5MEb0sP7N2C5yGy0CLSrErdh6fAhQ1hx182ILmEUFWqeguK6WcjVNgkS6tmnX517ee6KjABYmBcDNrzcC6H6WB7BE315LMCQilsgAo4o2GMkg5tODkqgyiJWWAxhctFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044667; c=relaxed/simple;
	bh=X/ZqB3F3uxrlq5fnYhJF9YmflnuXgYbIuIyXLKPZrBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgmGC0ZXWAXIulWQnJ0cO4yz+uixoRxVbxM7rp1KM3ck+meIYWeYfyKb7Ugh9DyirrJP2gv6qEwJF86hrs0DTTJiZ0wlLOydHZtnd3zFeK7AgiCr9/5fCfoEkH2h8WF9TXe2bPNT38PZ+CMuSV6xBfKqojf0qt3dsMUtWjosq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2LIQrzO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2LIQrzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769044665; x=1800580665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X/ZqB3F3uxrlq5fnYhJF9YmflnuXgYbIuIyXLKPZrBg=;
  b=g2LIQrzOL6/g6roedPhAcsi1NzF3d7V0/jmrsxBEPBcvwTBgeuwiBsrV
   OcgwZ2bIZyVTFtTGpGdsuZtGQtAcSv2mwDKd9tHCA/NZAD9+D5RCzX+Yq
   WKh6LK8eHMVYf330Rlv8fF9eJt4HW3z5YSzsnzE/L1iB+am2G66wnMQl5
   +IpS2h9BzGynM8FpXE7F38rpRQY0ALJejYy52UwaHG7LMvHzKsaWDUoWv
   XKAcpeK947ahguFCeOTk7wiEmdpuXxyB0rNRnAAR1qKBUxohor2xWQ2dh
   ea40fanPbbdeclXxU7l7fw0sCq1jHX2eiKypoxhwbl5CiWkyB6lrInsmn
   w==;
X-CSE-ConnectionGUID: bFyTSJWRRSS0tO2w+vYeQg==
X-CSE-MsgGUID: O58ZeufQRkSNisxCyFGhow==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69480623"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="69480623"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:17:38 -0800
X-CSE-ConnectionGUID: TRMk+zZkTl2jUQY/JKcenQ==
X-CSE-MsgGUID: dNgfp8zFQiqosj5IRWLZPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="211449798"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:17:34 -0800
Message-ID: <fa3e55e1-3cf4-4b73-8b5e-192a19a18f3b@linux.intel.com>
Date: Thu, 22 Jan 2026 09:17:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "praan@google.com" <praan@google.com>,
 "miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linux-cxl@vger.kernel.org
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com> <20260121130315.GE1134360@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260121130315.GE1134360@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/26 21:03, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 10:03:07AM +0000, Jonathan Cameron wrote:
>> On Wed, 21 Jan 2026 08:01:36 +0000
>> "Tian, Kevin"<kevin.tian@intel.com> wrote:
>>
>>> +Dan. I recalled an offline discussion in which he raised concern on
>>> having the kernel blindly enable ATS for cxl.cache device instead of
>>> creating a knob for admin to configure from userspace (in case
>>> security is viewed more important than functionality, upon allowing
>>> DMA to read data out of CPU caches)...
>>>
>> +CC Linux-cxl
> A cxl.cache device supporting ATS will automatically enable ATS today
> if the kernel option to enable translation is set.
> 
> Even if the device is marked untrusted by the PCI layer (eg an
> external port).

I don't follow here. The untrusted check is now in pci_ats_supported():

/**
  * pci_ats_supported - check if the device can use ATS
  * @dev: the PCI device
  *
  * Returns true if the device supports ATS and is allowed to use it, false
  * otherwise.
  */
bool pci_ats_supported(struct pci_dev *dev)
{
         if (!dev->ats_cap)
                 return false;

         return (dev->untrusted == 0);
}
EXPORT_SYMBOL_GPL(pci_ats_supported);

The iommu drivers (intel/amd/arm-smmuv3) all call pci_ats_supported()
before enabling ATS on a device. Anything I missed?

> 
> Yes this is effectively a security issue, but it is not really a CXL
> specific problem.
> 
> We might perfer to not enable ATS for untrusted devices and then fail to
> load drivers for "ats always on" cases.
> 
> Or maybe we can enable one of the ATS security features someday,
> though I wonder if those work for CXL..

Thanks,
baolu
