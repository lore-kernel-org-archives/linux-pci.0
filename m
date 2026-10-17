Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939DE12D21B;
	Sat, 17 Oct 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229243; cv=none; b=n4M55lHRT5DjFM0BVuyp0bYJUxN4xya1j0zbozB80R0VofwW8rBqQlqrZSFFI6WpX48rB3vIfMw6K/CGZC/ycMy17yH4rR+wn/xi1afCVUzobh5OWUx+sT6TLPDz5Fxugp/wmJt1VbBo0zEiTvNKZvWZcKSTsQzGPLy2kVjL8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229243; c=relaxed/simple;
	bh=8fCM+ZIyN8PVxzgFF9qasAvMvV+8H88XHgQe8q2Lfx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwGTyYSdDrJ8wy2lb7HVK5qNZxfqfYjOtOqRdT/RNYw7elr+bC1H9VZV0WenANSBl0MHCDoPBYuLjaVlZQwaHu/D7PPgDqZvfFw/2yY4BwEjH+MgN3Wc9Poya/SKF1+aBncI1XQH2Su0XNqKcmgWXiz+VktUjzPn4KaB6++whDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVAuLt/U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVAuLt/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AAA1F000C4;
	Sat, 17 Oct 2026 09:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792229242;
	bh=WJcKlK/pnWllbjb2ycYVXrDMuD9GwRzRABpINzqCzmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GVAuLt/U+SOqKGKqm0j1WcV5xRu+jofMbuSn8Xa7fydLkr7fbeYhMBxYzrFXqSeIJ
	 +I0Rf/LeB+xrrcsNg9CU9/0l3quuJo1cWqeKfTRiuATRDkOjKfvYo0YJuhKhCUmXe8
	 YbXist2DnxQZGDBNQRchNSa7UT4HXmTgWXzJ1hvqpAsQtJ4vR8YgcHtXbB5/8pyl1r
	 BkVDqqoNED0KtdkHvk83ZNfWiL6xpvGZNPOjNT9pTJZ/iIaRWa+/wP4RDWAS+JqBpT
	 Kvj3I59fP1vjURJqV4D7AtslvhNJZFx3KgWkvGmHriCv10n5c1yfBZFhY0zB4cXyz3
	 /ZBfN2WxVuPLQ==
Date: Sat, 17 Oct 2026 11:27:13 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: dwc: Add Endpoint reinit helper
Message-ID: <dee53d7no6nmzsaousuoqleg6dhigkejvkxmpyihc4v4piipwt@opa366n2sakq>
References: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
 <20260923072554.1141864-2-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923072554.1141864-2-mmaddireddy@nvidia.com>

On Wed, Sep 23, 2026 at 12:55:52PM +0530, Manikanta Maddireddy wrote:
> Endpoint controllers can receive a fundamental reset while software
> resources such as eDMA, debugfs and function state must live for the
> controller lifetime.
> 
> Track whether DWC Endpoint resources are initialized and add helpers
> that perform full initialization once, then reinitialize only reset-lost
> registers on later fundamental reset cycles.
> 
> A fundamental reset also clears outbound iATU programming. Clear the
> cached outbound window map, outbound address array and MSI iATU cache
> before reinitializing registers so stale software state cannot hide a
> window that was reset by hardware.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 152 +++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  |  13 ++
>  2 files changed, 124 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index de8ee3db4360..7ba40220b821 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1155,6 +1155,28 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_msix_irq);
>  
> +static void dw_pcie_ep_clear_msi_iatu(struct dw_pcie_ep *ep)
> +{
> +	ep->msi_iatu_mapped = false;
> +	ep->msi_iatu_mapped_offset = 0;
> +	ep->msi_msg_addr = 0;
> +	ep->msi_map_size = 0;
> +}
> +
> +static void dw_pcie_ep_clear_outbound_atus(struct dw_pcie_ep *ep)
> +{

I don't think this function clears the OB iATU mappings. It is done in
dw_pcie_ep_unmap_addr().

> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	if (ep->ob_window_map)
> +		bitmap_zero(ep->ob_window_map, pci->num_ob_windows);
> +
> +	if (ep->outbound_addr)
> +		memset(ep->outbound_addr, 0,
> +		       pci->num_ob_windows * sizeof(*ep->outbound_addr));
> +
> +	dw_pcie_ep_clear_msi_iatu(ep);
> +}
> +
>  /**
>   * dw_pcie_ep_cleanup - Cleanup DWC EP resources after fundamental reset
>   * @ep: DWC EP device
> @@ -1169,11 +1191,12 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  
>  	if (ep->msi_iatu_mapped) {
>  		dw_pcie_ep_unmap_addr(ep->epc, 0, 0, ep->msi_mem_phys);
> -		ep->msi_iatu_mapped = false;
> +		dw_pcie_ep_clear_msi_iatu(ep);
>  	}
>  
>  	dwc_pcie_debugfs_deinit(pci);
>  	dw_pcie_edma_remove(pci);
> +	ep->resources_initialized = false;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
>  
> @@ -1307,6 +1330,89 @@ static void dw_pcie_ep_disable_bars(struct dw_pcie_ep *ep)
>  	}
>  }
>  
> +static void dw_pcie_ep_init_ptm(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	u32 ptm_cap_base, reg;
> +
> +	/*
> +	 * PCIe r6.0, section 7.9.15 states that for endpoints that support
> +	 * PTM, this capability structure is required in exactly one
> +	 * function, which controls the PTM behavior of all PTM capable
> +	 * functions. This indicates the PTM capability structure
> +	 * represents controller-level registers rather than per-function
> +	 * registers.
> +	 *
> +	 * Therefore, PTM capability registers are configured using the
> +	 * standard DBI accessors, instead of func_no indexed per-function
> +	 * accessors.
> +	 */
> +	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> +
> +	/*
> +	 * PTM responder capability can be disabled only after disabling
> +	 * PTM root capability.
> +	 */
> +	if (ptm_cap_base) {
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> +		reg &= ~PCI_PTM_CAP_ROOT;
> +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> +
> +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> +		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +}
> +
> +/**
> + * dw_pcie_ep_reinit_registers - Reinitialize DWC EP reset-lost registers
> + * @ep: DWC EP device
> + *
> + * Reinitialize the EP registers lost after a fundamental reset without
> + * reallocating EP resources that live until dw_pcie_ep_deinit(). The
> + * caller must only use this after hardware has reset the iATU; this
> + * helper invalidates software iATU state but does not disable live
> + * windows.
> + */
> +int dw_pcie_ep_reinit_registers(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	int ret;
> +
> +	dw_pcie_ep_clear_outbound_atus(ep);
> +
> +	if (ep->ops->init) {
> +		ret = ep->ops->init(ep);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	dw_pcie_ep_disable_bars(ep);
> +	dw_pcie_ep_init_ptm(ep);
> +	dw_pcie_ep_init_non_sticky_registers(pci);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_reinit_registers);
> +
> +/**
> + * dw_pcie_ep_init_or_reinit_registers - Initialize or reinitialize DWC EP
> + * @ep: DWC EP device
> + *
> + * Initialize DWC EP resources on first use. If resources are already
> + * initialized, reinitialize only the reset-lost registers.
> + */
> +int dw_pcie_ep_init_or_reinit_registers(struct dw_pcie_ep *ep)
> +{

This function name looks awkward. Can you fold it inside
dw_pcie_ep_init_registers() instead?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
