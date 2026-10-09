Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB54AD7C6;
	Fri,  9 Oct 2026 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542662; cv=none; b=kmE0yLmVcSRXCRGOQOOLsAu1V00WKWMmI3e+MqrULyQwgkxNz7XN/xST7ahoY0mdCowt69dgosGhvr3seuLAut6xLdjBLDzYucpdF40aeYpVda9wVIIKshv6bckjkFOobbxOYdTBNhplylDnLdQFokhBa9zNiuQOGhtbCsZaKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542662; c=relaxed/simple;
	bh=NtOB5u3xXC7AtT7DSlv4r4hkOWPcd9HNXuQ7sRxZGXM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R0HjW41S/tUgJRHNaRjb5MJJAleAxYxuSIslgDTapX+iMrHtKenLjC9gtDnzYhlGXyqtsZc010GBCAPb+j/UPgImnAmNgWMg4QonhyG5mGgTYmTz3vwACEnrS+wweWRm1C8CTCVDfFa3F5KvqrfD95EbobpluOtjKopGCiIUMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHZDoYNP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHZDoYNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791542659; x=1823078659;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NtOB5u3xXC7AtT7DSlv4r4hkOWPcd9HNXuQ7sRxZGXM=;
  b=ZHZDoYNPmkMZcdiDkT3sdbTX0VfzZGjKrd7r9ARpmq/S6CFcOO1EKqno
   F01HthKTpDxT70HbCGeId867DvZFSb0JqJXZ/nr1SImLw1ExSq72Mm5Ah
   Q9u2WIdnXOyziiGAugQUgzsN1gZnhP+ACFL7fEyAFiYp4Ms30zVMTzpi/
   Azg2QEaOev8N/f5gcmT89sCYD0GPrC88WCuvPMpt00PYZseErhKXm3JQs
   bnQ9XO4HLNBxFI/t0NHPY46YhyXQipCsTlvIeW69Q0CGquCT9cjLgEMIT
   coJlVo5LrMnjV7YcWPM1grVH5iFU/xFJ/ctCcIcuNNxk2WLS0h9pjAmhr
   w==;
X-CSE-ConnectionGUID: /eHWMUJVT22kPcXjcLT/7g==
X-CSE-MsgGUID: hq7i/aP7RjmZZs6WqxMdrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="233441"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="233441"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:44:18 -0700
X-CSE-ConnectionGUID: ELnovMTKTbKKv2lBtwlv8w==
X-CSE-MsgGUID: tbMZuHvKSsOTq8URyEw6Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="227521"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.39])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:44:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Oct 2026 13:44:09 +0300 (EEST)
To: Alex Elder <elder@riscstar.com>
cc: bhelgaas@google.com, lizhi.hou@amd.com, herve.codina@bootlin.com, 
    andrea.porta@suse.com, daniel@riscstar.com, mohdayaa@qti.qualcomm.com, 
    lbiancon@qti.qualcomm.com, mani@kernel.org, robh@kernel.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: of: introduce
 of_pci_update_endpoint_node_ranges()
In-Reply-To: <20260924222444.1351466-4-elder@riscstar.com>
Message-ID: <25fe5129-6573-2102-4801-f1d372fe25b4@linux.intel.com>
References: <20260924222444.1351466-1-elder@riscstar.com> <20260924222444.1351466-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Sep 2026, Alex Elder wrote:

> Commit 407d1a51921e9 ("PCI: Create device tree node for bridge")
> introduced the PCI_DYNAMIC_OF_NODES Kconfig option, which creates
> a devicetree node for a PCI bridge as part of pci_bus_add_device().
> Its successor commit ae9813db1dc5a ("PCI: Add quirks to generate
> device tree node for Xilinx Alveo U50") shows how to use a PCI final
> fixup quirk to also create a devicetree node for a non-bridge PCI
> device.  In both cases, of_pci_make_dev_node() uses an OF changeset
> to dynamically create a node populated with appropriate properties
> and apply it to the live devicetree.
> 
> The dynamic devicetree node for a PCI device will include a "ranges"
> property, and a new type of 3-cell address is introduced for use
> within an endpoint.  The endpoint's ranges property will contain a
> range entry for each of the endpoint's BARs.  The "child address"
> portion of each range will use the BAR number in the "flags" (first)
> cell in the address.  This allows addresses within the endpoint to
> be expressed relative to whatever address gets assigned to each BAR.
> 
> Unfortunately, if a PCI endpoint device had a devicetree node set
> up statically, its "ranges" property (if present) will be static,
> and it cannot contain the addresses assigned to the endpoint's BARs
> during enumeration.
> 
> This means that the "BAR number" based addressing scheme doesn't
> work for PCI endpoints whose devicetree nodes are created statically.
> 
> To remedy this, modify of_pci_make_dev_node() to dynamically create
> a "ranges" property even if the device already has a devicetree
> node--just as is done when the endpoint has none.  A few conditions:
>   - A PCI bridge node's ranges property is never updated
>   - If a PCI endpoint node defines a ranges property with a
>     non-empty value (i.e., it's not just "ranges;"), that
>     ranges property is preserved
> 
> Otherwise a new ranges property is created using assigned addresses,
> and it replaces (or adds) that property to the PCI endpoint node.
> 
> As a result, "BAR number" addresses work correctly even when the
> endpoint's devicetree node is created statically.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v3: - Don't update an existing non-empty ranges property
> 
>  drivers/pci/of.c          | 94 +++++++++++++++++++++++++++++++++++----
>  drivers/pci/of_property.c |  2 +-
>  drivers/pci/pci.h         |  1 +
>  3 files changed, 88 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 5a040ed836744..7fb5e0351719c 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -742,20 +742,98 @@ void of_pci_remove_node(struct pci_dev *pdev)
>  	of_node_put(np);
>  }
>  
> +/* Returns true if the ranges property was added or updated successfully */
> +static bool of_pci_update_endpoint_node_ranges(struct pci_dev *pdev)
> +{
> +	struct device_node *np = pci_device_to_OF_node(pdev);
> +	struct property *prop;
> +	u32 *value;
> +	u32 size;
> +
> +	prop = kzalloc_obj(*prop);
> +	if (!prop)
> +		return false;
> +
> +	value = of_pci_build_prop_ranges(pdev, &size);
> +	if (!value) {
> +		kfree(prop);
> +		return false;
> +	}
> +
> +	prop->name = "ranges";
> +	prop->length = size * sizeof(u32);
> +	prop->value = value;
> +
> +	/* The property value needs to be in big-endian byte order */
> +	while (size--)
> +		cpu_to_be32s(value++);

Add include.

-- 
 i.

> +
> +	/* of_update_property() consumes the allocated property */
> +	of_update_property(np, prop);
> +
> +	return true;
> +}
> +
> +/*
> + * Create a devicetree node for a PCI device.  If the device is a bridge
> + * and it already has a devicetree node, there's nothing further to do.
> + * If it is a bridge without an existing devicetree node, one is created
> + * dynamically.
> + *
> + * This function can also be called (via PCI quirk) for a PCI endpoint
> + * (function) that implements a PCI endpoint bus.  As with a PCI bridge,
> + * if the endpoint has no existing devicetree node, one is created
> + * dynamically.  The node will include a ranges property that maps
> + * BAR-relative addresses in the child to the PCI address ranges
> + * assigned to the PCI endpoint BARs.
> + *
> + * If an endpoint already has a devicetree node, and it includes a
> + * "pci-ep-bus" sub-node, its ranges property must still be dynamically
> + * populated so that it can take into account the BAR ranges assigned
> + * during PCI enumeration.
> + */
>  void of_pci_make_dev_node(struct pci_dev *pdev)
>  {
> -	struct device_node *ppnode, *np = NULL;
> +	struct device_node *np = pci_device_to_OF_node(pdev);
> +	struct device *dev = &pdev->dev;
> +	struct device_node *ppnode;
> +	struct of_changeset *cset;
>  	const char *pci_type;
> -	struct of_changeset *cset;
>  	const char *name;
>  	int ret;
>  
> -	/*
> -	 * If there is already a device tree node linked to this device,
> -	 * return immediately.
> -	 */
> -	if (pci_device_to_OF_node(pdev))
> +	/* See if the PCI device already has a devicetree node */
> +	if (np) {
> +		struct device_node *child;
> +		unsigned int rlen = 0;
> +
> +		/* Nothing further needed for a bridge */
> +		if (pci_is_bridge(pdev))
> +			return;
> +
> +		/*
> +		 * A ranges property is only needed if the endpoint's
> +		 * devicetree node includes a "pci-ep-bus" sub-node.
> +		 */
> +		child = of_get_child_by_name(np, "pci-ep-bus");
> +		if (!child)
> +			return;
> +		of_node_put(child);
> +
> +		/* If the ranges property is non-empty, just keep it.*/
> +		if (of_get_property(np, "ranges", &rlen) && rlen)
> +			return;
> +
> +		/*
> +		 * Otherwise create a ranges property, defining an entry for
> +		 * each BAR, and map BAR offsets to the PCI bus address based
> +		 * on the BAR's assigned range.
> +		 */
> +		if (!of_pci_update_endpoint_node_ranges(pdev))
> +			dev_err(dev, "failed to update ranges property\n");
> +
>  		return;
> +	}
>  
>  	/* Check if there is device tree node for parent device */
>  	if (!pdev->bus->self)
> @@ -794,7 +872,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  
>  	np->data = cset;
>  
> -	ret = device_add_of_node(&pdev->dev, np);
> +	ret = device_add_of_node(dev, np);
>  	if (ret)
>  		goto out_revert_cset;
>  
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 9f30b3c09a730..8e1548c4aac3c 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -116,7 +116,7 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
>   *
>   * Caller is responsible for ensuring the returned pointer gets freed.
>   */
> -static u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
> +u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
>  {
>  	bool bridge_device = pci_is_bridge(pdev);
>  	struct of_pci_range_entry *entries;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e33d3bd4b0ba..1461e52777532 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1318,6 +1318,7 @@ struct of_changeset;
>  #ifdef CONFIG_PCI_DYNAMIC_OF_NODES
>  void of_pci_make_dev_node(struct pci_dev *pdev);
>  void of_pci_remove_node(struct pci_dev *pdev);
> +u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count);
>  int of_pci_add_properties(struct pci_dev *pdev, struct of_changeset *ocs,
>  			  struct device_node *np);
>  void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge);
> 
