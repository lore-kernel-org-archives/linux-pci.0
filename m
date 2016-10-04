Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752537AbcJDRYU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Oct 2016 13:24:20 -0400
Date: Tue, 4 Oct 2016 12:24:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] PCI: rockchip: improve the deassert sequence of four
 reset pins
Message-ID: <20161004172404.GC3449@localhost>
References: <1474596360-23483-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474596360-23483-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 23, 2016 at 10:05:59AM +0800, Shawn Lin wrote:
> Per TRM, we need to deassert the four reset pins simultaneously.
> Currently the reset framework doesn't support that so we did it
> one by one. It seems no side effect found but it does impact the
> state machine of controller, so sometimes the change speed bit is
> not setted when sending training sequence from recover state.
> After the silicon RTL review from Soc guys, we don't need to do
> the sequence recommended by TRM, and could just move the deassert
> of mgmt_sticky_rst to the first place.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied both to pci/host-rockchip for v4.9, thanks!

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index c3593e6..5e51121 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -433,21 +433,25 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		return err;
>  	}
>  
> -	err = reset_control_deassert(rockchip->core_rst);
> +	/*
> +	 * Please don't reorder the deassert sequence of the following
> +	 * four reset pins.
> +	 */
> +	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
>  	if (err) {
> -		dev_err(dev, "deassert core_rst err %d\n", err);
> +		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
>  		return err;
>  	}
>  
> -	err = reset_control_deassert(rockchip->mgmt_rst);
> +	err = reset_control_deassert(rockchip->core_rst);
>  	if (err) {
> -		dev_err(dev, "deassert mgmt_rst err %d\n", err);
> +		dev_err(dev, "deassert core_rst err %d\n", err);
>  		return err;
>  	}
>  
> -	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
> +	err = reset_control_deassert(rockchip->mgmt_rst);
>  	if (err) {
> -		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> +		dev_err(dev, "deassert mgmt_rst err %d\n", err);
>  		return err;
>  	}
>  
> -- 
> 2.3.7
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
