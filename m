Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62086 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932782AbaLJVO5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Dec 2014 16:14:57 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so3539351iec.36
        for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2014 13:14:56 -0800 (PST)
Date: Wed, 10 Dec 2014 14:14:54 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra: remove bogus bridge setup fixup
Message-ID: <20141210211454.GE6692@google.com>
References: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de>
 <1415907457-3147-3-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415907457-3147-3-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 13, 2014 at 08:37:37PM +0100, Lucas Stach wrote:
> The bridge setup is already done by generic code
> while scanning the buses. Do not duplicate (or potentially
> alter) this setup as a fixup.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied to next-pci/host-tegra for v3.19, with Tested-by, Reviewed-by, and
Acked-by from Alexandre and Thierry.  This branch will be rebased to
v3.19-rc1 when it comes out.

Bjorn

> ---
>  drivers/pci/host/pci-tegra.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index d5a14f22ebb8..0ef22505cead 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -624,19 +624,6 @@ static void tegra_pcie_port_free(struct tegra_pcie_port *port)
>  	devm_kfree(pcie->dev, port);
>  }
>  
> -static void tegra_pcie_fixup_bridge(struct pci_dev *dev)
> -{
> -	u16 reg;
> -
> -	if ((dev->class >> 16) == PCI_BASE_CLASS_BRIDGE) {
> -		pci_read_config_word(dev, PCI_COMMAND, &reg);
> -		reg |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> -			PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
> -		pci_write_config_word(dev, PCI_COMMAND, reg);
> -	}
> -}
> -DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_fixup_bridge);
> -
>  /* Tegra PCIE root complex wrongly reports device class */
>  static void tegra_pcie_fixup_class(struct pci_dev *dev)
>  {
> -- 
> 2.1.1
> 
