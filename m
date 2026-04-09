Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32931A6806;
	Thu,  9 Apr 2026 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760330; cv=none; b=eGIQ0w3DeYUaqlufNHLwsjuIYG1E7YvBVJzugo9um6oGtVoXsDp1iJLANLsr+T6v4bEKuermh3rODkSVOnwZYSLKDqF8oYGO3tx7Psbai2j5/8VcTgNCE89qLJZxjRbpn1r5oiKTZDLPz1+g6dORQEz89Bas+eY/VQxKyruBSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760330; c=relaxed/simple;
	bh=UZgwYqdPT8eyYrvs9N2GrV4S01GzaWg4ESNmc6eVdK8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iAQaC/QqK1QPsmXHZi/q9EqwGJ+yEosMQV3Q8ihkSNlkUhfksn/A88neCiXbwB+hxIQ/IzyLOAER8p4diVA6WppPANymD1KfI1s5dTArXG4bKVLMEW++eb0Vy1NLM6fZgTOSEQVIcfpyz/2ozWGMdq6w3q/4UAGaRRbQbY9MlSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl6uJouq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl6uJouq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAE3C4CEF7;
	Thu,  9 Apr 2026 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775760330;
	bh=UZgwYqdPT8eyYrvs9N2GrV4S01GzaWg4ESNmc6eVdK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Yl6uJouqm26Hs04EZRUss9c/RMlcrK1+dJSIgim+lKtQwrqOnGajeIaR7AKSML/be
	 mFPizJzHd1nOSPQitHVeyQzQISzkAYr8zmgaxtwouzqM2ow1cFJYKqplrcIYOU8ToK
	 Wznkbzje2PsWiTL8xORwtx6uyhZ0KxriNGwNIDKsPoqGFhf5LE0zMOs9G5MMPMbCmy
	 N1oc2BVDEse5W8bIN/rPW4MKsEOShoV8Px6TXUgJwgDt8eD5XKaHMTWj9S2U3IBfvQ
	 nk7LtusWz3eTyUAVV/TuDSlybsrhxZ1IuF7rpE69KflRIbSf0NvgnXzwZVc2o0ZZyh
	 e4IA31YSgfr1A==
Date: Thu, 9 Apr 2026 13:45:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com,
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org,
	18255117159@163.com, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/14] PCI: dwc: Apply ECRC workaround to DesignWare
 5.00a as well
Message-ID: <20260409184528.GA508955@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25417b97-ff10-4e5d-aa8f-2c832cb81250@nvidia.com>

On Thu, Apr 09, 2026 at 02:21:57PM +0530, Manikanta Maddireddy wrote:
> On 09/04/26 3:54 am, Bjorn Helgaas wrote:
> > On Wed, Mar 25, 2026 at 12:37:53AM +0530, Manikanta Maddireddy wrote:
> > > The ECRC (TLP digest) workaround was originally added for DesignWare
> > > version 4.90a. Tegra234 SoC has 5.00a DWC HW version, which has
> > > the same ATU TD override behaviour, so apply the workaround for 5.00a
> > > too.
> > > 
> > > Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
> > > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > > Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > ---
> > > Changes V8: Split into two patches
> > > Changes V1 -> V7: None
> > > 
> > >   drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 345365ea97c7..c4dc2d88649e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -486,7 +486,7 @@ static inline void dw_pcie_writel_atu_ob(struct dw_pcie *pci, u32 index, u32 reg
> > >   static inline u32 dw_pcie_enable_ecrc(u32 val)
> > >   {
> > >   	/*
> > > -	 * DesignWare core version 4.90A has a design issue where the 'TD'
> > > +	 * DWC versions 0x3530302a and 0x3536322a has a design issue where the 'TD'
> > 
> > 0x3536322a looks like DW_PCIE_VER_562A, not DW_PCIE_VER_500A, so this
> > comment doesn't seem to match the commit log or the code.
> > 
> > "0x3530302a and 0x3536322a" is not nearly as readable as 4.90A and
> > 5.00A.
> > 
> > >   	 * bit in the Control register-1 of the ATU outbound region acts
> > >   	 * like an override for the ECRC setting, i.e., the presence of TLP
> > >   	 * Digest (ECRC) in the outgoing TLPs is solely determined by this
> > > @@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > >   	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
> > >   	    dw_pcie_ver_is_ge(pci, 460A))
> > >   		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > > -	if (dw_pcie_ver_is(pci, 490A))
> > > +	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
> > >   		val = dw_pcie_enable_ecrc(val);
> > 
> > This is in shared DWC code, which raises the question of whether this
> > issue applies *only* to 490A and 500A?  What about other versions,
> > e.g., 520A (unused AFAICS), 540A, 562A?
> > 
> 
> Hi Bjorn,
> 
> I reviewed our internal bug database, I found that this dependency of iATU
> TD bit on ECRC is removed from version 5.10A. A comment from Synopsys case
> is quoted in our internal bug. Shall I prepare patch to address this for all
> versions < 5.10A? Or do we need inputs from Synopsys?

The patch below looks good to me, assuming the commit log is updated
to match this comment and the code.

I don't have any visibility into the Synopsys IP versions.

> Proposed patch
> 
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -486,7 +486,7 @@ static inline void dw_pcie_writel_atu_ob(struct dw_pcie
> *pci, u32 index, u32 reg
>  static inline u32 dw_pcie_enable_ecrc(u32 val)
>  {
>         /*
> -        * DWC versions 0x3530302a and 0x3536322a has a design issue where
> the 'TD'
> +        * DWC versions less than 5.10A has a design issue where the 'TD'
>          * bit in the Control register-1 of the ATU outbound region acts
>          * like an override for the ECRC setting, i.e., the presence of TLP
>          * Digest (ECRC) in the outgoing TLPs is solely determined by this
> @@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>         if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
>             dw_pcie_ver_is_ge(pci, 460A))
>                 val |= PCIE_ATU_INCREASE_REGION_SIZE;
> -       if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
> +       if (!dw_pcie_ver_is_ge(pci, 510A))
>                 val = dw_pcie_enable_ecrc(val);
>         dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> b/drivers/pci/controller/dwc/pcie-designware.h
> index 5bceadbd2c9f..00891adfd07d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -35,6 +35,7 @@
>  #define DW_PCIE_VER_480A               0x3438302a
>  #define DW_PCIE_VER_490A               0x3439302a
>  #define DW_PCIE_VER_500A               0x3530302a
> +#define DW_PCIE_VER_510A               0x3531302a
>  #define DW_PCIE_VER_520A               0x3532302a
>  #define DW_PCIE_VER_540A               0x3534302a
>  #define DW_PCIE_VER_562A               0x3536322a
> 
> Thanks,
> Manikanta
> 
> > >   	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> nvpublic
> 
