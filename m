Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965340AbdEWTop (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 15:44:45 -0400
Date: Tue, 23 May 2017 14:44:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: check link status when validating device
Message-ID: <20170523194443.GD7241@bhelgaas-glaptop.roam.corp.google.com>
References: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 19, 2017 at 02:58:27PM +0800, Shawn Lin wrote:
> This patch checks the link status before reading and
> writing configure space of devices attached to the RC.
> If the link status is down, we shouldn't try to access
> the devices.

What bad things happen without this patch?

It's racy to check the link status, then do the config access.  The
link might go down after we check but before we can perform the
access.

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 0e020b6..1e64227 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -275,9 +275,21 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, val, PCIE_CORE_TXCREDIT_CFG1);
>  }
>  
> +static inline bool rockchip_pcie_link_up(struct rockchip_pcie *rockchip)
> +{
> +	return PCIE_LINK_UP(rockchip_pcie_read(rockchip,
> +					PCIE_CLIENT_BASIC_STATUS1));
> +}
> +
>  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
>  				      struct pci_bus *bus, int dev)
>  {
> +	/* do not access the devices if the link isn't completed */
> +	if (bus->number != rockchip->root_bus_nr) {
> +		if (!rockchip_pcie_link_up(rockchip))
> +			return 0;
> +	}
> +
>  	/* access only one slot on each root port */
>  	if (bus->number == rockchip->root_bus_nr && dev > 0)
>  		return 0;
> -- 
> 1.9.1
> 
> 
