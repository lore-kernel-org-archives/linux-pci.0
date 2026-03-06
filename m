Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A175F3FB04E;
	Fri,  6 Mar 2026 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816937; cv=none; b=hXpcUu8FWaTggQNiZGoGJ+Y3fLD9AzPFGuqbi1/nX8+3cQV3bo6F1hPPcJ8W9auP1pOUdwiP1h1rrqG2TlvC4Fyb9kXePznMwdxcVkfwhuzwUmXMy3d+zv7ssj3lxsoMYk6Es3SckdJGuDjbO94dbT20e/BeWU6Gt2xPmEucORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816937; c=relaxed/simple;
	bh=hjiKnpECdX7EtIgLyl5V8xDsSvicW3fEguFFEaYFC0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T7AyVGx1wp+Z/xtEduFKyEm5mmEjUSZeUO5NlJFwSZD/F1CbGjrk96o7reHOoFiMnDOAndjLryWdIYca+7nuOFFdat3VZjEUwJ8A3er/aPecRghwJpGnSkGE6unxF33omTVg5M5fUsSLqgFeiZxx/lUNyrdNF7tSZDOB1UWsW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv+gVvMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv+gVvMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66121C4CEF7;
	Fri,  6 Mar 2026 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772816937;
	bh=hjiKnpECdX7EtIgLyl5V8xDsSvicW3fEguFFEaYFC0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jv+gVvMDIwSh5KLBkwK8E+hTDmDr1q0rkrhBNp3V8YSYVar9SVQXrdNHCa+M7ajfa
	 GiCuRt8p0Da4N9jAkQ9jMNbeekjCZ86Ljgxs7BuWC7yAK8bEz6QlJjySaKBUwxiiFi
	 FPM775aMyE22iImv/qZYIoNU5qKPosC2Ah42Zxz8Pse9cOQNNUHqd7rv+uJalaWW18
	 ZYAR8Pzbnq5jFRoRh3g5M8ZX15w2guaCS4oUt+xsI5+4reyFBmtmqs8jEfKhzX9r/5
	 My0hGlRD4Yk4LscbwUN+D8A0VB2SiDcDNGUUG1jLB72pbh2TrZaC/Kn5h9iqiyV7j3
	 xSANt9Spa4pkQ==
Date: Fri, 6 Mar 2026 11:08:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, mani@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 1/1] PCI: of: Remove max-link-speed generation
 validation
Message-ID: <20260306170856.GA107733@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218132036.308094-1-18255117159@163.com>

[+cc Rob]

On Thu, Dec 18, 2025 at 09:20:36PM +0800, Hans Zhang wrote:
> The current implementation of of_pci_get_max_link_speed() validates
> max-link-speed property values to be in the range 1~4 (Gen1~Gen4).
> However, this creates maintenance overhead as each new PCIe generation
> requires updating this validation logic.
> 
> Since device tree binding validation already enforces the allowed
> values through the schema, and the callers of this function perform
> their own validation checks, this intermediate validation becomes
> redundant.
> 
> Furthermore, with upcoming SOCs using Synopsys/Cadence IP requiring
> Gen5/Gen6 support, removing this hardcoded check enables seamless
> support for future PCIe generations without requiring kernel updates
> for each new speed grade.

The upcoming SoC info seems like too much detail for the commit log.

> Remove the max-link-speed > 4 validation check while retaining the
> property existence and non-zero check. This simplifies maintenance
> and aligns with the existing validation architecture where DT binding
> and driver-level checks provide sufficient validation.

I don't think it's legit to rely on DT binding checks.  The code
should protect itself regardless of what offline binding checkers
find.

I'm not convinced that callers do their own validation.  For example,
dw_pcie_get_resources() assigns of_pci_get_max_link_speed() to
pci->max_link_speed with no validation at all.

That's in the DWC core, so it's probably OK to expect the actual
controller drivers to validate pci->max_link_speed when they use it,
but dw_pcie_config_presets() uses pcie_link_speed[pci->max_link_speed]
and I don't see an obvious check that prevents an out-of-bounds
reference there.

I think this patch is the right direction -- I don't think there's
anything in drivers/pci/of.c that *uses* the value of
"max-link-speed", so it would be nice if it didn't have to be updated
for every generation.

> Signed-off-by: Hans Zhang <18255117159@163.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
> Changes for v6:
> - It'd be good to return the actual errno as of_property_read_u32() can return
>   -EINVAL, -ENODATA and -EOVERFLOW. (Mani)
> 
> Changes for v5:
> https://patchwork.kernel.org/project/linux-pci/patch/20251218125909.305300-1-18255117159@163.com/
> 
> - Delete the check for speed. (Mani)
> 
> Changes for v4:
> https://patchwork.kernel.org/project/linux-pci/patch/20251105134701.182795-1-18255117159@163.com/
> 
> - Add pcie_max_supported_link_speed.(Ilpo)
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20251101164132.14145-1-18255117159@163.com/
> 
> - Modify the commit message.
> - Add Reviewed-by tag.
> 
> Changes for v2:
> https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
> - The following files have been deleted:
>   Documentation/devicetree/bindings/pci/pci.txt
> 
>   Update to this file again:
>   dtschema/schemas/pci/pci-bus-common.yaml
> ---
>  drivers/pci/of.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..b56fdbcb3d72 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -888,10 +888,11 @@ bool of_pci_supply_present(struct device_node *np)
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
> -- 
> 2.34.1
> 
