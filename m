Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeHNMCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2018 08:02:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 14 Aug 2018 14:46:32 +0530
From: poza@codeaurora.org
To: Thomas Tai <thomas.tai@oracle.com>
Cc: bhelgaas@google.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
Message-ID: <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-13 22:21, Thomas Tai wrote:
> In order to prevent the pcie_do_fatal_recovery() from
> using the device after it is removed, the device's
> domain:bus:devfn is stored at the entry of
> pcie_do_fatal_recovery(). After rescanning the bus, the
> stored domain:bus:devfn is used to find the device and
> uses to report pci_info. The original issue only happens
> on an non-bridge device, a local variable is used instead
> of checking the device's header type.
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> ---
>  drivers/pci/pcie/err.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index f02e334..3414445 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -287,15 +287,20 @@ void pcie_do_fatal_recovery(struct pci_dev *dev,
> u32 service)
>  	struct pci_bus *parent;
>  	struct pci_dev *pdev, *temp;
>  	pci_ers_result_t result;
> +	bool is_bridge_device = false;
> +	u16 domain = pci_domain_nr(dev->bus);
> +	u8 bus = dev->bus->number;
> +	u8 devfn = dev->devfn;
> 
> -	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		is_bridge_device = true;
>  		udev = dev;
> -	else
> +	} else {
>  		udev = dev->bus->self;
> +	}
> 
>  	parent = udev->subordinate;
>  	pci_lock_rescan_remove();
> -	pci_dev_get(dev);
>  	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
>  					 bus_list) {
>  		pci_dev_get(pdev);
> @@ -309,27 +314,35 @@ void pcie_do_fatal_recovery(struct pci_dev *dev,
> u32 service)
> 
>  	result = reset_link(udev, service);
> 
> -	if ((service == PCIE_PORT_SERVICE_AER) &&
> -	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
> +	if (service == PCIE_PORT_SERVICE_AER && is_bridge_device) {
>  		/*
>  		 * If the error is reported by a bridge, we think this error
>  		 * is related to the downstream link of the bridge, so we
>  		 * do error recovery on all subordinates of the bridge instead
>  		 * of the bridge and clear the error status of the bridge.
>  		 */
> -		pci_cleanup_aer_uncorrect_error_status(dev);
> +		pci_cleanup_aer_uncorrect_error_status(udev);
>  	}
> 
>  	if (result == PCI_ERS_RESULT_RECOVERED) {
>  		if (pcie_wait_for_link(udev, true))
>  			pci_rescan_bus(udev->bus);
> -		pci_info(dev, "Device recovery from fatal error successful\n");
> +		/* find the pci_dev after rescanning the bus */
> +		dev = pci_get_domain_bus_and_slot(domain, bus, devfn);
one of the motivations was to remove and re-enumerate rather then going 
thorugh driver's recovery sequence
was; it might be possible that hotplug capable bridge, the device might 
have changed.
hence this check will fail
> +		if (dev)
> +			pci_info(dev, "Device recovery from fatal error successful\n");
> +		else
> +			pr_err("AER: Can not find pci_dev for %04x:%02x:%02x.%x\n",
> +			       domain, bus,
> +			       PCI_SLOT(devfn), PCI_FUNC(devfn));
> +		pci_dev_put(dev);
>  	} else {
> -		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> -		pci_info(dev, "Device recovery from fatal error failed\n");
> +		if (is_bridge_device)
previously there was no condition.. why is this required now ?
and it was doing on "dev" while you are doing it on "udev"
> +			pci_uevent_ers(udev, PCI_ERS_RESULT_DISCONNECT);
> +		pr_err("AER: Device %04x:%02x:%02x.%x recovery from fatal error 
> failed\n",
> +		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>  	}
> 
> -	pci_dev_put(dev);
>  	pci_unlock_rescan_remove();
>  }

Regards,
Oza.
