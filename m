Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235C389106;
	Thu, 24 Sep 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269272; cv=none; b=TUIngXqO/b/tBQvaNOpU9P00FuBzjoM97aGUxwRP7bjgSPuB2Gyz8wGqDreA8F4AYdJNotnYZkCXji/+w2YoAkIW8BBLQtN2+tt9HV9BKspqXI9lOpf4SWb0WoZ1zCalVAw1iYwIwUvKSEBk/o8N+EZeaDqSHAPB2Te/aZ5FOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269272; c=relaxed/simple;
	bh=Z6QzJKP3pf8IWxcTxVLAMkJMrnXGMTEb6PJxP0Kxoc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=my6zrVATUd2wtI61mDfa1rakLWzWuuq82FQJgilN9CCJS+GrDVBUIUcVPRzN7GN1rMi+ZU7cELTDjtYwQKXfG6FbEAiSU9KZsQ0iUT8/KxofzfPHb6lbSbPAZqg29YcxI+2lFqNH5SaIvd10YLKwmYpojMeUTrzNZKAkUMU0eXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHQnmLUI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHQnmLUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790269271; x=1821805271;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z6QzJKP3pf8IWxcTxVLAMkJMrnXGMTEb6PJxP0Kxoc8=;
  b=YHQnmLUI6WyunnTSt7hxXGovyALoONwhjMe4gLhsqw86QTBSYHJcjVOA
   DXVjr0ptkXJMJNuwaQ9u7TasN8ljFEknuMqnKpOQus2uOHFOUqKgmaJRO
   K2h/MZsxghPsWNMr0aBqSQFgvEFhTemd23sbJfPjdexzWqxVXXFsESL7G
   FNlbY/jFSSKau+yGD3i8le6uVdEZQ7MRZU20/IdiGD6NKKsD5Z3+H6vB2
   LPLiR9AipDpmvJLCUEzoVOxReqkkx37fWMUMMW53RwnuNt9jzdnjWr9Dr
   z4+6gY/HmNocdECDIE6+x+zrEqSoVwJGQriV9ra9rcMTyWB9NIi9xWsLh
   A==;
X-CSE-ConnectionGUID: 1PM15BBNSiqW7RFmHpAB2Q==
X-CSE-MsgGUID: 9wkbh4e2RoKrJpAyj8zW0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89955649"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89955649"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 10:01:10 -0700
X-CSE-ConnectionGUID: rYbqzNeMQw+Buo+qxqTRoA==
X-CSE-MsgGUID: +kJVQkejSSy80t7V6GLx2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273301655"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 10:01:08 -0700
Message-ID: <a8498db1-b400-4fd9-a9c8-dbf8a3d14dbb@intel.com>
Date: Thu, 24 Sep 2026 10:01:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/15] cxl: Share CXL port upstream PCI device lookup
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
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-3-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/22/26 1:39 AM, Srirangan Madhavan wrote:
> read_cdat_data() resolves a CXL port's upstream device to its backing PCI
> device. HDM cache updates need the same mapping.
> 
> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
> PCI device to make caller ownership explicit.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/core.h |  1 +
>  drivers/cxl/core/pci.c  | 23 ++++++-----------------
>  drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..983d7690c3a5 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -157,6 +157,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
>  
>  static inline struct device *port_to_host(struct cxl_port *port)
>  {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..bf7fc77626d9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -564,26 +564,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> -	struct device *uport = port->uport_dev;
> +	struct pci_dev *pdev = cxl_port_get_uport_pci_dev(port);
>  	struct device *dev = &port->dev;
>  	struct pci_doe_mb *doe_mb;
> -	struct pci_dev *pdev = NULL;
> -	struct cxl_memdev *cxlmd;
>  	struct cdat_doe_rsp *buf;
>  	size_t table_length, length;
>  	int rc;
>  
> -	if (is_cxl_memdev(uport)) {
> -		struct device *host;
> -
> -		cxlmd = to_cxl_memdev(uport);
> -		host = cxlmd->dev.parent;
> -		if (dev_is_pci(host))
> -			pdev = to_pci_dev(host);
> -	} else if (dev_is_pci(uport)) {
> -		pdev = to_pci_dev(uport);
> -	}
> -
>  	if (!pdev)
>  		return;
>  
> @@ -591,14 +578,14 @@ void read_cdat_data(struct cxl_port *port)
>  				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
> -		return;
> +		goto out;
>  	}
>  
>  	port->cdat_available = true;
>  
>  	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>  		dev_dbg(dev, "No CDAT length\n");
> -		return;
> +		goto out;
>  	}
>  
>  	/*
> @@ -625,11 +612,13 @@ void read_cdat_data(struct cxl_port *port)
>  	port->cdat.table = buf->data;
>  	port->cdat.length = length;
>  
> -	return;
> +	goto out;
>  err:
>  	/* Don't leave table data allocated on error */
>  	devm_kfree(dev, buf);
>  	dev_err(dev, "Failed to read/validate CDAT.\n");
> +out:
> +	pci_dev_put(pdev);
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..5dc2815d82d8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -34,6 +34,32 @@
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> +/**
> + * cxl_port_get_uport_pci_dev - get the PCI device for a port's upstream device
> + * @port: CXL port to map to a PCI device
> + *
> + * Return: A referenced PCI device, or NULL if the upstream device is not PCI.
> + * The caller must release the returned reference with pci_dev_put().
> + */
> +struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
> +{
> +	struct device *uport = port->uport_dev;
> +	struct device *host;
> +
> +	if (is_cxl_memdev(uport)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
> +
> +		host = cxlmd->dev.parent;
> +	} else {
> +		host = uport;
> +	}
> +
> +	if (!host || !dev_is_pci(host))
> +		return NULL;
> +
> +	return pci_dev_get(to_pci_dev(host));
> +}
> +
>  /*
>   * The terminal device in PCI is NULL and @platform_bus
>   * for platform devices (for cxl_test)

