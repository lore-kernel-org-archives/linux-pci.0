Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41476 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932094AbcHIReB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Aug 2016 13:34:01 -0400
Date: Tue, 9 Aug 2016 12:33:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 3/3] pcie/aer: Cache capability position
Message-ID: <20160809173350.GE27301@localhost>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <1470683667-28418-4-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470683667-28418-4-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Mon, Aug 08, 2016 at 01:14:27PM -0600, Keith Busch wrote:
> This saves the postition of the error reporting capability so that it
> doesn't need to be rediscovered during error handling.

I like the idea of this, and I wonder if we should go even further,
and cache aer_pos in the pci_dev.  There are a zillion places that
look for PCI_EXT_CAP_ID_ERR, and several of them are outside the AER
driver, where it would be inconvenient to look up the aer_rpc.

That would probably mean adding a hook to pci_init_capabilities(),
which would be kind of nice anyway because we already have a call to
pci_cleanup_aer_error_status_regs() there, which is sort of dangling
and not parallel to the other calls.

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/aer/aerdrv.c | 38 +++++++++++++++++---------------------
>  drivers/pci/pcie/aer/aerdrv.h |  1 +
>  2 files changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 48d21e0..d05c864 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -122,7 +122,6 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
>  static void aer_enable_rootport(struct aer_rpc *rpc)
>  {
>  	struct pci_dev *pdev = rpc->rpd->port;

What if you did this instead:

 -	int aer_pos;
 +	int aer_pos = rpc->pos;

Then all the config accesses wouldn't have to change.

>  	u16 reg16;
>  	u32 reg32;
>  
> @@ -134,14 +133,13 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
>  				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
>  
> -	aer_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
>  	/* Clear error status */
> -	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, &reg32);
> -	pci_write_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, reg32);
> -	pci_read_config_dword(pdev, aer_pos + PCI_ERR_COR_STATUS, &reg32);
> -	pci_write_config_dword(pdev, aer_pos + PCI_ERR_COR_STATUS, reg32);
> -	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
> -	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
> +	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_STATUS, &reg32);
> +	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_STATUS, reg32);
> +	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_COR_STATUS, &reg32);
> +	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_COR_STATUS, reg32);
> +	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_UNCOR_STATUS, &reg32);
> +	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_UNCOR_STATUS, reg32);
>  
>  	/*
>  	 * Enable error reporting for the root port device and downstream port
> @@ -150,9 +148,9 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	set_downstream_devices_error_reporting(pdev, true);
>  
>  	/* Enable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
> +	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_COMMAND, &reg32);
>  	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, reg32);
> +	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_COMMAND, reg32);
>  }
>  
>  /**
> @@ -165,7 +163,6 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
>  {
>  	struct pci_dev *pdev = rpc->rpd->port;
>  	u32 reg32;
> -	int pos;
>  
>  	/*
>  	 * Disable error reporting for the root port device and downstream port
> @@ -173,15 +170,14 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
>  	 */
>  	set_downstream_devices_error_reporting(pdev, false);
>  
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
>  	/* Disable Root's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
> +	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_COMMAND, &reg32);
>  	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, pos + PCI_ERR_ROOT_COMMAND, reg32);
> +	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_COMMAND, reg32);
>  
>  	/* Clear Root's error status reg */
> -	pci_read_config_dword(pdev, pos + PCI_ERR_ROOT_STATUS, &reg32);
> -	pci_write_config_dword(pdev, pos + PCI_ERR_ROOT_STATUS, reg32);
> +	pci_read_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_STATUS, &reg32);
> +	pci_write_config_dword(pdev, rpc->pos + PCI_ERR_ROOT_STATUS, reg32);
>  }
>  
>  /**
> @@ -198,9 +194,7 @@ irqreturn_t aer_irq(int irq, void *context)
>  	struct aer_rpc *rpc = get_service_data(pdev);
>  	int next_prod_idx;
>  	unsigned long flags;
> -	int pos;
>  
> -	pos = pci_find_ext_capability(pdev->port, PCI_EXT_CAP_ID_ERR);
>  	/*
>  	 * Must lock access to Root Error Status Reg, Root Error ID Reg,
>  	 * and Root error producer/consumer index
> @@ -208,15 +202,15 @@ irqreturn_t aer_irq(int irq, void *context)
>  	spin_lock_irqsave(&rpc->e_lock, flags);
>  
>  	/* Read error status */
> -	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, &status);
> +	pci_read_config_dword(pdev->port, rpc->pos + PCI_ERR_ROOT_STATUS, &status);
>  	if (!(status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV))) {
>  		spin_unlock_irqrestore(&rpc->e_lock, flags);
>  		return IRQ_NONE;
>  	}
>  
>  	/* Read error source and clear error status */
> -	pci_read_config_dword(pdev->port, pos + PCI_ERR_ROOT_ERR_SRC, &id);
> -	pci_write_config_dword(pdev->port, pos + PCI_ERR_ROOT_STATUS, status);
> +	pci_read_config_dword(pdev->port, rpc->pos + PCI_ERR_ROOT_ERR_SRC, &id);
> +	pci_write_config_dword(pdev->port, rpc->pos + PCI_ERR_ROOT_STATUS, status);
>  
>  	/* Store error source for later DPC handler */
>  	next_prod_idx = rpc->prod_idx + 1;
> @@ -317,6 +311,8 @@ static int aer_probe(struct pcie_device *dev)
>  		return -ENOMEM;
>  	}
>  
> +	rpc->pos = pci_find_ext_capability(dev->port, PCI_EXT_CAP_ID_ERR);
> +
>  	/* Request IRQ ISR */
>  	status = request_irq(dev->irq, aer_irq, IRQF_SHARED, "aerdrv", dev);
>  	if (status) {
> diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
> index 945c939..d7c586e 100644
> --- a/drivers/pci/pcie/aer/aerdrv.h
> +++ b/drivers/pci/pcie/aer/aerdrv.h
> @@ -72,6 +72,7 @@ struct aer_rpc {
>  					 * recovery on the same
>  					 * root port hierarchy
>  					 */
> +	int pos;			/* position of AER capability */
>  };
>  
>  struct aer_broadcast_data {
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
