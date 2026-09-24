Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2683E3D80;
	Thu, 24 Sep 2026 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268926; cv=none; b=FuBWLDLUEx3YCzgBlheUzwKkWbQFoniwVUeFNnGtujI9UlEc551sTvvGlwosAocSc5HjZD6+iDiIraX+HRuzfY5E5ssNunJQB91bYzJOVP4mtYViB4clLn2gdhc6tH+1RYIUzPt1iMKWOEyyl+eme7y+9TXY3+pu/QLmjItjCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268926; c=relaxed/simple;
	bh=6dQdmiQfmu7E7lPMmHE3dRzgnkhHdkJC+aa88UFF+ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZSIyLDSfH3fbR0msXj/DpfuqYoz76R1FJpZbiv+xdtwv5l4XRCENzNAjsSkUhMi1wLFBBAQkz873AqfMUu0gSAooEgPkZWUK2WBBnUooR4ka4mEH2LxeT2gSV9HoEZVZpH4mXFbGLLCXw2BJe7NNCArxkx+h9QBbTa1H6GmOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GaWiUqyD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GaWiUqyD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790268923; x=1821804923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6dQdmiQfmu7E7lPMmHE3dRzgnkhHdkJC+aa88UFF+ms=;
  b=GaWiUqyD6PcHFPJse9YRQ1JOrADGNJitM6PUs9Gy6TeZVWGqWPZ/I8yd
   GvvcOhnntWoaQdgvLbufwqikcjwebCGGMFfJgavj/9pEAOzbU4613rQ/T
   Xg+5Nx6BKRerggciS80gKOueVft0ic+6nNfiH667Tk8pyf4LZWtpyjVXZ
   RMzRptLJtkmmCqPpZF1gXooTYC+FcGO3yuEckvRZR45tAbIlwdfGnf8n4
   lRKNrlKUgjTOFi2bZFudIGX5mVnzEkMHc58EdwG5dtr6c+cmmkLpHDNnc
   xwLOoH2KRWEZLG5CWEfig/gxKRTKErkXwTzY3X0mqwB3l4JBVOgOLuQdN
   w==;
X-CSE-ConnectionGUID: bR1K+xWBQrqHUOCWrNP+OQ==
X-CSE-MsgGUID: Vstpg77NT4uJCjxJ8H0tkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89955135"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89955135"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:55:22 -0700
X-CSE-ConnectionGUID: SXwGW+N/ScOhy8p68GY4FA==
X-CSE-MsgGUID: Py9uXdteTUC0FwYXpeiF9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273299531"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:55:21 -0700
Message-ID: <fb513893-7c6c-408c-811f-1eae20f0436c@intel.com>
Date: Thu, 24 Sep 2026 09:55:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/15] cxl: Share CXL port upstream PCI device lookup
To: Jonathan Cameron <jic23@kernel.org>,
 "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-3-smadhavan@nvidia.com>
 <63e196f0-7175-4421-8677-5ae30cbfbacf@amd.com>
 <20260924022156.5d376e91@jic23-hlaptop>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260924022156.5d376e91@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/26 6:21 PM, Jonathan Cameron wrote:
> 
>>>  
>>>  	/*
>>> @@ -625,11 +612,13 @@ void read_cdat_data(struct cxl_port *port)
>>>  	port->cdat.table = buf->data;
>>>  	port->cdat.length = length;
>>>  
>>> -	return;
>>> +	goto out;
> 
> Confusing flow, just duplicate the pci_dev_put()
> 
>>>  err:
>>>  	/* Don't leave table data allocated on error */
>>>  	devm_kfree(dev, buf);
>>>  	dev_err(dev, "Failed to read/validate CDAT.\n");
>>> +out:
>>> +	pci_dev_put(pdev);  
>>
>> I'd use __free() instead of introducing another goto, especially since this is the ideal
>> use case for it. There should be a free action defined for this, but I can't remember what
>> it's called.
> 
> Don't do that.  See the guidance on where __free should be used in
> cleanup.h.  There are places where it 'could' be used but we don't
> because it adds fragility under potential code refactoring.

Ah yeah because the devm_kzalloc() forcing the goto. Essentially don't mix goto and __cleanup(). 
> 
> Jonathan
> 
> 
> 
> 
> 

