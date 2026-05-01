Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602C2D8DC2;
	Fri,  1 May 2026 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660575; cv=none; b=hKQEVPB3+KYddbc1k8f6Ip0zppXDFfPf8h8Wmaz5fQfJoP82aaDZpdN7fj7SgL1tGpNUlWd4xTeR8yfw8OJU4e8Usur3K76BjWCoVwe9wPbSTV+9v398P+R1q9oDFAZihYOiuW84OZFl3EWTAwQc/czrvzgFHci/6RPJDf7WsOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660575; c=relaxed/simple;
	bh=dqWzN3WzUs/2xEA/hJZyavoFvPEMuufxcbTgcr0EqdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esPOG6jB3AJC9yWE3rRs+38UTDTzP6SR0fpCDNXOjUSGC1my1Vj9GgyBqmmy2PwRVjWNo1X0IsRTG7vvdev4Ue3g3rgff45QbwKBGjgdkORTXL/o3m3pAsUe+xtVnfzO6JqKij+Rjt18SlfM+DrazqgY6wwxWYvIdNPPK4iwgDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I20yWzME; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I20yWzME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777660573; x=1809196573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dqWzN3WzUs/2xEA/hJZyavoFvPEMuufxcbTgcr0EqdM=;
  b=I20yWzME1nz0kiLO7LJjlm4lDzibugIp8FLqhnNfBISaR1za1ArDLJwe
   2oI6PfPbZv/ksZb75ASkdHtmnxtW9/D+OE4g+pMYbQaZ3CuEoAh0qW9Io
   bKZhxAPITecXDtfbHKqenet2eN6obfCorvfRjR+Wrc+q38aTJ7ODO3O7K
   IgKrAR4lp4zUsmeCTwuvCCquVvtB9sA7JIRtt8cvuVN0+ipVo5xC0a0xa
   kUvAk+QaLfwBNbec9iJoll/wr28PGPIS7b29vAbOdvBY5/g/vpCxW+ZBM
   szvvP4wspG+e2EpojT/NRKfvE15d0AqA0GHToEhlzAQiaa3JJG6E0VZqH
   A==;
X-CSE-ConnectionGUID: XzGn19YySq2pcEiJgH/A5A==
X-CSE-MsgGUID: rX5wYDzETs6rsrx0iaalyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="89724017"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="89724017"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 11:36:13 -0700
X-CSE-ConnectionGUID: Eotnzz2UTJKwfUIHB/PKHg==
X-CSE-MsgGUID: 6Rp0cYAFSBSpwBRsOtmaPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="236716382"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.150]) ([10.125.109.150])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 11:36:12 -0700
Message-ID: <180be663-7834-45ee-8a82-7e9b8a196820@intel.com>
Date: Fri, 1 May 2026 11:36:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/CXL: Allow PM Init to complete on cxl_bus reset
 if ACS SV enabled
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Dan Williams <djbw@kernel.org>
References: <20260428182454.464655-1-fabio.m.de.francesco@linux.intel.com>
 <20260428182454.464655-2-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260428182454.464655-2-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 11:24 AM, Fabio M. De Francesco wrote:
> CXL r4.0 sec 8.1.5.1 Implementation Note describes a scenario in which
> issuing a Secondary Bus Reset on a CXL Downstream Port leaves the
> Port Power Management Initialization Complete bit unset when the PCIe
> Access Control Service (ACS) Source Validation bit (SV) is enabled on
> the Downstream Port. The spec states that another SBR alone will not
> facilitate recovery and shows a software recovery sequence.
> 
> Implement the sequence by extending cxl_reset_bus_function() to save,
> clear, and restore ACS SV and Bus Master Enable (BME) on the Downstream
> Port around the SBR with the use of helpers.
> 
> The wait inside pci_bridge_secondary_bus_reset() covers the 100 ms
> referenced by the spec. The helpers return when ACS SV is not enabled on
> the Downstream Port.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/pci/pci.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc00090..047d3b4508a5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4930,10 +4930,55 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return rc;
>  }
>  
> +static void cxl_disable_acs_sv_bme(struct pci_dev *bridge, u16 *saved_cmd,
> +				   u16 *saved_acs_ctrl)

Maybe you can call this 'cxl_bus_reset_prep' and the restore one 'cxl_bus_reset_done'?

> +{

Should you return int and check if the two ptr passed in are valid?

> +	if (!bridge->acs_cap)
> +		return;

Returning here and the output parameters are not set. That is a problem when you try to restore with invalid values. Maybe -EOPNOTSUPP needs to be returned. Errno from this function should prevent the restore from being called.

> +
> +	pci_read_config_word(bridge, bridge->acs_cap + PCI_ACS_CTRL,
> +			     saved_acs_ctrl);
> +	if (!(*saved_acs_ctrl & PCI_ACS_SV))
> +		return;

What is the caller suppose to do if PCI_ACS_SV is not set? Should you skip restore later?

> +
> +	pci_read_config_word(bridge, PCI_COMMAND, saved_cmd);
> +	if (*saved_cmd & PCI_COMMAND_MASTER)

If all you care is master bit enabled, maybe just write back a bool 'master_en'.

> +		pci_clear_master(bridge);
> +
> +	pci_write_config_word(bridge, bridge->acs_cap + PCI_ACS_CTRL,
> +			      *saved_acs_ctrl & ~PCI_ACS_SV);
> +}
> +
> +static void cxl_restore_acs_sv_bme(struct pci_dev *bridge, u16 saved_cmd,
> +				   u16 saved_acs_ctrl)

static void cxl_bus_reset_done(struct pci_dev *bridge, bool master_en, u16 acs_ctrl)

saved_ has no relevance to the function itself.

Come to think of it, why not create a local struct and pass that in as parameter for prep and done functions? That way in the future if there are other stuff that needs to be done, this can be more versatile.

struct cxl_reset_ctx {
	u16 acs_ctrl;
	bool master_en;
	bool acs_restore;
};

This way you can also set 'acs_restore' on completion of the prep function. And in the done function, you can check and return early if it's not set. That takes away the messiness of returning errno in the prep function and then needing to determine if you need to call the prep function or not.

DJ

> +{
> +	if (!bridge->acs_cap || !(saved_acs_ctrl & PCI_ACS_SV))
> +		return;
> +
> +	pci_write_config_word(bridge, bridge->acs_cap + PCI_ACS_CTRL,
> +			      saved_acs_ctrl);
> +	if (saved_cmd & PCI_COMMAND_MASTER)
> +		pci_set_master(bridge);
> +}
> +
> +/**
> + * cxl_reset_bus_function - SBR for a child of a CXL downstream port
> + * @dev: child device whose upstream bridge is a CXL downstream port
> + * @probe: if true, only check whether the reset is supported
> + *
> + * Issues an SBR on @dev's parent bus. Temporarily sets the CXL Port
> + * DVSEC Unmask SBR bit across the reset. When ACS Source Validation
> + * is enabled on the bridge, also temporarily clears Bus Master Enable
> + * and ACS Source Validation, per CXL r4.0 sec 8.1.5.1.
> + *
> + * Return: 0 on success, -ENOTTY if the reset cannot be issued, or an
> + * errno from the reset path.
> + */
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
>  	struct pci_dev *bridge;
>  	u16 dvsec, reg, val;
> +	u16 saved_cmd = 0, saved_acs_ctrl = 0;
>  	int rc;
>  
>  	bridge = pci_upstream_bridge(dev);
> @@ -4957,6 +5002,8 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		return rc;
>  	}
>  
> +	cxl_disable_acs_sv_bme(bridge, &saved_cmd, &saved_acs_ctrl);
> +
>  	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
>  		val = reg;
>  	} else {
> @@ -4971,6 +5018,8 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
>  
> +	cxl_restore_acs_sv_bme(bridge, saved_cmd, saved_acs_ctrl);
> +
>  	pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }

