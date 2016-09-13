Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759145AbcIMVcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 17:32:16 -0400
Date: Tue, 13 Sep 2016 16:32:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org
Subject: Re: [RFC] pci/aer: kmalloc the aer_err_info struct once
Message-ID: <20160913213205.GH4138@localhost>
References: <1473186952-8998-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473186952-8998-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 06, 2016 at 12:35:52PM -0600, Jon Derrick wrote:
> AER injecting tests with many devices and nosourceid are resulting in
> soft lockups, mostly due to the config reads, but there's also a
> kmalloc/kfree pair for the aer_err_info struct for each p_device.
> 
> When a device emits an error, it's not unreasonable to assume that it
> may emit another error soon. Instead of mallocing the aer error info
> struct each pass through the aer isr, malloc it once per root port and
> hold the reference through the life of the root port. This may save a
> few cycles if there are many devices downstream of the root port and
> no-source-id checking is enabled, disabling the fast path and requiring
> checking all devices for errors.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pcie/aer/aerdrv.c      |  1 +
>  drivers/pci/pcie/aer/aerdrv.h      |  1 +
>  drivers/pci/pcie/aer/aerdrv_core.c | 23 +++++++++++++++--------
>  3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 48d21e0..dab15d3 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -286,6 +286,7 @@ static void aer_remove(struct pcie_device *dev)
>  
>  		flush_work(&rpc->dpc_handler);
>  		aer_disable_rootport(rpc);
> +		kfree(rpc->e_info);
>  		kfree(rpc);
>  		set_service_data(dev, NULL);
>  	}
> diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
> index 945c939..2c5a5b8 100644
> --- a/drivers/pci/pcie/aer/aerdrv.h
> +++ b/drivers/pci/pcie/aer/aerdrv.h
> @@ -60,6 +60,7 @@ struct aer_rpc {
>  	struct pcie_device *rpd;	/* Root Port device */
>  	struct work_struct dpc_handler;
>  	struct aer_err_source e_sources[AER_ERROR_SOURCES_MAX];
> +	struct aer_err_info *e_info;
>  	unsigned short prod_idx;	/* Error Producer Index */
>  	unsigned short cons_idx;	/* Error Consumer Index */
>  	int isr;
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 521e39c..e1b2e6c 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -715,14 +715,23 @@ static inline void aer_process_err_devices(struct pcie_device *p_device,
>  static void aer_isr_one_error(struct pcie_device *p_device,
>  		struct aer_err_source *e_src)
>  {
> -	struct aer_err_info *e_info;
> +	struct aer_rpc *rpc = get_service_data(p_device);
> +	struct aer_err_info *e_info = rpc->e_info;
>  
> -	/* struct aer_err_info might be big, so we allocate it with slab */
> -	e_info = kmalloc(sizeof(struct aer_err_info), GFP_KERNEL);
> +	/*
> +	 * struct aer_err_info might be big, so we allocate it with slab.
> +	 * It's not unreasonable to assume a faulting device might emit
> +	 * another error, so try to only malloc once and keep the
> +	 * reference through the root port's life.
> +	 */
>  	if (!e_info) {
> -		dev_printk(KERN_DEBUG, &p_device->port->dev,
> -			"Can't allocate mem when processing AER errors\n");
> -		return;
> +		e_info = kmalloc(sizeof(struct aer_err_info), GFP_KERNEL);
> +		if (!e_info) {
> +			dev_printk(KERN_DEBUG, &p_device->port->dev,
> +				"Can't allocate mem when processing AER errors\n");
> +			return;
> +		}
> +		rpc->e_info = e_info;

I like the idea of this.  The part I *don't* like is using kmalloc()
in this path.

We've always done this, and this patch means we would only do it the
first time for each device, but the struct aer_rpc (which we allocate
for each device at probe time) is over 900 bytes, while the struct
aer_err_info is only about 70 bytes.  Why don't we just include
aer_error_info directly in aer_rpc and allocate the whole shebang once
at probe time?  I don't really see what we gain by doing the
allocation in the runtime path.

>  	}
>  
>  	/*
> @@ -762,8 +771,6 @@ static void aer_isr_one_error(struct pcie_device *p_device,
>  		if (find_source_device(p_device->port, e_info))
>  			aer_process_err_devices(p_device, e_info);
>  	}
> -
> -	kfree(e_info);
>  }
>  
>  /**
> -- 
> 1.8.3.1
> 
