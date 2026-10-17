Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C64CF487;
	Sat, 17 Oct 2026 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792228964; cv=none; b=rjd7UjZkx+2nj3/M0gZcblGKZoV7k7Uxay3/d4hR+rruRlZwwF/eujHp1TE4/FD3KYNcwb992y6DwhoXK+DgBq+Tq6D57WH7JpciE5hV3a4KInx0clnkl/eNw7M+ZT0PEVO3DucG9uLJjjAqfDURepKvhaPBrn6H9QjcquxyR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792228964; c=relaxed/simple;
	bh=PjNzsWtledvd+ALvAvqcS+QgajX2hsFQGoJeirc18Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI1FQX1lpVxWXEYlWvuWr8p7wNojhWnWNSug1uDUaWF5zqfBEbO6pJDPQNQab4MGX5A3pz7jrlDv5uRMUarW6LRy+BLXqPA6WLx9nwm88OIw/W4usXEoKGFnlEsCBDWoKFc58mbT9V3TCxUJ0jzFYjqn4kAJl4SjK17MFA5s8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2ruVNSV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2ruVNSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081B01F000C4;
	Sat, 17 Oct 2026 09:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792228963;
	bh=vrEM57kvw03+nyiDaBS4tcxaXsddYN2DMYLy7Jqn17E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2ruVNSVWI7x36ixeN4lDIuO8yqZig0wk9dQNkwsnJ8xG684Ur+8obencxAUvaFPX
	 4U6pEPxLIHuZ8jZAgraKFkQp9+isdRgRXyn6NCwEQ7W3KJ4MeMrS7lJMO8FkHQFT1y
	 372wc5R22UJPlvxP1Un6vCoex+FAFtwTKD8jUkSFrY9KkkaUWCgIRkfv0CUusRA5aP
	 8E4AKHk6LMekKHFpMajt82Nmef3sH/lNgTl1+LB9VATeyWRUlVp4v6pgXXHcY1cVoR
	 nNlCBVGDNT9GGQ6KXEefxyLrqupdJcP1zJt0fOUCRzw5ONKQLeK6wTMP4rTeZvDo4D
	 c2KjL5ImieHkw==
Date: Sat, 17 Oct 2026 11:22:35 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: tegra194: Notify Endpoint functions on PERST#
 assert
Message-ID: <ogerzdjwq5wus3eb436x5gylxyfekmir7rz72ycywd2xoaiank@h7ayvhizjpu7>
References: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
 <20260923072554.1141864-4-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923072554.1141864-4-mmaddireddy@nvidia.com>

On Wed, Sep 23, 2026 at 12:55:54PM +0530, Manikanta Maddireddy wrote:
> Tegra Endpoint mode powers the controller down when the host asserts
> PERST#. EPF drivers must be told about link down before that happens,
> otherwise remove while PERST# is asserted can free EPC resources while
> EPF work is still active.
> 
> Use pci_epc_linkdown() directly in the PERST# assert path. It is a
> software-only EPF notification

Not entirely true. The EPF drivers can still access the hardware registers in
the link_down() callback. But most likely they won't access any DBI registers,
so that access may still be OK without REFCLK.

> and avoids dw_pcie_ep_linkdown(), which
> reinitializes non-sticky DWC registers and touches DBI while the host
> REFCLK may be disappearing.
> 
> Keep pci_epc_deinit_notify() in the PERST# deassert path, after core
> reset is deasserted, because EPF deinit callbacks can clear BARs and
> therefore need register access. If remove runs while the controller is
> already powered down, pex_ep_event_pex_rst_assert() returns because
> ep_state is disabled; that is safe because the link-down notification
> was sent at the earlier PERST# assert.
> 
> The final dw_pcie_ep_deinit() does not require Tegra register access
> today: Tegra uses its own MSI-X address-match window instead of the
> DWC MSI iATU, and the supported DTs do not register a DWC eDMA device.
> 

Is the last paragraph related to this patch?

> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index dd3f4c30ba52..3e9d46850a78 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1724,6 +1724,7 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>  
>  static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
>  {
> +	struct dw_pcie_ep *ep = &pcie->pci.ep;
>  	u32 val;
>  	int ret;
>  
> @@ -1745,6 +1746,8 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
>  	if (ret)
>  		dev_info(pcie->dev, "LTSSM state: 0x%x detect timeout: %d\n", val, ret);
>  
> +	pci_epc_linkdown(ep->epc);
> +
>  	/*
>  	 * Deassert LTSSM state to stop the state toggling between
>  	 * Polling and Detect.
> @@ -1913,7 +1916,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>  	}
>  
>  	/* Perform cleanup that requires refclk and core reset deasserted */
> -	pci_epc_deinit_notify(pcie->pci.ep.epc);
> +	pci_epc_deinit_notify(ep->epc);

Unrelated change.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
