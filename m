Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B527FD49;
	Fri, 27 Feb 2026 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187152; cv=none; b=mLEro7I6wKcYUwj1mSpVSzLJRW/FzAQEPxK0T+bAajfZm/KvJdrqxOSjKX/2q2EDvQYcrymkjo4rWU5yJEbVtsQxAq7jhCABys+QyE1FCtNbBH+2zodh46bliA9TnTUeakHgh8s6WbsBKECJO4+J7SO2AlIQ+REatoKR3Kjt94o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187152; c=relaxed/simple;
	bh=GMZuYZ6ukAvprNim5zqzNMDtv6GlcNFpkh2RyqcFG/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQeSDi5+u03EjCc7J9LAdKlZBNCjq772GmYlGPhoJtTKKLrj4Pdeo9VKCTANzd75YhJLda98Ue7E2vRO5MkMOUK+HqpZF0uCSfAMB72zFvDKfomzUFVA2oC7/OP8PD9qQhgRsMJdy1EFm3pNa0pjA5GtIACz844guwd8CLCxSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiSMqldJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiSMqldJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9FDC116C6;
	Fri, 27 Feb 2026 10:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772187152;
	bh=GMZuYZ6ukAvprNim5zqzNMDtv6GlcNFpkh2RyqcFG/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tiSMqldJw1KKvojFskjJLiTIlEr48oA3nU2ng7qIoBq9GX/UfzoArbjarujwIGSoX
	 1JL78HUNIXkoD/0At4MXviZrYi3lrwFVXLRBa+dwGikxSHZOcbduym7TdZaHRPqKwk
	 D4cl8M0j1ghkOVjpmvnMfn4kF58GPxcNjYbR7PoUKXH1oC5npU9xYn/2yNDCyC9I2P
	 mTqK5qFnd9ZVEAQUbpFmpIRutWj5gIE/qQqsA6zoBVyiV9XF/xQ6jraxw6IQqegvlH
	 LP6h1o1h+gGgCjyyKXBg6HN37dyKhwTZjUi0KIQTi+qvRDv9H5n2ZK2W9slfRfxUun
	 NZ8cf1ECDCrGA==
Date: Fri, 27 Feb 2026 11:12:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Add MSI Enable checks before raising
 MSI to the host
Message-ID: <aaFuC-oJyk7Ka2Ss@ryzen>
References: <20260225162359.116000-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20260225162359.116000-2-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225162359.116000-2-manivannan.sadhasivam@oss.qualcomm.com>

On Wed, Feb 25, 2026 at 09:53:58PM +0530, Manivannan Sadhasivam wrote:
> PCIe spec r7, sec 7.7.1.2 mandates that a Function should raise MSI only if
> the MSI Enable bit is set and MSI-X enable bit is clear.
> 
> Hence, add those checks to be spec compliant with relevant helpers to avoid
> code duplication.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 43 ++++++++++++++++---
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 295076cf70de..fcbd648e049e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -672,6 +672,17 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	return 0;
>  }
>  
> +static bool dw_pcie_ep_msi_enabled(struct dw_pcie_ep *ep,
> +				   struct dw_pcie_ep_func *ep_func, u8 func_no)
> +{
> +	u32 val, reg;
> +
> +	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
> +	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);

Since you are doing a readw, I think it looks a bit weird that val
is u32 instead of u16.


> +
> +	return FIELD_GET(PCI_MSI_FLAGS_ENABLE, val);
> +}
> +
>  static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> @@ -682,11 +693,11 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  	if (!ep_func || !ep_func->msi_cap)
>  		return -EINVAL;
>  
> -	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
> -	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
> -	if (!(val & PCI_MSI_FLAGS_ENABLE))
> +	if (!dw_pcie_ep_msi_enabled(ep, ep_func, func_no))
>  		return -EINVAL;
>  
> +	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
> +	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	val = FIELD_GET(PCI_MSI_FLAGS_QSIZE, val);
>  
>  	return 1 << val;
> @@ -716,6 +727,17 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	return 0;
>  }
>  
> +static bool dw_pcie_ep_msix_enabled(struct dw_pcie_ep *ep,
> +				    struct dw_pcie_ep_func *ep_func, u8 func_no)
> +{
> +	u32 val, reg;
> +
> +	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
> +	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);

Since you are doing a readw, I think it looks a bit weird that val
is u32 instead of u16.


> +
> +	return FIELD_GET(PCI_MSIX_FLAGS_ENABLE, val);
> +}
> +
>  static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> @@ -726,11 +748,11 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  	if (!ep_func || !ep_func->msix_cap)
>  		return -EINVAL;
>  
> -	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
> -	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
> -	if (!(val & PCI_MSIX_FLAGS_ENABLE))
> +	if (!dw_pcie_ep_msix_enabled(ep, ep_func, func_no))
>  		return -EINVAL;
>  
> +	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
> +	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	val &= PCI_MSIX_FLAGS_QSIZE;

Since you are touching these lines, I think you should change this to
use FIELD_GET() just like all other functions in this file.
If you don't want to do it in the same patch, then do it in a separate
patch in the same series.


>  
>  	return val + 1;
> @@ -877,6 +899,15 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	if (!ep_func || !ep_func->msi_cap)
>  		return -EINVAL;
>  
> +	/*
> +	 * PCIe spec r7, sec 7.7.1.2 mandates that a Function should raise MSI
> +	 * only if the MSI Enable bit is set and MSI-X Enable bit is clear.
> +	 */
> +	if (!dw_pcie_ep_msi_enabled(ep, ep_func, func_no) ||
> +	    (dw_pcie_ep_msi_enabled(ep, ep_func, func_no) &&
> +	     dw_pcie_ep_msix_enabled(ep, ep_func, func_no)))

Here we will call dw_pcie_ep_msi_enabled() twice per dw_pcie_ep_raise_msi_irq().
I would call dw_pcie_ep_msi_enabled() once and store the result in a local
variable, to avoid the latency of doing two reads instead of one, for each
dw_pcie_ep_raise_msi_irq().


Kind regards,
Niklas
