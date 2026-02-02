Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4F4296BBC;
	Mon,  2 Feb 2026 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019074; cv=none; b=PDj/jQohjqAo/SAJ5U4kYfRoXyDshRB6JAVZvIe2ji6ALPZne7dmeHCDOEKNHz1AIvZumIV7rmLmUnH4C0btGwUBdPs6wNmCWwffLr+0qljoEQ4oAq4OMapTJGl7xcZBOB8Epqf6mzjxn2+aBPPM9EM0zOsJGuhywjpf0PTb4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019074; c=relaxed/simple;
	bh=NkcCNdyJQdVEfl5MFpCbiTm9O61YwNIFwwW666DclN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAg+xQikM6KmkyJXDNk/RvfGqTytYwMx3tGECCIelB0LYfta4zIPTX8C6ccdOfEyRQDj4NErFscTVAOGGpGIHIvBk4MpApb1a7LKTYSq5IMTNwLjRfOvBd1vkqqGX0dxgNIPN0U/K9ShNbOEj8xdcnpGA8FtlDNp7JtcjUr25pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpY+FBa5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpY+FBa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B362AC116D0;
	Mon,  2 Feb 2026 07:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770019073;
	bh=NkcCNdyJQdVEfl5MFpCbiTm9O61YwNIFwwW666DclN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OpY+FBa5IrnMAk9oo4Id9KCcbXXqmmL+MpZwWZbdNkMDSJmPr3Bp3JzBxoO6ShwYn
	 mK9JD0XibBS60RbG4I3mdLDTeTt0uazmGs+iYURPXyHPn4zpm1FL86lBY/OwV54p0x
	 LVdrSK5M4ybKFABem0xW45E72o6WWhJ9fcntzND02BEfe3rN0jcpCWNMUbVjqwDB6R
	 atSY35bN/VUJHb/Y29MVjjD/Ew/Z9q6HDaTiP9AueWfdsSZ2yaLe6TtKWQvyn/baDv
	 zjw1dts99frEMOScGbLAeQi8ozRCKvZnUh6Cy5BFWBT5K1xhrEFy8CRmHhMMOJEbGy
	 Mn836y6qHg+9g==
Date: Mon, 2 Feb 2026 08:57:48 +0100
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
Message-ID: <aYBY_K21cmj4ICxx@ryzen>
References: <20260202072758.101845-1-a-garg7@ti.com>
 <20260202072758.101845-2-a-garg7@ti.com>
 <aYBYgrM6SPWQy6iP@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYBYgrM6SPWQy6iP@ryzen>

On Mon, Feb 02, 2026 at 08:55:52AM +0100, Niklas Cassel wrote:
> On Mon, Feb 02, 2026 at 12:57:57PM +0530, Aksh Garg wrote:
> > The MSI-X configuration code reads from the correct physical function's
> > register space using dw_pcie_ep_readw_dbi(), but writes back only to
> > PF0 using the old dw_pcie_writew_dbi() helper. This causes incorrect
> > MSI-X configuration for other PFs.
> > 
> > Fix this by using dw_pcie_ep_writew_dbi() to write to the correct PF's
> > register space, matching the read operation.
> > 
> > Fixes: 70fa02ca1446 ("PCI: dwc: Add dw_pcie_ep_{read,write}_dbi[2] helpers")
> > Signed-off-by: Aksh Garg <a-garg7@ti.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 7e7844ff0f7e..771241e1a2c9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -745,7 +745,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
> >  	val &= ~PCI_MSIX_FLAGS_QSIZE;
> >  	val |= nr_irqs - 1; /* encoded as N-1 */
> > -	dw_pcie_writew_dbi(pci, reg, val);
> > +	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
> >  
> >  	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
> >  	val = offset | bir;
> > -- 
> > 2.34.1
> > 
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> 
> However, please also fix the only remaining place in this file which still
> uses the incorrect dw_pcie_writew_dbi() instead of dw_pcie_ep_writew_dbi()
> 
> i.e.:
> dw_pcie_ep_raise_msix_irq_doorbell().

Perhaps doorbell is special, and there is only one register for this...

But then, perhaps add a comment why this is the only place that needs
to not supply func_no.
