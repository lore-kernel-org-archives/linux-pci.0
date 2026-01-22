Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D33659F8;
	Thu, 22 Jan 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094720; cv=none; b=lkmmCv1AWXdtbzvRXFhZNTO+naXNljICSTW39hvHUj0XBtzWAp8/xCHMVYWRelxPQ9DnvIMhIdi9qH2z3e1w0cu7HLfuX8HXerd7wp8qArIYHy8R3cpDaMe9d1Aax4ZGDdBdlPwgJLnxNufTMoigYQFeWRvIZB85flfdYqMZWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094720; c=relaxed/simple;
	bh=ATCHQ+yR/thUppfjEyNiKCY9/rWKeCSkn1csmjKAnjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6aBnAsgvJHsk3mUQNVwjLFWtDR7zqSuhPrVYgEnJB6BEmePHuACIyuiJEeGmaBiVJRlu0WG1b+JUb/xyKu+uf/hRpFK1mnE5QebPWO1aI6gMpnWhuiphJkTnV5gdXQm1TfAyhq+d7AzGHfd/SuwyYnN04L9TiciGcTHgTquPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTMvV84y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTMvV84y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769094717; x=1800630717;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ATCHQ+yR/thUppfjEyNiKCY9/rWKeCSkn1csmjKAnjQ=;
  b=UTMvV84yGWRnZBEzSEAmm7DB8IGuT6OCOGJmdjGyojhfAPCUYMgFUC0X
   0oo2emPJ2oOtAfqm6zPCGojhsTn/Bbi8RLi4nWKZS4TxojTjHinMP7aWT
   zvU2jQtNLVJDrfsB4iDVleS4tViyE6kRQrvQVNbAOJwoNxaB4etC0Qnzm
   0XOIrD2xg60ob0dH+i9mRPx8cd9xDfyAAd10QP6rYeTbQ7Ex3QeiNd0Ch
   qPSoFh62BHE3FfI99oQdDEZkdTRAenh62DE12ME/1iBILIMgUjIwHYvSx
   b9fljM/q35X6X18WH+aurjQm2yajsODWfpZ6px3LF5CEhYxiIvGyWnl8x
   w==;
X-CSE-ConnectionGUID: LYuWezpoQCCmkRC7GQvOKQ==
X-CSE-MsgGUID: ktCXJyAITd+ttM7BB5TJJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81450941"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="81450941"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:11:56 -0800
X-CSE-ConnectionGUID: r2hdUEZ0QPasuYS+FSWPAQ==
X-CSE-MsgGUID: bnbcfLRvQRGAT3gsGnQHWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206005830"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.157]) ([10.125.108.157])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:11:55 -0800
Message-ID: <ed883f8d-dad7-4aa3-86f6-f96f8250bf56@intel.com>
Date: Thu, 22 Jan 2026 08:11:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] PCI: wire CXL reset prepare/cleanup
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 "rrichter@amd.com" <rrichter@amd.com>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>,
 "huaisheng.ye@intel.com" <huaisheng.ye@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Vishal Aslot <vaslot@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Vidya Sagar
 <vidyas@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jason Sequeira <jsequeira@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-7-smadhavan@nvidia.com>
 <8b974b31-3ac7-4158-bb25-497a254296bb@intel.com>
 <C109CA60-D346-4EFE-8BC3-C3204C8DED94@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <C109CA60-D346-4EFE-8BC3-C3204C8DED94@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/21/26 7:17 PM, Srirangan Madhavan wrote:
> 
> 
> ﻿On 1/21/26, 2:14 PM, "Dave Jiang" <dave.jiang@intel.com <mailto:dave.jiang@intel.com>> wrote:
> 
> 
>>> Wire CXL reset preparation and cleanup into the PCI CXL reset path.
>>> The flow now validates/offlines regions, performs teardown and cache
>>> flushes, then releases the lock on completion or error. This keeps the
>>> common reset_prepare flow intact while adding cxl_reset-specific quiesce logic.
>>
>> Can this be moved to the ->reset_prepare() callback of 'pci_error_handlers' rather than directly wire it into PCI core code? I don't think we want build a
>> dependency of cxl core to the PCI core.
> 
> I understand the current implementation is not ideal. But I opted not to insert the call into ->reset_prepare() as pci_error_handler would be invoked for all the other reset methods (cxl_bus, FLR, etc).
> Would it be okay to include the same reset prepare steps (i.e region teardown, cache flush, etc) in the common reset prepare? 

See my suggestion reply against patch 10/10. Maybe we shouldn't be going to PCI reset path.

> 
> Thank you.
> 

