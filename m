Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE383ED5A2;
	Mon,  9 Mar 2026 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082535; cv=none; b=hjmeqPNJaLQUeCGigOMJI+ltBE3WOmqYSMhS6b8c8gtSw5W3dcfO4oBo2QXgojW9t4Kl4tecmgyX5R16QTKG1CrNh0D5ZecPoKhm318ZGQBMPbWMnhOd8waeGWo0ScmzrzDpF6Xl6hfEj0tnX2ZzMAPcQu6ovOqAqsaSlFkMjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082535; c=relaxed/simple;
	bh=w1VkNd3bsGEsVZxaN9KV5MP89lEhMFQ/X0PNqqgFncM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8nYpVnjG4qUZQJpCcD0I5uWMi0k2xuZ6UPsTPjAbdpalGnjwlTZ8EtiUNPHXJ7jPcwPSmpUZBZvys50KdDv+c72QErVDfgIiYt2r23YYPvweelK0Gz9vvA4zoYf79QaaFp7Z00obyyitajtBOpAholSZqULqt3GYBXLNkBGcLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TohFGA39; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TohFGA39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773082534; x=1804618534;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w1VkNd3bsGEsVZxaN9KV5MP89lEhMFQ/X0PNqqgFncM=;
  b=TohFGA39zDfHS8ly0KYLoTqxNlKzy5TuYJ5TDa4hPpqbanAy9W3PgEnj
   JG+244jQNpyZC/eF1AfLDMXQCCs5V3lOa2Y1HsqYgs1r4/YY86iyQyDSG
   DTyk+juV3jrlDv3dw0xCSRcdzjP54kVlWdrm89xjqSNtrEVagaZCrrZYj
   GtbeCtJLMJKGO9WuI+c4hFjtfP5umgbUnrJft0haJV6rbPdHsidJD44t5
   q2dMKoMDMk8p2ocJAcFK6YlP9K4R3jNHSvVUxJpF6HYquTNLm9dRa8XV/
   HLRVUgBtXRxq2wOTknWzvj2GDItsSrjS3racIdjz0Ymog9oomPNPlD5Yv
   w==;
X-CSE-ConnectionGUID: 0CbfkUCOSiSaFGtF8BJX0Q==
X-CSE-MsgGUID: O0SyU9qaRneZsSMhkIZ0ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74160342"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74160342"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 11:55:33 -0700
X-CSE-ConnectionGUID: IeHsLyuKQ9uAh4s3xR0Nlw==
X-CSE-MsgGUID: aIVpfg3hTsOWReGWfKID/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219819614"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 11:55:31 -0700
Message-ID: <b7566e75-8d1e-4551-b21c-4e1123627583@intel.com>
Date: Mon, 9 Mar 2026 11:55:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 09/10] cxl: Remove Endpoint AER correctable handler
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-10-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260302203648.2886956-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/2/26 1:36 PM, Terry Bowman wrote:
> CXL drivers dont require a correctable PCI AER handler. Correctable AER
> errors reported by CXL devices are logged and cleared in the AER driver.
> This makes the correctable AER handler callback in the CXL driver
> unnecessary.
> 
> Remove cxl_cor_error_detected() and drop the .cor_error_detected callback
> from the CXL PCI error handlers.
> 
> This consolidates correctable error reporting under the CXL RAS infrastructure
> and avoids redundant or conflicting logging with the AER driver.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v15->v16:
> - None
> 
> Changes in v14->v15:
> - Remove cxl_pci_cor_error_detected(). Is not needed. AER is logged
>   in the AER driver. (Dan)
> - Update commit message (Terry)
> 
> Changes in v13->v14:
> - New commit
> - Change cxl_cor_error_detected() parameter to &pdev->dev device from
>   memdev device. (Terry)
> - Updated commit message (Terry)
> ---
>  drivers/cxl/core/ras.c | 23 -----------------------
>  drivers/cxl/cxlpci.h   |  2 --
>  drivers/cxl/pci.c      |  1 -
>  3 files changed, 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 884e40c66638..d6112b812c82 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -370,29 +370,6 @@ cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	return PCI_ERS_RESULT_PANIC;
>  }
>  
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> -{
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlds->cxlmd->dev;
> -
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return;
> -		}
> -
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(pdev);
> -
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial,
> -				   cxlmd->endpoint->regs.ras);
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> -
>  static bool cxl_uncor_aer_present(struct pci_dev *pdev)
>  {
>  	struct aer_capability_regs aer_regs;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 86029d96d6bb..184a95e96ea9 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -78,13 +78,11 @@ struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_RAS
> -void cxl_cor_error_detected(struct pci_dev *pdev);
>  void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
>  pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  					pci_channel_state_t error);
>  void devm_cxl_port_ras_setup(struct cxl_port *port);
>  #else
> -static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>  static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  						      pci_channel_state_t state)
>  {
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b57f4727af53..77a2ee57222b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1055,7 +1055,6 @@ static const struct pci_error_handlers pci_error_handlers = {
>  	.error_detected	= cxl_pci_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
> -	.cor_error_detected	= cxl_cor_error_detected,
>  	.reset_done	= cxl_reset_done,
>  };
>  

