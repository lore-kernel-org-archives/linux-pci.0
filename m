Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62571FC8;
	Tue,  2 Jun 2026 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431491; cv=none; b=D4AxXpYglnXRvbSlDt9pWg5aLFNpj1D4pSl+rOKj0ZI8ZEHW7m69YWRBs7riPAcEmTv5LkmFIfsUvcbiJMxFDiZfynxo9cpG/bGmST7IcmQ6xFgnQeF7MCqsdpJnnnOXq0BTswZrAAxSdM3Sz5/G0nQXm4oBim8XSnYcBEjLs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431491; c=relaxed/simple;
	bh=cLGDD99pERY+puEjKEGdBo2qaj7LeiqKqZuYQyILfZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgNYU2ZQklaofhAZnbhgitjQJsbhqgYTLtHG9Q5/RUu7S8jeCW1hmUjusc0m5bgL/p/IXBW8lPkyoaTdabtDVT+cvgn7qp61k4X/zKS9jpdx/C0SrcBAzMWBbVB2pMVYnL8wnCeXiY9qvCZ8zVNvAFtt8osbXxZv5ARxdcHXOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TW/V/QLA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TW/V/QLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780431490; x=1811967490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cLGDD99pERY+puEjKEGdBo2qaj7LeiqKqZuYQyILfZM=;
  b=TW/V/QLAvrjnixOuzYL2q3C3Sla7csh4KLC7dIYppEdAqzvDqoLD+GHC
   J52bBr6tnL0nUiOS5dotFWdN9z9lY4FJWkfw2Tfb65K4acYBcejzVBBS0
   al4CkIeewZmRhF4om1U245vyrZtxKiCNSW9sBQFMC4Lvyw+5nmCu7MVum
   tB07QaDdVyE51KJbUE6hLJX7DrUdowUvZqK3m0jtUQrc0y0kKIX/8ABbd
   gdfakIfhOb9Le8pVnSeki6J1CegDANUoeciKovQBOCif/FKXGMndpZFnN
   8wzTqUIp9A/C2fR6FM/raWWqpAXTzvDwimU4kGWSq0BCCCcYlLPyEUfCC
   A==;
X-CSE-ConnectionGUID: lits8tSrT3C/etdrhOsEpQ==
X-CSE-MsgGUID: wobl0GXpQdunBEUdZNK8Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91915330"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="91915330"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 13:18:09 -0700
X-CSE-ConnectionGUID: fKXhjXCjTeib+CPGytZnKw==
X-CSE-MsgGUID: mXz6W4c5RbmRchmnaOn0Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="241025903"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.56]) ([10.125.108.56])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 13:18:07 -0700
Message-ID: <8b9a46c4-7e3a-49a0-b2b0-845218bd43bf@intel.com>
Date: Tue, 2 Jun 2026 13:18:06 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] PCI: Export pci_dev_save_and_disable() and
 pci_dev_restore()
To: Srirangan Madhavan <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, alwilliamson@nvidia.com,
 Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-3-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260528083154.137979-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 1:31 AM, Srirangan Madhavan wrote:
> Export pci_dev_save_and_disable() and pci_dev_restore() so CXL reset
> orchestration can reuse the PCI core reset lifecycle for non-standard
> reset flows.
> 
> These helpers invoke driver reset_prepare/reset_done callbacks, save and
> restore PCI config state, and disable the device while the caller holds
> the device lock.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/pci/pci.c   | 22 ++++++++++++++++++++--
>  include/linux/pci.h |  2 ++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d34266651ad0..75d2f4074750 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5003,7 +5003,15 @@ void pci_dev_unlock(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_dev_unlock);
>  
> -static void pci_dev_save_and_disable(struct pci_dev *dev)
> +/**
> + * pci_dev_save_and_disable - Save device state and disable it
> + * @dev: PCI device to save and disable
> + *
> + * Save the PCI configuration state, invoke the driver's reset_prepare()
> + * callback if present, and disable the device by clearing the Command
> + * register. The device lock must be held by the caller.
> + */
> +void pci_dev_save_and_disable(struct pci_dev *dev)
>  {
>  	const struct pci_error_handlers *err_handler =
>  			dev->driver ? dev->driver->err_handler : NULL;
> @@ -5036,8 +5044,17 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>  	 */
>  	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
>  }
> +EXPORT_SYMBOL_GPL(pci_dev_save_and_disable);

Maybe only export it to CXL namespace to reduce the scope?

>  
> -static void pci_dev_restore(struct pci_dev *dev)
> +/**
> + * pci_dev_restore - Restore device state after reset
> + * @dev: PCI device to restore
> + *
> + * Restore the saved PCI configuration state and invoke the driver's
> + * reset_done() callback if present. The device lock must be held by the
> + * caller.
> + */
> +void pci_dev_restore(struct pci_dev *dev)
>  {
>  	const struct pci_error_handlers *err_handler =
>  			dev->driver ? dev->driver->err_handler : NULL;
> @@ -5054,6 +5071,7 @@ static void pci_dev_restore(struct pci_dev *dev)
>  	else if (dev->driver)
>  		pci_warn(dev, "reset done");
>  }
> +EXPORT_SYMBOL_GPL(pci_dev_restore);

same comment as above

>  
>  /* dev->reset_methods[] is a 0-terminated list of indices into this array */
>  const struct pci_reset_fn_method pci_reset_fn_methods[] = {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c11..d6303e16e11b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2012,6 +2012,8 @@ void pci_dev_lock(struct pci_dev *dev);
>  int pci_dev_trylock(struct pci_dev *dev);
>  void pci_dev_unlock(struct pci_dev *dev);
>  DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
> +void pci_dev_save_and_disable(struct pci_dev *dev);
> +void pci_dev_restore(struct pci_dev *dev);
>  
>  /*
>   * PCI domain support.  Sometimes called PCI segment (eg by ACPI),

