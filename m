Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5F1DED42;
	Mon,  9 Mar 2026 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081034; cv=none; b=PXBt6lp1+NDuXUGT0cV5zFvyxgXeEBuQ3b1gvk9h5N/PGSFudCcWGIeUOQ8C10wSRuFUPJgdO8PvKY1z2cr+Ot27hQH9pMfW98JaSt2Ft6DjjFc4fyOpyXfKIdwGTF5xuAdjMYve9Ac3bQ+gSipjN/0hniQCg9qrQaICEzfThmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081034; c=relaxed/simple;
	bh=fcHCraRUhUoIO7CRko7nHKUewPlIyNcfVedCkLJHRI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUmKXDSYruo/TcJRe8zqVOltmQ5Z3kPpEC3WWQDJOO6DVNu1FkN2FNEdmCXyGMfAw5adQqGV1xovBE9I6kUPvcnqhrSf8k5m+9axQlS5HtQiO1ZVevIzp9LqyWWnZ4UYdtgToTy7L4WqILs91PZ/Dhdl4SC8k9iFBn7OlVLf+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbK9k7eP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbK9k7eP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773081032; x=1804617032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fcHCraRUhUoIO7CRko7nHKUewPlIyNcfVedCkLJHRI0=;
  b=LbK9k7ePKmiCGW1+Sru5UUhCKvWKGIMkqu7PnvVAKw8CzQ4AMkcq6PDN
   gk90ytQh7ibejZVGsW9Hq7AtjJqfoGwlwIkdgmw/lvCgV6rU9ibBBUT7D
   nXVyO1d07wujOkqJrOJL29b3KjivPRvc5+6GhYp3l3GTSmEodvjk1jaeF
   4ZOW8fHyH5j8lTiDPD53P+iNkRzSHpjb0in4dc+ddmRGFWGpRZr/weRfK
   S+uveKdDL7V0FOCAbfTlTG6lzkRJxzMmXRpDWNc0zdunbuwTM0wWttZsU
   4h08VLjurwwsFzzGBBslNQTMBTWlHrooZopo6vR6t2+t8cANEjVTXnTOB
   Q==;
X-CSE-ConnectionGUID: XtbX0xElT5aI3xCFQF4pFQ==
X-CSE-MsgGUID: GUtiee7xTbWaookSPhdibg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="61686841"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="61686841"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 11:30:31 -0700
X-CSE-ConnectionGUID: bvR4NPXoQsaMqz4Zk9XmnA==
X-CSE-MsgGUID: 6FFLQ4RaQuyNG/2IkxxAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224780733"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 11:30:30 -0700
Message-ID: <2bb59ea6-9d33-4dfe-91de-644e20da6307@intel.com>
Date: Mon, 9 Mar 2026 11:30:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 02/10] PCI/CXL: Update unregistration for AER-CXL and
 CPER-CXL kfifos
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
 <20260302203648.2886956-3-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260302203648.2886956-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/2/26 1:36 PM, Terry Bowman wrote:
> The current AER-CXL kfifo unregistration does not cancel pending work after
> clearing the work function pointer. In addition, cancel_work_sync() is
> called on behalf of the CPER-CXL kfifo in cxl_ras_exit() and should be
> moved into the kfifo deregistration function.
> 
> Add logic to cancel the AER-CXL kfifo's pending work in
> cxl_unregister_proto_err_work().
> 
> Move the CPER-CXL kfifo cancel call from cxl_ras_exit() to
> cxl_cper_unregister_prot_err_work(). Release the CPER-CXL spinlock
> before calling cancel_work_sync() to avoid deadlock.
> 
> In both kfifo unregistration cases, add the necessary synchronization
> to enforce proper lock ordering: protect pointer updates under the
> lock, and clear the work pointer, then cancel any outstanding work
> after the lock is released.
> 
> Link: https://lore.kernel.org/linux-cxl/6982ca54e094b_55fa1005@dwillia2-mobl4.notmuch/
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Assisted-by: Azure:gtp-4.1-nano-key

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ----
> 
> Changes in v16:
> - New commit
> ---
>  drivers/acpi/apei/ghes.c      | 6 +++++-
>  drivers/cxl/core/ras.c        | 1 -
>  drivers/pci/pcie/aer_cxl_vh.c | 9 ++++++++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 8acd2742bb27..de935e0e1dcf 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -776,8 +776,12 @@ int cxl_cper_unregister_prot_err_work(struct work_struct *work)
>  	if (cxl_cper_prot_err_work != work)
>  		return -EINVAL;
>  
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	spin_lock(&cxl_cper_prot_err_work_lock);
>  	cxl_cper_prot_err_work = NULL;
> +	spin_unlock(&cxl_cper_prot_err_work_lock);
> +
> +	cancel_work_sync(work);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 006c6ffc2f56..949d8c8ecdfe 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -124,7 +124,6 @@ int cxl_ras_init(void)
>  void cxl_ras_exit(void)
>  {
>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> -	cancel_work_sync(&cxl_cper_prot_err_work);
>  }
>  
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 7e2bc1894395..ebca1112652a 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -74,8 +74,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
>  
>  void cxl_unregister_proto_err_work(void)
>  {
> -	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsema);
> +	struct work_struct *work;
> +
> +	down_write(&cxl_proto_err_kfifo.rwsema);
> +	work = cxl_proto_err_kfifo.work;
>  	cxl_proto_err_kfifo.work = NULL;
> +	up_write(&cxl_proto_err_kfifo.rwsema);
> +
> +	if (work)
> +		cancel_work_sync(work);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
>  

