Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53932 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeIEKYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Sep 2018 06:24:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 05 Sep 2018 11:26:05 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 05/16] PCI/ERR: Handle fatal error recovery
In-Reply-To: <20180831212639.10196-6-keith.busch@intel.com>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-6-keith.busch@intel.com>
Message-ID: <aff22d47f3f8295da0e5ae8e14a7954e@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-09-01 02:56, Keith Busch wrote:
> We don't need to be paranoid about the topology changing while handling 
> an
> error. If the device has changed in a hotplug capable slot, we can rely
> on the presence detection handling to react to a changing topology. 
> This
> patch restores the fatal error handling behavior that existed before
> merging DPC with AER with 7e9084b3674 ("PCI/AER: Handle ERR_FATAL with
> removal and re-enumeration of devices").
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/dpc.c |  2 +-
>  drivers/pci/pcie/err.c | 89 
> +++++++++-----------------------------------------
>  2 files changed, 17 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f03279fc87cd..eadfd835af13 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -169,7 +169,7 @@ static irqreturn_t dpc_handler(int irq, void 
> *context)
> 
>  	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
>  	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
> -	dev_warn(dev, "DPC %s detected, remove downstream devices\n",
> +	dev_warn(dev, "DPC %s detected\n",
>  		 (reason == 0) ? "unmasked uncorrectable error" :
>  		 (reason == 1) ? "ERR_NONFATAL" :
>  		 (reason == 2) ? "ERR_FATAL" :
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 12c1205e1d80..44c55f7ceb39 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -271,87 +271,20 @@ static pci_ers_result_t
> broadcast_error_message(struct pci_dev *dev,
>  	return result_data.result;
>  }
> 
> -/**
> - * pcie_do_fatal_recovery - handle fatal error recovery process
> - * @dev: pointer to a pci_dev data structure of agent detecting an 
> error
> - *
> - * Invoked when an error is fatal. Once being invoked, removes the 
> devices
> - * beneath this AER agent, followed by reset link e.g. secondary bus 
> reset
> - * followed by re-enumeration of devices.
> - */
> -void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
> -{
> -	struct pci_dev *udev;
> -	struct pci_bus *parent;
> -	struct pci_dev *pdev, *temp;
> -	pci_ers_result_t result;
> -
> -	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> -		udev = dev;
> -	else
> -		udev = dev->bus->self;
> -
> -	parent = udev->subordinate;
> -	pci_lock_rescan_remove();
> -	pci_dev_get(dev);
> -	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
> -					 bus_list) {
> -		pci_dev_get(pdev);
> -		pci_dev_set_disconnected(pdev, NULL);
> -		if (pci_has_subordinate(pdev))
> -			pci_walk_bus(pdev->subordinate,
> -				     pci_dev_set_disconnected, NULL);
> -		pci_stop_and_remove_bus_device(pdev);
> -		pci_dev_put(pdev);
> -	}
> -
> -	result = reset_link(udev, service);
> -
> -	if ((service == PCIE_PORT_SERVICE_AER) &&
> -	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
> -		/*
> -		 * If the error is reported by a bridge, we think this error
> -		 * is related to the downstream link of the bridge, so we
> -		 * do error recovery on all subordinates of the bridge instead
> -		 * of the bridge and clear the error status of the bridge.
> -		 */
> -		pci_aer_clear_fatal_status(dev);
> -		pci_aer_clear_device_status(dev);
> -	}
> -
> -	if (result == PCI_ERS_RESULT_RECOVERED) {
> -		if (pcie_wait_for_link(udev, true))
> -			pci_rescan_bus(udev->bus);
> -		pci_info(dev, "Device recovery from fatal error successful\n");
> -	} else {
> -		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> -		pci_info(dev, "Device recovery from fatal error failed\n");
> -	}
> -
> -	pci_dev_put(dev);
> -	pci_unlock_rescan_remove();
> -}
> -
> -/**
> - * pcie_do_nonfatal_recovery - handle nonfatal error recovery process
> - * @dev: pointer to a pci_dev data structure of agent detecting an 
> error
> - *
> - * Invoked when an error is nonfatal/fatal. Once being invoked, 
> broadcast
> - * error detected message to all downstream drivers within a hierarchy 
> in
> - * question and return the returned code.
> - */
> -void pcie_do_nonfatal_recovery(struct pci_dev *dev)
> +static void pcie_do_recovery(struct pci_dev *dev, enum 
> pci_channel_state state,
> +			     u32 service)
>  {
>  	pci_ers_result_t status;
> -	enum pci_channel_state state;
> -
> -	state = pci_channel_io_normal;
> 
>  	status = broadcast_error_message(dev,
>  			state,
>  			"error_detected",
>  			report_error_detected);
> 
> +	if (state == pci_channel_io_frozen &&
> +	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> +		goto failed;
> +
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER)
>  		status = broadcast_error_message(dev,
>  				state,
> @@ -387,3 +320,13 @@ void pcie_do_nonfatal_recovery(struct pci_dev 
> *dev)
>  	/* TODO: Should kernel panic here? */
>  	pci_info(dev, "AER: Device recovery failed\n");
>  }
> +
> +void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
> +{
> +	pcie_do_recovery(dev, pci_channel_io_frozen, service);
> +}
> +
> +void pcie_do_nonfatal_recovery(struct pci_dev *dev)
> +{
> +	pcie_do_recovery(dev, pci_channel_io_normal, PCIE_PORT_SERVICE_AER);
> +}


Overall I like this idea of not being paranoid about the topology 
changing while handling an
error. this is what was always on my mind, now since we are there, its 
good looking series.
