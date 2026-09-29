Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6E55294B
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711704; cv=none; b=nqqTtwZoGImlE8sc67kCLADMhphkdFS4MoNVcYrLxMZfVWkYFxtf4rF5HuBdy0A6cSzFhDnVL+gQAZ3LJXkxnkW4QF29EqNfSnhTugYqIBlXia3wbIsGon3XaL5VXDIwq5j9VOW+Q+TqSq2U3BcLJ71ebWgVln/wuZL5N2BoqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711704; c=relaxed/simple;
	bh=dUjNyb1h3b94BZyQ3gAJU25yty+v8AyaGD3/bgCbkkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMFR2rypiCS9b8ET0gc/l/UPAmXIIqGz/xgaKUL/Cul7iRyqpzOdovqK/0ndZRuzAVr9jGr6Fys/sxGFy+jbuUVL5K3AzgJCXQbgky8YboKUz2UQlzFOz6E7dWuqDe5tMszlt1jvE3I/4MfWx92oeEq8ZLYwkNGY0cY7ZUvv5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0Kpx6Ee; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0Kpx6Ee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790711703; x=1822247703;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dUjNyb1h3b94BZyQ3gAJU25yty+v8AyaGD3/bgCbkkg=;
  b=l0Kpx6EeMeQMfW/3/C6vX6wd/jrZ5FYnE512/+OioxEYE0wCd2ewqXPT
   W3uFHIBqilqdXc1BHPiV1fmnCCS6kHV+6vf8wiim4Sa40KdYMSG/u2fkr
   G6UOBljeKaKKN1Td6/TD8bqi1FApweAPkGLRsD0oxCFZ7x3vn7Q3bNBaF
   UbekdxMM+ZcW0m6eY81WvWeOmkKoZmk+VkgLBgTAG+tbqCHfgPqChgP06
   P4MZ2VTLDMXqYixikcJzyDjGdgqSqhZ47uJwK2rCXW6mXmrNzYP38dKMh
   yAGu25q+eIaUwtYYeJRXQJ6M/v62JVn45OgHHMx4LstgQaTVXmYeqZwIB
   w==;
X-CSE-ConnectionGUID: QCnAR4jyScuoucNqnuq3KA==
X-CSE-MsgGUID: p6dtiwtvRJC/a+psf1sC9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79005329"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="79005329"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:55:02 -0700
X-CSE-ConnectionGUID: i8ZCpWykR/2DwbpUOjV67Q==
X-CSE-MsgGUID: P7temBsESBCAIKsBwjEizQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274673188"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:55:01 -0700
Message-ID: <ad14dd46-851d-4caf-a877-50e53c60e661@linux.intel.com>
Date: Tue, 29 Sep 2026 12:55:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] PCI/AER: Renumber severity constants
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
 <244713dea3786099e9ad4eb10ff9f2f430cd7ad3.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <244713dea3786099e9ad4eb10ff9f2f430cd7ad3.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> The AER driver uses constants for Correctable, Non-Fatal and Fatal Error
> severity which look as if they match something in the spec, but are
> actually just made-up numbers.
> 
> Use the bit number in the Device Status Register instead (PCIe r7.1 sec
> 7.5.3.5).  A subsequent commit takes advantage of this by using BIT() to
> conveniently compute the register bit corresponding to a given severity.
> 
> While at it, drop the DPC_FATAL constant which was introduced by commit
> b09803b5e546 ("PCI/DPC: Use the generic pcie_do_fatal_recovery() path")
> but never saw any use in 8 years.
> 

This changes the raw severity value in the aer_event tracepoint, which
may break userspace.  rasdaemon relies on the current numbering
(enum hw_event_aer_err_type in core/ras-events.h), so it would
misclassify error.


> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pcie/aer.c  | 2 +-
>  include/linux/aer.h     | 8 ++++----
>  include/ras/ras_event.h | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 34a8eddc427a..6bc843ab9b37 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -504,9 +504,9 @@ void pci_aer_exit(struct pci_dev *dev)
>   * AER error strings
>   */
>  static const char * const aer_error_severity_string[] = {
> +	"Correctable",
>  	"Uncorrectable (Non-Fatal)",
>  	"Uncorrectable (Fatal)",
> -	"Correctable"
>  };
>  
>  static const char *aer_error_layer[] = {
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index df0f5c382286..795c55132008 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -11,10 +11,10 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  
> -#define AER_NONFATAL			0
> -#define AER_FATAL			1
> -#define AER_CORRECTABLE			2
> -#define DPC_FATAL			3
> +/* Must match bit number in Device Status Register (PCIe r7.1, sec 7.5.3.5) */
> +#define AER_CORRECTABLE			0
> +#define AER_NONFATAL			1
> +#define AER_FATAL			2
>  
>  /*
>   * AER and DPC capabilities TLP Logging register sizes (PCIe r6.2, sec 7.8.4
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index fdb785fa4613..1e03ade99386 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -302,7 +302,7 @@ TRACE_EVENT(non_standard_event,
>   *			([domain:]bus:device.function).
>   * u32 status -		Either the correctable or uncorrectable register
>   *			indicating what error or errors have been seen
> - * u8 severity -	error severity 0:NONFATAL 1:FATAL 2:CORRECTED
> + * u8 severity -	error severity 0:CORRECTED 1:NONFATAL 2:FATAL
>   */
>  
>  #define aer_correctable_errors					\

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

