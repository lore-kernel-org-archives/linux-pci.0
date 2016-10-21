Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51232 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbcJUH4z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Oct 2016 03:56:55 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: rockchip: Add three new resets as required properties
Date: Fri, 21 Oct 2016 09:56:26 +0200
Message-ID: <2683489.TXdAHLhj84@phil>
In-Reply-To: <1477017836-19317-2-git-send-email-shawn.lin@rock-chips.com>
References: <1477017836-19317-1-git-send-email-shawn.lin@rock-chips.com> <1477017836-19317-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, 21. Oktober 2016, 10:43:55 CEST schrieb Shawn Lin:
> pm_rst, aclk_rst, pclk_rst was controlled by rom code so the
> software wasn't needed to control it again in theory. But it
> didn't work properly, so we do need to do it again and add a
> enough delay between the assert of pm_rst and the deassert of
> pm_rst. The Soc intergrated with this controller, rk3399 is still
> under MP test internally, so the backward compatibility won't be
> a big deal.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

looks good from my side.
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

As Shawn wrote the soc in question (first one at all with a pcie controller) 
has not yet found its way into any device, so no existing one can abviously be 
affected by this change. So doing it this way will hopefully be ok.

Obviously it would probably be nice, to have this in 4.9-rc to keep the gap 
small.


Heiko

>  .../devicetree/bindings/pci/rockchip-pcie.txt      | 11 ++--
>  drivers/pci/host/pcie-rockchip.c                   | 62
> ++++++++++++++++++++++ 2 files changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt index
> ba67b39..71aeda1 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
> @@ -26,13 +26,16 @@ Required properties:
>  	- "sys"
>  	- "legacy"
>  	- "client"
> -- resets: Must contain five entries for each entry in reset-names.
> +- resets: Must contain seven entries for each entry in reset-names.
>  	   See ../reset/reset.txt for details.
>  - reset-names: Must include the following names
>  	- "core"
>  	- "mgmt"
>  	- "mgmt-sticky"
>  	- "pipe"
> +	- "pm"
> +	- "aclk"
> +	- "pclk"
>  - pinctrl-names : The pin control state names
>  - pinctrl-0: The "default" pinctrl state
>  - #interrupt-cells: specifies the number of cells needed to encode an
> @@ -86,8 +89,10 @@ pcie0: pcie@f8000000 {
>  	reg = <0x0 0xf8000000 0x0 0x2000000>, <0x0 0xfd000000 0x0 0x1000000>;
>  	reg-names = "axi-base", "apb-base";
>  	resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
> -		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>;
> -	reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
> +		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
> +		 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
> +	reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
> +		      "pm", "pclk", "aclk";
>  	phys = <&pcie_phy>;
>  	phy-names = "pcie-phy";
>  	pinctrl-names = "default";
> diff --git a/drivers/pci/host/pcie-rockchip.c
> b/drivers/pci/host/pcie-rockchip.c index e0b22da..e04f69b 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -190,6 +190,9 @@ struct rockchip_pcie {
>  	struct	reset_control *mgmt_rst;
>  	struct	reset_control *mgmt_sticky_rst;
>  	struct	reset_control *pipe_rst;
> +	struct	reset_control *pm_rst;
> +	struct	reset_control *aclk_rst;
> +	struct	reset_control *pclk_rst;
>  	struct	clk *aclk_pcie;
>  	struct	clk *aclk_perf_pcie;
>  	struct	clk *hclk_pcie;
> @@ -408,6 +411,44 @@ static int rockchip_pcie_init_port(struct rockchip_pcie
> *rockchip)
> 
>  	gpiod_set_value(rockchip->ep_gpio, 0);
> 
> +	err = reset_control_assert(rockchip->aclk_rst);
> +	if (err) {
> +		dev_err(dev, "assert aclk_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(rockchip->pclk_rst);
> +	if (err) {
> +		dev_err(dev, "assert pclk_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_assert(rockchip->pm_rst);
> +	if (err) {
> +		dev_err(dev, "assert pm_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	udelay(10);
> +
> +	err = reset_control_deassert(rockchip->pm_rst);
> +	if (err) {
> +		dev_err(dev, "deassert pm_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_deassert(rockchip->aclk_rst);
> +	if (err) {
> +		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> +		return err;
> +	}
> +
> +	err = reset_control_deassert(rockchip->pclk_rst);
> +	if (err) {
> +		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> +		return err;
> +	}
> +
>  	err = phy_init(rockchip->phy);
>  	if (err < 0) {
>  		dev_err(dev, "fail to init phy, err %d\n", err);
> @@ -781,6 +822,27 @@ static int rockchip_pcie_parse_dt(struct rockchip_pcie
> *rockchip) return PTR_ERR(rockchip->pipe_rst);
>  	}
> 
> +	rockchip->pm_rst = devm_reset_control_get(dev, "pm");
> +	if (IS_ERR(rockchip->pm_rst)) {
> +		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing pm reset property in node\n");
> +		return PTR_ERR(rockchip->pm_rst);
> +	}
> +
> +	rockchip->pclk_rst = devm_reset_control_get(dev, "pclk");
> +	if (IS_ERR(rockchip->pclk_rst)) {
> +		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing pclk reset property in node\n");
> +		return PTR_ERR(rockchip->pclk_rst);
> +	}
> +
> +	rockchip->aclk_rst = devm_reset_control_get(dev, "aclk");
> +	if (IS_ERR(rockchip->aclk_rst)) {
> +		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
> +			dev_err(dev, "missing aclk reset property in node\n");
> +		return PTR_ERR(rockchip->aclk_rst);
> +	}
> +
>  	rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
>  	if (IS_ERR(rockchip->ep_gpio)) {
>  		dev_err(dev, "missing ep-gpios property in node\n");


