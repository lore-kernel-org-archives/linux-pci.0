Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67F28CF6F;
	Fri, 27 Feb 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187225; cv=none; b=jog5wmJ/awXd2XrJTPCbTXfFfwSclLfGvAVqcTmUBPcK9/AOTNbGfYUp4Jk/um9rhdR+Mmghjl0VbjdjF4rH1ZQW55EvI0lAP6ZCaOWlg/CBvC8rV6xf542Hs2Fq85u25niYlyf8I6O5oBaaMfxrBflXpk3qMMD/qna6PbrQq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187225; c=relaxed/simple;
	bh=zxeprUvEX8mHMVTRI18PqRNa1fhf5q4R2qxdu6DTjAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtCep/+d+yUQqaPAlc+ep3c16xHxha+kt8gb4aewPqZOARj9029u4xAUsOh2XQCsx3Yq86hMEy6YkrN1OGRQW3LwfoVhtO909uAq4Sl5TZBFY3zEN+dEF/aFdi5P4SmXzOQNl6Ai7I32TfTgXWONYYcT5BbQlOSuK4Q8k2IEnJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1Sy7BbS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1Sy7BbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A36AC116C6;
	Fri, 27 Feb 2026 10:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772187225;
	bh=zxeprUvEX8mHMVTRI18PqRNa1fhf5q4R2qxdu6DTjAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1Sy7BbSr+5yybHMx++9lDFlJVCVkUlwlnDHxXI5MWfRy215Th4nTTkdndhsUtOk5
	 6n85ETNaTjluDqjL4q34veMdXK/hT8D/86/DlSrTU7e8+tZc8FEY4+fg3UnMYMGY7C
	 hwaTx8vKdhxR9eO4iboWrE7xTBFZ/eU2m9JlUY5Cty4bJwCWfUcBklp+3YSc6qZJEm
	 Ys+wIka3er3s1oA+GVtF+Eg6mWO04qtjoKp+hZCVsGIeMj79pcJWA23XUa1eT01muE
	 /5H7aoKksSqslk2jYnwWUexklHxEbt7FS9Oby+r61/x+RoTF4d+c3zrUTuG9AoHNuw
	 dB6exspwNIuzg==
Date: Fri, 27 Feb 2026 11:13:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Add MSI-X Enable checks before raising
 MSI-X to the host
Message-ID: <aaFuVOxHvKs9Mseu@ryzen>
References: <20260225162359.116000-1-manivannan.sadhasivam@oss.qualcomm.com>
 <20260225162359.116000-3-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225162359.116000-3-manivannan.sadhasivam@oss.qualcomm.com>

On Wed, Feb 25, 2026 at 09:53:59PM +0530, Manivannan Sadhasivam wrote:
> PCIe spec r7, sec 7.7.2.2 mandates that a Function should raise MSI-X only
> if the MSI-X Enable bit is set and MSI enable bit is clear.
> 
> Hence, add those checks to be spec compliant.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index fcbd648e049e..47bc33346342 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1018,6 +1018,15 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	if (!ep_func || !ep_func->msix_cap)
>  		return -EINVAL;
>  
> +	/*
> +	 * PCIe spec r7, sec 7.7.2.2 mandates that a Function should raise MSI-X
> +	 * only if the MSI-X Enable bit is set and MSI Enable bit is clear.
> +	 */
> +	if (!dw_pcie_ep_msix_enabled(ep, ep_func, func_no) ||
> +	    (dw_pcie_ep_msix_enabled(ep, ep_func, func_no) &&
> +	     dw_pcie_ep_msi_enabled(ep, ep_func, func_no)))
> +		return -EOPNOTSUPP;

Same comment as patch 1/2.


Kind regards,
Niklas
