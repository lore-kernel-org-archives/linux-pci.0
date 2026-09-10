Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC72371899;
	Thu, 10 Sep 2026 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024870; cv=none; b=KGivpQZ0YjNgFIVFuWFqa3GW7SVEL2USXA1MFnwSG4ka0ALmppjeO/x5yw1gwaX4wXhD+PfrZjsbdTwOsAj/xamRZSCVwdZloMxZcnvJZ8I3rlIExneDywdy+29CQkrXPStvr68ljQu+L9tX8rkbSEHMNK3H63V9QyuwbRdfkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024870; c=relaxed/simple;
	bh=q4L0q0OfnPuvtFAGnEBOkYmRezNqJwmRDFb+02NRgZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN3ykjY6mLHOWfHryUgXUPiZ/M694aWPH+wFZ5AF86zHctjdHJVay/+DGW92JatA9otSNFmBes0qN/BkZq+76GWgyr/07yntDLef1CpgyQoi3kVQAxRm8h5IBnQ2lV+lkubdUbZzsSRbd7z8z9/+HNzBHYPJwjQMKyVfxW6zRII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKcSsOZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKcSsOZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282A51F000FF;
	Thu, 10 Sep 2026 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024868;
	bh=fs2GO2ucfvQef/WDQaTt63tsX174+5+4LFAzvYnckFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gKcSsOZTJUbET1+Lf+1r4mnFr7Udi36wc/aS4qJHWG6aRDYzmeXtWGX1+5Em1ryHy
	 73tHbBAzUjbjXoZN62Bty+lGl46Xa3IG7AqrNoi9IX0C4s1WVYcoAYPuiFh1prt3N8
	 xMrUFojnqUehLsb54NSlOElTAgqXC73wFisC6nMFTyMxUkbX4Etbqat0kSKZa7sRf3
	 7JVGZo9SXlKnL/rotWcDtfceLir80hZirovQ8Sz0mpn3OUWumQeEHEzF30BIxJDsuu
	 ifeBWGjqM9auzbIK8QtkCf+2Uv3Bbx0LNSwb40g0HQOl0oalks5gWKGn1fe9XpUM8+
	 C3i4w6MWTuWOw==
Date: Thu, 10 Sep 2026 09:20:58 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, shengchao.guo@oss.qualcomm.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/5] PCI: qcom: Add CGC disable workaround for Nord
 PCIe
Message-ID: <smgyk5ray7laj2ltwnmx3r7cfiouj4hyn7tyfmx7rpsrhu7kin@p5pr7wdoprjn>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-3-b0a82721c547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909-nord-v3-3-b0a82721c547@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 05:18:18PM +0530, Krishna Chaitanya Chundru wrote:
> Nord requires a workaround to address a timing convergence issue in the
> PCIe power domain. To avoid the issue, set the CORE_CLK_CGC_DIS and
> AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.
> 

Both the subject and commit message sounds like this patch is only adding the
CGC workaround (you need to expand CGC btw), but this patch is adding Nord PCIe
controller support. So that should be the subject and CGC, l0s, no_snoop should
be documented in the commit message.

> The SLV_ACLK_CGC_DIS bit is already configured by hardware reset. This
> change adds the remaining required settings as documented in
> QCTDD11972446.

Mention that this erratum is private and not available publicly.

> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b58a607b713f..b97e40fb7ec8 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -281,6 +281,7 @@ struct qcom_pcie_cfg {
>  	bool override_no_snoop;
>  	bool firmware_managed;
>  	bool no_l0s;
> +	bool cgc_dis_workaround;

'disable_cgc'

>  };
>  
>  struct qcom_pcie_perst {
> @@ -1097,11 +1098,18 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
> +	u32 val;
>  
>  	if (pcie_cfg->override_no_snoop)
>  		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
>  				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
>  
> +	if (pcie_cfg->cgc_dis_workaround) {
> +		val = readl(pcie->parf + PARF_SYS_CTRL);
> +		val |= CORE_CLK_CGC_DIS | AUX_PWR_DET;
> +		writel(val, pcie->parf + PARF_SYS_CTRL);
> +	}
> +
>  	qcom_pcie_set_slot_cap(pcie->pci);
>  
>  	return 0;
> @@ -1630,6 +1638,13 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
>  	.ops = &ops_2_9_0,
>  };
>  
> +static const struct qcom_pcie_cfg cfg_nord = {

Can you use DWC IP version instead of SoC name?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
