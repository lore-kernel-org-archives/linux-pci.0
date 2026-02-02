Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A5299928;
	Mon,  2 Feb 2026 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018952; cv=none; b=QCWQ++/wInRVtV1aCklNCMyDbwwHUkIyHKxyusRb//gdTN9SWaz4zWoBZNvGnN5hcVmAKZIaXD+4bU7UxwP8oj2ZEMaEWJKbqL/4xuEnaS3snKyWM6svo21xyNwkwo4D7gNTtgIiXpDyrg1AjWT65EjZCy31MgnYJDbfK+iyu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018952; c=relaxed/simple;
	bh=iOQ5LMXPgsTE4ugyN/czA9z+1WMJqspwsEJobSbCEsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFkH8Fed2CR9HLtfq2SrY8g/U0K3Jb45PYGXkZYuflKzvxLV8JbyHfhz6DY59ljgfa7z7D3ZqmUTstr3b8wmuTBihgt1Pjf10YMajSJZUwaMfChx6+5Fbd7Lnqd/aTaJ0giTQdnCpt+9X8fLeeX+C9st2/eQlQr+79KS7Y8krwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7vBZGW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7vBZGW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E08EC116D0;
	Mon,  2 Feb 2026 07:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770018952;
	bh=iOQ5LMXPgsTE4ugyN/czA9z+1WMJqspwsEJobSbCEsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7vBZGW3sxT2XcB3YbWFd7Y5ejxk0P+Q2dbyx/B0UCIvaEV4hsbmfx/97+tnYEsWC
	 +QYId8OrCqynG1A0T3p1NAl883J1kZdYIPn8bO7YnoAhdI7ifP6Xn9RMjW3hsLfC3o
	 Qp5UCZsOJOcjeP7v79pbwam/jGFSKUg6IG49gQ23eP/fLLL/kkRfaFv68jSvJyCNKr
	 JoTteY88Ka9w5ZfLnK2sOUg3DEcwwB57inmTTpvhBhwDmWINwWBSfgkb6rLa5XCNmH
	 PQtVkQYNb4ZH664aZQnqagx84N4vs677e9DfM2hg+qsFqWmkteVQYJG2yvw7+u64mG
	 PmExeWt8HeUcw==
Date: Mon, 2 Feb 2026 08:55:46 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, yoshihiro.shimoda.uh@renesas.com,
	fancer.lancer@gmail.com, Zhiqiang.Hou@nxp.com,
	gustavo.pimentel@synopsys.com, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Fix MSI-X configuration to write to
 correct physical function
Message-ID: <aYBYgrM6SPWQy6iP@ryzen>
References: <20260202072758.101845-1-a-garg7@ti.com>
 <20260202072758.101845-2-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202072758.101845-2-a-garg7@ti.com>

On Mon, Feb 02, 2026 at 12:57:57PM +0530, Aksh Garg wrote:
> The MSI-X configuration code reads from the correct physical function's
> register space using dw_pcie_ep_readw_dbi(), but writes back only to
> PF0 using the old dw_pcie_writew_dbi() helper. This causes incorrect
> MSI-X configuration for other PFs.
> 
> Fix this by using dw_pcie_ep_writew_dbi() to write to the correct PF's
> register space, matching the read operation.
> 
> Fixes: 70fa02ca1446 ("PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers")
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e7844ff0f7e..771241e1a2c9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -745,7 +745,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	val &= ~PCI_MSIX_FLAGS_QSIZE;
>  	val |= nr_irqs - 1; /* encoded as N-1 */
> -	dw_pcie_writew_dbi(pci, reg, val);
> +	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
>  
>  	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
>  	val = offset | bir;
> -- 
> 2.34.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>


However, please also fix the only remaining place in this file which still
uses the incorrect dw_pcie_writew_dbi() instead of dw_pcie_ep_writew_dbi()

i.e.:
dw_pcie_ep_raise_msix_irq_doorbell().
