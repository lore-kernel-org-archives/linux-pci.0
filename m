Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAD1EFF8D;
	Mon, 23 Feb 2026 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872960; cv=none; b=mMWrHnRbCpkO/NzG8LxdHwk4vk3W4UEceQjige1HnZRumN1K714Wff3ulpmnqVYWvtLRC1r0op2XB3KWTj+N28HUQQR6N7zlUz8Z9lTNikDUkCV1ljLSfLtLyj546AddBDgoRJSxT88iT2VZlRAPac8Q1HTsxAcn8zN6Fjwg0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872960; c=relaxed/simple;
	bh=ZFLkiQi4/1bH6eoz6wkVdakelyv5TSTDKDBuawpe178=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Df72FCBJhvcOIp36MoHGnBoaPUdcDvg4Xhigd6Ll2pPHVINlusOZddRu7dt6NhCgBDHMFJWhQo+FRF8KmqOCTXtV1oW5subhMZRkq48rSJbHF04hOj3y/uPsOmEgWNg595m222xq8c2Fg+m5xXNiHrfY+70fU+oD5VBnw/iWJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrFAcR3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrFAcR3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194ACC116D0;
	Mon, 23 Feb 2026 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771872960;
	bh=ZFLkiQi4/1bH6eoz6wkVdakelyv5TSTDKDBuawpe178=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DrFAcR3lgCO+AHYOz3RimU0XPsNqALoy2rk6N342c0HTnfBc0Z3w1pucWdRioAS/o
	 CpRJ1kAlkOzym57vA6XKe966CH+nRa8YHhk2hjGurPZf18dXquSw2ektGddUdxQk01
	 8VQc5QVVpphphrNx8lB+qvFIvAl/RlpyNT8KgnZvp4Anzfi0LgkizMn8Uz0wsETDmt
	 DU9dZktrsIPwzU+0YWcW+yN7facLKsw6XjyHP5PK4GcqyBD+qDtwcrKVO0+SYenTne
	 EnOBJOMP0siqSkvKU8sMgaQ9oiDoHzSHlIwZtltHelJryJPiqlAJtOzn1tK1pvkSH5
	 GgO+4YeurPZww==
Date: Mon, 23 Feb 2026 12:55:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, yoshihiro.shimoda.uh@renesas.com,
	fancer.lancer@gmail.com, Zhiqiang.Hou@nxp.com,
	gustavo.pimentel@synopsys.com, cassel@kernel.org,
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH v2 2/2] PCI: dwc: ep: Mirror the max link width and speed
 fields to all functions
Message-ID: <20260223185558.GA3701139@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219064511.695086-3-a-garg7@ti.com>

On Thu, Feb 19, 2026 at 12:15:11PM +0530, Aksh Garg wrote:
> PCIe r6.0, section 7.5.3.6 states that for multi-function devices, the
> Max Link Width and Max Link Speed fields in the Link Capabilities
> Register must report the same values for all functions.

Please update the citations here and in the comment below to r7.0.

> Currently, dw_pcie_setup() programs these fields only for physical
> function 0 (PF0) via dw_pcie_link_set_max_speed() and
> dw_pcie_link_set_max_link_width(). For multi-function endpoint
> configurations, PF1 and beyond retain their default values, violating
> the PCIe specification.
> 
> Fix this by reading the Max Link Width and Max Link Speed fields from
> PF0's Link Capabilities Register after dw_pcie_setup() completes,
> then mirroring these values to all other physical functions.

"PF" and "physical function" are terms that apply to SR-IOV, not to
ordinary functions of a multi-function device, so it's confusing to 
use them here.  Instead of "physical function 0" and "PF0", just refer
to "Function 0" as the spec does.

> Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")

Sorry I missed it earlier; it's also the wrong term here in the
subject of 24ede430fa49, but it's too late to fix that.

> Fixes: 89db0793c9f2 ("PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling")
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
> 
> The link speed and width would be negotiated through PF0 during
> initialization that controls the link behaviour, hence it didn't broke
> the driver. However, the change is proposed just to make the driver
> compatible with the PCIe base specifications.
> 
> The fix is implemented in pcie-designware-ep.c rather than modifying
> dw_pcie_setup() directly to keep pcie-designware.c independent of RC/EP
> specifics and maintain it as common code.
> 
> Changes from v1 to v2:
> - Used FIELD_* macros
> 
> v1: https://lore.kernel.org/all/20260202072758.101845-3-a-garg7@ti.com/
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 771241e1a2c9..6b9f90810fec 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1094,7 +1094,8 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  {
>  	struct dw_pcie_ep *ep = &pci->ep;
>  	u8 funcs = ep->epc->max_functions;
> -	u8 func_no;
> +	u32 ref_lnkcap, lnkcap;
> +	u8 func_no, offset;
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> @@ -1102,6 +1103,26 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  		dw_pcie_ep_init_rebar_registers(ep, func_no);
>  
>  	dw_pcie_setup(pci);
> +
> +	/*
> +	 * PCIe r6.0, section 7.5.3.6 states that for multi-function endpoints,
> +	 * max link width and speed fields must report same values for all functions.
> +	 * However, dw_pcie_setup() programs these fields only for physical function 0.
> +	 * Hence, mirror these fields to all other physical functions as well.

s/physical function 0/function 0/

Wrap this to fit in 80 columns like the rest of the file.

> +	 */
> +	if (funcs > 1) {
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +		ref_lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +		ref_lnkcap = FIELD_GET(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS, ref_lnkcap);
> +
> +		for (func_no = 1; func_no < funcs; func_no++) {
> +			offset = dw_pcie_ep_find_capability(ep, func_no, PCI_CAP_ID_EXP);
> +			lnkcap = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_EXP_LNKCAP);
> +			FIELD_MODIFY(PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS, &lnkcap, ref_lnkcap);
> +			dw_pcie_ep_writel_dbi(ep, func_no, offset + PCI_EXP_LNKCAP, lnkcap);

Please wrap these too, it's not too hard to make these fit in 80
columns like (most of) the rest of the file.

> +		}
> +	}
> +
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
> -- 
> 2.34.1
> 
