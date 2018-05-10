Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 10 May 2018 08:22:22 -0500
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
Subject: Re: [PATCH v15 8/9] PCI/DPC: Unify and plumb error handling into DPC
Message-ID: <20180510132222.GE173327@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-9-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525323838-1735-9-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 01:03:57AM -0400, Oza Pawandeep wrote:
> Current DPC driver does not do recovery, e.g. calling end-point's driver's
> callbacks, which sanitize the sw.
> 
> DPC driver implements link_reset callback, and calls pci_do_recovery().
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 80ec384..aed7c9f 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -73,29 +73,21 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
>  	pcie_wait_for_link(pdev, false);
>  }
>  
> -static void dpc_work(struct work_struct *work)
> +static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  {
> -	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
> -	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
> -	struct pci_bus *parent = pdev->subordinate;
> -	u16 cap = dpc->cap_pos, ctl;
> -
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

I think it would be good to have a comment here about why this "reset_link"
function doesn't actually reset the link, e.g.,

  /*
   * DPC disables the Link automatically in hardware, so it has
   * already been reset by the time we get here.
   */

> +	struct dpc_dev *dpc;
> +	struct pcie_device *pciedev;
> +	struct device *devdpc;
> +	u16 cap, ctl;
> +
> +	devdpc = pcie_port_find_device(pdev, PCIE_PORT_SERVICE_DPC);
> +	pciedev = to_pcie_device(devdpc);
> +	dpc = get_service_data(pciedev);
> +	cap = dpc->cap_pos;

And maybe one about waiting until the link is inactive, then clearing DPC
Trigger Status to allow the port to leave DPC.

>  	dpc_wait_link_inactive(dpc);
>  	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
> -		return;
> +		return PCI_ERS_RESULT_DISCONNECT;
>  	if (dpc->rp_extensions && dpc->rp_pio_status) {
>  		pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS,
>  				       dpc->rp_pio_status);
> @@ -108,6 +100,17 @@ static void dpc_work(struct work_struct *work)
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
>  			      ctl | PCI_EXP_DPC_CTL_INT_EN);
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +static void dpc_work(struct work_struct *work)
> +{
> +	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
> +	struct pci_dev *pdev = dpc->dev->port;
> +
> +	/* From DPC point of view error is always FATAL. */
> +	pcie_do_recovery(pdev, DPC_FATAL);
>  }
>  
>  static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
> @@ -288,6 +291,7 @@ static struct pcie_port_service_driver dpcdriver = {
>  	.service	= PCIE_PORT_SERVICE_DPC,
>  	.probe		= dpc_probe,
>  	.remove		= dpc_remove,
> +	.reset_link	= dpc_reset_link,
>  };
>  
>  static int __init dpc_service_init(void)
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 877785d..526aba8 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -181,11 +181,12 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
>  	return PCI_ERS_RESULT_RECOVERED;
>  }
>  
> -static pci_ers_result_t reset_link(struct pci_dev *dev)
> +static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
>  {
>  	struct pci_dev *udev;
>  	pci_ers_result_t status;
>  	struct pcie_port_service_driver *driver;
> +	u32 service;
>  
>  	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>  		/* Reset this port for all subordinates */
> @@ -196,7 +197,12 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>  	}
>  
>  	/* Use the aer driver of the component firstly */
> -	driver = pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);
> +	if (severity == DPC_FATAL)
> +		service = PCIE_PORT_SERVICE_DPC;
> +	else
> +		service = PCIE_PORT_SERVICE_AER;
> +
> +	driver = pcie_port_find_service(udev, service);

This is where I was wondering about passing in "service" directly instead
of "severity".

>  	if (driver && driver->reset_link) {
>  		status = driver->reset_link(udev);
> @@ -302,7 +308,7 @@ static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)
>  		pci_dev_put(pdev);
>  	}
>  
> -	result = reset_link(udev);
> +	result = reset_link(udev, severity);
>  	if (result == PCI_ERS_RESULT_RECOVERED)
>  		if (pcie_wait_for_link(udev, true))
>  			pci_rescan_bus(udev->bus);
> @@ -326,7 +332,8 @@ void pcie_do_recovery(struct pci_dev *dev, int severity)
>  	pci_ers_result_t status;
>  	enum pci_channel_state state;
>  
> -	if (severity == AER_FATAL) {
> +	if ((severity == AER_FATAL) ||
> +	   (severity == DPC_FATAL)) {
>  		status = do_fatal_recovery(dev, severity);
>  		if (status != PCI_ERS_RESULT_RECOVERED)
>  			goto failed;
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 8f87bbe..0c506fe 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -14,6 +14,7 @@
>  #define AER_NONFATAL			0
>  #define AER_FATAL			1
>  #define AER_CORRECTABLE			2
> +#define DPC_FATAL			4
>  
>  struct pci_dev;
>  
> -- 
> 2.7.4
> 
