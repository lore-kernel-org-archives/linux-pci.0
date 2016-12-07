Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753104AbcLGVru (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 16:47:50 -0500
Date: Wed, 7 Dec 2016 15:46:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v3 3/3] PCI: rockchip: Add system PM support
Message-ID: <20161207214653.GF22129@bhelgaas-glaptop.roam.corp.google.com>
References: <1479952462-194300-1-git-send-email-shawn.lin@rock-chips.com>
 <1479952462-194300-3-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479952462-194300-3-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Thu, Nov 24, 2016 at 09:54:22AM +0800, Shawn Lin wrote:
> This patch adds system PM support for Rockchip's RC.
> For pre S3, the EP is configured into D3 state which guarantees
> the link state should be in L1. So we could send PME_Turn_Off message
> to the EP and wait for its ACK to make the link state into L2 or L3
> without the aux-supply. This could help save more power which I think
> should be very important for mobile devices.
> 
> As note that there is a 5s timeout for RC to wait for the PMA_ACK
> aftering send PME_Turn_Off. Technically it should depends on the
> hierarchy of devices but seems PCIe core framework doesn't handle the
> L2/3 for S3 at all. So that means we should presume to set a default
> value for PME_ACK. From the bug report[1], we could find a statment that
> Microsoft Windows versions typically wait for 5 seconds. So we are prone
> to take 5s for this timeout here.
> 
> [1] https://lists.launchpad.net/kernel-packages/msg123315.html
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>

> @@ -1196,8 +1207,96 @@ static int rockchip_cfg_atu(struct rockchip_pcie *rockchip)
>  		}
>  	}
>  
> +	/* assign message regions */
> +	rockchip_pcie_prog_ob_atu(rockchip, reg_no + 1 + offset,
> +				  AXI_WRAPPER_NOR_MSG,
> +				  20 - 1, 0, 0);
> +	if (rockchip->msg_region)
> +		goto out;
> +
> +	rockchip->msg_region = devm_ioremap(rockchip->dev,
> +					    rockchip->mem_bus_addr +
> +					    ((reg_no + offset) << 20),
> +					    SZ_1M);
> +	if (!rockchip->msg_region)
> +		err = -ENOMEM;

I don't really like this strategy of "if msg_region is already mapped,
skip it; otherwise map it."  The ioremap() looks like something that
should be done at probe-time and does not need to be re-done at
resume-time.

Bjorn
