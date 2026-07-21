Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F03C13F2;
	Tue, 21 Jul 2026 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624640; cv=none; b=gDbcQVtjwBojrZ5saXI/yUnPTbw42qmQdxHkhmMSp3WNCnQkKALi8ZR77bQtvtKAw1nJyIemAB4diK6HkAdE59xTjPxsqSR1UU8qRS7BpBu0qXCO668wSMOzpzhm1HHyHg/kcgQyzjIPEKkxNad15DRLyR2qHzRpW/y27Jn+1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624640; c=relaxed/simple;
	bh=eu23ebjcIur2cA0SO+mhe3VXUBG3ctpCWPkoCbA6vfQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H24p7R7q8LeVlc69EZ1tdZg3yYQeZkXNoIi9BZzt3vX5TEUHXevG0XFGXUSjAuXY44QPQ/RD7Lq2bQLDZGMkeF1o8Q69IP4l7STXdE4DgTjIQ8xLV9/b4ad+SXdmQZPBXA4n0hB6PmhRYbmRIiibvCxQWrFDxHAOzwWrX7aAaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7J0cryg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7J0cryg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784624638; x=1816160638;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eu23ebjcIur2cA0SO+mhe3VXUBG3ctpCWPkoCbA6vfQ=;
  b=F7J0crygNSRqoIsZV5ETp7I1RwG5OZUQ9PMQ0dXPIVbW9tjLjnjXgW7i
   /uCA6t6dnb98U939qIBVi06zyar9wYGamoWBhSqpul3XDwWxH97tzQBVu
   4Vd/pNhRxJO7Dyu8lKkAMnDnhpog0ZtUpsJkE6u0OVMd79A7B9v+IZC56
   vgWQerX2UWdZTy28yZFu69d4PpnqLkMO4Ec21OiyRJ33GqYVNrnsANnYj
   0sZRa1VjzPNZdtdlN8LQTm5jckPN8QmTIjz1VkWPAQktelSanCi6f+Svv
   mg4BQX4tLheg3ROo+mT2sppLVUTKkdlZDOMX0HC1NdQInlQi2gBdN7xNQ
   Q==;
X-CSE-ConnectionGUID: /RPPt2v4SrGEpI4L5EVA2w==
X-CSE-MsgGUID: UzKMkreXTmWHZSNSiuR3vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96577996"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="96577996"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 02:03:57 -0700
X-CSE-ConnectionGUID: ReH9/eo/Qy6y3ccYx0//kQ==
X-CSE-MsgGUID: IuNPDpkOQnuPL3+jbPVqCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="261484237"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 02:03:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 12:03:45 +0300 (EEST)
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
cc: Andre Eikmeyer <andre@negmaster.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Andreas Noever <andreas.noever@gmail.com>, 
    Mika Westerberg <westeri@kernel.org>, 
    Yehezkel Bernat <YehezkelShB@gmail.com>, Hans de Goede <hansg@kernel.org>, 
    Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
    Roberto Sassu <roberto.sassu@huawei.com>, 
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
    Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
    James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-usb@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
    linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] thunderbolt: Add device links for Apple T2 NHI
In-Reply-To: <20260721063412.11588-3-atharvatiwarilinuxdev@gmail.com>
Message-ID: <08b02889-82b7-048b-760b-cc84a778545f@linux.intel.com>
References: <20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com> <20260721063412.11588-3-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Jul 2026, Atharva Tiwari wrote:

> From: Andre Eikmeyer <andre@negmaster.com>
> 
> Thunderbolt NHI on T2 Macs (2018-2020). The NHI and its
> associated PCIe root ports all sit directly on the root complex
> with no upstream port. Apple's ACPI tables name Thunderbolt root
> ports as TRP0, TRP1, etc. Find them and create device links back
> to the NHI so that PCIe tunnels can be re-established after sleep.
> 
> Co-developed-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> 
> Signed-off-by: Andre Eikmeyer <andre@negmaster.com>
> ---
>  drivers/thunderbolt/tb.c | 51 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index c69c323e6952..0cdffcf577cd 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2019, Intel Corporation
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> @@ -3305,11 +3306,59 @@ static const struct tb_cm_ops tb_cm_ops = {
>  static bool tb_apple_add_links(struct tb_nhi *nhi)
>  {
>  	struct pci_dev *upstream, *pdev;

This file seems to have a pre-existing lack of pci.h include, please add 
it now when doing pci related code.

> -	bool ret;
> +	bool ret = false;
>  
>  	if (!x86_apple_machine)
>  		return false;
>  
> +	/* On T2 Macs. the root ports are stored in ACPI as TRP0,
> +	 * TRP1, etc. Find them and create device links
> +	 * so that PCIe tunnels can be re-established after
> +	 * sleep.
> +	 */
> +	if (has_apple_t2_chip && IS_ENABLED(CONFIG_ACPI)) {
> +		struct acpi_device *adev;
> +		unsigned int slot, func;
> +		const struct device_link *link;
> +		const char *bid;
> +
> +		for (slot = 0; slot < 32; slot++) {
> +			for (func = 0; func < 8; func++) {
> +				pdev = pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));
> +				if (!pdev)
> +					continue;
> +
> +				if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) !=
> +						PCI_EXP_TYPE_ROOT_PORT)
> +					goto put_pdev;
> +
> +				adev = ACPI_COMPANION(&pdev->dev);
> +				if (!adev)
> +					goto put_pdev;
> +
> +				bid = acpi_device_bid(adev);
> +				if (strncmp(bid, "TRP", 3) != 0)
> +					goto put_pdev;
> +
> +				link = device_link_add(&pdev->dev, &nhi->pdev->dev,
> +						DL_FLAG_AUTOREMOVE_SUPPLIER |
> +						DL_FLAG_PM_RUNTIME);
> +				if (link) {
> +					dev_dbg(&nhi->pdev->dev, "created link from %s\n",
> +						dev_name(&pdev->dev));
> +					ret = true;
> +				} else
> +					dev_warn(&nhi->pdev->dev,
> +						"device link creation from %s failed\n",
> +						dev_name(&pdev->dev));

Please only use balanced braces.

> +
> +put_pdev:
> +	pci_dev_put(pdev);

I think you can use __free() with it and avoid the label. You cannot then 
reuse the existing pdev variable for it but declare it in this block while 
you assign to it.

This line would be misaligned anyway but better get rid of goto logic 
anyway.

> +			}
> +		}
> +		return ret;
> +	}
> +
>  	switch (nhi->pdev->device) {
>  	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
>  	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
> 

-- 
 i.

