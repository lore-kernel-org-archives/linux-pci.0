Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983A2773D8;
	Thu, 19 Feb 2026 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536760; cv=none; b=bugGWSQNYUz+zDQBQWu5sqX/yrlAwEfUA78rYmb7TVHjMwkVccUc/AvXSiCmOWPJTCVjNv1Vn8SRI7kKxD5rN64fRj+B6qWIwa2g3RZ1G58xQNrkEtbWaVLtlqSP+V35DJII3/nqhfmgUdfnA5PpnsKX4WfUw1UqTxUdYG45b5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536760; c=relaxed/simple;
	bh=3mlXZG0FI4PDQwXvFhPqsvtwTAzaebDO5b2Oql1FGA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CqF/IBgPKjwdN3ZBwPY/nrUW7oOFq7B94F4/MptRnjQX/HB0Yr81tLq10dQMfchL47d8zgAkhNu2QsaDlQy4ri8hFqHnFphnd5P8EifWUIgbGFfGXZQkBoXPMyY8jqOygUzvt80C2qwuqYLw4ZVsxdFDgsX+fEWTyrY2piREw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcKjLexv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcKjLexv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BC9C4CEF7;
	Thu, 19 Feb 2026 21:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771536759;
	bh=3mlXZG0FI4PDQwXvFhPqsvtwTAzaebDO5b2Oql1FGA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bcKjLexvD+WiCfbVaE/g+Kd40W+vS5Y7WGXiEXkRzFnzSoipCyxekbXID8yYLOhob
	 qESKUS3s/UJI5UdS4FUkAM/++KhuA3VIWp4Az6kPbrlNvsEcCS3SSJRjpwb73GOmqy
	 AKeji/dHfbzBToJm2gzIaKRZpc4EpOFRFG5duLCRzw9+VHQHXQpMh+DpnLQ2+/bam+
	 3qHvg8q4KAp80UrmZ8VtRqIJPcBE2hna24uZTZRQ3xHhtxvAuGb4p+oBsFV9t4ZrwW
	 VX8+O7t6LRVGe7jawVUIfyzw4sGlmFQBCYU/PuHfsX5cl7XiEdKdSvDTAVhQiaAmGK
	 dkodUo0JIcoXw==
Date: Thu, 19 Feb 2026 15:32:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	RavitejaX Veesam <ravitejax.veesam@intel.com>
Subject: Re: [PATCH 1/1] PCI: Account fully optional bridge windows correctly
Message-ID: <20260219213238.GA3498861@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218223419.22366-1-ilpo.jarvinen@linux.intel.com>

On Thu, Feb 19, 2026 at 12:34:18AM +0200, Ilpo Järvinen wrote:
> pbus_size_mem_optional() adds dev_res->add_size of a bridge window into
> children_add_size when the window has a non-optional part. However, if
> the bridge window is fully optional, only r_size is added (which is
> zero for such a window).

I guess this means we might not make a bridge window big enough for
optional resources, even if space is available?

> Also, a second dev_res entry will be added by pci_dev_res_add_to_list()
> into realloc_head for the bridge window (resulting in triggering the
> realloc_head-must-be-fully-consumed sanity check after a single pass of
> the resource assignment algorithm):
> 
>   WARNING: drivers/pci/setup-bus.c:2153 at pci_assign_unassigned_root_bus_resources+0xa5/0x260
> 
> Correct these problems by always adding dev_res->add_size for bridge
> windows and not calling pci_dev_res_add_to_list() if the dev_res entry
> exists.
> 
> Fixes: 6a5e64c75e82 ("PCI: Add pbus_mem_size_optional() to handle optional sizes")

We merged 6a5e64c75e82 for v7.0, so it looks like this fix is also
v7.0 material, right?

> Reported-by: RavitejaX Veesam <ravitejax.veesam@intel.com>

Is there a public report of this?  I didn't see anything on lore that
looked relevant.

> Tested-by: RavitejaX Veesam <ravitejax.veesam@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 32aa72456a44..0c8cbbfaf8d7 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1217,31 +1217,34 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
>  	struct resource *res = pci_resource_n(dev, resno);
>  	bool optional = pci_resource_is_optional(dev, resno);
>  	resource_size_t r_size = resource_size(res);
> -	struct pci_dev_resource *dev_res;
> +	struct pci_dev_resource *dev_res = NULL;
>  
>  	if (!realloc_head)
>  		return false;
>  
> -	if (!optional) {
> -		/*
> -		 * Only bridges have optional sizes in realloc_head at this
> -		 * point. As res_to_dev_res() walks the entire realloc_head
> -		 * list, skip calling it when known unnecessary.
> -		 */
> -		if (!pci_resource_is_bridge_win(resno))
> -			return false;
> -
> +	/*
> +	 * Only bridges have optional sizes in realloc_head at this
> +	 * point. As res_to_dev_res() walks the entire realloc_head
> +	 * list, skip calling it when known unnecessary.
> +	 */
> +	if (pci_resource_is_bridge_win(resno)) {
>  		dev_res = res_to_dev_res(realloc_head, res);
>  		if (dev_res) {
>  			*children_add_size += dev_res->add_size;
>  			*add_align = max(*add_align, dev_res->min_align);
>  		}
> +	}
>  
> +	if (!optional)
>  		return false;
> -	}
>  
> -	/* Put SRIOV requested res to the optional list */
> -	pci_dev_res_add_to_list(realloc_head, dev, res, 0, align);
> +	/*
> +	 * Put requested res to the optional list if not there yet (SRIOV,
> +	 * disabled ROM). Bridge windows with an optional part are already
> +	 * on the list.
> +	 */
> +	if (!dev_res)
> +		pci_dev_res_add_to_list(realloc_head, dev, res, 0, align);
>  	*children_add_size += r_size;
>  	*add_align = max(align, *add_align);
>  
> 
> base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
> -- 
> 2.39.5
> 
