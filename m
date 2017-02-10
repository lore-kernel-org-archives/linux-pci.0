Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753151AbdBJVED (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Feb 2017 16:04:03 -0500
Date: Fri, 10 Feb 2017 15:03:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH 1/2] pcie-dpc: Decode extended reasons
Message-ID: <20170210210335.GL29169@bhelgaas-glaptop.roam.corp.google.com>
References: <1486158373-18655-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486158373-18655-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 03, 2017 at 04:46:12PM -0500, Keith Busch wrote:
> This is just informational to decode the currently defined extended
> event reasons rather than just using the generic "extended" explanation.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Applied both of these to pci/dpc for v4.11, thanks, Keith!

> ---
>  drivers/pci/pcie/pcie-dpc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index d91e538..9ca74f4 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -77,11 +77,15 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  
>  	if (status & PCI_EXP_DPC_STATUS_TRIGGER) {
>  		u16 reason = (status >> 1) & 0x3;
> +		u16 ext_reason = (status >> 5) & 0x3;
>  
> -		dev_warn(&dpc->dev->device, "DPC %s triggered, remove downstream devices\n",
> +		dev_warn(&dpc->dev->device, "DPC %s detected, remove downstream devices\n",
>  			 (reason == 0) ? "unmasked uncorrectable error" :
>  			 (reason == 1) ? "ERR_NONFATAL" :
> -			 (reason == 2) ? "ERR_FATAL" : "extended error");
> +			 (reason == 2) ? "ERR_FATAL" :
> +			 (ext_reason == 0) ? "RP PIO error" :
> +			 (ext_reason == 1) ? "software trigger" :
> +					     "reserved error");
>  		schedule_work(&dpc->work);
>  	}
>  	return IRQ_HANDLED;
> -- 
> 2.7.2
> 
