Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC703A1A27;
	Tue, 20 Jan 2026 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768951659; cv=none; b=PQCJByoXlQDCjVMC3tPfglFecgzWlo/oUCd0VqQzT2vZKzssDSrboJrvJDvdg8LXDH2IhYK+oq0HA3DUli+3tYVoGrB8l992GwZwlKyCVTZcgHML1qNlsudC56jDLt0RPBzEJiDfxO0TNW9YV+XnCx7sQsrkEibFUWIhjz+B1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768951659; c=relaxed/simple;
	bh=YphWY+8iefVTPwkRmzCN/Fn1y9x1XBNnv1bRkIFIL0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IG6Ynw4bqNxgG4y7cyV4aE70oTP6+BcspNBQc400FdeLMNfPsh0jNqCDDwAonHRc/v+r9epBxc4TFBoM7kymqSF8XwZburpPgdYkLcx/B/yMJf4Nubc3wwei+ccQiWhckfl7tc8L4XXfpMMC5N4ReXjw9m4bUq0LsYqsaqd0gB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jk0lwlv7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jk0lwlv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768951658; x=1800487658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YphWY+8iefVTPwkRmzCN/Fn1y9x1XBNnv1bRkIFIL0U=;
  b=Jk0lwlv7ny8jli/HwYTjRuhgOmCZVZcDbCDlwKJ4OZ6Bc+juHVr5Q5Vw
   RZavbELw/gxnBpgjC3oRGVTbKBACGmUyMisiN6ngiuwU7ZlJCObv9qaQq
   WzG2CEBlLUnrNtT3kA1j+xingHlawjhhUGni8wCi6J++Gxf8x+6WR9fSB
   l0PNaJU1cjsL26uMglykQ4wV3RvfUyS/1oPgjlcDxibmXsYPDbbpTme6s
   9E02d/Eup+zJ59F+d4LT9F0Kf6dNY3Wnzr3lb/Fnbezpmp0jxVNGjaeYD
   j8iMimkBd4mI9Ddqa+VlrQ3ZZ+TqUkVc7h7wjpal1WWnl7ryr2+onn3VM
   Q==;
X-CSE-ConnectionGUID: S6hd33TZQl2JY8gGlm/BqA==
X-CSE-MsgGUID: MrFkz9h9TsOd9TIRR3gFZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87587362"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="87587362"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 15:27:38 -0800
X-CSE-ConnectionGUID: K7b1270hRO6yEp2bNm/SOw==
X-CSE-MsgGUID: jd5gSnjSTS2ppvmCAqZPnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="229221668"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.108.33]) ([10.125.108.33])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 15:27:35 -0800
Message-ID: <aa8d4f6a-e7bd-4a20-8d34-4376ea314b8f@intel.com>
Date: Tue, 20 Jan 2026 16:27:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] cxl: add type 2 helper and reset DVSEC bits
To: smadhavan@nvidia.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, ming.li@zohomail.com,
 rrichter@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 huaisheng.ye@intel.com, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc: vaslot@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
 vidyas@nvidia.com, mochs@nvidia.com, jsequeira@nvidia.com
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-4-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260120222610.2227109-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/20/26 3:26 PM, smadhavan@nvidia.com wrote:
> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Introduce a helper to identify CXL Type 2 devices and define the DVSEC
> reset/cache control bits used by the reset flow.

Should probably be 2 separate patches for these 2 things.

> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/pci.c | 10 ++++++++++
>  include/cxl/pci.h | 14 ++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 55c767df4543..b562e607ec46 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1075,6 +1075,16 @@ static pci_ers_result_t cxl_slot_reset(struct pci_dev *pdev)
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
> 
> +bool cxl_is_type2_device(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +
> +	if (!cxlds)
> +		return false;
> +
> +	return cxlds->type == CXL_DEVTYPE_DEVMEM;
> +}
> +
>  static void cxl_error_resume(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index 728ba0cdd289..71d8de5de948 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -14,10 +14,24 @@
>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>  #define CXL_DVSEC_PCIE_DEVICE					0
>  #define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_CACHE_CAPABLE	BIT(0)
>  #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>  #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define     CXL_DVSEC_CACHE_WBI_CAPABLE	BIT(6)
> +#define     CXL_DVSEC_CXL_RST_CAPABLE	BIT(7)
> +#define     CXL_DVSEC_CXL_RST_TIMEOUT_MASK	GENMASK(10, 8)
> +#define     CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE	BIT(11)
>  #define   CXL_DVSEC_CTRL_OFFSET		0xC
>  #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_CTRL2_OFFSET	0x10
> +#define     CXL_DVSEC_DISABLE_CACHING	BIT(0)
> +#define     CXL_DVSEC_INIT_CACHE_WBI	BIT(1)
> +#define     CXL_DVSEC_INIT_CXL_RESET	BIT(2)
> +#define     CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE	BIT(3)
> +#define   CXL_DVSEC_STATUS2_OFFSET	0x12
> +#define     CXL_DVSEC_CACHE_INVALID	BIT(0)
> +#define     CXL_DVSEC_CXL_RST_COMPLETE	BIT(1)
> +#define     CXL_DVSEC_CXL_RESET_ERR	BIT(2)
>  #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
>  #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
>  #define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)

Should this chunk go with a different patch where the definitions are being used?

> --
> 2.34.1
> 

