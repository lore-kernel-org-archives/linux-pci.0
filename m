Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f41.google.com ([209.85.160.41]:45914 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031286AbeBNPfs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Feb 2018 10:35:48 -0500
Received: by mail-pl0-f41.google.com with SMTP id p5so8707721plo.12
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2018 07:35:48 -0800 (PST)
Date: Wed, 14 Feb 2018 07:35:45 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: stanimir.varbanov@linaro.org, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: use regulator bluk api for apq8064 supplies
Message-ID: <20180214153545.GA93895@bjorns-mbp-2.lan>
References: <20180214122315.2069-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180214122315.2069-1-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed 14 Feb 04:23 PST 2018, Srinivas Kandagatla wrote:
> @@ -217,18 +216,15 @@ static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> +	int ret;
>  
> -	res->vdda = devm_regulator_get(dev, "vdda");
> -	if (IS_ERR(res->vdda))
> -		return PTR_ERR(res->vdda);
> -
> -	res->vdda_phy = devm_regulator_get(dev, "vdda_phy");
> -	if (IS_ERR(res->vdda_phy))
> -		return PTR_ERR(res->vdda_phy);
> -
> -	res->vdda_refclk = devm_regulator_get(dev, "vdda_refclk");
> -	if (IS_ERR(res->vdda_refclk))
> -		return PTR_ERR(res->vdda_refclk);
> +	res->supplies[0].supply = "vdda";
> +	res->supplies[1].supply = "vdda_phy";
> +	res->supplies[1].supply = "vdda_refclk";

2

> +	ret = devm_regulator_bulk_get(dev, QCOM_PCIE_2_1_0_MAX_SUPPLY,

Use ARRAY_SIZE(res->supplies) instead.

> +				      res->supplies);
> +	if (ret)
> +		return ret;
>  

Other than that, this looks good.

Regards,
Bjorn
