Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082DF4ABBC4;
	Fri,  9 Oct 2026 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542637; cv=none; b=W0yG6uoTfowEdEDJgAstVGPmQt9wtYrk8zegeXGKdPgLEF7dBmpZ0MhXteOxJa8kLTX4XhrtpofOnwTVhjGNMuwygga2kJajUr83b43Cy78uOSDhj9qMobwqOCzp7EaMrUYb3cjdXSYnkcn329GogxrrYdc/+kNT35PZDI8WL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542637; c=relaxed/simple;
	bh=t/ok+iudgJkPR+eVlj/kiNqB/upPAAqQbxS/oNQY2X0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qw2iCmY3lEVn1D1zxpImSOtC9rHMa5ta8bLn4jnuBic5Gc8UndUwJCXNxqaZmNZOkCe3vMba8yZJj3PZRoYto5lalYRPoCXLur6rDr2UID/7JAW4J8A8i3bVITDzGVhrWYqa4UlSH3fZioWR4mGejCaKBXboStlNcFDHC1vQeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dwh3QZzc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dwh3QZzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791542634; x=1823078634;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t/ok+iudgJkPR+eVlj/kiNqB/upPAAqQbxS/oNQY2X0=;
  b=Dwh3QZzc1Z134ulu0hCZ2p7HMDcbxGMwz2yOFM60t5qMnWRtusIr61si
   iwVgEpNTddnlfkkVipxXalwl1C3kd2497pZavWVype03yIDQdztBKCdM+
   T728dEhxD+Cz8SiwTyUp0i39uB59kVw6ZbefeZTnlwUIbqBmQFbOipIn5
   sY4yzVjDkk6pxxq2d4a78RBRs9RCDoA6FJDu6AduA0Jtp38PDGxpUGmrK
   b4eR8mNVRagvrFDa9bak3RCF9FLR3A0XuHq2qqQ68eBwVFIhQVoNAQvjW
   QadPhKzX8tZh9Zp8h8Dv1gGaAeCdKIFAk+VjJQgNZTjTolqAJjZY63FWt
   A==;
X-CSE-ConnectionGUID: 9jS/0/bfTPScVf0uB92f7Q==
X-CSE-MsgGUID: EYI42lKoTmCX8laYLjq6wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="233390"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="233390"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:43:53 -0700
X-CSE-ConnectionGUID: XPnxLc5KShS4sjG4oN3Jnw==
X-CSE-MsgGUID: IdVdF0KxTmqXphTKCHreOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2027304"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.39])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:43:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Oct 2026 13:43:45 +0300 (EEST)
To: Alex Elder <elder@riscstar.com>
cc: bhelgaas@google.com, lizhi.hou@amd.com, herve.codina@bootlin.com, 
    andrea.porta@suse.com, daniel@riscstar.com, mohdayaa@qti.qualcomm.com, 
    lbiancon@qti.qualcomm.com, mani@kernel.org, robh@kernel.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] PCI: of: introduce of_pci_build_prop_ranges()
In-Reply-To: <20260924222444.1351466-3-elder@riscstar.com>
Message-ID: <00eb50b8-20dd-3079-7bcf-7e30a9ff3b20@linux.intel.com>
References: <20260924222444.1351466-1-elder@riscstar.com> <20260924222444.1351466-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Sep 2026, Alex Elder wrote:

> Move the bulk of what happens inside of_pci_prop_ranges() into
> a helper function that builds up the value to be passed to
> of_changeset_add_prop_u32_array().
> 
> This helper will be used in the next commit to build the ranges
> property for a statically-defined PCI endpoint devicetree node
> when it has a "pci-ep-bus" sub-node.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/pci/of_property.c | 129 +++++++++++++++++++++++++-------------
>  1 file changed, 86 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index a6c0cca986bdc..9f30b3c09a730 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -102,57 +102,100 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
>  					       ARRAY_SIZE(bus_range));
>  }
>  
> +/*
> + * Build a "ranges" property value that defines the mapping between
> + * child and parent PCI address space for each of the given PCI
> + * device's resources.
> + *
> + * Returns a dynamically allocated array of u32 devicetree cells, or
> + * a null pointer if allocation fails.  The cell array is built as a
> + * of_pci_prop_ranges structure consisting of 8 32-bit cells in host
> + * byte order.  It is suitable for use as the value of a PCI device
> + * node "ranges" property passed to of_changeset_add_prop_u32_array().
> + * The total number of cells in the array is returned in *count.
> + *
> + * Caller is responsible for ensuring the returned pointer gets freed.
> + */
> +static u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
> +{
> +	bool bridge_device = pci_is_bridge(pdev);
> +	struct of_pci_range_entry *entries;
> +	struct of_pci_range_entry *ep;
> +	u32 resource_count = 0;
> +	struct resource *res;
> +	u32 first;
> +	u32 num;
> +	u32 i;
> +
> +	if (bridge_device) {
> +		first = PCI_BRIDGE_RESOURCES;
> +		num = PCI_BRIDGE_RESOURCE_NUM;
> +	} else {
> +		first = PCI_STD_RESOURCES;
> +		num = PCI_STD_NUM_BARS;
> +	}
> +
> +	/* First count how many resources will get a range property */
> +	res = &pdev->resource[first];

pci_resource_n()

> +	for (i = 0; i < num; i++, res++)
> +		if (resource_size(res) && !of_pci_get_addr_flags(res, NULL))

+ ioport.h

(I know you're mostly moving code around in this change so these missing 
includes are a pre-existing problem but it would be nice to finally add 
them.)

> +			resource_count++;
> +
> +	entries = kzalloc_objs(*entries, resource_count);

include

> +	if (!entries)
> +		return NULL;
> +
> +	ep = entries;
> +	res = &pdev->resource[first];

pci_resource_n()

> +	for (i = 0; i < num; i++, res++) {
> +		u64 size = resource_size(res);
> +		u32 flags;
> +
> +		if (!size || of_pci_get_addr_flags(res, &flags))
> +			continue;
> +
> +		/* Record the size in the range entry */

> +		ep->size[0] = upper_32_bits(size);
> +		ep->size[1] = lower_32_bits(size);

include.

> +
> +		/* Record the parent bus address from the resource */
> +		of_pci_set_address(pdev, ep->parent_addr,
> +				   pci_bus_address(pdev, first + i),
> +				   flags, false);
> +
> +		/*
> +		 * For a bridge device, the child address matches the
> +		 * parent address (including its flags cell).  For an
> +		 * endpoint device, the (flags) cell contains the BAR
> +		 * number, and the two address cells are zero.
> +		 */
> +		if (bridge_device)
> +			memcpy(ep->child_addr, ep->parent_addr,
> +			       sizeof(ep->child_addr));
> +		else
> +			ep->child_addr[0] = i;
> +
> +		ep++;
> +	}
> +	*count = resource_count * sizeof(*ep) / sizeof(u32);
> +
> +	return (u32 *)entries;
> +}
> +
>  static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>  			      struct device_node *np)
>  {
>  	struct of_pci_range_entry *rp;
> -	struct resource *res;
> -	int i, j, ret;
> -	u32 flags, num;
> -	u64 val64;
> +	u32 *value;
> +	u32 count;
> +	int ret;
>  
> -	if (pci_is_bridge(pdev)) {
> -		num = PCI_BRIDGE_RESOURCE_NUM;
> -		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
> -	} else {
> -		num = PCI_STD_NUM_BARS;
> -		res = &pdev->resource[PCI_STD_RESOURCES];
> -	}
> -
> -	rp = kzalloc_objs(*rp, num);
> -	if (!rp)
> +	value = of_pci_build_prop_ranges(pdev, &count);
> +	if (!value)
>  		return -ENOMEM;
>  
> -	for (i = 0, j = 0; j < num; j++) {
> -		if (!resource_size(&res[j]))
> -			continue;
> +	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", value, count);
>  
> -		if (of_pci_get_addr_flags(&res[j], &flags))
> -			continue;
> -
> -		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
> -		of_pci_set_address(pdev, rp[i].parent_addr, val64, flags,
> -				   false);
> -		if (pci_is_bridge(pdev)) {
> -			memcpy(rp[i].child_addr, rp[i].parent_addr,
> -			       sizeof(rp[i].child_addr));
> -		} else {
> -			/*
> -			 * For endpoint device, the lower 64-bits of child
> -			 * address is always zero.
> -			 */
> -			rp[i].child_addr[0] = j;
> -		}
> -
> -		val64 = resource_size(&res[j]);
> -		rp[i].size[0] = upper_32_bits(val64);
> -		rp[i].size[1] = lower_32_bits(val64);
> -
> -		i++;
> -	}
> -
> -	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", (u32 *)rp,
> -					      i * sizeof(*rp) / sizeof(u32));
>  	kfree(rp);

Isn't totally rp unused now so this frees with an uninitialized value?

>  
>  	return ret;
> 

-- 
 i.

