Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A042E00A;
	Mon, 20 Jul 2026 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584045; cv=none; b=txwFx56bOTdcwu9Zg5Wp2qQ6hYELPepUOvc1RHyh4Q+s+oK0th/IrNh1UtsrX8IEIxhCxxuklkRNbB/2URUvBtaeW9ovpnkqM9k+DjzWtytbo5cLIIM8vhpyNv54wa2ebp50qyBFz1gUPB6z4oB2wG6JNatjYxvKkE5+ar3/aU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584045; c=relaxed/simple;
	bh=QIzYrMKcdySuEhSJdqjHin2gRJCSE1MpXqRAuEKSTQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DevUQHN/OUTe2LwKG91pUgLlp+raAq7cK/iERxTgqmFyrXt18Er1mu4Vct6EMauWzuVIidzlxBIiXxjVIgF0cLfA5oxn/4MlJhSwumTPwgKpICQJyTUN8AFHEx0oy9M5LYX+WneLMs+RW8JsCVk8q0XZMzlqRGEdtdcfh8QoYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgEMfxKW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgEMfxKW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784584040; x=1816120040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QIzYrMKcdySuEhSJdqjHin2gRJCSE1MpXqRAuEKSTQo=;
  b=kgEMfxKWUjEuX5kfu2Hpn3S79nOCmx4ebM28TT20X8iJFTKUm7I0y7AA
   UXjb8kOBNvsHhI+D4jPGclZGYqIV/i1d+XFbWda5MdgCcK8Vv/PhgVCV+
   WjVuCRs9GUol/6ITK9BtfnA+lCnjTn0noCKd7qkfQIfD7HTAv4oV+4gPX
   hDP9a05tasoX60IgyyeMj/kPnpm0+VyBUQkyq+U1Y33oylmwM0fpd3cEW
   c1WBiMk9Xlm4xE9wlWvqJwbcATe5L2ayMcEJ0pvTW44fA0OA2QTPBpbTT
   QNYTSZijCwS0xofzgQGbbbvDz6Ad3N2dJrD7oZVk/oocX4ixISU7kRdyJ
   A==;
X-CSE-ConnectionGUID: NJNi2cLjS9G+2QFnIA+IPA==
X-CSE-MsgGUID: idI58/t+R1+FxUr5WgS4CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="110727412"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="110727412"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 14:47:17 -0700
X-CSE-ConnectionGUID: mL6X8Ah1RX2Byg87k1sPBg==
X-CSE-MsgGUID: 8dYlYmpESzikuMWT5/WD/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="282058132"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 14:47:14 -0700
Message-ID: <af763e03-578a-45d3-82e3-7222de3db6ac@intel.com>
Date: Mon, 20 Jul 2026 14:47:13 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers
To: Terry Bowman <terry.bowman@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-8-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:27 PM, Terry Bowman wrote:
> Restricted CXL Host (RCH) error handling is a separate path from the
> new CXL Port error handling flow. Fold RCH error handling into the
> Port flow so both share a common entry point.
> 
> Update cxl_rch_handle_error_iter() to forward RCH protocol errors
> through the AER-CXL kfifo. Change cxl_rch_handle_error() return type
> from void to bool so handle_error_source() can determine whether work
> was enqueued and call cxl_proto_err_flush() before AER recovery
> proceeds.
> 
> For RC_END devices, __cxl_proto_err_work_fn() calls
> cxl_handle_rdport_errors() to process RCH Downstream Port errors,
> then falls through to the VH path for RC_END Endpoint handling.
> 
> An RCD uncorrectable CXL RAS error now panics via cxl_do_recovery().
> Before this patch the RCH Downstream Port UCE path called
> cxl_handle_ras() but ignored its return value - no panic. After this
> patch the same condition calls cxl_do_recovery() which panics on
> confirmed UCE. The Endpoint UCE path already panicked at the parent
> commit. This matches the panic policy added in the common CXL Port
> protocol error flow.
> 
> Remove cxl_cor_error_detected() and its .cor_error_detected
> registration in cxl_error_handlers. Correctable Endpoint errors are
> now routed through the AER-CXL kfifo like all other CXL protocol
> errors.
> 
> Drop the cxlds->rcd / cxl_handle_rdport_errors(cxlds) branches from
> cxl_error_detected(). RCH downstream port error handling is now
> performed by __cxl_proto_err_work_fn() via the kfifo path, which
> calls cxl_handle_rdport_errors(pdev) before the common dispatch.
> 
> Change cxl_handle_rdport_errors() to take a struct pci_dev * instead
> of a struct cxl_dev_state *, matching the new caller context. Re-fetch
> dport under guard() to close the TOCTOU window between
> cxl_pci_find_port()'s lockless xa_load() and the first dereference of
> the returned pointer.
> 
> Change find_cxl_port_by_dev() RC_END lookup from
> find_cxl_port_by_dport(dev->parent) to find_cxl_port_by_uport(dev),
> matching the Endpoint lookup path. RC_END Endpoint port resolution
> uses the uport (the RC_END device itself), while the separate RCH
> Downstream Port lookup is handled by cxl_handle_rdport_errors().
> 
> The RCH Downstream Port and the RCD Endpoint (RC_END) are separate
> devices with independent RAS register blocks. cxl_handle_rdport_errors()
> handles the RCH Downstream Port RAS. RCD Endpoint (RC_END) is handled in
> cxl_handle_proto_error().
> 
> Use to_ras_base() in cxl_handle_rdport_errors() instead of referencing
> dport->regs.ras directly. Make to_ras_base() non-static in ras.c and
> declare it in core.h so ras_rch.c can access it. Route all RAS base address lookups
> through a single helper to prepare for CXL RAS error injection testing
> that follows this series.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v17->v18:
> - Pass &pdev->dev instead of dport->port->uport_dev in
>   cxl_handle_rdport_errors() to avoid dropping RCH trace events.
> - Document trace event attribution change.
> - Document removal of cxl_cor_error_detected() and cxlds->rcd branches.
> - Capitalize Endpoint per PCI spec convention.
> - Use to_ras_base() in cxl_handle_rdport_errors() to centralize RAS base
>   address lookup in preparation for error injection testing.
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
>  drivers/cxl/core/core.h        | 10 +++++--
>  drivers/cxl/core/ras.c         | 50 ++++++++--------------------------
>  drivers/cxl/core/ras_rch.c     | 16 ++++++-----
>  drivers/cxl/cxlpci.h           |  3 --
>  drivers/cxl/pci.c              |  1 -
>  drivers/pci/pcie/aer.c         |  4 +--
>  drivers/pci/pcie/aer_cxl_rch.c | 39 ++++++++++++--------------
>  drivers/pci/pcie/portdrv.h     |  4 +--
>  8 files changed, 48 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 7c70bea06c2db..272634ff2615b 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -191,7 +191,8 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
> -void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
> +void cxl_handle_rdport_errors(struct pci_dev *pdev);
> +void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport);
>  void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>  #else
>  static inline void cxl_ras_init(void) { }
> @@ -205,7 +206,12 @@ static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
> -static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> +static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
> +static inline void __iomem *to_ras_base(struct cxl_port *port,
> +					 struct cxl_dport *dport)
> +{
> +	return NULL;
> +}
>  static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  #endif /* CONFIG_CXL_RAS */
>  
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index b190e69c2d415..9a142abcf4f8b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -218,7 +218,8 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>  
> -static void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
> +
> +void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>  {
>  	if (!port)
>  		return NULL;
> @@ -324,37 +325,7 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	return true;
>  }
>  
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> -{
> -	guard(device)(&pdev->dev);
> -	if (!pdev->dev.driver)
> -		return;
> -
> -	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> -	if (!port)
> -		return;
> -
> -	if (is_cxl_restricted(pdev)) {
> -		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -		struct cxl_memdev *cxlmd = cxlds->cxlmd;
>  
> -		scoped_guard(device, &cxlmd->dev) {
> -			cxl_handle_rdport_errors(cxlds);
> -		}
> -	}
> -
> -	scoped_guard(device, &port->dev) {
> -		if (!port->dev.driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: port disabled, abort error handling\n",
> -				 dev_name(&port->dev));
> -			return;
> -		}
> -
> -		cxl_handle_cor_ras(port->uport_dev, to_ras_base(port, NULL));
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state)
> @@ -365,14 +336,6 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	if (!port)
>  		return PCI_ERS_RESULT_DISCONNECT;
>  
> -	if (is_cxl_restricted(pdev)) {
> -		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -		struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -
> -		scoped_guard(device, &cxlmd->dev) {
> -			cxl_handle_rdport_errors(cxlds);
> -		}
> -	}
>  
>  	scoped_guard(device, &port->dev) {
>  		if (!port->dev.driver) {
> @@ -429,6 +392,15 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  
>  static void __cxl_proto_err_work_fn(struct cxl_proto_err_work_data *wd)
>  {
> +	/*
> +	 * For RC_END (RCD) devices, handle RCH Downstream Port errors
> +	 * first.  cxl_handle_rdport_errors() does its own port lookup
> +	 * and locking, keeping the Downstream Port lock separate from the
> +	 * Endpoint Port lock taken below.
> +	 */
> +	if (is_cxl_restricted(wd->pdev))
> +		cxl_handle_rdport_errors(wd->pdev);
> +
>  	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&wd->pdev->dev, NULL);
>  	if (!port) {
>  		dev_err_ratelimited(&wd->pdev->dev,
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 44b335d560708..f2d2fb83758b9 100644
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
> @@ -96,18 +95,21 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
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
>  
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> +	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
>  	if (!port)
>  		return;
>  
> +	guard(device)(&port->dev);
> +	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
> +	if (!dport)
> +		return;
> +
>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>  		return;
>  
> @@ -116,7 +118,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  
>  	pci_print_aer(pdev, severity, &aer_regs);
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +		cxl_handle_cor_ras(&pdev->dev, to_ras_base(port, dport));
>  	else
> -		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
> +		cxl_do_recovery(pdev, dport->port, dport);
>  }
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index b826eb53cf7ba..06c46adcf0f6c 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -89,14 +89,11 @@ struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_RAS
> -void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
>  void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
>  void devm_cxl_port_ras_setup(struct cxl_port *port);
>  #else
> -static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
> -
>  static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  						  pci_channel_state_t state)
>  {
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7c6faee7f85ed..5c21db36073fe 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1004,7 +1004,6 @@ static const struct pci_error_handlers cxl_error_handlers = {
>  	.error_detected	= cxl_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
> -	.cor_error_detected	= cxl_cor_error_detected,
>  	.reset_done	= cxl_reset_done,
>  };
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2d9d40528e709..0bd23a65e7ebc 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1185,9 +1185,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	bool cxl_pending = false;
> -
> -	cxl_rch_handle_error(dev, info);
> +	bool cxl_pending = cxl_rch_handle_error(dev, info);
>  
>  	if (is_cxl_error(dev, info))
>  		cxl_pending |= cxl_forward_error(dev, info);
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index e471eefec9c40..683712fc965ff 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -34,42 +34,37 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>  	return (pcie_ports_native || host->native_aer);
>  }
>  
> +struct cxl_rch_error_ctx {
> +	struct aer_err_info *info;
> +	bool enqueued;
> +};
> +
>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>  {
> -	struct aer_err_info *info = (struct aer_err_info *)data;
> -	const struct pci_error_handlers *err_handler;
> +	struct cxl_rch_error_ctx *ctx = data;
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
> +	if (cxl_forward_error(dev, ctx->info))
> +		ctx->enqueued = true;
>  	return 0;
>  }
>  
> -void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> +bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
> +	struct cxl_rch_error_ctx ctx = { .info = info };
> +
>  	/*
> -	 * Internal errors of an RCEC indicate an AER error in an
> -	 * RCH's downstream port. Check and handle them in the CXL.mem
> -	 * device driver.
> +	 * An RCEC AER internal error indicates an error in an
> +	 * associated RCH Downstream Port or RC_END device or both.
> +	 * Forward to the cxl_core module for handling.
>  	 */
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>  	    is_aer_internal_error(info))
> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, &ctx);
> +
> +	return ctx.enqueued;
>  }
>  
>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index fd203010877bf..807bca90dee0e 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -128,14 +128,14 @@ struct aer_err_info;
>  
>  #ifdef CONFIG_CXL_RAS
>  bool is_aer_internal_error(struct aer_err_info *info);
> -void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
> +bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
>  void cxl_rch_enable_rcec(struct pci_dev *rcec);
>  bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
>  bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
>  void cxl_proto_err_flush(void);
>  #else
>  static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
> -static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
> +static inline bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { return false; }
>  static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
>  static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
>  static inline bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }

