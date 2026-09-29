Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392055294B
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709893; cv=none; b=knAWIcGixyCQAJoc0WaU3rL6wgEXM3buLqkDatO/STA3PgxjoUBxEDB9ahAxDGbJrLrUCe5+E42nqlAtqKQz42W2XQjvUphQtokwLcIT0HBNs6X2e5VsjVKq2zN5/AdN2wqxrNMoiBPLiN//NpDC25HIDTWB5rI1XWWJ+ibTWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709893; c=relaxed/simple;
	bh=TLlPtwM9+jBoyZmH2gCTAvCqM903Ko9m2ipWHJKM4D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUIkLXBz3mNvrlhZchgrR9elm9rZFlt2xam5aOnOQAPCqrqTJdVwtbeE6YXh4PYGkyKePLQ7gC9gztcM5oipH7I9Z4c7P5SHEVn5kpQ1BZ9f3+SIWviILCsyyy33jlsiXAiB/VHXheGWuDzb5B6qdh3TyBDaL/7YEtX6Y0QuWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjiaCt/1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjiaCt/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790709891; x=1822245891;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TLlPtwM9+jBoyZmH2gCTAvCqM903Ko9m2ipWHJKM4D0=;
  b=DjiaCt/1AHFCK1QzQBRcijl9bVMLLQ2KBf+9yS9143jSMWLlNKafs668
   fspVMUa36YRxkvIt63tKB7FSW/F8h3O1xCs64NLTivT6bvutLyjbV28UT
   54vX7tX4fO1f9lIpWx1in9ldFAqv6xYW1KuRmsBo+3KNd9p+ZHRp4RJp2
   B8MOqGSV1/ZTQbztrbJp4CiCL+8qQflSGWHTkmo19DBeyRoyCXQy2SDCq
   SQGTpPSDzTc5OuJLfGYE2csJkFDnSCY+S+zaYPYE7YfmvaxcWI+mmPjsR
   PN8fjvWxvwh5N/c/vVEWQyOGmlM10NDXRmdSelWjYTFcfv4uIYglK6TXe
   A==;
X-CSE-ConnectionGUID: Nc1OcvzySWmmysMvOGNMvw==
X-CSE-MsgGUID: Wa5Mg1ltSGCUQ7wrPguPOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102112637"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="102112637"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:24:50 -0700
X-CSE-ConnectionGUID: RkhCk2BbSSeE/Rr+qQDZ/A==
X-CSE-MsgGUID: h2sXK3lORbWX61B578fp4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="278655597"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:24:51 -0700
Message-ID: <b857cc94-2624-4478-ae06-a3512dde948a@linux.intel.com>
Date: Tue, 29 Sep 2026 12:24:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] PCI/AER: Drop AER native check from
 handles_cxl_errors()
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>,
 Yury Murashka <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>,
 linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
References: <cover.1790531238.git.lukas@wunner.de>
 <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> Drop a superfluous call to pcie_aer_is_native() from handles_cxl_errors().
> 
> The call is superfluous because the function is only called from:
> 
>   aer_probe()
>     cxl_rch_enable_rcec()
>       handles_cxl_errors()
> 
> ...and aer_probe() is only invoked if an AER port service was instantiated
> in get_port_device_capability(), which is conditional on:
> 
>   (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>    pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>   pci_aer_available() &&
>   dev->aer_cap && (pcie_ports_native || host->native_aer))
> 
> ...and the last line of those conditions is equivalent to
> pcie_aer_is_native().
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/pci/pcie/aer_cxl_rch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index e471eefec9c4..9cc2d5749b9d 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -87,8 +87,7 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
>  {
>  	bool handles_cxl = false;
>  
> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> -	    pcie_aer_is_native(rcec))
> +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC)
>  		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>  
>  	return handles_cxl;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

