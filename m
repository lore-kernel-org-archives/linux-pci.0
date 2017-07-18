Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33618 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbdGRUdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 16:33:39 -0400
Received: by mail-pg0-f54.google.com with SMTP id k14so18691629pgr.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 13:33:38 -0700 (PDT)
Date: Tue, 18 Jul 2017 13:33:36 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/7] PCI: rockchip: introduce per-lanes PHYs
 support
Message-ID: <20170718203335.GC116895@google.com>
References: <1500364623-97041-1-git-send-email-shawn.lin@rock-chips.com>
 <1500364623-97041-3-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500364623-97041-3-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tue, Jul 18, 2017 at 03:56:58PM +0800, Shawn Lin wrote:
> We distinguish the legacy PHY with the newer per-lane
> PHYs by adding legacy_phy flag. Note that the legacy phy
> is still the first option to be searched in order not to
> break the backward compatibility of DTB.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v3:
> - kill rockchip_pcie_manipulate_phys and related stuff
> - use phys array
> - improve the commit msg
> 
> Changes in v2: None
> 
>  drivers/pci/host/pcie-rockchip.c | 100 +++++++++++++++++++++++++++------------
>  1 file changed, 69 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 6632a51..4cc6aec 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c

...

> @@ -537,10 +579,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		return err;
>  	}
>  
> -	err = phy_init(rockchip->phy);
> -	if (err < 0) {
> -		dev_err(dev, "fail to init phy, err %d\n", err);
> -		return err;
> +	for (i = 0; i < MAX_LANE_NUM; i++) {
> +		err = phy_init(rockchip->phys[i]);
> +		if (err) {
> +			dev_err(dev, "init phy err %d\n", err);

Include the PHY index in the error message?

> +			return err;
> +		}
>  	}
>  
>  	err = reset_control_assert(rockchip->core_rst);
> @@ -602,10 +646,12 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  			    PCIE_CLIENT_MODE_RC,
>  			    PCIE_CLIENT_CONFIG);
>  
> -	err = phy_power_on(rockchip->phy);
> -	if (err) {
> -		dev_err(dev, "fail to power on phy, err %d\n", err);
> -		return err;
> +	for (i = 0; i < MAX_LANE_NUM; i++) {
> +		err = phy_power_on(rockchip->phys[i]);
> +		if (err) {
> +			dev_err(dev, "power on phy err %d\n", err);

Same?

> +			return err;
> +		}
>  	}
>  
>  	/*

...

Brian
