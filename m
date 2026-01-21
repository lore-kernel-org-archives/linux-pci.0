Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB644103D;
	Wed, 21 Jan 2026 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034759; cv=none; b=Ko3BxVqnIryXOoHR9PaNlTZJY70FPaQvGnT/Ca+8A0OEkChTwW1cTyQ9o5rV75pxNDFYX38vt7Vw2BE44fKV7jaxQAQ+6FrtP1ALg9rxrpW7/YFYoe5qog6h+69XPdECvKG+hV7S5wVYzN68XHE1SOkIT5LRtOMfdsRHkg3Pgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034759; c=relaxed/simple;
	bh=CANHRjZzXJnK31dIt3IF+oh9BpdgBGk7iy4AtE1Ext0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5NovssbsAisF2ul3saY1Py74tA5nVGLE3/qu0wrW8y/6aQdtjHO49EWmhoWYlQ4Pz8KHM21InzrHJKlr7icrMJl6DrEzdmOgu4AIq72izWLRZrtYBeS5od7h84MBFpiWtKjN/TNNhui0S+kI9/Xmd1qw/T+/Y1IXYcVjDnmLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R59Mlvcf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R59Mlvcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769034756; x=1800570756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CANHRjZzXJnK31dIt3IF+oh9BpdgBGk7iy4AtE1Ext0=;
  b=R59MlvcfUPPLLS2kVzsN44Z/ssXMAccHGV6so774iRjaq7xso1szrCKi
   uNBpVocx2H1o6KGidW5kv+I+ko7RLZG9jwl9oX3zlGvuE5XzQwxxOKqrM
   tI6Pr40paKaCEtyfdxg/LiWhH9St8ty6I57+tVYRvwMsGtJpOGgZp4TCR
   hxTmvvl9V4m74M2c0QKWwZybIO6eeLDP8DWqxQa8rw0aaAiugw8suSydy
   1tSRQ8g33Yt/qHLE5U+npbirOoP1UBxVV809JvctRuN76cm0dWmr4AT9O
   Y0b0DYv4WCxP2L6k7oAj+5Ex5BJoIRkQ0B5xEHCERZWVTs1WEd56fWgrY
   A==;
X-CSE-ConnectionGUID: c4bnDXpFSuSVkK/2w+btJQ==
X-CSE-MsgGUID: UhVYl+99T/KW2MUUR+4NmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="87686366"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="87686366"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:32:30 -0800
X-CSE-ConnectionGUID: R4HaSctiQ/uIwh/Vixe5ng==
X-CSE-MsgGUID: ExJTtxY8SweOsGjgsnzufg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="205698725"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.97]) ([10.125.108.97])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 14:32:28 -0800
Message-ID: <a0719ccc-4f2e-4b17-9361-a0759b1fca08@intel.com>
Date: Wed, 21 Jan 2026 15:32:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] PCI: save/restore CXL config around reset
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
 rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 huaisheng.ye@intel.com, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc: vaslot@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
 vidyas@nvidia.com, mochs@nvidia.com, jsequeira@nvidia.com
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-10-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260120222610.2227109-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/20/26 3:26 PM, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Save PCI and CXL configuration state before cxl_reset and restore it
> after reset completes. This preserves DVSEC state alongside standard
> PCI state and avoids losing reset-sensitive CXL configuration.

Instead of putting dependency on the cxl core, maybe just move the code in the previous patch here since it's just a few lines of config read/writes. But an explanation of why the DVSEC needs to be preserved on the device regardless of whether a driver is present is needed in the commit log.

DJ


> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/pci/pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 18047c893b0c..0bc85c4cc5fd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4960,6 +4960,7 @@ static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
>   */
>  static int cxl_reset(struct pci_dev *dev, bool probe)
>  {
> +	struct cxl_type2_saved_state cxl_state;
>  	u16 dvsec, reg;
>  	int rc;
> 
> @@ -4989,6 +4990,11 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
> 
> +	pci_save_state(dev);
> +	rc = cxl_config_save_state(dev, &cxl_state);
> +	if (rc)
> +		pci_warn(dev, "Failed to save CXL config state: %d\n", rc);
> +
>  	/*
>  	 * CXL-reset-specific preparation: validate memory offline,
>  	 * tear down regions, flush device caches.
> @@ -5004,10 +5010,16 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
>  	if (rc)
>  		goto out_cleanup;
> 
> +	pci_restore_state(dev);
> +	rc = cxl_config_restore_state(dev, &cxl_state);
> +	if (rc)
> +		pci_warn(dev, "Failed to restore CXL config state: %d\n", rc);
> +
>  	cxl_reset_cleanup_device(dev);
>  	return 0;
> 
>  out_cleanup:
> +	pci_restore_state(dev);
>  	cxl_reset_cleanup_device(dev);
>  	return rc;
>  }
> --
> 2.34.1
> 

