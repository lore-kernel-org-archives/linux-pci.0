Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B853D6692;
	Wed, 25 Feb 2026 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037245; cv=none; b=mWHmrsVtOXZgXF0Xh0qA15eWTiv1eWWQpYdqZ3uAk6b6yszwutiXUFWogleGGAnUAdCgBRQ0f2f2rEM51QJR+8UC6TsbIa1jC/KCvhWVV4ciDdOKPWvqT/TgAU4ddXRm8Mh4+SZqqPQjBkNam6Glz0QDL6cu6SfoTRtlTCXno5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037245; c=relaxed/simple;
	bh=nA5ubXR7ldqmvu+5ms32j4vZptre4X8kYgLmhb/ey2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSTTQQrCtZMPT5ASzcgZs51gXeDiE4I/bkvSX/LsXRvGciVu1PUAnNcwwrK4Pdafluzd7e6hqlTJ7aMozE5Ydkp89StkBQZLBLaaBVhmB/XRrWAyr4x9c2MSznfcaDLVxGjj1fOMY5Yrcloh1ulu9M9+6U5WrDBJ4kNoOxMe9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tl9y7LdO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tl9y7LdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772037244; x=1803573244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nA5ubXR7ldqmvu+5ms32j4vZptre4X8kYgLmhb/ey2o=;
  b=Tl9y7LdOj0dwIYCIVg1IipjTUv6oVeRx9Htnly11ICfFYKM20KLwEShn
   HQC4TQ9V4FfwbSTSOVMsptqYfPc2noeElSzAVuTUY1ZU0SyQ6fxifV2la
   0UJGgUrNfFfEWMDQ46B31nBw8QHCtVi9Z5G+uxmgfnBkrxPROhX/69zyp
   mCRsaYq/+c8nwjj/KB/ApRsnVQqUQkC4NwG/tFuCd7ERiyZ6nCCEztUpg
   fRwCAmwQuy+P90wh+a3CvZupchLS61txZ9dtf/gZuyQoBGpWD9i3wdDXT
   a5qSUMgGQYXG3IJpgLNgKc9NdDA2z729klt+IBFuto4U8NbzhCCxEiWpR
   w==;
X-CSE-ConnectionGUID: 9vHPuv2HTnuPhMnzYLoFLA==
X-CSE-MsgGUID: XFV6uylbRH+p+uls+OD4/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="90494521"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="90494521"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:34:03 -0800
X-CSE-ConnectionGUID: TwyXHUZ+SOmrLJlCru2idQ==
X-CSE-MsgGUID: 7wBMd34LRcapbIpMa+i/cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="220419879"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.98]) ([10.125.111.98])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 08:34:02 -0800
Message-ID: <b7c04f27-39a9-41df-af0a-14bc5005518e@intel.com>
Date: Wed, 25 Feb 2026 09:34:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] PCI: Hide SBR from reset_methods if masked by CXL
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
 Jonathan.Cameron@huawei.com, raphael.norwitz@nutanix.com
Cc: vsethi@nvidia.com, sdonthineni@nvidia.com, smadhavan@nvidia.com,
 skancherla@nvidia.com, vaslot@nvidia.com, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20260220195259.2397847-1-vidyas@nvidia.com>
 <20260225133801.30231-1-vidyas@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260225133801.30231-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/26 6:38 AM, Vidya Sagar wrote:
> The CXL specification (e.g., CXL r3.1 v1.0, sec 8.1.5.2) defines
> the "Unmask SBR" bit in the Port Control Extensions Register.
> When this bit is 0 (default), asserting the Secondary Bus Reset (SBR) bit
> in the Bridge Control register has no effect on the downstream bus.
> 
> Currently, the Linux PCI core checks this condition in
> pci_reset_bus_function(). If SBR is masked, it returns -ENOTTY during the
> execution of the reset. However, during the probe phase (when probe=true),
> the function currently returns 0. This 0 return value incorrectly signals
> to the PCI subsystem that SBR is a viable reset method for the device.
> 
> As a result, 'bus' is listed in the device's
> /sys/bus/pci/devices/.../reset_methods attribute, even though the hardware
> is incapable of performing it. If a user attempts to write bus to reset
> method or triggers a reset that falls back to SBR, the operation fails
> with: "bash: echo: write error: Inappropriate ioctl for device" error.
> 
> This patch modifies pci_reset_bus_function() to return -ENOTTY immediately
> if cxl_sbr_masked() is true, regardless of the probe argument. This
> ensures that 'bus' is not advertised in reset_methods when the hardware
> prevents it, improving clarity for users and aligning the sysfs capability
> report with actual hardware behavior.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v2:
> * Before deciding to hide 'bus' reset method, add an extra check to make sure
>   that the link is indeed operating in the CXL mode and not in PCIe mode as
>   the spec clearly says that a '0' in 'Unmask SBR' doesn't have any effect if
>   the link is not operating in the CXL mode.
> 
>  drivers/pci/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f3244630bfd0..a176566ba56f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4915,12 +4915,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	 * If "dev" is below a CXL port that has SBR control masked, SBR
>  	 * won't do anything, so return error.
>  	 */
> -	if (bridge && cxl_sbr_masked(bridge)) {
> -		if (probe)
> -			return 0;
> -
> +	if (bridge && bridge->is_cxl && cxl_sbr_masked(bridge))
>  		return -ENOTTY;
> -	}
>  
>  	rc = pci_dev_reset_iommu_prepare(dev);
>  	if (rc) {

