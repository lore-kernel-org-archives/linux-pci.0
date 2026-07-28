Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F01F8755;
	Tue, 28 Jul 2026 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214130; cv=none; b=XPLrMne2cOlszuM/phpOkCTN1LL5dJJ/dK8n5JiBAiPUSTwPqZGBB1jaFn/hjsCgmj4BLatnfYzk9TsMv+F9tkBzv9pGhfBHh9+pO5FRN8mqEX012mnVpqOnv2Di9WuF4hqBC/P+J25KrMo5aN8k/eG8APGb+uLxe8S0LJICXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214130; c=relaxed/simple;
	bh=mVvYjCGpEIs/ZVmt7GUUmpQHRMrA2O2xmFppm7/BzQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0NimMHQE2rLId0kWYE1MiXUNynd7VLwqrwQufhaz9GWbUE4Tz/tQDjTK/QHkiUJJTcZ3OBpXRIsYthmP2ycvWcR7HSilR5JqhA+GakqJi2yRiqKWGDMXa15O97CF6Ivbcaxn60WSi1tVtTOfKZDYcCZ3q9aUU60U7dubJE3WCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOfrZ1zy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOfrZ1zy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785214129; x=1816750129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mVvYjCGpEIs/ZVmt7GUUmpQHRMrA2O2xmFppm7/BzQM=;
  b=fOfrZ1zyRUvJH9AHhn1qRZdqeypx4LHNxDFjy1DiAn2Acs1nBop2wabX
   barXrxYI7zFX9dkwRIMIS+nn3HqK5l2mX+pXbIlV8xWgSh8YZlpgI1Rs8
   Lim+0FpNWaBhQxQfLtyzp6SojjxO3s1rONZmld3Vz5PdFESWRjgbmZzRK
   pQbamB7ax3V6TKFHE8xtjV44VNbFgsB4UO9zuUA7gXbRWqHeUnliCHnUT
   DzjNsOhVkmaWn9vurXnftYOG77bA2XpSLm1Rh2WmzYr2luKQoa5uzP8Qq
   Qorhtd0nKwx++co8IGTQTngoq3nqbLVOEAbfI7J64fArW3zrsXQuCvAb5
   w==;
X-CSE-ConnectionGUID: 9GBzbgmaRXmFJ/ACkr32bw==
X-CSE-MsgGUID: Vzyuq/31RrWQXAVcg5hNnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85640394"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85640394"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 21:48:48 -0700
X-CSE-ConnectionGUID: bkycI+ykQPqDZtFVL2YxLQ==
X-CSE-MsgGUID: RgRwljhqQOKJzgjJjvSe0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="297835036"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 27 Jul 2026 21:48:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0609699; Tue, 28 Jul 2026 06:48:41 +0200 (CEST)
Date: Tue, 28 Jul 2026 06:48:41 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v5 2/2] thunderbolt: Add device links for Apple T2 NHI
Message-ID: <20260728044841.GP2365036@black.igk.intel.com>
References: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
 <20260727211807.1223-3-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727211807.1223-3-atharvatiwarilinuxdev@gmail.com>

On Mon, Jul 27, 2026 at 05:18:03PM -0400, Atharva Tiwari wrote:
> Ice Lake Thunderbolt NHI on T2 Macs (2018–2020). The NHI and its
> associated PCIe Root Ports all sit directly on the Root Complex
> with no upstream port. Identify the tunneled PCIe Root Ports by
> their PCI IDs and create device links back to the NHI so that
> PCIe tunnels can be re-established after sleep.
> 
> And on other T2 Thunderbolt NHI's, like Titan Ridge, the default method
> is used to add device links.
> 
> Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> 
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  drivers/thunderbolt/tb.c | 54 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index c69c323e6952..9b80e9339728 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -9,6 +9,7 @@
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> +#include <linux/pci.h>

We should not be calling PCI functions anymore from the SW CM core. We have
pci.c for that.

>  #include <linux/pm_runtime.h>
>  #include <linux/platform_data/x86/apple.h>
>  
> @@ -3305,21 +3306,70 @@ static const struct tb_cm_ops tb_cm_ops = {
>  static bool tb_apple_add_links(struct tb_nhi *nhi)

I wonder if we can put this to pci.c, rename it to tb_pci_add_links()
instead.

>  {
>  	struct pci_dev *upstream, *pdev;
> -	bool ret;
> +	bool ret = false;
>  
>  	if (!x86_apple_machine)
>  		return false;

BTW, why you need to differentiate T2 vs. the rest of Apple x86? Don't this
variable do?

>  
> +	/* On T2 Macs with Ice Lake Thunderbolt NHIs,
> +	 * identify the tunneled PCIe Root Ports by their PCI IDs
> +	 * and create device links so that
> +	 * PCIe tunnels can be re-established after sleep.
> +	 */
> +	if (has_apple_t2_chip && (nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI0 ||
> +				nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI1)) {
> +		unsigned int slot, func;
> +		const struct device_link *link;
> +
> +		for (slot = 0; slot < 32; slot++) {
> +			for (func = 0; func < 8; func++) {
> +				struct pci_dev *current_pdev __free(pci_dev_put) =
> +					pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));

I'm not fan of __free() and the like so let's not use it here.

Also you don't need to scan all the slots. Just look for the tunneled
downstream ports based on their PCI IDs like we do already.

> +				if (!current_pdev)
> +					continue;
> +
> +				if (!pci_is_pcie(current_pdev) || pci_pcie_type(current_pdev) !=
> +						PCI_EXP_TYPE_ROOT_PORT)
> +					continue;
> +
> +				switch (current_pdev->device) {
> +				case 0x8a1d:
> +				case 0x8a1f:
> +				case 0x8a21:
> +				case 0x8a23:
> +					break;
> +				default:
> +					continue;
> +				}
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

This is unrelated change.

>  	upstream = pci_upstream_bridge(nhi->pdev);
>  	while (upstream) {
>  		if (!pci_is_pcie(upstream))
> -- 
> 2.43.0
