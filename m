Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5E1DF755;
	Fri, 20 Feb 2026 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771622491; cv=none; b=Tp5iZII70wSoUisbZ1MVNLTl977YpM4C0lAiyqGj4V6NPLz2kxO9RRtHUz7dYSdnLJQq5C8CrRGhSVCzE7NJlQNkWvXirshOFIb3y0uK38NR4Re6YixAydDVPsgDEpHCJuhs0lXTE0Sg7VT4QqaK/OAggkm5POwolBw33CUz5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771622491; c=relaxed/simple;
	bh=bUkrBcum9rV45ttLKW3UY8qSv1nhE/clRvq2R8oa9Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHvuhN0VqYe3fkcm0OxwF0L7M6TToe7zo3AWF7xJ5JVdqE215CIJIHjFl+gp9iseaNQCTgvOPXj+B62sG1+S0VmJSH+ULJDKoxZMxQTMUjmzrnloKViMCwyiVaWuqae6Gfk3HwgmpkzE6lpyowflRO/Zbz3YDeCO+mozFJfEr8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcT/lruS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcT/lruS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771622490; x=1803158490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bUkrBcum9rV45ttLKW3UY8qSv1nhE/clRvq2R8oa9Oc=;
  b=WcT/lruSYyHvKyk8gC8+0OgTRJkT/F1vt7BlcSIkDmLHfNL3VPpAXpm7
   +H546yfLDkmSzB8EBTpdv6mZNx5VjK6eAnIhe3oJYDad1z/Ov1+CkO4PI
   K7otLIunQP39MSpZw/odRgkCb0snrpS0eF/0KjBQZtyLjXoRjQYEP9U1I
   +jhfDTSCkFuyuiYwwqy53HUmhXc3NixX8GhMNtu/x10bsdX9JP6O/dhMG
   BcxHrU/KqpJ3RrPeFDkFO0r6kVWb8gVsa16K/nsLwKg2ddCHczPD8ZNTd
   EKMcjoAzLlqxfAOmGhgIAuT4IjgYFoYlc8eFcVCmCkOORLBI3ga0kT62v
   g==;
X-CSE-ConnectionGUID: FfenKU8IRxmYl7PLi6aslQ==
X-CSE-MsgGUID: 4BJc7BOTSQihuvDSvVwoEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="84172600"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="84172600"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 13:21:29 -0800
X-CSE-ConnectionGUID: ht+gyMkFT3+BLn3Humo8lQ==
X-CSE-MsgGUID: ZUPap9+FSeW6ePlC5CoJYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="219499078"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.116]) ([10.125.110.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 13:21:28 -0800
Message-ID: <835de7c9-a64f-4aaa-95e0-b91c2ae5885e@intel.com>
Date: Fri, 20 Feb 2026 14:21:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] PCI: Hide SBR from reset_methods if masked by CXL
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
 Jonathan.Cameron@huawei.com, alex.williamson@redhat.com,
 raphael.norwitz@nutanix.com, Dan Williams <dan.j.williams@intel.com>
Cc: vsethi@nvidia.com, sdonthineni@nvidia.com, smadhavan@nvidia.com,
 skancherla@nvidia.com, vaslot@nvidia.com, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20260220195259.2397847-1-vidyas@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260220195259.2397847-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/26 12:52 PM, Vidya Sagar wrote:
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


The "Unmask SBR" bit is a toggle bit. It does not give indicator whether the device is capable of SBR or not. The original thought was that if the user is issuing CXL SBR, you know what you are doing and the kernel will set that bit and issue the SBR.

DJ

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
> ---
>  drivers/pci/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f3244630bfd0..57e24300d1c7 100644
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
> +	if (bridge && cxl_sbr_masked(bridge))
>  		return -ENOTTY;
> -	}
>  
>  	rc = pci_dev_reset_iommu_prepare(dev);
>  	if (rc) {

