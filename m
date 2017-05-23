Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761585AbdEWTae (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 15:30:34 -0400
Date: Tue, 23 May 2017 14:30:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: control vpcie0v9 for system PM
Message-ID: <20170523193032.GA7241@bhelgaas-glaptop.roam.corp.google.com>
References: <1493710283-164065-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493710283-164065-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 02, 2017 at 03:31:23PM +0800, Shawn Lin wrote:
> vpcie0v9 is used for PHY, so we could disable it as
> we don't need PHY to work then in S3 if folks assign it
> DT. But we should note that there is a side effect that
> we could not support beacon wakeup if we disable vpcie0v9
> for aggressive power-saving.
> 
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-rockchip for v4.13, thanks!

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 0e020b6..c8ca796 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1251,6 +1251,9 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
>  	clk_disable_unprepare(rockchip->aclk_perf_pcie);
>  	clk_disable_unprepare(rockchip->aclk_pcie);
>  
> +	if (!IS_ERR(rockchip->vpcie0v9))
> +		regulator_disable(rockchip->vpcie0v9);
> +
>  	return ret;
>  }
>  
> @@ -1259,6 +1262,14 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
>  	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>  	int err;
>  
> +	if (!IS_ERR(rockchip->vpcie0v9)) {
> +		err = regulator_enable(rockchip->vpcie0v9);
> +		if (err) {
> +			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
> +			return err;
> +		}
> +	}
> +
>  	clk_prepare_enable(rockchip->clk_pcie_pm);
>  	clk_prepare_enable(rockchip->hclk_pcie);
>  	clk_prepare_enable(rockchip->aclk_perf_pcie);
> -- 
> 1.9.1
> 
> 
