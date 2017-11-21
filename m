Return-Path: <SRS0=yv87=CT=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=yv87=CT=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 21 Nov 2017 15:08:48 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, treding@nvidia.com,
	bhelgaas@google.com, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, kthota@nvidia.com, swarren@nvidia.com,
	mmaddireddy@nvidia.com
Subject: Re: [PATCH V3 2/3] PCI: tegra: fixups to avoid unnecessary wakeup
 from ASPM-L1.2
Message-ID: <20171121150848.GB14465@red-moon>
References: <1510492674-12786-1-git-send-email-vidyas@nvidia.com>
 <1510492674-12786-3-git-send-email-vidyas@nvidia.com>
 <20171120213052.GD16362@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171120213052.GD16362@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 20, 2017 at 03:30:52PM -0600, Bjorn Helgaas wrote:

[...]

> >  static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
> > @@ -2290,6 +2293,16 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
> >  			(7 << RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_SHIFT);
> >  		writel(value, port->base + RP_L1_PM_SUBSTATES_CTL);
> >  
> > +		if (soc->l1ss_rp_wake_fixup) {
> > +			/* Set CLKREQ asserted delay greater than Power_Off
> > +			 * time (2us) to avoid RP wakeup in L1.2_ENTRY
> > +			 */
> 
> Use standard multi-line comment formatting (and "L1.2.Entry" as above).
> 
> I assume "CLKREQ asserted delay" is a Tegra-internal thing, since it
> doesn't obviously correspond to a timing parameter in the spec.
> 
> And I assume it doesn't depend on any of the OS-writable things in the
> L1 PM Substates control registers, since this fixup isn't executed
> during config writes to those registers?
> 
> Does this depend on any circuit details outside of Tegra, i.e., should
> it be described via DT?

Yes, I have noticed too that there are lots of hardcoded values in this
driver that may benefit from some Tegra DT bindings instead of
hardcoding everything in the kernel.

Thanks,
Lorenzo

> > +			value = readl(port->base + RP_L1_PM_SUBSTATES_1_CTL);
> > +			value &= ~RP_L1SS_1_CTL_CLKREQ_ASSERTED_DLY_MASK;
> > +			value |= RP_L1SS_1_CTL_CLKREQ_ASSERTED_DLY;
> > +			writel(value, port->base + RP_L1_PM_SUBSTATES_1_CTL);
> > +		}
> > +
> >  		/* Following is based on clk_m being 19.2 MHz */
> >  		value = readl(port->base + RP_L1_PM_SUBSTATES_1_CTL);
> >  		value &= ~RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY_MASK;
> > @@ -2446,6 +2459,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
> >  	.program_deskew_time = false,
> >  	.updateFC_threshold = false,
> >  	.has_aspm_l1ss = false,
> > +	.l1ss_rp_wake_fixup = false,
> >  };
> >  
> >  static const struct tegra_pcie_soc tegra30_pcie = {
> > @@ -2468,6 +2482,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
> >  	.program_deskew_time = false,
> >  	.updateFC_threshold = false,
> >  	.has_aspm_l1ss = false,
> > +	.l1ss_rp_wake_fixup = false,
> >  };
> >  
> >  static const struct tegra_pcie_soc tegra124_pcie = {
> > @@ -2489,6 +2504,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
> >  	.program_deskew_time = false,
> >  	.updateFC_threshold = false,
> >  	.has_aspm_l1ss = false,
> > +	.l1ss_rp_wake_fixup = false,
> >  };
> >  
> >  static const struct tegra_pcie_soc tegra210_pcie = {
> > @@ -2518,6 +2534,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
> >  	.program_deskew_time = true,
> >  	.updateFC_threshold = true,
> >  	.has_aspm_l1ss = true,
> > +	.l1ss_rp_wake_fixup = true,
> >  };
> >  
> >  static const struct tegra_pcie_soc tegra186_pcie = {
> > @@ -2540,6 +2557,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
> >  	.program_deskew_time = false,
> >  	.updateFC_threshold = false,
> >  	.has_aspm_l1ss = true,
> > +	.l1ss_rp_wake_fixup = false,
> >  };
> >  
> >  static const struct of_device_id tegra_pcie_of_match[] = {
> > -- 
> > 2.7.4
> > 
