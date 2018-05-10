Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757063AbeEJNRT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 09:17:19 -0400
Date: Thu, 10 May 2018 08:17:17 -0500
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
Subject: Re: [PATCH v15 3/9] PCI/AER: Handle ERR_FATAL with removal and
 re-enumeration of devices
Message-ID: <20180510131717.GC173327@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-4-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525323838-1735-4-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 01:03:52AM -0400, Oza Pawandeep wrote:
> This patch alters the behavior of handling of ERR_FATAL, where removal
> of devices is initiated, followed by reset link, followed by
> re-enumeration.
> 
> So the errors are handled in a different way as follows:
> ERR_NONFATAL => call driver recovery entry points
> ERR_FATAL    => remove and re-enumerate
> 
> please refer to Documentation/PCI/pci-error-recovery.txt for more details.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 779b387..206f590 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -330,6 +330,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
>  	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
>  
> +	/*
> +	 * This function is called only on ERR_FATAL now, and since
> +	 * the pci_report_resume is called only in ERR_NONFATAL case,
> +	 * the clearing part has to be taken care here.
> +	 */
> +	aer_error_resume(dev);
> +
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 0ea5acc..655d4e8 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/kfifo.h>
>  #include "aerdrv.h"
> +#include "../../pci.h"
>  
>  #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
>  				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
> @@ -474,6 +475,44 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>  	return status;
>  }
>  
> +static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)

Here's a possiblity for your consideration.  Expose these two interfaces:

  void pcie_do_nonfatal_recovery(struct pci_dev *dev);
  void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service);

(this would be the end result, after the rename and move to err.c) and move
the fatal/nonfatal testing into the callers, e..g, 

  handle_error_source(...)
  {
    ...
    if (info->severity == AER_NONFATAL)
      pcie_do_nonfatal_recovery(dev);
    else if (info->severity == AER_FATAL)
      pcie_do_fatal_recovery(dev, PCIE_PORT_SERVICE_AER);
  }

Then I don't think you would need this code in reset_link():

  reset_link(...)
  {
    ...
    if (severity == DPC_FATAL)
      service = PCIE_PORT_SERVICE_DPC;
    ...

because you would already have the service.

> +{
> +	struct pci_dev *udev;
> +	struct pci_bus *parent;
> +	struct pci_dev *pdev, *temp;
> +	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
> +
> +	if (severity == AER_FATAL)
> +		pci_cleanup_aer_uncorrect_error_status(dev);
> +
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +		udev = dev;
> +	else
> +		udev = dev->bus->self;
> +
> +	parent = udev->subordinate;
> +	pci_lock_rescan_remove();
> +	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
> +				 bus_list) {
> +		pci_dev_get(pdev);
> +		pci_dev_set_disconnected(pdev, NULL);
> +		if (pci_has_subordinate(pdev))
> +			pci_walk_bus(pdev->subordinate,
> +				     pci_dev_set_disconnected, NULL);
> +		pci_stop_and_remove_bus_device(pdev);
> +		pci_dev_put(pdev);
> +	}
> +
> +	result = reset_link(udev);
> +	if (result == PCI_ERS_RESULT_RECOVERED)
> +		if (pcie_wait_for_link(udev, true))
> +			pci_rescan_bus(udev->bus);
> +
> +	pci_unlock_rescan_remove();
> +
> +	return result;
> +}
> +
>  /**
>   * do_recovery - handle nonfatal/fatal error recovery process
>   * @dev: pointer to a pci_dev data structure of agent detecting an error
> @@ -485,11 +524,15 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>   */
>  static void do_recovery(struct pci_dev *dev, int severity)
>  {
> -	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
> +	pci_ers_result_t status;
>  	enum pci_channel_state state;
>  
> -	if (severity == AER_FATAL)
> -		state = pci_channel_io_frozen;
> +	if (severity == AER_FATAL) {
> +		status = do_fatal_recovery(dev, severity);
> +		if (status != PCI_ERS_RESULT_RECOVERED)
> +			goto failed;
> +		return;
> +	}
>  	else
>  		state = pci_channel_io_normal;
>  
> @@ -498,12 +541,6 @@ static void do_recovery(struct pci_dev *dev, int severity)
>  			"error_detected",
>  			report_error_detected);
>  
> -	if (severity == AER_FATAL) {
> -		result = reset_link(dev);
> -		if (result != PCI_ERS_RESULT_RECOVERED)
> -			goto failed;
> -	}
> -
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER)
>  		status = broadcast_error_message(dev,
>  				state,
> -- 
> 2.7.4
> 
