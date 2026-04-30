Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE63AEF27;
	Thu, 30 Apr 2026 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777544241; cv=none; b=qdrUPJFBR6ZoHciaq9gsFM2ialoy4QRK1UmIC8S03htZlwuWO0KPSoeLlOXvllklT0fdSd/pTiCGTtNyJJunyuHzvaXKMX8BW7+e5mWSLK5GKgoYEYzI9twD4XyqdtGHPZjpa+HWPr6hKa5g9zadfecPcO5vbDmPdd8/aW0bfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777544241; c=relaxed/simple;
	bh=S0v5qpPb2HKsA7S/oacjg6Hic7Fw5gWZ3KFJlQyGFxk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F6QsSH+HNFTEYTkc168zFYC+0BJLD8l18xZQVm5lG1zagAvjYZ2u8dsyomZl2SMhrbt2J1/nrnFyFWjk5y3F2mRz9AGIkrprRqBz3OrWCOEA995iM64683CB4/GpzG6XXJA2QD68/S9ALKW+NUJRFBaWt5FJQM0vzgfn85gplDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyiOFJjm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyiOFJjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777544239; x=1809080239;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=S0v5qpPb2HKsA7S/oacjg6Hic7Fw5gWZ3KFJlQyGFxk=;
  b=ZyiOFJjmLJy4AkyuO032x/3bjvvfsAyxBERLWHSF2CAr5wts9KZ2vcpg
   PiLEpZmqleH33lSXxVMHxZ6iKt24fReoLcgZq5fm1gHWne+KI06W8O1ji
   75fqMFa5NNBmu2VN/e7yCCgZBYcKHFI5fqmiOKVGW/2qD2Ar2hvz/AyFg
   ix9c+HB+zNkv35To9eGAOFynZzIzA0RXYDFU+R3jjPydHN9VfEBmL32nL
   SI7EMIqvS9EdeXHYw3tWI8tDQ02yyufoxZJCnMlXuAxtP3BVqpEa/kfCu
   LW9PurBqS8qtlEHq0Wi6qppn4d4I9OG/0S3b1wuKv89wItO7CYTrMNkqm
   A==;
X-CSE-ConnectionGUID: pEFCNaezQ1iK0UQBFcLxqw==
X-CSE-MsgGUID: dL5AZ7SOQJaDgXskXWsyOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="96056592"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="96056592"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 03:17:12 -0700
X-CSE-ConnectionGUID: dO46cEGAToGz/cdyvo7yQg==
X-CSE-MsgGUID: 2GzgCBXpSsSSyJVJMKjc9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234818500"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 03:17:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 Apr 2026 13:17:05 +0300 (EEST)
To: Thomas Falcon <thomas.falcon@intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    "David E . Box" <david.e.box@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
    Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] pcie/aspm: Enable all hardware power-saving
 states by default
In-Reply-To: <20260429180647.197072-4-thomas.falcon@intel.com>
Message-ID: <dfff52bc-06ad-0531-f28a-72804620c072@linux.intel.com>
References: <20260429180647.197072-1-thomas.falcon@intel.com> <20260429180647.197072-4-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Apr 2026, Thomas Falcon wrote:

> For systems with a BIOS release date starting in 2025, default
> ASPM policy to powersupersave if supported in the ACPI FADT.
> Provide a flag, aspm_user_policy, tracking whether a user has
> requested a specific power state to give those precedence.
> Do not enable all states if user has chosen a specific policy
> or disabled ASPM using the pcie_aspm module parameter.
> 
> Suggested-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  drivers/pci/pci-acpi.c  |  4 +++-
>  drivers/pci/pcie/aspm.c | 17 +++++++++++++++++
>  include/linux/pci.h     |  1 +
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 4d0f2cb6c695..d849bc6d0c0c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1523,7 +1523,9 @@ static int __init acpi_pci_init(void)
>  	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>  		pr_info("ACPI FADT declares the system doesn't support PCIe ASPM, so disable it\n");
>  		pcie_no_aspm();
> -	}
> +	} else
> +		/* If ASPM is supported, configure the default policy here. */
> +		pcie_aspm_policy_config_init();

Please balance braces (and with comment this is multiline block anyway 
so you should use braces even because of that).

>  
>  	if (acpi_pci_disabled)
>  		return 0;
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 84d49aa8a5ba..1c81e2f2e589 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -267,6 +267,8 @@ static int aspm_policy = POLICY_POWER_SUPERSAVE;
>  #else
>  static int aspm_policy;
>  #endif
> +static int aspm_default_policy = POLICY_POWER_SUPERSAVE;
> +static bool aspm_user_policy;
>  
>  static const char *policy_str[] = {
>  	[POLICY_DEFAULT] = "default",
> @@ -1609,6 +1611,7 @@ static int pcie_aspm_set_policy(const char *val,
>  	down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	aspm_policy = i;
> +	aspm_user_policy = true;
>  	list_for_each_entry(link, &link_list, sibling) {
>  		pcie_config_aspm_link(link, policy_to_aspm_state(link));
>  		pcie_set_clkpm(link, policy_to_clkpm_state(link));
> @@ -1810,6 +1813,20 @@ static int __init pcie_aspm_disable(char *str)
>  
>  __setup("pcie_aspm=", pcie_aspm_disable);
>  
> +
> +

Extra empty lines.

> +void __init pcie_aspm_policy_config_init(void)
> +{
> +	/*
> +	 * Set ASPM policy here, enabling all power-saving states
> +	 * unless ASPM has been disabled or the user has already
> +	 * requested a policy or the systems BIOS release date
> +	 * is before the year 2025. Otherwise use BIOS defaults.
> +	 */
> +	if (!aspm_disabled && !aspm_user_policy && dmi_get_bios_year() >= 2025)

Is it good to have this 2025 check in two places as literals, should there 
be only one function which is called by both places?

> +		aspm_policy = aspm_default_policy;
> +}
> +
>  void pcie_no_aspm(void)
>  {
>  	/*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c11..36fa5579709c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1915,6 +1915,7 @@ int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
>  int pci_enable_link_state(struct pci_dev *pdev, int state);
>  int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
>  void pcie_no_aspm(void);
> +void pcie_aspm_policy_config_init(void);
>  bool pcie_aspm_support_enabled(void);
>  bool pcie_aspm_enabled(struct pci_dev *pdev);
>  #else
> 

-- 
 i.

