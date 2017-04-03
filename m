Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbdDCVMH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Apr 2017 17:12:07 -0400
Date: Mon, 3 Apr 2017 16:12:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: set RC's RCB to 128 bytes
Message-ID: <20170403211203.GC13232@bhelgaas-glaptop.roam.corp.google.com>
References: <1490002780-67737-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490002780-67737-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 20, 2017 at 05:39:40PM +0800, Shawn Lin wrote:
> Read Completion Boundary could be 64 bytes or 128 bytes
> for rockchip RC. The reset value of RCB is zero which means
> it doesn't support RCB to be 128 bytes, however it does support
> that. When setting the RCB to 128 bytes, we see some significant
> improvment for testing NVMe with libaio. So this patch will set
> RC's RCB to 128 bytes.
> 
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-rockchip for v4.12, thanks!

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 26ddd35..8bcd417 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -599,6 +599,11 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	status |= PCI_EXP_LNKCTL_CCC;
>  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>  
> +	/* Set RC's RCB to 128 */
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status |= PCI_EXP_LNKCTL_RCB;
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +
>  	/* Enable Gen1 training */
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
> -- 
> 1.9.1
> 
> 
