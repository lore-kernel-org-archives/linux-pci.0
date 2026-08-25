Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96684223DFF;
	Tue, 25 Aug 2026 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787689938; cv=none; b=M92JiFo+ynRVT+fMsIQRCUsTzBfDRkdm3M7rMT7VanW8O4nId7nJLV4WqQ1ypVL7ipgQZasUMIC4qzLIGcFn0XuYsRU075j4fhsmu7Jk/ZoUSVVXeJ0+7ntU9h3hsjBeBTrYmWNaaD5ZcC9c4Spn9mhMu9SsqEm6eZUtGFSrlr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787689938; c=relaxed/simple;
	bh=zInRDHH5JXAV2MYOFMLW0uweBzSOuIh0YeeaHf9J/m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpRnkt/gJ9jz0L2eTB2Cf+I0NPEt8HgHmSfx1/QnUCjZNQTWmnBsQs695MKTCTSthq/1iZcIBWhFvMvNj4r5G/rIB+7VjcfK2Gj8MgmARV8TBKhlHytSlQ1Sw0UD1y4wAfurwGjuse6LtTYJ7jBFylfcKZ5H8iWK34WOMlfH/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2gi6As2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2gi6As2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787689936; x=1819225936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zInRDHH5JXAV2MYOFMLW0uweBzSOuIh0YeeaHf9J/m4=;
  b=k2gi6As2mkN5cMGd2upib0Ri+t//2fG6lbhbD77/yk5qT0hgNrWC4wEh
   PslXPppTEsltxfzeh+l4BZ09Ycq1H18csQxqUKIqVj426GYBF2kZ7r1Pd
   zbJS+L4H7IguL2WeWUh3o9mi/iRkZKXQEZoRshCXc2eQx8NJTxFQUDUkJ
   4VwwypLQfGmhctDX+mHX7Ls06ohCXT58iGqpM7Cgi0qcgFsvFVsi/Pct1
   RjU9C+SlK53oKVXwoli0uA6ficegJWHaAOs7g67+ZEMg0rEJ1XNG9tuhk
   ZDVj1QnnmoHhz0ts6h0g9QaM13aGozS6FZ6NOi0u2GgdkxyPsE+pcYSt+
   A==;
X-CSE-ConnectionGUID: V7dWd6rfQQCAoNl2fBtTtw==
X-CSE-MsgGUID: uMssCjYkQ9W/MD0h344g7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="113703170"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="113703170"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:32:15 -0700
X-CSE-ConnectionGUID: bEihwMWuQaKmNCQoISzhxQ==
X-CSE-MsgGUID: fbvABTmQQ5qtj/jzR5ZsRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="271177728"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 13:32:14 -0700
Message-ID: <05b84967-fe76-4a69-9b36-ae958946e244@intel.com>
Date: Tue, 25 Aug 2026 13:32:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/12] cxl: Reject CXL Reset on multifunction devices
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-9-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260804192958.1823952-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/26 12:29 PM, Srirangan Madhavan wrote:
> CXL Reset can be exposed as a PCI function reset method only when the
> reset is function-scoped. PCI reset-method probing runs during
> enumeration, so walking sibling functions there can race with functions
> that have not been added to the bus yet.
> 
> Reject multifunction devices for now instead of trying to infer reset
> scope from sibling state. Systems that can prove a multifunction device
> has function-scoped CXL Reset can be enabled later.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/resource.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 6d4528f77c53..464ca9bdae05 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -979,6 +979,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (dvsec < 0)
>  		return dvsec;
>  
> +	if (pdev->multifunction)
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
>  

