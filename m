Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56076 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeFVF0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2018 01:26:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 22 Jun 2018 10:56:06 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 1/7] PCI/DPC: Leave interrupts enabled while handling
 event
In-Reply-To: <20180620213833.25072-1-keith.busch@intel.com>
References: <20180620213833.25072-1-keith.busch@intel.com>
Message-ID: <e15b408472f371244c5b50a4c59b5d09@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-21 03:08, Keith Busch wrote:
> Now that the DPC driver clears the interrupt status before exiting the
> irq handler, we don't need to abuse the DPC control register to know if
> a shared interrupt is for a new DPC event: a DPC port can not trigger
> a second interrupt until the host clears the trigger status later in 
> the
> work queue handler.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/dpc.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 921ed979109d..972aac892846 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -77,7 +77,7 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev 
> *pdev)
>  	struct dpc_dev *dpc;
>  	struct pcie_device *pciedev;
>  	struct device *devdpc;
> -	u16 cap, ctl;
> +	u16 cap;
> 
>  	/*
>  	 * DPC disables the Link automatically in hardware, so it has
> @@ -105,10 +105,6 @@ static pci_ers_result_t dpc_reset_link(struct
> pci_dev *pdev)
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>  			      PCI_EXP_DPC_STATUS_TRIGGER);
> 
> -	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
> -	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
> -			      ctl | PCI_EXP_DPC_CTL_INT_EN);
> -
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
> 
> @@ -183,16 +179,11 @@ static irqreturn_t dpc_irq(int irq, void 
> *context)
>  	struct dpc_dev *dpc = (struct dpc_dev *)context;
>  	struct pci_dev *pdev = dpc->dev->port;
>  	struct device *dev = &dpc->dev->device;
> -	u16 cap = dpc->cap_pos, ctl, status, source, reason, ext_reason;
> -
> -	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
> -
> -	if (!(ctl & PCI_EXP_DPC_CTL_INT_EN) || ctl == (u16)(~0))
> -		return IRQ_NONE;
> +	u16 cap = dpc->cap_pos, status, source, reason, ext_reason;
> 
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> 
> -	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT))
> +	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || status == (u16)(~0))
>  		return IRQ_NONE;
> 
>  	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
> @@ -201,9 +192,6 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  		return IRQ_HANDLED;
>  	}
> 
> -	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
> -			      ctl & ~PCI_EXP_DPC_CTL_INT_EN);
> -
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
>  			     &source);
> 
> @@ -226,9 +214,8 @@ static irqreturn_t dpc_irq(int irq, void *context)
> 
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>  			      PCI_EXP_DPC_STATUS_INTERRUPT);
> -
> -	schedule_work(&dpc->work);
> -
> +	if (status & PCI_EXP_DPC_STATUS_TRIGGER)
> +		schedule_work(&dpc->work);
>  	return IRQ_HANDLED;
>  }



Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
<For whole series>
