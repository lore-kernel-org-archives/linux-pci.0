Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968E3B19CA;
	Tue, 10 Mar 2026 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182238; cv=none; b=kBwQNKfj+ffmyR6sH730+nk6R8upgoSCCF1uWsasAFsg9XDu9w/eARDKQQvwii4mORDHsUvBkMwRGlQXdZCv2Acc03+kQLgASl5Ngu/2hgj/jc6qZJDhTCUqrbgAJCvjAoqbMF75hJutk6BUrm3IE9oqh0chR2chKZ9YdULx7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182238; c=relaxed/simple;
	bh=pTL1Wf512hcnMUtFReWLSplTd5JUPyVtfFY07DdMnbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KiHUNQU+0arlNJ1TheyoTrinIHz8HQiht4xBnd6YNXtU3C/kWTo74yoamrxLa78T4yYZcMMjAEdYS4BQXugEp1kaBkAtJb13O0/90aP5vdLMzfHRjs8PLt7cTqrHAW6Xk2PGF7g8r/KPfwyg9GBNI1ItlFQIFeV7jgxGJrV38CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnTa/+hB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnTa/+hB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491BEC19423;
	Tue, 10 Mar 2026 22:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773182238;
	bh=pTL1Wf512hcnMUtFReWLSplTd5JUPyVtfFY07DdMnbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UnTa/+hBxYXfLDDm5K73yF5u3g5IFAmfczZvR70oOVe3ttdzzCLq/hI/9JJXrZw/D
	 YmzQG+DbD5pUlWEpU5JFzvvMCuHl1vttHkQ3HS73fvQjW0sH0AO6kWnEJFVI1Rx2J3
	 8Vxzt5qU3M2ZMXFMSmbYyOtBA6FanJHqvqhMK+Lf7qOnTjbn7dwtyGjeP9Beb1ulcH
	 fWOgFeUY039vZQiKCHLYtv0/tJa+BkffH5bChwI0P12qutZYfvUiu60KNIBmFwB7XX
	 bS3/vjtcEKAZMStfNCpwpS3HjlIiVggT+SkauNtHJzcOeeMj4QY8Hv8htTC7J2Ej6W
	 sjSBMGL1Ys09g==
Date: Tue, 10 Mar 2026 17:37:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] PCI: of: Remove max-link-speed generation
 validation
Message-ID: <20260310223717.GA835760@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308142629.75392-2-18255117159@163.com>

On Sun, Mar 08, 2026 at 10:26:28PM +0800, Hans Zhang wrote:
> The of_pci_get_max_link_speed() function currently validates the
> "max-link-speed" DT property to be in the range 1..4 (Gen1..Gen4).
> This imposes a maintenance burden because each new PCIe generation
> would require updating this validation.
> 
> Remove the range check so the function returns the raw property value
> (or a negative error code if the property is missing or malformed).
> Callers must now validate the returned speed against the range they
> support.  A subsequent patch adds such validation to the DWC driver,
> which is the primary user of this function.
> 
> This change allows future PCIe generations to be supported without
> modifying drivers/pci/of.c.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Mani's right that we shouldn't have a window without any validation.
I hope I didn't otherwise.

> ---
>  drivers/pci/of.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 9f8eb5df279e..cff5fd337c2b 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -889,10 +889,11 @@ EXPORT_SYMBOL_GPL(of_pci_supply_present);
>  int of_pci_get_max_link_speed(struct device_node *node)
>  {
>  	u32 max_link_speed;
> +	int ret;
>  
> -	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> -	    max_link_speed == 0 || max_link_speed > 4)
> -		return -EINVAL;
> +	ret = of_property_read_u32(node, "max-link-speed", &max_link_speed);
> +	if (ret)
> +		return ret;
>  
>  	return max_link_speed;
>  }

From AI review (gemini/gemini-3.1-pro-preview):

  By removing the upper bounds check here, the returned max_link_speed
  value can now be arbitrarily large if configured incorrectly in the
  device tree. While the commit message notes that a subsequent patch
  adds validation to the DWC driver, there are several other callers
  in the tree that assume the returned value is bounded. These drivers
  remain vulnerable to out-of-bounds accesses and hardware
  misconfiguration at the end of this patch series.

  For example, in drivers/pci/controller/pcie-rzg3s-host.c, the
  returned value is used directly as an array index. Could this cause
  an out-of-bounds read on pcie_link_speed[]?

I think this is a valid concern, and I think we should protect
pcie_link_speed[] by making it static and accessing it via a function
that validates the index.  It's too hard to enforce validation at
every place that uses it.

I think you're going to have to:

  - Validate every use of dw_pcie.max_link_speed (set from
    of_pci_get_max_link_speed()) in the dwc glue drivers

  - Validate the return from of_pci_get_max_link_speed() at every
    other caller.  It looks like j721e_pcie_set_link_speed(),
    brcm_pcie_probe(), mtk_pcie_setup(), rzg3s_pcie_probe() would need
    that.

Right now we validate inside of_pci_get_max_link_speed(), which can
help avoid generic problems like indexing pcie_link_speed[], but it
can't account for individual driver restrictions.  So I do still think
you're right to move it from drivers/pci/of.c to the individual
drivers because those drivers are where it's really important, and it
avoids changing a common place for driver-specific reasons.  We're
just going to have to strictly enforce it in those drivers.
