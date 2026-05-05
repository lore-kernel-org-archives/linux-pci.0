Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308333A9C3;
	Wed,  6 May 2026 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025614; cv=none; b=RhxpgQAqn5g8C3TCC+RsB44lu5fw2kNE27OKrVoMgFm8Ms/k29ALQ08of2qi8S5yKwaEVzkC+7pbEyBmg4fJKqFHbBemFPy0pqPvy1PnZYxxMgWfJdY01Y0KBg1ZaekQMzjhqNK/aEHaJ8/WYRk/3SI80PgHAIDdDjcpnUxX8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025614; c=relaxed/simple;
	bh=BU+ku2HbqivXM3GBbrgS1jHksjPhIuqY0hTbeAtLpCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2vWaspMBStlE8G3npRWZryKw8j+tHFs9wmdcElRDrUgd5RKIqcFLS9/v0VqdJtuai6+2osmkwy1r0GY4/RNJrhedDxHAqyvPJixNgfB9husYkWkIT9UaIdrVKc9G5rry62ooQNEHaSJJQz9NzgTZ6NiX7IO0WDPmhVS3y7GhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QL1ttLtH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QL1ttLtH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778025613; x=1809561613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BU+ku2HbqivXM3GBbrgS1jHksjPhIuqY0hTbeAtLpCY=;
  b=QL1ttLtHqu2a9nn3xs8IQg763XleAATfO1eA5icokypFDhoSvWBa+q6r
   hfICvgYrAU/todikd69+Y20zF+mO3Sg/bkY9BRb25EAtRc3tmvkmvsgUj
   cxlLI+mUu2Datc9HCs6gOuaLVO2v8eIMaiAt6WkrzPQWdH+GgGhNdyN6h
   CX0IDB4cRaY3sCOFxt5GUmJ2QZLpFY3DyF7qF6c0sdI9VsauUAdD2XcZ3
   yH6AG375812AxoZQaOzn+4kIgv2ldnTiMv9OD/sMhFG0rEpJEmvJD23D1
   smsAjJhU1dbLP0jA+vWRRSRHTMF7PapOzNnxDOme4pPQHE4HwmcDi71t5
   Q==;
X-CSE-ConnectionGUID: mwwx3kN2QWuEYuxkRYhbog==
X-CSE-MsgGUID: Jcj8HCLWRWmfuIMRvYuWXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78904501"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="78904501"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 17:00:05 -0700
X-CSE-ConnectionGUID: 97GRI57NQquqI9I39KH9Dw==
X-CSE-MsgGUID: MkPu+dmIQtm9R5fI4JCdNg==
X-ExtLoop1: 1
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.125.110.85]) ([10.125.110.85])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 17:00:01 -0700
Message-ID: <ba97bbfc-2fc3-49d2-be6a-9384a4095c2c@intel.com>
Date: Tue, 5 May 2026 16:59:58 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 07/11] PCI/CXL: Add RCH support to CXL handlers
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, djbw@kernel.org, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, vishal.l.verma@intel.com,
 alucerop@amd.com, ira.weiny@intel.com, corbet@lwn.net, rafael@kernel.org,
 xueshuai@linux.alibaba.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-8-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260505173029.2718246-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 10:30 AM, Terry Bowman wrote:
> Restricted CXL Host (RCH) error handling is a separate path from the
> new CXL Port error handling flow. Fold RCH error handling into the
> Port flow so both share a common entry point.
> 
> Update cxl_rch_handle_error_iter() to forward RCH protocol errors
> through the AER-CXL kfifo.
> 
> Update cxl_handle_proto_error() to dispatch RCH errors via
> cxl_handle_rdport_errors(). cxl_handle_rdport_errors() handles both
> correctable and uncorrectable RCH protocol errors.
> 
> Behavior change: an RCD uncorrectable CXL RAS error now panics via
> cxl_do_recovery(). Before this patch the RCH path returned
> PCI_ERS_RESULT_NEED_RESET via cxl_pci's err_handler. After this patch
> the same condition panics. This matches the panic policy added in the
> common CXL Port protocol error flow. CXL.cachemem traffic cannot be
> safely recovered from an uncorrectable protocol error in software.
> 
> Change cxl_handle_rdport_errors() to take a PCI device instead of a
> CXL device state, matching the new caller context. The error trace events
> emitted from this path now report device=<PCI BDF> instead of device=<memN>,
> matching the rest of the unified CXL trace events. Userspace consumers keyed
> off the memdev name need to map the PCI BDF back to a memdev.
> 
> Include the RCD Endpoint serial number in RCH log messages so the RCH
> can be associated with its RCD.
> 
> Remove the cxlds->rcd check from cxl_cor_error_detected() and
> cxl_error_detected(). RCH errors are now forwarded by
> cxl_rch_handle_error_iter() through the AER-CXL kfifo to
> cxl_handle_proto_error(), so cxl_pci's err_handler no longer sees
> them.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v16->v17:
> - Drop now-dead cxlds->rcd branches from cxl_{cor_,}error_detected().
> - Drop duplicate subject line from commit body.
> - Document panic-on-uncorrectable behavior change for RCD path.
> - Document trace event device-name change (memN -> PCI BDF) for RCH path.
> - Rewrite cxl_handle_proto_error() RC_END comment to clarify RCD/RCH shared
>   interrupt relationship
> - Rewrite commit message
> 
> Changes in v16:
> - New commit
> ---
>  drivers/cxl/core/core.h        |  4 ++--
>  drivers/cxl/core/ras.c         | 14 +++++++++-----
>  drivers/cxl/core/ras_rch.c     |  8 +++-----
>  drivers/pci/pcie/aer_cxl_rch.c | 17 +----------------
>  4 files changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index bc36cd1575a4..2c7387506dfb 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -188,7 +188,7 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial,
>  			void __iomem *ras_base);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
> +void cxl_handle_rdport_errors(struct pci_dev *pdev);
>  void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>  #else
>  static inline int cxl_ras_init(void)
> @@ -205,7 +205,7 @@ static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
>  				      void __iomem *ras_base) { }
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
> -static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> +static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
>  static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  #endif /* CONFIG_CXL_RAS */
>  
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 0a552d5a236e..1f1dd20623f6 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -267,9 +267,6 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  			return;
>  		}
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -
>  		cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
>  				   cxlmd->endpoint->regs.ras);
>  	}
> @@ -292,8 +289,6 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  			return PCI_ERS_RESULT_DISCONNECT;
>  		}
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
>  		/*
>  		 * A frozen channel indicates an impending reset which is fatal to
>  		 * CXL.mem operation, and will likely crash the system. On the off
> @@ -329,6 +324,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>  static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport, int severity)
>  {
> +	/*
> +	 * An RC_END device is an RCD (Restricted CXL Device). Its AER
> +	 * interrupt is shared with the RCH Downstream Port, so handle RCH
> +	 * Downstream Port protocol errors first before processing the RCD's
> +	 * own errors. See CXL spec r3.1 s12.2.
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)

May as well use is_cxl_restricted(pdev).

DJ
 
> +		cxl_handle_rdport_errors(pdev);
> +
>  	if (severity == AER_CORRECTABLE) {
>  		cxl_handle_cor_ras(&pdev->dev, pci_get_dsn(pdev),
>  				   to_ras_base(port, dport));
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 61835fbafc0f..cbd02cabefbc 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2025 AMD Corporation. All rights reserved. */
>  
> -#include <linux/types.h>
>  #include <linux/aer.h>
>  #include "cxl.h"
>  #include "core.h"
> @@ -95,9 +94,8 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>  	return false;
>  }
>  
> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> +void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  {
> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	struct aer_capability_regs aer_regs;
>  	struct cxl_dport *dport;
>  	int severity;
> @@ -115,9 +113,9 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  
>  	pci_print_aer(pdev, severity, &aer_regs);
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
> +		cxl_handle_cor_ras(&pdev->dev, pci_get_dsn(pdev),
>  				   dport->regs.ras);
>  	else
> -		cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
> +		cxl_handle_ras(&pdev->dev, pci_get_dsn(pdev),
>  			       dport->regs.ras);
>  }
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index e471eefec9c4..83142eac0cab 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -37,26 +37,11 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  {
>  	struct aer_err_info *info = (struct aer_err_info *)data;
> -	const struct pci_error_handlers *err_handler;
>  
>  	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>  		return 0;
>  
> -	guard(device)(&dev->dev);
> -
> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> -	if (!err_handler)
> -		return 0;
> -
> -	if (info->severity == AER_CORRECTABLE) {
> -		if (err_handler->cor_error_detected)
> -			err_handler->cor_error_detected(dev);
> -	} else if (err_handler->error_detected) {
> -		if (info->severity == AER_NONFATAL)
> -			err_handler->error_detected(dev, pci_channel_io_normal);
> -		else if (info->severity == AER_FATAL)
> -			err_handler->error_detected(dev, pci_channel_io_frozen);
> -	}
> +	cxl_forward_error(dev, info);
>  	return 0;
>  }
>  

