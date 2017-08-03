Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752037AbdHCVpD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 17:45:03 -0400
Date: Thu, 3 Aug 2017 16:45:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 056/102] PCI: mediatek: explicitly request exclusive
 reset control
Message-ID: <20170803214500.GF20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-57-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170719152646.25903-57-p.zabel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 19, 2017 at 05:26:00PM +0200, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
> 
> No functional changes.
> 
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied to pci/host-mediatek for v4.14, thanks!

Ryder, Matthias, holler if you see any issues.

> ---
>  drivers/pci/host/pcie-mediatek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index 5a9d8589ea0bd..9c9f89bcf24ce 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -303,7 +303,7 @@ static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
>  	}
>  
>  	snprintf(name, sizeof(name), "pcie-rst%d", index);
> -	port->reset = devm_reset_control_get_optional(dev, name);
> +	port->reset = devm_reset_control_get_optional_exclusive(dev, name);
>  	if (PTR_ERR(port->reset) == -EPROBE_DEFER)
>  		return PTR_ERR(port->reset);
>  
> -- 
> 2.11.0
> 
