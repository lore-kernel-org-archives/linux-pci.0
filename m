Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017893;
	b=stDTssKXQCTClGDgJjILNOGYSWk8tUF5lPPB/JyUsw7TZQxF4waVFC2lTSJaaPqYfpDT
	 MC1Bp/BHHr4Bzt4zD65umPAtDNtjT5sxX38gZiOap4oZVez22rZwi5/H4B4MidLHX4X99
	 20Fpky5qfcUDH37b9MkxVm5+qO3rYuTYZb10Zc+EzFx0Sx/0deZ9o0h3UcwOyUY6ZYFy0
	 kGpDq4XrnzDrwhaRYvABqIirb5llKjkw4itKkIuuJ0IlWG9cwVgD5L0BtdnyMlwe0yckt
	 5UUNa4ABRHymxpUeRQbyKDjeqUmEss09AKF/LUoN1cb4J7yTc7o14nhPzlxPCWzb77g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017893;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qNdQCu46JN+AvdW92yL/KhzoPvPF7o18pJEDv6Keoe0=;
	b=gIWAY9vbQrs3u2sFFi13Z9wIdyMCDlLpfhQaL6tK9m6I1ST/0rA+GhUWFmYnxYREKLCL
	 U0SVegc7GH6t5dDPv4QYNCcEA3o6SWqjv0qNsQ8ImpAzuwP037BdoC55yxLIrOmZwlM/o
	 ce3qnmiq8B0SZ9VnkxmtCVEr9ziC+wdjw1yIewywELQ7aNNhvrTuorhD7Ehh5nAJ8H+nq
	 QZfuvyhj9JMZAuZ2DONeye+2mZpc4iy3t8tmA4ih4KeIC18MTYp3ja3z+plWvk4ehIByC
	 e0qJYb4cv/VOCNYXPKyNL7qycaXHMKQvtWFq1syFUy3AAJQ3G8Z+Qawf2lVoD/3z6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HnEGa6aO;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B38606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 16:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B38606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HnEGa6aO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795017893; x=1826553893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HlGntMaTXfG5rGmcaRF+1287Rm/VarsPSDTRNOZC8FQ=;
  b=HnEGa6aOKB+RcXeqdLeoXa+3UND6dIwi3AHq4bZYU9qHHELx8rtMEHoO
   4XfUkYhRXWIqisD+/eeZK/TojLcOV9s7RCOdCmaJqxySQ5leVjGXGoCCk
   Kmvpd3MP39uyYIYeRpbZrH0X9dWfte5pMcQHi5RqGnYAPjgwJ8Qoxgx7C
   HNrNy3schuXHqK198P3h/lnP+l0c/60o9W2CLCFVKpLG7eJONMt7a0Ris
   ulfdBfiXvF9cAzs3i29JdLfdr8iN8T38MKXKGaSRgK7wC1BGK2JQXrMrP
   lsebsCfOaff7Ck1pCE4D/vra8POlIbBnh6ivMHgoVo7M5zJgnRPWN54KB
   Q==;
X-CSE-ConnectionGUID: /8V9+ROfSrSgho5VyoLqrw==
X-CSE-MsgGUID: LfxdXAybRd+J1nlMEFF7/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3727457"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3727457"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:04:52 -0800
X-CSE-ConnectionGUID: GMqOpEkEQZqhGqmE8CouQA==
X-CSE-MsgGUID: 4MI+bbhVQnWNScobLRH2MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10540463"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:04:52 -0800
Message-ID: <5cc37811-961a-43a7-8c87-278572c91ad5@linux.intel.com>
Date: Wed, 18 Nov 2026 08:04:51 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] PCI/ERR: Clear error status bits more selectively
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Darshit Shah <darnshah@amazon.de>,
 Jason Perlow <jperlow@gmail.com>, Riana Tauro <riana.tauro@intel.com>,
 Yury Murashka <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>
References: <cover.1794997749.git.lukas@wunner.de>
 <8ab33b2307e9136719f72ccc2d9f946417651eab.1794997749.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <8ab33b2307e9136719f72ccc2d9f946417651eab.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/26 02:40, Lukas Wunner wrote:
> After recovery from a PCIe error, all of the error status bits in the
> Device Status register are cleared indiscriminately, regardless of the
> error's severity.
> 
> So when a Correctable Error occurs simultaneously to an Uncorrectable
> Error, after the former is handled, it is cleared alongside the latter.
> As a result, the Uncorrectable Error isn't handled at all.
> 
> Conversely, an Uncorrectable Error occurring shortly before a Correctable
> Error may cause the latter to be cleared and thus ignored.
> 
> Avoid by clearing only the error bits corresponding to the error severity
> being handled.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Changes v1 -> v2:
>   * New patch to clear error status bits more selectively (sashiko).
>  
>  drivers/pci/pcie/aer.c | 20 +++++++++++++++++++-
>  drivers/pci/pcie/err.c |  7 ++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6f2460231422..51cf2ff8c85a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -141,6 +141,12 @@ struct aer_info {
>  					PCI_ERR_ROOT_MULTI_COR_RCV |	\
>  					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
>  
> +static const u8 severity2devsta[] = {
> +	[AER_NONFATAL]    = PCI_EXP_DEVSTA_NFED,
> +	[AER_FATAL]       = PCI_EXP_DEVSTA_FED,
> +	[AER_CORRECTABLE] = PCI_EXP_DEVSTA_CED,
> +};
> +
>  static bool pcie_aer_disable;
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>  
> @@ -1314,6 +1320,17 @@ bool is_aer_internal_error(struct aer_err_info *info)
>  }
>  #endif
>  
> +static void pcie_clear_device_status_sev(struct pci_dev *dev, u8 severity,
> +					 u32 uncor_status)
> +{
> +	u16 devsta = severity2devsta[severity];
> +
> +	if (uncor_status & PCI_ERR_UNC_UNSUP)
> +		devsta |= PCI_EXP_DEVSTA_URD;
> +
> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, devsta);
> +}
> +
>  /**
>   * pci_aer_handle_error - handle logging error into an event log
>   * @dev: pointer to pci_dev data structure of error source device
> @@ -1344,7 +1361,8 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  			if (pdrv && pdrv->err_handler &&
>  			    pdrv->err_handler->cor_error_detected)
>  				pdrv->err_handler->cor_error_detected(dev);
> -			pcie_clear_device_status(dev);
> +			pcie_clear_device_status_sev(dev, AER_CORRECTABLE,
> +						     info->anfe_status);
>  		}
>  	} else if (info->severity == AER_NONFATAL)
>  		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 1a7fc71c79d8..24a8a8263c2e 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -21,6 +21,10 @@
>  #include "portdrv.h"
>  #include "../pci.h"
>  
> +#define PCI_EXP_DEVSTA_UNC_MASK	(PCI_EXP_DEVSTA_NFED | \
> +				 PCI_EXP_DEVSTA_FED | \
> +				 PCI_EXP_DEVSTA_URD)
> +
>  static pci_ers_result_t merge_result(enum pci_ers_result orig,
>  				  enum pci_ers_result new)
>  {
> @@ -274,7 +278,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	 * signaling device may not even be visible to the OS.
>  	 */
>  	if (host->native_aer) {
> -		pcie_clear_device_status(dev);
> +		pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
> +					   PCI_EXP_DEVSTA_UNC_MASK);
>  		pci_aer_clear_nonfatal_status(dev);
>  	}
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

