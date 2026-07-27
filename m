Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0C3F8232;
	Mon, 27 Jul 2026 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151456; cv=none; b=V0ZugsPZez81VUbHnSb2wZkokYPUSApjSHYw7QTFcjTVGFbsCA4BK9/4vVFNGNYlx/+jRnC8gJ8M0HfbBzYLgbzuS461xH7CVZ/zhx5Wzc0aZnzAnYbhHqgisImX1EDmuaChD3OW87gtjxIw/ZfUr1mEx+XTT+h6StAXT983Nko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151456; c=relaxed/simple;
	bh=AZwWVfLUpRB56C2ybr5a6pVyaxMU0DcKOMz0DUMoBo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud9qP60ujAPdxI9jKJVTBZyr77v8E4NwFtYYxR80ifUat3MnHAX/fj/2FYyedcSVkIeX8dUhYV+DMaDj0iQ6NPqIlXPkPs/7g8q1zjfEPYGGK1ABu/xKy0bIRRIDfvbKEh3r3jhh4psv2JYVgWfqisWkFhzediL7kutz3H0vqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsBjr0wo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsBjr0wo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785151454; x=1816687454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZwWVfLUpRB56C2ybr5a6pVyaxMU0DcKOMz0DUMoBo4=;
  b=MsBjr0woAfeXUtdA09zO8UVITpo8CDI7O42Ldz5EUrbyaehdmelN9Vom
   lLagK8Bh/ifGDp89R6YbWC5lhsNvENX17yOnFVAvA1GvBjzZA6YpmS6ho
   oFk9hasUF/MmOCNUku4bvcVskqY8aIYWfqgiPbLqHewlaHKoGmOqHIF4r
   76jwGrJS5rDtvS5uzlluV6KqQ9ps685lozvCW9gVFzak6RCHJJAFDwVoD
   5dLP3HdDWq6A0Q24pfJzgN7QiTeL1AyhLumpOn4iDaatpsAJERd52QbHw
   ZVFCdZ3baVjqbxj/9X6OhCPHXhZjwJ88wbrzXaPUX+LPTH+hy4zpr48Vr
   A==;
X-CSE-ConnectionGUID: PZV4hTmESaatQh0Im5JHRA==
X-CSE-MsgGUID: JtoXXW9ERzGvwqXJVdXhcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85660837"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85660837"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 04:24:13 -0700
X-CSE-ConnectionGUID: B2tIAVOoRI+zMjKg/FOM+A==
X-CSE-MsgGUID: pT84ywi6RbGlA48jgsWj8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="283905711"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 27 Jul 2026 04:24:07 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B58FB99; Mon, 27 Jul 2026 13:24:06 +0200 (CEST)
Date: Mon, 27 Jul 2026 13:24:06 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Andre Eikmeyer <andre@negmaster.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 2/2] thunderbolt: Add device links for Apple T2 NHI
Message-ID: <20260727112406.GI2365036@black.igk.intel.com>
References: <20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com>
 <20260724164641.2239-3-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724164641.2239-3-atharvatiwarilinuxdev@gmail.com>

Hi,

On Fri, Jul 24, 2026 at 12:46:37PM -0400, Atharva Tiwari wrote:
> From: Andre Eikmeyer <andre@negmaster.com>
> 
> Icelake Thunderbolt NHI on T2 Macs (2018-2020). The NHI and its
> associated PCIe root ports all sit directly on the root complex
> with no upstream port. Apple's ACPI tables name Thunderbolt root
> ports as TRP0, TRP1, etc. Find them and create device links back
> to the NHI so that PCIe tunnels can be re-established after sleep.

For Ice Lake we can just add the known PCI IDs without need to look into
ACPI at all. You can look how it was done in
pcie_has_usb4_host_interface().

> And on other Thunderbolt NHI's, like Titan Ridge, the default method
> is used to add device links.

Is this for another Mac then? A Titan Ride based one? That should be a
separate patch.

> Co-developed-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> 
> Signed-off-by: Andre Eikmeyer <andre@negmaster.com>
> ---
>  drivers/thunderbolt/tb.c | 58 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index c69c323e6952..625451ff3ea0 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -6,9 +6,11 @@
>   * Copyright (C) 2019, Intel Corporation
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> +#include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_data/x86/apple.h>
>  
> @@ -3305,21 +3307,73 @@ static const struct tb_cm_ops tb_cm_ops = {
>  static bool tb_apple_add_links(struct tb_nhi *nhi)
>  {
>  	struct pci_dev *upstream, *pdev;
> -	bool ret;
> +	bool ret = false;
>  
>  	if (!x86_apple_machine)
>  		return false;
>  
> +	/* On T2 Macs with Icelake thunderbolt NHI's.
> +	 * the root ports are stored in ACPI as TRP0,
> +	 * TRP1, etc. Find them and create device links
> +	 * so that PCIe tunnels can be re-established after
> +	 * sleep.
> +	 */
> +#if IS_ENABLED(CONFIG_ACPI)
> +	if (has_apple_t2_chip && (nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI0 ||
> +				nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI1)) {
> +		struct acpi_device *adev;
> +		unsigned int slot, func;
> +		const struct device_link *link;
> +		const char *bid;
> +
> +		for (slot = 0; slot < 32; slot++) {
> +			for (func = 0; func < 8; func++) {
> +				struct pci_dev *current_pdev __free(pci_dev_put) =
> +					pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));
> +				if (!current_pdev)
> +					continue;
> +
> +				if (!pci_is_pcie(current_pdev) || pci_pcie_type(current_pdev) !=
> +						PCI_EXP_TYPE_ROOT_PORT)
> +					continue;
> +
> +				adev = ACPI_COMPANION(&current_pdev->dev);
> +				if (!adev)
> +					continue;
> +
> +				bid = acpi_device_bid(adev);
> +				if (strncmp(bid, "TRP", 3) != 0)
> +					continue;
> +
> +				link = device_link_add(&current_pdev->dev, &nhi->pdev->dev,
> +						DL_FLAG_AUTOREMOVE_SUPPLIER |
> +						DL_FLAG_PM_RUNTIME);
> +				if (link) {
> +					dev_dbg(&nhi->pdev->dev, "created link from %s\n",
> +						dev_name(&current_pdev->dev));
> +					ret = true;
> +				} else {
> +					dev_warn(&nhi->pdev->dev,
> +						"device link creation from %s failed\n",
> +						dev_name(&current_pdev->dev));
> +				}
> +			}
> +		}
> +		return ret;
> +	}
> +#endif
> +
>  	switch (nhi->pdev->device) {
>  	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
>  	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
>  	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
>  	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
> +	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
> +	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
>  		break;
>  	default:
>  		return false;
>  	}
> -
>  	upstream = pci_upstream_bridge(nhi->pdev);
>  	while (upstream) {
>  		if (!pci_is_pcie(upstream))
> -- 
> 2.43.0
