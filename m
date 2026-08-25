Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930642F6FD;
	Tue, 25 Aug 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670043; cv=none; b=vDIH9/l+qWD1WaLfa7mI8pCOzyMeMfDJ7KeEz1y51OWsFHZQ6DAgllbMnXRokFFsp3rf9xI/KPHl1q2X2k8EpkBLVYZRMV3DpdA2SBz0hmWiH26eIpiX5hnpDjbBprQTFULBPznEMxLL5KHfV0uVq6MLrDmFW+g3rsc1xP7TnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670043; c=relaxed/simple;
	bh=djbm7y0+FkCYYm4NIgaW/JaD/0F91KLSwmaHyoh0/C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/ujOAPNWC48foEhKVJnnSDngtllW8ZgOy8M6rwG1v5kgLnzQzWwbbdw5WKKgy26aX/u3hFic0xDFuk8kkWLz2nMOsjYp9O/X0EHheSqvo5dgfYrFVJXrT0VCBaDwaGPqrIzUME2TfNyW1wDBsNyqkslAfSscdBK4HiXrI/zZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDCD2FRN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDCD2FRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787670035; x=1819206035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=djbm7y0+FkCYYm4NIgaW/JaD/0F91KLSwmaHyoh0/C4=;
  b=cDCD2FRN0LdoqtvITxj+7kLEF9zdruS3q8+Ef2jKK7xiX8PIScSe6niq
   5JKF2diuIx1aA11qKKMkrsyYu0eOFXykX9ZG+PiqbVH+jcHOVpTihcQrg
   9FWWtDwuFDNNg2gyv1p6/EdnuAB5TUUYgvHZ1lsNdGDRSUJ77kgYfB/Ik
   XGjeaEZ78Xx2mHmg+1To0hvOvDEt3jHnvIITYRM/sRKAduLuSehdcOPVW
   TGN8umKDuygBp1ofgRXJObPbPMwR6tpVe4qGm7wf/ZQKzo2jdU+FqU0iS
   ATe/AUfX3adfMjGG8C0nW4XgxrMRPHcjuzGFWsH7a7z9IAOPmZK8n12Pd
   w==;
X-CSE-ConnectionGUID: kKPbjLRuQHCytTuXJN8W7g==
X-CSE-MsgGUID: sHl21hnnTKuGNb5+2iamSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98729120"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="98729120"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:00:26 -0700
X-CSE-ConnectionGUID: enzCpgCXQvecHW8utHpUhg==
X-CSE-MsgGUID: 458F323BQBu2pmtIxZsyEA==
X-ExtLoop1: 1
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:00:24 -0700
Message-ID: <55f13d5d-c222-4e7d-8666-4f2b8d81d396@intel.com>
Date: Tue, 25 Aug 2026 08:00:23 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/AER: Export pcie_aer_is_native() to AER
 namespace
To: Raag Jadav <raag.jadav@intel.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 iweiny@kernel.org, ming.li@zohomail.com, bhelgaas@google.com,
 rodrigo.vivi@intel.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 lukas@wunner.de, riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com
References: <20260825054312.1319951-1-raag.jadav@intel.com>
 <20260825054312.1319951-2-raag.jadav@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260825054312.1319951-2-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/24/26 10:42 PM, Raag Jadav wrote:
> pcie_aer_is_native() was originally exported to CXL namespace in commit
> 49f776724e64 ("PCI/AER: Export pcie_aer_is_native()"). This is a bit
> misleading as the symbol or its underlying implementation does not reflect
> any distinguishable CXL functionality.
> 
> Change this and export pcie_aer_is_native() to AER namespace, which is
> cleaner and more suitable for its implementation.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

For the CXL part,
Acked-by: Dave Jiang <dave.jiang@intel.com>

You'll need Bjorn's ack for the PCI portion.

> ---
>  drivers/cxl/port.c     | 1 +
>  drivers/pci/pcie/aer.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 99cf77b6b699..00f675163b3d 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -340,5 +340,6 @@ module_exit(cxl_port_exit);
>  
>  MODULE_DESCRIPTION("CXL: Port enumeration and services");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS("AER");
>  MODULE_IMPORT_NS("CXL");
>  MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c4fd9c0b2a54..8660b18bac8b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -248,7 +248,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  
>  	return pcie_ports_native || host->native_aer;
>  }
> -EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
> +EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "AER");
>  
>  static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {

