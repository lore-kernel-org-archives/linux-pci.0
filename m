Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A202D781B;
	Tue,  5 May 2026 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018808; cv=none; b=lrNZX/om+G+R7kJPylqFTmSQoOj5vKeTAs3A0BqsjSKRlP6qU32om/JNDZD3Xc+fGsxtzmFp+mGzhXt+lqeBBFU9bB8R0eAL+Sl9vXiqBcwxs8CPOySLJC9LN5D02MYol+IQeqWUYpLi/WHWkK1lXt+4rKpVPiFgSan8LRu/les=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018808; c=relaxed/simple;
	bh=p/KdBFrY1pdWdMKYMGNY+10d1KOpGCh8qQK+ZFY12hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saJXoh2UPSoMzRuCcL0D6Ug8YV0JIq+oRNE4dL6IkPgJ1CD8Dh0aAj+l7fMEaBX/swHryN3EXovz9hdo5ARCV7qUo81VeMEKzO/7uanlxmaocU6IffxqVeNR/xSmEcNRRLVMNklXk2mYIlC/YK2PuevodpTCDQiTS2oG+MppURg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlrzOt96; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlrzOt96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778018807; x=1809554807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p/KdBFrY1pdWdMKYMGNY+10d1KOpGCh8qQK+ZFY12hE=;
  b=PlrzOt96DwT5lunKwXmPGfCbPyZjBjfAcMK1C02ssAPKLr7ebkuZef2+
   E/yF/J7wUS+TR2Gxm2xJ1//C9rztswP6EdXH+b3zR1NXbX66No0gDJdTl
   d3752CzN5R5+R8SFkuGZC9nnXfMhyJcPnUktRQUGqIVm9w/mt+77esFMp
   g46/SMmUHX81NZoVTNgwJWdkBeb4L7prGiiWb5LlsFMXDGASHQb0TIhSU
   Y3AkMHZgOLwixvtlu23tOEnppXbQF6N5xvmog6zzlq6cpC494Q1wd1I0s
   CHl5AzUxFSvdhlFupz1Y5wGOgZRCrzfW3zxx+Vhdp1K3wDMKaxyW8B+Jo
   g==;
X-CSE-ConnectionGUID: ZBwl6AktT9uSDbR5NEvGcw==
X-CSE-MsgGUID: 65saHWbnQLyS7Y6zHTxIVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90010580"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="90010580"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 15:06:47 -0700
X-CSE-ConnectionGUID: kj4oskQMTPaWmV6s0QHp/A==
X-CSE-MsgGUID: Od9QKWFKQ82l1QAxtSZ7zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="232814837"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.125.110.85]) ([10.125.110.85])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 15:06:44 -0700
Message-ID: <c5d40fc5-e8e0-4fa4-94af-4ea08c2f370b@intel.com>
Date: Tue, 5 May 2026 15:06:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 04/11] cxl: Rename find_cxl_port() to
 find_cxl_port_by_dport()
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, djbw@kernel.org, bhelgaas@google.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com,
 corbet@lwn.net, rafael@kernel.org, xueshuai@linux.alibaba.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-5-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260505173029.2718246-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 10:30 AM, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> find_cxl_port() and find_cxl_port_by_uport() are internal port lookup
> functions that search the CXL bus by dport and uport respectively, but
> their names do not make the lookup method clear.
> 
> Rename find_cxl_port() to find_cxl_port_by_dport() to make the lookup
> method explicit and consistent with find_cxl_port_by_uport(). Both
> functions remain static to port.c; the upcoming patch that adds the
> first cross-file caller will widen their scope.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v16->v17:
> - New commit
> ---
>  drivers/cxl/core/port.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c5aacd7054f1..b35a9016fc81 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1377,7 +1377,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
>  	return dport != NULL;
>  }
>  
> -static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
> +static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
>  {
>  	struct device *dev;
>  
> @@ -1390,8 +1390,16 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +/**
> + * find_cxl_port_by_dport - find a cxl_port by one of its targets
> + * @dport_dev: device representing the dport target
> + * @dport: optional output of the 'struct cxl_dport' companion of the @dport_dev
> + *
> + * Return a 'struct cxl_port' with an elevated reference if found. Use
> + * __free(put_cxl_port) to release.
> + */
> +static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
> +					       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> @@ -1399,7 +1407,7 @@ static struct cxl_port *find_cxl_port(struct device *dport_dev,
>  	};
>  	struct cxl_port *port;
>  
> -	port = __find_cxl_port(&ctx);
> +	port = __find_cxl_port_by_dport(&ctx);
>  	return port;
>  }
>  
> @@ -1893,14 +1901,14 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, "CXL");
>  struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
>  				   struct cxl_dport **dport)
>  {
> -	return find_cxl_port(pdev->dev.parent, dport);
> +	return find_cxl_port_by_dport(pdev->dev.parent, dport);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, "CXL");
>  
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport)
>  {
> -	return find_cxl_port(grandparent(&cxlmd->dev), dport);
> +	return find_cxl_port_by_dport(grandparent(&cxlmd->dev), dport);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
>  

