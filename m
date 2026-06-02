Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB59232A3E5;
	Tue,  2 Jun 2026 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423966; cv=none; b=gqBQrK5sLuwch3I5MDa5ghfskQ7obF85Zur0G4r72oAL15kk5bFEslhsrwHM7YYbqW1N1LQDlDVw3R9nCHMSS3PlHqSaJmscGZ/iOZc6YdAAITJwVt7uGbRP5SmJXsWgeIHqaf3bNkFVi0/P6rbA3rAOd6GGagUTI2O12nd4JO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423966; c=relaxed/simple;
	bh=IFRDbioFrCISGrGSj3nN4AnKWbV8EKm1kjCrdO+x5i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZAAJQIWDlHxwFCGDAof/Vc5XuJuXRNKfyUPUJTeYUckgYeMU7L/jZknoB04fHSPI5TPfnho1lr98SeTuqNyfw0EgxbwyExAEnGqPBlyUiUiMREqKqGyCLhnkhfQ81jE3NXbhU/KYEV3JnLHqbOichYtSU1UvJifofTMmmXW8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kExEhRNV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kExEhRNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780423965; x=1811959965;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IFRDbioFrCISGrGSj3nN4AnKWbV8EKm1kjCrdO+x5i0=;
  b=kExEhRNVD9KvF1QUnGkn7iRNGZDOqFhEre1WlG7qbBgjn78A2ruITto7
   vVPSWR38J91hjclkUhT2ABe9mQOwq1ypt23OtyNsDFp2DaWcBbWy4IQpV
   MkgpxNpjxWoOZJ5nt6vWZh5VbMNKwCpjC8yMr+5j/9wj58jFW/caoJFDw
   Rt0xuLB7heYr7EAu8QYo2NFrhzWDbm6YKnsHA1CmsoeOCL9zMtUMTmkO8
   7NBW1cL/zCtecV+1ZTG3Dqm8KPMkrUrWG57AFDKiNWUbQkMnAvgD9r+mk
   TxV7RzvxQU2walhhLCT4z5yFqmBI9cUwW3xXiYN6rz4YXqx0gR9+qWax9
   g==;
X-CSE-ConnectionGUID: p6xkbeNTTASSPilCAZJxcQ==
X-CSE-MsgGUID: U/1jBsdeQwiT0niigd1t/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81250059"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81250059"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:12:44 -0700
X-CSE-ConnectionGUID: pmgZQr/0ST66+Q6hWzO60Q==
X-CSE-MsgGUID: P3AgbKtIRZ+ufTqBgJiT+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243135761"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.56]) ([10.125.108.56])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:12:43 -0700
Message-ID: <79fbf3fc-81ce-45c3-9889-be4c3867bfb8@intel.com>
Date: Tue, 2 Jun 2026 11:12:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] cxl/hdm: Add helpers to restore and commit memdev
 decoders
To: Richard Cheng <icheng@nvidia.com>,
 Srirangan Madhavan <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-2-smadhavan@nvidia.com> <ahghCNiphEn6X8gn@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ahghCNiphEn6X8gn@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 4:06 AM, Richard Cheng wrote:
> On Thu, May 28, 2026 at 08:31:46AM +0800, Srirangan Madhavan wrote:

<-- snip -->

>> +static int cxl_restore_dvsec_range(struct cxl_memdev *cxlmd,
>> +				   struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_decoder *cxld = &cxled->cxld;
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	u64 base = cxld->hpa_range.start;
>> +	u64 size = range_len(&cxld->hpa_range);
>> +	u32 lo;
>> +	int dvsec = cxlds->cxl_dvsec;
>> +	int id = cxld->id;
>> +	int rc;
>> +
>> +	if (!dvsec)
>> +		return 0;
>> +
>> +	if (id >= CXL_DVSEC_RANGE_MAX)
>> +		return 0;
>> +
>> +	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(id),
>> +				    upper_32_bits(base));
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(id),
>> +				   &lo);
>> +	if (rc)
>> +		return rc;
> 
> Here pci_read/write* returns positive values on failure, and you pass the value up.
> Eventually surfacing through cxl_reset_store to userspace where sysfs thinks positive
> values as "bytes written".
> 
> I think this might need a fix ?
Great catch! Not something I ever thought about before WRT pci_read/write*. I think to get errno it needs pcibios_err_to_errno() wrapper called. The sysfs exposure definitely needs to be audited.
