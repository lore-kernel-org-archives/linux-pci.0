Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE5E31352F;
	Mon, 16 Feb 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254535; cv=none; b=OAdrqKhd8+CZA5Cpb8lCP1pNDuSjpjR9NMXXG9ceB0EqFQYtf8GqWIl5Nn5a/WksLiurj67sR6puUEeKNO3kIvpd24F5l7gH5xCeOrjGKzL4KLytCo6+3GnIyky9n9dHmBuJb5L8IvuruE7bPeuqVqUnawFt2oy2BTavd/d+13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254535; c=relaxed/simple;
	bh=dc3qZ6MngsLfirs8y1/jUoXbmuh9O84XNbto5LTFwUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjnUk9pSAPHnLZMc9CKhyP/+kdHiOpnniwLiGNHSLZAqwtb5BK9Kz/0uNxfEDIwRdRDq6xmQf9i6NuSp5bzrZ3ZgbfEo/vP6Px1QGtzLqYYFGfRFUgy6HQYEOMsg0NkfcUW7pienl69nEDZ4nbradZAglJzchNzwkmiF7/sOT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbAPFS8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbAPFS8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C46C19424;
	Mon, 16 Feb 2026 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771254534;
	bh=dc3qZ6MngsLfirs8y1/jUoXbmuh9O84XNbto5LTFwUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbAPFS8mDbZ9iVT5nWfBiuJ+cU1efDYuqfs5j9ofssHGRXO7oM73CCq3RmnKe2uaH
	 PhSAZQJ7jEJnlUY9LHuaLpGAApYnphKYblHchNOHVHAa5CHVA6uUbe3/4EjzLSUEun
	 zmevWDRBWNX/To/POy6KG5WnodsKVKVNtRsE+W0fiegFiYfYQmbUzwYjrcuyCy3GEb
	 axuiFqm2k9zTwJVeTpmUhUyUH+awdTmGDm5qox12bHI3+uQqwnEGIEKIHqpvYqjGYo
	 mZgcMlO938xHdQUhcorlbe2+QR+cQ1t/k+5lqGbD4IDmqg0mOwnwX8HUhK80UbJOO2
	 nnYtpWD6LKxbA==
Date: Mon, 16 Feb 2026 20:38:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: qcom: Add link retention support
Message-ID: <xifiwzkg7bscg2ueqlbhpe53km2shhl7npmqvmdc2xwxhh56c6@x5vfuhablrsf>
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
 <20260109-link_retain-v1-4-7e6782230f4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109-link_retain-v1-4-7e6782230f4b@oss.qualcomm.com>

On Fri, Jan 09, 2026 at 12:51:09PM +0530, Krishna Chaitanya Chundru wrote:
> Some platforms keep the PCIe link active across bootloader and kernel
> handoff. Reinitializing the controller and toggling PERST# in such cases
> is unnecessary if driver doesn't want to do link training again.
> 
> Introduce link_retain in both qcom_pcie_cfg and qcom_pcie to
> indicate when link retention is supported. During initialization, check
> the LTSSM state, if the link is already in L0 or L1 idle and LTSSM is
> enabled, set pp.link_retain and skip controller reset, PERST# toggling,
> and other post-init steps.
> 
> If there is a devicetree property to restrict PCIe data rate and lane
> width go with the normal execution instead of link retantion logic.
> 

Mention the properties here and also make it clear that the link will not be
retained if the values do not match bootloader programmed ones.

> Configure DBI and ATU base in this scenerio, since bootloader DBI & ATU
> base may differ from HLOS one. So use the DBI & ATU provided from the
> devicetree.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 50 ++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 9342f9c75f1c3017b55614069a7aa821a6fb8da7..bdd5bdb462c5f6814c8311be96411173456b6b14 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -259,12 +259,14 @@ struct qcom_pcie_ops {
>    * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
>    * snooping
>    * @firmware_managed: Set if the Root Complex is firmware managed
> +  * @link_retain: Set if controller supports link retain from bootloader

s/"link retain"/"retaining link"

>    */
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
>  	bool override_no_snoop;
>  	bool firmware_managed;
>  	bool no_l0s;
> +	bool link_retain;
>  };
>  
>  struct qcom_pcie_port {
> @@ -965,6 +967,35 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static bool qcom_pcie_check_link_retain(struct qcom_pcie *pcie)
> +{
> +	u32 cap, speed, val, ltssm, width;
> +	struct dw_pcie *pci = pcie->pci;
> +	u8 offset;
> +
> +	val = readl(pcie->parf + PARF_LTSSM);
> +	ltssm = val & 0x1f;
> +	if ((val & LTSSM_EN) &&
> +	    (ltssm == DW_PCIE_LTSSM_L0 || ltssm == DW_PCIE_LTSSM_L1_IDLE)) {
> +		qcom_pcie_configure_dbi_atu_base(pcie);
> +
> +		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +		cap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +		speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
> +		width = dw_pcie_link_get_max_link_width(pci);
> +
> +		if (pci->max_link_speed > 0 && speed < pci->max_link_speed)
> +			return false;
> +
> +		if (pci->num_lanes > 0 && width > pci->num_lanes)
> +			return false;

IIUC, these checks are in place to override the link retention if the users want
to change the lane/width count than what was already programmed by the
bootloader.

If so, please add comment on top of this helper to make it explicit.

> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> @@ -983,6 +1014,14 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	if (ret < 0)
>  		goto err_disable_regulators;
>  
> +	if (pcie->cfg->link_retain) {
> +		pci->pp.link_retain = qcom_pcie_check_link_retain(pcie);
> +		if (pci->pp.link_retain) {
> +			dev_info(dev, "Enabling link retain\n");

"Retaining PCIe link"

- Mani

-- 
மணிவண்ணன் சதாசிவம்
