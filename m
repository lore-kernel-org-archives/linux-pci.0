Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751772AbeFEWKE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jun 2018 18:10:04 -0400
Date: Tue, 5 Jun 2018 17:09:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Alex_Gagniuc@Dellteam.com,
        Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCH 4/4] PCI/AER: Lock pci topology when scanning errors
Message-ID: <20180605220911.GB226399@bhelgaas-glaptop.roam.corp.google.com>
References: <20180409220444.6632-1-keith.busch@intel.com>
 <20180409220444.6632-5-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409220444.6632-5-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2018 at 04:04:44PM -0600, Keith Busch wrote:
> The side effects of surprise removal may trigger AER handling. The AER
> handling walks the pci topology and may access a pci_dev that is being
> freed by the hotplug handler.
> 
> This patch fixes that use-after-free by locking the PCI topology in
> the AER handler so it isn't racing with the pciehp removal.
> 
> Since the AER handler now runs under a global PCI lock, the rpc specific
> mutex is no longer necessary.
> 
> Reported-by: Alex Gagniuc <Alex_Gagniuc@Dellteam.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/aer/aerdrv.c      | 1 -
>  drivers/pci/pcie/aer/aerdrv.h      | 5 -----
>  drivers/pci/pcie/aer/aerdrv_core.c | 4 ++--
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 0b2eb88c422b..b88e5e2f3700 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -237,7 +237,6 @@ static struct aer_rpc *aer_alloc_rpc(struct pcie_device *dev)
>  	rpc->rpd = pci_dev_get(dev->port);
>  	kref_init(&rpc->ref);
>  	INIT_WORK(&rpc->dpc_handler, aer_isr);
> -	mutex_init(&rpc->rpc_mutex);
>  
>  	/* Use PCIe bus function to store rpc into PCIe device */
>  	set_service_data(dev, rpc);
> diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
> index f886521e2c7b..b90fc5d4cda2 100644
> --- a/drivers/pci/pcie/aer/aerdrv.h
> +++ b/drivers/pci/pcie/aer/aerdrv.h
> @@ -70,11 +70,6 @@ struct aer_rpc {
>  					 * Lock access to Error Status/ID Regs
>  					 * and error producer/consumer index
>  					 */
> -	struct mutex rpc_mutex;		/*
> -					 * only one thread could do
> -					 * recovery on the same
> -					 * root port hierarchy
> -					 */
>  };
>  
>  struct aer_broadcast_data {
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index e4059d7fa7fa..de210b7439eb 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -796,10 +796,10 @@ void aer_isr(struct work_struct *work)
>  	struct aer_rpc *rpc = container_of(work, struct aer_rpc, dpc_handler);
>  	struct aer_err_source uninitialized_var(e_src);
>  
> -	mutex_lock(&rpc->rpc_mutex);
> +	pci_lock_rescan_remove();
>  	while (get_e_source(rpc, &e_src))
>  		aer_isr_one_error(rpc, &e_src);
> -	mutex_unlock(&rpc->rpc_mutex);
> +	pci_unlock_rescan_remove();

I think this needs to be updated after Oza's patches, doesn't it?

It looks like this would deadlock if I applied it to my current "next"
branch as-is:

  aer_isr
    pci_lock_rescan_remove
    aer_isr_one_error
      aer_process_err_devices
        handle_error_source
          pcie_do_fatal_recovery
            pci_lock_rescan_remove      <-- deadlock

>       aer_release(rpc);
>  }
> -- 
> 2.14.3
> 
