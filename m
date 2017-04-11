Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752436AbdDKVm0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Apr 2017 17:42:26 -0400
Date: Tue, 11 Apr 2017 16:42:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        "jeffy.chen" <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v2] PCI: rockchip: Mark PCI_EXP_LNKSTA_SLC in the root
 port
Message-ID: <20170411214220.GD14778@bhelgaas-glaptop.roam.corp.google.com>
References: <1491548357-145106-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491548357-145106-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 07, 2017 at 02:59:17PM +0800, Shawn Lin wrote:
> All platforms using Rockchip use a common clock for the Root
> Port and the slot connected to it. Indicate this by setting
> the Slot Clock Configuration (PCI_EXP_LNKSTA_SLC) bit in the
> Root Port's Link Status.
> 
> Per the Implementation Note in the spec (PCIe r3.1, sec 7.8.7),
> if the downstream component also sets PCI_EXP_LNKSTA_SLC, software
> may set the Common Clock Configuration (PCI_EXP_LNKCTL_CCC) bits on
> both ends of the Link. This is done by pcie_aspm_configure_common_clock()
> 
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: jeffy.chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-rockchip for v4.12, thanks!

> ---
> 
> Changes in v2:
> - replace CCC with SLC
> - reword the commit msg
> 
>  drivers/pci/host/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 26ddd35..7e7a6b6 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -596,7 +596,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  
>  	/* Set RC's clock architecture as common clock */
>  	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> -	status |= PCI_EXP_LNKCTL_CCC;
> +	status |= PCI_EXP_LNKSTA_SLC << 16;
>  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
>  
>  	/* Enable Gen1 training */
> -- 
> 1.9.1
> 
> 
