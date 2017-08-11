Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:55001 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdHKCjP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 22:39:15 -0400
Message-ID: <598D18CC.5080104@rock-chips.com>
Date: Fri, 11 Aug 2017 10:39:08 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3] PCI: rockchip: fix system hang up if activating CONFIG_DEBUG_SHIRQ
References: <1502416371-185632-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1502416371-185632-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On 08/11/2017 09:52 AM, Shawn Lin wrote:
> +static void rockchip_pcie_disable_clocks(void *data)
> +{
> +	struct rockchip_pcie *rockchip = data;
> +
> +	clk_disable_unprepare(rockchip->clk_pcie_pm);
> +	clk_disable_unprepare(rockchip->hclk_pcie);
> +	clk_disable_unprepare(rockchip->aclk_perf_pcie);
> +	clk_disable_unprepare(rockchip->aclk_pcie);
> +}

maybe we can reuse this function in suspend noirq


> +
>   static int rockchip_pcie_probe(struct platform_device *pdev)
>   {
>   	struct rockchip_pcie *rockchip;
> @@ -1493,31 +1511,49 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   	err = clk_prepare_enable(rockchip->aclk_pcie);
>   	if (err) {
>   		dev_err(dev, "unable to enable aclk_pcie clock\n");
> -		goto err_aclk_pcie;
> +		return err;
>   	}
>
>   	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
>   	if (err) {
>   		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
> -		goto err_aclk_perf_pcie;
> +		clk_disable_unprepare(rockchip->aclk_pcie);
> +		return err;
>   	}
>
>   	err = clk_prepare_enable(rockchip->hclk_pcie);
>   	if (err) {
>   		dev_err(dev, "unable to enable hclk_pcie clock\n");
> -		goto err_hclk_pcie;
> +		clk_disable_unprepare(rockchip->aclk_pcie);
> +		clk_disable_unprepare(rockchip->aclk_perf_pcie);
> +		return err;
>   	}
>
>   	err = clk_prepare_enable(rockchip->clk_pcie_pm);
>   	if (err) {
> -		dev_err(dev, "unable to enable hclk_pcie clock\n");
> -		goto err_pcie_pm;
> +		dev_err(dev, "unable to enable clk_pcie_pm clock\n");
> +		clk_disable_unprepare(rockchip->aclk_pcie);
> +		clk_disable_unprepare(rockchip->aclk_perf_pcie);
> +		clk_disable_unprepare(rockchip->hclk_pcie);
> +		return err;
>   	}

maybe we can have a rockchip_pcie_enable_clocks for these, and also 
reuse it in resume noirq
