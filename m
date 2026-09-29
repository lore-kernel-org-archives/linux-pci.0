Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E84582DC
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709625; cv=none; b=V/3mfqd1T+3VNYMOHMZKFHD83xTUzfYr05rXDCH21JrO2BeBK2JXS8/KQ1hDrt4kdrZ6YsCtzyV5af/0lkPoJi3ohV6VM5wbV/9uS0oI/Du1OyqG9F9uAzk13UwFbK8tlnR13rliH3najf6te2zfK7qdDeQzmfmHXXSkdi6dnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709625; c=relaxed/simple;
	bh=lsJW8PoLoWwqdXMo/RBv2iqDlvjNOGyT8FfkT6mX9r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfMUzQk9lIcXvrBXiZeov0qLqHq3reYoVjoCN+ktTMO4y9+P9BGf5+TE8mH1v61aL7rWPUm8kXVx9107OJds+fI36sbA5y0/zpih3uPnBvnkrOu4PvvA3M56+ANYoAong85hmxB/FiV8S0ABFOTIXPj7N8ReLFl3BFBoEWMolw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtl56qGs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtl56qGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790709623; x=1822245623;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lsJW8PoLoWwqdXMo/RBv2iqDlvjNOGyT8FfkT6mX9r8=;
  b=mtl56qGsNkBl4wEwR0naak51dGsIuzydp41mAIPLsxG9ACTVzLLLXn2q
   WD6YFOA7Nz9x9BbXozXDMDLSmtRGMPz7Ad9uXazOsPTSuZ60lgER73Syv
   FSi/qidIkm8iLCeALA4DDPgUlKZ/psP+MgPBXABfBv8ieFUhEiOEX3brU
   JqnvKpgy4L53ml50/ELg1DpQnqXyE8uCa9tEIexltKUF3+WUCRqxTGmfi
   oSkxvWyd+QMKCaJrULkP7BFEHR2ZTA3+k6y9D7Fnyag2BPQuoe0vIxjAx
   AYsxRdeWwcQXsHN/BI5CNP5zFjFtlGjo7FRPoOpy1o/Dgcc/APGFaPlaz
   A==;
X-CSE-ConnectionGUID: ak9ldLgCQSCMpDpX+0grMA==
X-CSE-MsgGUID: xKsZLufgTRCQ/J+LANTPDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102112343"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="102112343"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:20:22 -0700
X-CSE-ConnectionGUID: R1BEhrwJT1ek6egCvPxHSA==
X-CSE-MsgGUID: XfbfVqTCQeKlR5yhZza6aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="278655075"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:20:22 -0700
Message-ID: <8af8a1ee-69bc-4819-a9dc-b3321dc4e30d@linux.intel.com>
Date: Tue, 29 Sep 2026 12:20:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] PCI/ERR: Avoid stale error status bits on recovery
 failure
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
 <c7048e7dafe470f1f85709169c31b5aafe7ad59f.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <c7048e7dafe470f1f85709169c31b5aafe7ad59f.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> From: Yury Murashka <yurypm@arista.com>
> 
> pcie_do_recovery() only clears the error status bits of an error-reporting
> device if recovery succeeds, but not if it fails.  (E.g. because reset
> failed, drivers are missing pci_error_handlers or those handlers failed.)
> 
> One undesirable consequence is that the AER driver may subsequently
> identify a wrong device when searching for error-reporting devices in
> is_error_source(), due to stale bits on an unaffected device.
> 
> Avoid by clearing error status bits on recovery failure.
> 
> Link: https://lore.kernel.org/r/CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com/
> Signed-off-by: Yury Murashka <yurypm@arista.com>
> [lukas: drop cmdline param, rewrite commit msg, tag for stable]
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/pcie/err.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index d77403d8855b..cfcfc7e4f10d 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -284,6 +284,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	return status;
>  
>  failed:
> +	if (host->native_aer || pcie_ports_native) {

If Bjorn takes AER cleanup patch before this series, we can avoid sprinkling
pcie_ports_native checks everywhere.

https://lore.kernel.org/linux-pci/20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com/


> +		pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);

This only clears Non-Fatal status bits.  On the success path, Fatal
status bits are cleared by pci_restore_state() -> pci_aer_clear_status(),
which drivers call from their ->slot_reset() callback.  On the failure
path, that may not happen (e.g. if the reset failed or the driver lacks
pci_error_handlers).

> +	}
> +
>  	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
>  
>  	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

