Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365B2FFF89;
	Wed, 22 Jul 2026 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703778; cv=none; b=YI1igOMJJQatEq0vw4nb79+Vjs753KptiDckkkfPkS4S1l2XPPLC/NwMQqKecRbMfvYVdTFMHnhIFJhpE/ZwbWP2vR2ztxDHm/gNJPtYmIujC4aiygeSLyCsEXexrk11/ZG9BOwBw+6/joYK62br9n9KOQEI1VnpVOK7oGfpPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703778; c=relaxed/simple;
	bh=Dhxpyp5WxHO0+rnMTK966vwBcBFPaMwCoLRcDTolfcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUw/IBoxj3/6uEIvh2uSYQ9cyQsBAN/nBBRyXT0HScpquMBJyKY2FzGPl8OaiD+//TWaXz/+gaBIuWoD6JvfHG3rYLDE3htEasik7C3s56+Z8rL7PGKRDg/yzZTLbVqQzjxOxPhNLdOaEGtgWbwIPBat2kMTE7erQQ059LhDGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLcnPq+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLcnPq+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4FD1F000E9;
	Wed, 22 Jul 2026 07:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784703776;
	bh=8FpaDTxzOLlH/vfTaml0v7+h+U0X8a7uuWws5ZIBjq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YLcnPq+oJeAUGwMjBWaJMrNrFs0MWh5P98fmBAB3O0SE7qYaP6yuDecdj4WGQ/rsA
	 Ys10sqrnzZxB61ukk+JxiYPeORqgiXxw90Q+Y/uGlbiTVPyQ2clTvOFyc8tSIQpwRe
	 SOlaoYEP0OpsvKs/20T3y12nhtPZrYvPSPaDrj47xncUXvcyQDQ+JdtydFofu2F5Jz
	 dZKgv4uJsEjED8dge+hAbs30PhNOBehdToLZzg3pyhmoqN8ZBpCz9EZwCiNKmavRgi
	 fuQr54pmneIEAxay7ZmTh9QTRJPKRW9TFaDxVxiMzpmvlmps837J4MBHwjgat5qvX5
	 jOQAnbFQ3d/aA==
Date: Wed, 22 Jul 2026 09:02:50 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Message-ID: <acmo2p23ivae7zwf2nyymzlx5flhgc6fbnmlc3rg5ugadzsnml@ipxycw7lb7cs>
References: <20260721-aspm-v5-1-58860c48d0c7@oss.qualcomm.com>
 <20260721143945.86E7D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721143945.86E7D1F000E9@smtp.kernel.org>

On Tue, Jul 21, 2026 at 02:39:45PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The ASPM state restoration loop unconditionally overwrites the entire PCI Express Link Control (PCI_EXP_LNKCTL) register of all downstream functions with the exact snapshot from function 0, corrupting function-specific configuration.
> - [Medium] ASPM L1 is only temporarily disabled on function 0 before executing the Devicetree override that disables L1SS, leaving L1 enabled on other functions and creating an asymmetric configuration flow.
> --
> 
> --- Patch [1]: [PATCH v5] PCI/ASPM: Mask ASPM states based on Devicetree properties ---
> commit 164cdaf6b21843e390d8074afc28fbe939d2fb44
> Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Subject: PCI/ASPM: Mask ASPM states based on Devicetree properties
> 
> Some platforms require selectively disabling specific ASPM states on a
> given PCIe link to avoid link instability or functional failures caused
> by board-level connectivity constraints. Devicetree supports disabling ASPM
> L0s, L1, and L1 PM Substates via the 'aspm-no-l0s', 'aspm-no-l1', and
> 'aspm-no-l1ss' properties. This commit enables the ASPM driver to honor
> these properties when initializing the default link state.
> 
> Link: https://github.com/devicetree-org/dt-schema/pull/188
> Link: https://github.com/devicetree-org/dt-schema/pull/190
> 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 172783e7f519a..82041052747fc 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> 
> [ ... ]
> 
> > @@ -846,6 +889,36 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
> >  
> >  	/* For devicetree platforms, enable L0s and L1 by default */
> >  	if (of_have_populated_dt()) {
> > +		bool no_l0s = pcie_link_has_aspm_override(link, "aspm-no-l0s");
> > +		bool no_l1 = pcie_link_has_aspm_override(link, "aspm-no-l1");
> > +		bool no_l1ss = pcie_link_has_aspm_override(link, "aspm-no-l1ss");
> > +
> > +		if (no_l0s) {
> > +			link->aspm_support &= ~PCIE_LINK_STATE_L0S;
> > +			link->aspm_default &= ~PCIE_LINK_STATE_L0S;
> > +			link->aspm_enabled &= ~PCIE_LINK_STATE_L0S;
> > +		}
> > +
> > +		/*
> > +		 * Clear L1SS in hardware before updating aspm_support. Once
> > +		 * aspm_capable is derived from aspm_support, pcie_config_aspm_link()
> > +		 * skips pcie_config_aspm_l1ss() entirely via the aspm_capable guard,
> > +		 * leaving firmware-enabled L1SS substates active in hardware.
> > +		 * This applies equally when disabling L1 (which implies L1SS).
> > +		 */
> > +		if ((no_l1 || no_l1ss) && (link->aspm_enabled & PCIE_LINK_STATE_L1SS))
> > +			pcie_config_aspm_l1ss(link, 0);
> 
> [Severity: Medium]
> Does this hardware write violate the PCIe specification precondition for L1 PM
> Substates on multi-function devices?
> 
> The PCIe spec mandates disabling ASPM L1 across the entire link before
> modifying L1SS. Before calling this override, pcie_aspm_cap_init() temporarily
> disables L0s/L1, but it only clears the ASPM Control bits for the first child
> function:
> 
> pcie_aspm_cap_init()
>     pcie_capability_write_word(child, PCI_EXP_LNKCTL,
>                                child_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
> 
> If L1 was enabled on functions > 0, they remain active when
> pcie_config_aspm_l1ss(link, 0) is called here. Could this cause hardware
> configuration faults or link instability since the precondition isn't fully met
> across all functions?
> 

This is a valid concern. We should disable ASPM L1 of all functions of the child
of the link and enable it later if required, like pcie_config_aspm_link().

> > +
> > +		if (no_l1) {
> > +			link->aspm_support &= ~(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS);
> 
> [ ... ]
> 
> > @@ -924,18 +997,30 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> >  
> >  	aspm_l1ss_init(link);
> >  
> >  	/* Save default state */
> >  	link->aspm_default = link->aspm_enabled;
> >  
> >  	pcie_aspm_override_default_link_state(link);
> >  
> > +	/*
> > +	 * Restore L0s/L1 if they were enabled, but don't restore any
> > +	 * state a Devicetree override just disabled in aspm_support above.
> > +	 */
> > +	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
> > +	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
> > +		if (!(link->aspm_support & PCIE_LINK_STATE_L0S)) {
> > +			child_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L0S;
> > +			parent_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L0S;
> > +		}
> > +		if (!(link->aspm_support & PCIE_LINK_STATE_L1)) {
> > +			child_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L1;
> > +			parent_lnkctl &= ~PCI_EXP_LNKCTL_ASPM_L1;
> > +		}
> > +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
> > +		list_for_each_entry(child, &linkbus->devices, bus_list)
> > +			pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
> 
> [Severity: High]
> Can this unconditional write corrupt function-specific configuration?
> 
> The child_lnkctl variable is a complete snapshot of PCI_EXP_LNKCTL taken
> exclusively from function 0. The PCI_EXP_LNKCTL register contains
> function-specific fields, such as the Read Completion Boundary at bit 3.
> 
> Writing the full 16-bit word from function 0 to all other downstream
> functions blindly overwrites their distinct state.
> 
> Should this loop use a read-modify-write targeting only the
> PCI_EXP_LNKCTL_ASPMC bits to safely restore the ASPM state across all
> functions?
> 

True. pcie_capability_clear_and_set_word() should be used here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
