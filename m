Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486842DA35;
	Mon, 20 Jul 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784585882; cv=none; b=LgZy9fZqzrLe+dGe1ZmHPhGlku85DzfnLw3G2WokBzKk+LS4XMQKZ9K2bQ6AXfEJ4+MfcayGJQOi+N6HloYrK8yGosyz2kbhJqevIlmLxhdOzs7b3leJD8DmcSWUjs0unKOuVrgrJS67ZOIZ+j2RnHN5UAVibPFQtoxkSpIzqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784585882; c=relaxed/simple;
	bh=piJCye+663SJPdUrzyC56NPwu7ZHIhzz+UfLbBqyqUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USPxj/fPu+2Npmixvi3eAjvtP7vPLjJgZ+djcRuZ34FrgTC3KJex+x1ug22pNeWYW5+1CS85QAn/OsrXB8CrgqDfeiIDErl5vEw0O6AcbVCWr0Ruarhl4CJIftF33OCxnk7EWzuJghFXozA15ExmhIQ5Gpd3H8aZHIWwkSXzbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmGxGRZg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmGxGRZg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784585880; x=1816121880;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=piJCye+663SJPdUrzyC56NPwu7ZHIhzz+UfLbBqyqUc=;
  b=UmGxGRZgYfe0MLf9lMzk4AWdsOPE0jF1EBkJyFzqX5K89p865tOg6lVO
   DMqSIRVxrtONzjZ0xh4AYBDp1tIMKg0OOsSehfBGr4CQ9+SC0OpLwy5fm
   MqjNf088KFBGEWJ0HdNGlAmbz7L6BM+276EG8msR90SaFQnyR0F2vGoat
   PW+KmjmzUfHHPxqcR8EWuGszmLoAaz4T+QJdNUgc9P6Y7+rTcNswjrICC
   OH6VkGjuXeBGbOoIOzbxzgG8t4kxr1Vd3eVIHwAjEM6ZI6t7g3jFSQBLK
   y+lgx9HKMAleiDLP6xDViI4XGfqBA9HA1X88J7mAjy93COpmcq0I7lAG+
   g==;
X-CSE-ConnectionGUID: C+puY+SWTOyQoDU4+WaXxQ==
X-CSE-MsgGUID: 8dFBOlQAS5+YY+l8klPiww==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95829463"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="95829463"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:15:12 -0700
X-CSE-ConnectionGUID: IPJQR+ENQPWu7HFmV6oHlQ==
X-CSE-MsgGUID: DQS5BRxVSWS9nTZJ/HpaJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="255799392"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:15:10 -0700
Message-ID: <bf7e8105-9c0b-4e80-a8b1-5df7873754c5@intel.com>
Date: Mon, 20 Jul 2026 15:15:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 08/13] cxl/pci: Thread port and dport through RAS
 handling helpers
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
 <20260717222706.3540281-9-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:27 PM, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
> a struct cxl_port * and struct cxl_dport * for the device being
> handled. Passing a generic struct device * requires is_cxl_memdev()
> to distinguish Endpoints from ports at trace emission time. Threading
> port and dport directly enables is_cxl_endpoint(port) and explicit
> dport/port branching for cleaner trace dispatch.
> 
> Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
> cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
> emission logic is split into three branches: Endpoint events are
> identified via is_cxl_endpoint(port) and emit with the memdev, dport
> events emit with dport->dport_dev, and Upstream Port events fall back
> to port->uport_dev.
> 
> Update cxl_handle_rdport_errors() in ras_rch.c and
> cxl_handle_proto_error() in ras.c to pass port and dport to the
> refactored functions.
> 
> RCH Downstream Port correctable trace events now report the dport
> device (dport->dport_dev) as a consequence of threading port and dport
> through the RAS helpers. The following trace event rework ("cxl: Add
> port and dport identifiers to CXL AER trace events") adds explicit
> memdev, port, dport, and host fields that provide full context for
> all device types.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/cxl/core/core.h    | 12 ++++++++----
>  drivers/cxl/core/ras.c     | 29 +++++++++++++++--------------
>  drivers/cxl/core/ras_rch.c |  2 +-
>  3 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 272634ff2615b..5ca1275fd8f35 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -185,10 +185,12 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  #ifdef CONFIG_CXL_RAS
>  void cxl_ras_init(void);
>  void cxl_ras_exit(void);
> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> +		    void __iomem *ras_base);
>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  		     struct cxl_dport *dport);
> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> +			void __iomem *ras_base);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
> @@ -197,13 +199,15 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>  #else
>  static inline void cxl_ras_init(void) { }
>  static inline void cxl_ras_exit(void) { }
> -static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> +				  void __iomem *ras_base)
>  {
>  	return false;
>  }
>  static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport) { }
> -static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
> +static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> +				      void __iomem *ras_base) { }
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 9a142abcf4f8b..6f4a3c1b0bb85 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -232,7 +232,6 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>  
>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
>  {
> -	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
>  	void __iomem *ras_base = to_ras_base(port, dport);
>  
>  	if (!ras_base) {
> @@ -241,14 +240,14 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
>  		return;
>  	}
>  
> -	if (cxl_handle_ras(dev, ras_base))
> +	if (cxl_handle_ras(port, dport, ras_base))
>  		panic("CXL cachemem error");
>  
>  	dev_dbg(&pdev->dev,
>  		"CXL UCE signaled but no CXL RAS status bits set\n");
>  }
>  
> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>  {
>  	u32 status;
>  	void __iomem *addr;
> @@ -260,10 +259,12 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		if (is_cxl_memdev(dev))
> -			trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> +		if (is_cxl_endpoint(port))
> +			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
> +		else if (dport)
> +			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
>  		else
> -			trace_cxl_port_aer_correctable_error(dev, status);
> +			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
>  	}
>  }
>  
> @@ -288,7 +289,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>  	void __iomem *addr;
> @@ -315,10 +316,12 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	if (is_cxl_memdev(dev))
> -		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	if (is_cxl_endpoint(port))
> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
> +	else if (dport)
> +		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
>  	else
> -		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
>  
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> @@ -351,7 +354,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		 * chance the situation is recoverable dump the status of the RAS
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
> -		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
> +		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>  	}
>  
>  	/*
> @@ -382,10 +385,8 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>  static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport, int severity)
>  {
> -	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
> -
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(dev, to_ras_base(port, dport));
> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
>  	else
>  		cxl_do_recovery(pdev, port, dport);
>  }
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index f2d2fb83758b9..f4b98f2c11a1c 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -118,7 +118,7 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  
>  	pci_print_aer(pdev, severity, &aer_regs);
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(&pdev->dev, to_ras_base(port, dport));
> +		cxl_handle_cor_ras(dport->port, dport, to_ras_base(port, dport));
>  	else
>  		cxl_do_recovery(pdev, dport->port, dport);
>  }

