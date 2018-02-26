Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752587AbeBZOFa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Feb 2018 09:05:30 -0500
Date: Mon, 26 Feb 2018 14:05:23 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: srinivas.kandagatla@linaro.org
Cc: stanimir.varbanov@linaro.org, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] PCI: qcom: add missing supplies required for msm8996
Message-ID: <20180226140523.GA23806@e107981-ln.cambridge.arm.com>
References: <20180215132248.5572-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180215132248.5572-1-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 15, 2018 at 01:22:48PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds supplies that are required for msm8996. vdda
> is analog supply that go in to controller, and vddpe_3v3 is
> supply to PCIe endpoint.
> 
> Without these supplies PCIe endpoints which require power supplies are
> not enumerated at all, as there is no one to power it up.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> changes since v2:
> 	Add back empty line suggested by Stan
> 	use ARRAY_SIZE
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  4 ++++
>  drivers/pci/dwc/pcie-qcom.c                        | 23 +++++++++++++++++++++-

Applied to pci/dwc for v4.17, thanks.

Lorenzo

>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 3c9d321b3d3b..1fd703bd73e0 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -189,6 +189,10 @@
>  	Value type: <phandle>
>  	Definition: A phandle to the analog power supply for IC which generates
>  		    reference clock
> +- vddpe-3v3-supply:
> +	Usage: optional
> +	Value type: <phandle>
> +	Definition: A phandle to the PCIe endpoint power supply
>  
>  - phys:
>  	Usage: required for apq8084
> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
> index 3e89909f8cb9..e3f20e09a18d 100644
> --- a/drivers/pci/dwc/pcie-qcom.c
> +++ b/drivers/pci/dwc/pcie-qcom.c
> @@ -102,12 +102,14 @@ struct qcom_pcie_resources_1_0_0 {
>  	struct regulator *vdda;
>  };
>  
> +#define QCOM_PCIE_2_3_2_MAX_SUPPLY	2
>  struct qcom_pcie_resources_2_3_2 {
>  	struct clk *aux_clk;
>  	struct clk *master_clk;
>  	struct clk *slave_clk;
>  	struct clk *cfg_clk;
>  	struct clk *pipe_clk;
> +	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
>  };
>  
>  struct qcom_pcie_resources_2_4_0 {
> @@ -521,6 +523,14 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> +	int ret;
> +
> +	res->supplies[0].supply = "vdda";
> +	res->supplies[1].supply = "vddpe-3v3";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(res->supplies),
> +				      res->supplies);
> +	if (ret)
> +		return ret;
>  
>  	res->aux_clk = devm_clk_get(dev, "aux");
>  	if (IS_ERR(res->aux_clk))
> @@ -550,6 +560,8 @@ static void qcom_pcie_deinit_2_3_2(struct qcom_pcie *pcie)
>  	clk_disable_unprepare(res->master_clk);
>  	clk_disable_unprepare(res->cfg_clk);
>  	clk_disable_unprepare(res->aux_clk);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
>  }
>  
>  static void qcom_pcie_post_deinit_2_3_2(struct qcom_pcie *pcie)
> @@ -567,10 +579,16 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>  	u32 val;
>  	int ret;
>  
> +	ret = regulator_bulk_enable(ARRAY_SIZE(res->supplies), res->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot enable regulators\n");
> +		return ret;
> +	}
> +
>  	ret = clk_prepare_enable(res->aux_clk);
>  	if (ret) {
>  		dev_err(dev, "cannot prepare/enable aux clock\n");
> -		return ret;
> +		goto err_aux_clk;
>  	}
>  
>  	ret = clk_prepare_enable(res->cfg_clk);
> @@ -621,6 +639,9 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>  err_cfg_clk:
>  	clk_disable_unprepare(res->aux_clk);
>  
> +err_aux_clk:
> +	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
> +
>  	return ret;
>  }
>  
> -- 
> 2.15.1
> 
