Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD64345753;
	Tue, 17 Mar 2026 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777465; cv=none; b=XfJZMrJoXvH/F15ifPasQbZZsOnPOH6vf4F5qT3mG6mEBaVAJdaa953hvXmBH0LEOqJYs5qHXx5rvzQ2gmAdZp6XTeISkyqQS9YnJGw2dSO5flJSJYeBe/5SJHPxTVdsFgWnYo2ruX+CMgQTBF7SZPpoSunVDMVrn8nEwa0NW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777465; c=relaxed/simple;
	bh=5iuk5HLQnShrXCR2H8x4KX7ju64cB201DN1+1DBo8OI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jaU8kTr1Geq8bhCKoATo+8GLKpr/vPDxCTRYOud7gSFVX9L4ICsBlAgTikm4zpWdX2oC+S5mjs0eUoqtO9nkzvYgt8KsYSNYjeuIzQMYtb+kjAs16ieiYQqa995FDjYxL8oqMjY45QEr/18c6O5lLczpq99bBlFau+D0jTvMfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmPCIk1H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmPCIk1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64813C4CEF7;
	Tue, 17 Mar 2026 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773777464;
	bh=5iuk5HLQnShrXCR2H8x4KX7ju64cB201DN1+1DBo8OI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dmPCIk1H2iwKJ5eY5vhnYdSr1eM4yVsqpPdP+4BeO/55Ie58PQ0QaBjYf2yrKQF22
	 J/iJoOwCkjH5yuciRDZXlPF3eReB4NhD5iP1gx9H3YkJnnmipD8413ekHAYWUuV9Ld
	 v/RvebO+pAEnYzbYeXS98hlH8/jas/Hg3oIPn175Rxuvy8mWw4P7Ll7SJERdrk6BiD
	 MK4ca2y6xOm6VvGlNpTBAR189eK/qumAoWjmHOUQYqqmDAW6PGpXLTy+pvZc/OjdPn
	 amcwnBzhYqpfAkdWlPKm0W2fXDgSuEyKmPCwh0S6drx93JEgvte/PLAa+ap9aHc8SH
	 bR44e/pFXeo6A==
Date: Tue, 17 Mar 2026 14:57:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
	raphael.norwitz@nutanix.com, vsethi@nvidia.com,
	sdonthineni@nvidia.com, smadhavan@nvidia.com, skancherla@nvidia.com,
	vaslot@nvidia.com, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI: Hide SBR from reset_methods if masked by CXL
Message-ID: <20260317195743.GA99791@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225133801.30231-1-vidyas@nvidia.com>

On Wed, Feb 25, 2026 at 07:08:01PM +0530, Vidya Sagar wrote:
> The CXL specification (e.g., CXL r3.1 v1.0, sec 8.1.5.2) defines
> the "Unmask SBR" bit in the Port Control Extensions Register.
> When this bit is 0 (default), asserting the Secondary Bus Reset (SBR) bit
> in the Bridge Control register has no effect on the downstream bus.
> 
> Currently, the Linux PCI core checks this condition in
> pci_reset_bus_function(). If SBR is masked, it returns -ENOTTY during the
> execution of the reset. However, during the probe phase (when probe=true),
> the function currently returns 0. This 0 return value incorrectly signals
> to the PCI subsystem that SBR is a viable reset method for the device.
> 
> As a result, 'bus' is listed in the device's
> /sys/bus/pci/devices/.../reset_methods attribute, even though the hardware
> is incapable of performing it. If a user attempts to write bus to reset
> method or triggers a reset that falls back to SBR, the operation fails
> with: "bash: echo: write error: Inappropriate ioctl for device" error.
> 
> This patch modifies pci_reset_bus_function() to return -ENOTTY immediately
> if cxl_sbr_masked() is true, regardless of the probe argument. This
> ensures that 'bus' is not advertised in reset_methods when the hardware
> prevents it, improving clarity for users and aligning the sysfs capability
> report with actual hardware behavior.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Applied to pci/reset for v7.1, thanks!

I changed bridge->is_cxl to pcie_is_cxl(bridge) to match most other
tests.

> ---
> v2:
> * Before deciding to hide 'bus' reset method, add an extra check to make sure
>   that the link is indeed operating in the CXL mode and not in PCIe mode as
>   the spec clearly says that a '0' in 'Unmask SBR' doesn't have any effect if
>   the link is not operating in the CXL mode.
> 
>  drivers/pci/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f3244630bfd0..a176566ba56f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4915,12 +4915,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	 * If "dev" is below a CXL port that has SBR control masked, SBR
>  	 * won't do anything, so return error.
>  	 */
> -	if (bridge && cxl_sbr_masked(bridge)) {
> -		if (probe)
> -			return 0;
> -
> +	if (bridge && bridge->is_cxl && cxl_sbr_masked(bridge))
>  		return -ENOTTY;
> -	}
>  
>  	rc = pci_dev_reset_iommu_prepare(dev);
>  	if (rc) {
> -- 
> 2.25.1
> 
