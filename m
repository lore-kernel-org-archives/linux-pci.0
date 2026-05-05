Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674B31716D;
	Tue,  5 May 2026 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778019395; cv=none; b=ubwFbgqYHi2N2zC/16qHCoGfGFD15qlTM8MzpwLH6E0HJxvgzAwKHi6QAb2IwFbB7Dr6BiRBil9G/dweCQLMsoo3IPL5ESMMdGx/l/u+V5QH39kI6cA7y/uihM9vneWNkaH/SUKSf2H5ta4kLqvYU7Ks/PxUa/R00jgXu+jGYAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778019395; c=relaxed/simple;
	bh=2kn9vnW/RQZlq9cSKZLyrOnx2FcEcdncD2IH1ClVi+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhICr71kdeEkEXp/CltqQ/wjTUwlXcEb+AYj78WjgXTIsG2b0MjgG0xu6952/nA+3jnz8lZWALqsgVX3MoJ077DBHEX3PLyoix+Ie/19yZNTumlGCVN9eBpgU0WcPACAugbh3Z79fJGrT5qWt7kmf02pmPXdNoNKieLZtxFu/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKMhNlH2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKMhNlH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778019393; x=1809555393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2kn9vnW/RQZlq9cSKZLyrOnx2FcEcdncD2IH1ClVi+s=;
  b=WKMhNlH2bvtEL0//pY3DJl5pqWueH8xnIRnbSe0KmNSDdAaEbYMbSfS0
   YXDTHNJgxf0Xq+vyGJ93WKB9O+iaNssgrK5VT6pnPc44EQVlFdcXIJ33D
   DCfhdq2+pnlWtyUSy3U82QJVWeds/C+KKpsybHmGIuiTHQFISN3spnxz3
   W64s1WM0w2fRNYvQgrSJ47KO1j5VGa+nUjYyV58QFcKV+0nIqJGfv9Y8K
   9JEhid6dMupkg+Dsusj4RYNQYPc/PxyiZQpdMZqnkgFa7sHPqYfUzSPWV
   mB25au8kG0zULh03dhNpyyuDp/u7iDnz4mwnj5dZpaco2YAnYlce7fMob
   Q==;
X-CSE-ConnectionGUID: i8xO3omuTGCrN/1YrZ+Kpw==
X-CSE-MsgGUID: i1+jg5jFTPGb4Ldk6a/H+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79004777"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="79004777"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 15:16:32 -0700
X-CSE-ConnectionGUID: Zm8/Zq25Rem6IsII6PyFkQ==
X-CSE-MsgGUID: FrPtP51RQhmnzK0vxrlPVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="234940856"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.125.110.85]) ([10.125.110.85])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 15:16:31 -0700
Message-ID: <0a372718-a3ae-4c8c-94a6-6b6c334cab16@intel.com>
Date: Tue, 5 May 2026 15:16:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 05/11] cxl: Limit CXL-CPER kfifo registration
 functions scope
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, djbw@kernel.org, bhelgaas@google.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com,
 corbet@lwn.net, rafael@kernel.org, xueshuai@linux.alibaba.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-6-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260505173029.2718246-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 10:30 AM, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> Some CPER functions used by CXL drivers are exported using the
> EXPORT_SYMBOL_NS_GPL(fn, ns) macro. This doesn't provide compile time
> enforcement or visibility of the consumers.
> 
> This can be improved by using EXPORT_SYMBOL_FOR_MODULES() instead.
> EXPORT_SYMBOL_FOR_MODULES() explicitly names the modules that can access
> the function. This provides more precise control and visibility of symbol
> exposure than the namespace macro. It also provides compile time checking.
> 
> To improve control and clarity, update cxl_cper_register_prot_err_work(),
> cxl_cper_unregister_prot_err_work(), and cxl_cper_prot_err_kfifo_get()
> to use EXPORT_SYMBOL_FOR_MODULES(). Also, update the register and unregister
> functions to return void type.
> 
> Update the CPER kfifo unregister to cancel work while using
> synchronization.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v16->v17:
> - Split from v16 02/10 ("Update unregistration for AER-CXL and
>   CPER-CXL kfifos"); AER-CXL half folded into v17 01/10.
> - Convert exports to EXPORT_SYMBOL_FOR_MODULES("cxl_core").
> - Change register/unregister return type from int to void.
> - Drop work_struct argument from cxl_cper_unregister_prot_err_work();
>   it now cancels its own work.
> - Remove now-redundant cancel_work_sync() from cxl_ras_exit().
> - Add WARN_ONCE() in cxl_cper_register_prot_err_work() for
>   double-registration.
> ---
>  drivers/acpi/apei/ghes.c | 27 ++++++++++++++-------------
>  drivers/cxl/core/ras.c   |  6 +++---
>  include/cxl/event.h      | 10 ++++------
>  3 files changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6..dd0a073af93c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -778,33 +778,34 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  #endif
>  }
>  
> -int cxl_cper_register_prot_err_work(struct work_struct *work)
> +void cxl_cper_register_prot_err_work(struct work_struct *work)
>  {
> -	if (cxl_cper_prot_err_work)
> -		return -EINVAL;
> -
>  	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	WARN_ONCE(cxl_cper_prot_err_work,
> +		  "CPER-CXL kfifo consumer already registered\n");
>  	cxl_cper_prot_err_work = work;
> -	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
> +EXPORT_SYMBOL_FOR_MODULES(cxl_cper_register_prot_err_work, "cxl_core");
>  
> -int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +void cxl_cper_unregister_prot_err_work(void)
>  {
> -	if (cxl_cper_prot_err_work != work)
> -		return -EINVAL;
> +	struct work_struct *work;
>  
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	spin_lock(&cxl_cper_prot_err_work_lock);
> +	work = cxl_cper_prot_err_work;
>  	cxl_cper_prot_err_work = NULL;
> -	return 0;
> +	spin_unlock(&cxl_cper_prot_err_work_lock);
> +
> +	if (work)
> +		cancel_work_sync(work);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> +EXPORT_SYMBOL_FOR_MODULES(cxl_cper_unregister_prot_err_work, "cxl_core");
>  
>  int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
>  {
>  	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
> +EXPORT_SYMBOL_FOR_MODULES(cxl_cper_prot_err_kfifo_get, "cxl_core");
>  
>  /* Room for 8 entries for each of the 4 event log queues */
>  #define CXL_CPER_FIFO_DEPTH 32
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 56611da8357a..9193dac4e507 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -68,13 +68,13 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
>  int cxl_ras_init(void)
>  {
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	return 0;
>  }
>  
>  void cxl_ras_exit(void)
>  {
> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> -	cancel_work_sync(&cxl_cper_prot_err_work);
> +	cxl_cper_unregister_prot_err_work();
>  }
>  
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index ff97fea718d2..51acedb0d683 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -289,8 +289,8 @@ struct cxl_cper_prot_err_work_data {
>  int cxl_cper_register_work(struct work_struct *work);
>  int cxl_cper_unregister_work(struct work_struct *work);
>  int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
> -int cxl_cper_register_prot_err_work(struct work_struct *work);
> -int cxl_cper_unregister_prot_err_work(struct work_struct *work);
> +void cxl_cper_register_prot_err_work(struct work_struct *work);
> +void cxl_cper_unregister_prot_err_work(void);
>  int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
>  #else
>  static inline int cxl_cper_register_work(struct work_struct *work)
> @@ -306,13 +306,11 @@ static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
>  {
>  	return 0;
>  }
> -static inline int cxl_cper_register_prot_err_work(struct work_struct *work)
> +static inline void cxl_cper_register_prot_err_work(struct work_struct *work)
>  {
> -	return 0;
>  }
> -static inline int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +static inline void cxl_cper_unregister_prot_err_work(void)
>  {
> -	return 0;
>  }
>  static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
>  {

