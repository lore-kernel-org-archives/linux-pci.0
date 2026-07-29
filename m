Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBF3B83E3;
	Wed, 29 Jul 2026 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314153; cv=none; b=PRXUC/gLNFRZY6OnQ8ODAh+ub9RfmfDL/FlAoTj7fjsHu91Cwa3Z3GN0pRWeEtrT7A9kQkBoZxJGwGAl8PZy+3jL1H9Df7P8fLDhRlREDEodRB18FD9NFBwT//ZcXDZG/TThAmxo92nL+G5SHPybDn4KRL1rhWnNkYExjf+B6S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314153; c=relaxed/simple;
	bh=ivp876KM5bpUXgRJMZfVGFw+qa8GdI82hsqEcH8jPT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smz4nFFavQIihTPsO61tLgV0FfOqVcKZWoCaHlIqu2Wfrg3fTO0DkzTXeCm/9ZTAAf7YyF3Y8p7ZvROIuRk1bqj9jxy6NGp5W6yUB8qj4JaggFWO4KCK7wGbUyN6JBx0EzYb9y88XgLQGaxmd9nN+S4efd7eWDsY0tOa7mtn/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkE1NIH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkE1NIH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4316F1F00A3D;
	Wed, 29 Jul 2026 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314150;
	bh=k2GvoOWfgYs5AGZFXjwhbQCB0Yb8MenIRXq0Oemp6e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IkE1NIH9a24MffRdsoKx4koTZfEQw8vHxm26SWCUEGNTRZ55iWkQxZDE6gsbN4CyX
	 NJpf4JeLGlprZZSgyWXJoJDTjnvKkdl9zoLW5NsTCl2Dfbsfqyg6XKzP/SFL8ESS+V
	 Nwnz9+SEQ3EH1igr04O8ZuZuMwtpFP9h4HbyNcaiQyXBaXLT88BSvzXFusYALiYp5b
	 ckv+UnJX8ySjPDOuGl7U3TSUNhxl+9O1RLGOkXz5BYaiMmWbN99qmrLBDMQBq9tpTS
	 7CHukEvXivXct3W60xdllAQS9milVSKwPMY8lmoXV56n9bauZKFqsKuuNGs20GazHW
	 MRZiWrQ9vsacw==
Date: Wed, 29 Jul 2026 10:35:42 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/4] PCI: qcom: Add link retention support
Message-ID: <xl77nuhfk2egth2deriqjvc36cwjvwwlrpasc3i4g5ktt4keir@b37waddu4psq>
References: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
 <20260709-link_retain-v3-3-81a9d187bb61@oss.qualcomm.com>
 <63rwvquftwg77cy6wmsw7stubpluvmp6dplg3nt5lzhdilio2e@dmdesbk63frc>
 <3eee6637-0b6e-431c-b3cc-959bba5b2646@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3eee6637-0b6e-431c-b3cc-959bba5b2646@oss.qualcomm.com>

On Wed, Jul 29, 2026 at 09:37:47AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/13/2026 10:20 AM, Manivannan Sadhasivam wrote:
> > On Thu, Jul 09, 2026 at 12:05:18PM +0530, Krishna Chaitanya Chundru wrote:
> >> Some platforms keep the PCIe link active across bootloader and kernel
> >> handoff. Reinitializing the controller and toggling PERST# in such cases is
> >> unnecessary when the driver does not need to retrain the link.
> >>
> >> Introduce link_retain in both qcom_pcie_cfg and qcom_pcie to indicate when
> >> link retention is supported. During initialization, check the LTSSM state;
> >> if the link is already in L0 or L1 idle and LTSSM is enabled, set
> >> link_retain and skip controller reset, PERST# toggling, and other post-
> >> init steps.
> >>
> >> The max-link-speed and num-lanes properties in Device Tree cap the link's
> >> maximum capability. Retrain the link if the controller's max link speed or
> >> width exceeds the Device Tree cap, unless the currently negotiated speed
> >> or width is already within that cap, in which case the existing link can
> >> still be retained.
> >>
> >> Configure the DBI and ATU base addresses in the retention path, since the
> >> bootloader may use different base addresses than those provided by the
> >> device tree.
> >>
> > Where is this base address change?
> It is being covered as part of  dw_pcie_setup_rc(), this part can be removed
> as this being called unconditionally in this patch.
> >> Set l1ss_support in the retention path as well, since it is otherwise only
> >> set later in the normal init flow which is skipped when the link is
> >> retained.
> >>
> >> Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> >> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >> ---
> >>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
> >>  drivers/pci/controller/dwc/pcie-qcom.c       | 68 ++++++++++++++++++++++++++--
> >>  2 files changed, 66 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> >> index de4b245b1758..0c98b914eb52 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.h
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> >> @@ -471,6 +471,7 @@ struct dw_pcie_rp {
> >>  	bool			native_ecam;
> >>  	bool                    skip_l23_ready;
> >>  	bool			skip_pwrctrl_off;
> >> +	bool			link_retain;
> >>  };
> >>  
> >>  struct dw_pcie_ep_ops {
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index 9ca620d4746a..77d2d989e9da 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -260,12 +260,14 @@ struct qcom_pcie_ops {
> >>    * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
> >>    * snooping
> >>    * @firmware_managed: Set if the Root Complex is firmware managed
> >> +  * @link_retain: Set if controller supports retaining link from bootloader
> >>    */
> >>  struct qcom_pcie_cfg {
> >>  	const struct qcom_pcie_ops *ops;
> >>  	bool override_no_snoop;
> >>  	bool firmware_managed;
> >>  	bool no_l0s;
> >> +	bool link_retain;
> >>  };
> >>  
> >>  struct qcom_pcie_perst {
> >> @@ -996,6 +998,50 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> >>  	return 0;
> >>  }
> >>  
> >> +/*
> >> + * Determine whether the link established by the bootloader can be reused.
> >> + *
> >> + * The max-link-speed and num-lanes specified in Device Tree are meant to cap
> >> + * the link's maximum capability. Retrain the link if the controller's max
> >> + * link speed/width exceeds the Device Tree cap, unless the currently
> >> + * negotiated speed/width is already within that cap, in which case the
> >> + * existing link can be retained as-is.
> >> + */
> >> +static bool qcom_pcie_check_link_retain(struct qcom_pcie *pcie)
> >> +{
> >> +	u32 cap, speed, cur_speed, val, ltssm, width, cur_width;
> >> +	struct dw_pcie *pci = pcie->pci;
> >> +	u8 offset;
> >> +
> >> +	val = readl(pcie->parf + PARF_LTSSM);
> >> +	ltssm = val & 0x1f;
> >> +	if ((val & LTSSM_EN) &&
> >> +	    (ltssm == DW_PCIE_LTSSM_L0 || ltssm == DW_PCIE_LTSSM_L1_IDLE)) {
> >> +		qcom_pcie_configure_dbi_atu_base(pcie);
> >> +
> >> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >> +		cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> >> +		speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
> >> +		width = dw_pcie_link_get_max_link_width(pci);
> >> +
> >> +		val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> >> +		cur_speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
> >> +		cur_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
> >> +
> >> +		if (pci->max_link_speed > 0 && speed > pci->max_link_speed &&
> >> +		    cur_speed > pci->max_link_speed)
> >> +			return false;
> >> +
> >> +		if (pci->num_lanes > 0 && width > pci->num_lanes &&
> >> +		    cur_width > pci->num_lanes)
> >> +			return false;
> >> +
> >> +		return true;
> >> +	}
> >> +
> >> +	return false;
> >> +}
> >> +
> >>  static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> >>  {
> >>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> >> @@ -1014,6 +1060,15 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> >>  	if (ret < 0)
> >>  		goto err_disable_regulators;
> >>  
> >> +	if (pcie->cfg->link_retain) {
> >> +		pci->pp.link_retain = qcom_pcie_check_link_retain(pcie);
> >> +		pci->l1ss_support = true;
> >> +		if (pci->pp.link_retain) {
> >> +			dev_info(dev, "Retaining PCIe link\n");
> >> +			return 0;
> >> +		}
> >> +	}
> >> +
> >>  	ret = reset_control_assert(res->rst);
> >>  	if (ret) {
> >>  		dev_err(dev, "reset assert failed (%d)\n", ret);
> >> @@ -1074,6 +1129,9 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> >>  {
> >>  	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
> >>  
> >> +	if (pcie->pci->pp.link_retain)
> >> +		return 0;
> >> +
> >>  	if (pcie_cfg->override_no_snoop)
> >>  		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
> >>  				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
> >> @@ -1364,12 +1422,13 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> >>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> >>  	int ret;
> >>  
> >> -	qcom_pcie_perst_assert(pcie);
> >> -
> > This is problematic. Most of the init callbacks do operations like reset the
> > PHY, enable clocks... If those operations affect the link state and the device
> > is not reset using PERST#, it will cause the device to crash.
> PERST# is only for endpoint, not for internal controller so it will not cause
> any crash.

If those operations affect the PCIe link state and REFCLK (most likely yes),
then it may end up crashing the device.

> More over the perst default state can be set be assert through pincntrl if you
> still
> suspect this can cause some issue on the pcie controller side.
> 

'can be set' is not a guarantee.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
