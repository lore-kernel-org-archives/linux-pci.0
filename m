Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbeDJVDv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Apr 2018 17:03:51 -0400
Date: Tue, 10 Apr 2018 16:03:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
Message-ID: <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523284914-2037-7-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:54AM -0400, Oza Pawandeep wrote:
> DPC and AER should attempt recovery in the same way, except the
> cases where system is with hotplug enabled.

What's the connection with hotplug?  I see from the patch that for
hotplug bridges you remove the tree below the bridge, and otherwise
you just reset the secondary link (I think).

The changelog should explain why we need the difference.

I'm a little skeptical to begin with, because I'm not sure why we
should handle a DPC event differently just because a bridge has the
*capability* of hotplug.  Even if a hotplug bridge reports a DPC
event, that doesn't necessarily mean a hotplug has occurred.

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 8e1553b..6d9a841 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -108,8 +108,6 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
>   */
>  static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  {
> -	struct pci_bus *parent = pdev->subordinate;
> -	struct pci_dev *dev, *temp;
>  	struct dpc_dev *dpc;
>  	struct pcie_device *pciedev;
>  	struct device *devdpc;
> @@ -120,19 +118,6 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	dpc = get_service_data(pciedev);
>  	cap = dpc->cap_pos;
>  
> -	pci_lock_rescan_remove();
> -	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> -					 bus_list) {
> -		pci_dev_get(dev);
> -		pci_dev_set_disconnected(dev, NULL);
> -		if (pci_has_subordinate(dev))
> -			pci_walk_bus(dev->subordinate,
> -				     pci_dev_set_disconnected, NULL);
> -		pci_stop_and_remove_bus_device(dev);
> -		pci_dev_put(dev);
> -	}
> -	pci_unlock_rescan_remove();
> -
>  	dpc_wait_link_inactive(dpc);
>  	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
>  		return PCI_ERS_RESULT_DISCONNECT;
> @@ -152,13 +137,37 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> +static void dpc_reset_link_remove_dev(struct pci_dev *pdev)
> +{
> +	struct pci_bus *parent = pdev->subordinate;
> +	struct pci_dev *dev, *temp;
> +
> +	pci_lock_rescan_remove();
> +	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> +					 bus_list) {
> +		pci_dev_get(dev);
> +		pci_dev_set_disconnected(dev, NULL);
> +		if (pci_has_subordinate(dev))
> +			pci_walk_bus(dev->subordinate,
> +				     pci_dev_set_disconnected, NULL);
> +		pci_stop_and_remove_bus_device(dev);
> +		pci_dev_put(dev);
> +	}
> +	pci_unlock_rescan_remove();
> +
> +	dpc_reset_link(pdev);
> +}
> +
>  static void dpc_work(struct work_struct *work)
>  {
>  	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
>  	struct pci_dev *pdev = dpc->dev->port;
>  
>  	/* From DPC point of view error is always FATAL. */
> -	pcie_do_recovery(pdev, DPC_FATAL);
> +	if (!pdev->is_hotplug_bridge)
> +		pcie_do_recovery(pdev, DPC_FATAL);
> +	else
> +		dpc_reset_link_remove_dev(pdev);
>  }
>  static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
>  {
> -- 
> 2.7.4
> 
