Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBVSj5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Feb 2018 13:39:57 -0500
Date: Thu, 22 Feb 2018 10:39:54 -0800
From: Christoph Hellwig <hch@infradead.org>
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
Subject: Re: [PATCH v10 4/7] PCI/DPC: Unify and plumb error handling into DPC
Message-ID: <20180222183954.GD6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-5-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519315332-26852-5-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 22, 2018 at 09:32:09PM +0530, Oza Pawandeep wrote:
> Current DPC driver does not do recovery, e.g. calling end-point's driver's
> callbacks, which sanitize the sw.
> 
> DPC driver implements link_reset callback, and calls pci_do_recovery.
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a5a79f0..124f42e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -343,6 +343,8 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
>  void pci_enable_acs(struct pci_dev *dev);
>  
>  /* PCI error reporting and recovery */
> +#define DPC_FATAL	4
> +
>  void pci_do_recovery(struct pci_dev *dev, int severity);
>  
>  #ifdef CONFIG_PCIEASPM
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index 38e40c6..208b427 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -13,6 +13,7 @@
>  #include <linux/pcieport_if.h>
>  #include "../pci.h"
>  #include "aer/aerdrv.h"
> +#include "portdrv.h"
>  
>  struct dpc_dev {
>  	struct pcie_device	*dev;
> @@ -45,6 +46,60 @@ struct dpc_dev {
>  	"Memory Request Completion Timeout",		 /* Bit Position 18 */
>  };
>  
> +static int find_dpc_dev_iter(struct device *device, void *data)
> +{
> +	struct pcie_port_service_driver *service_driver;
> +	struct device **dev;
> +
> +	dev = (struct device **) data;
> +
> +	if (device->bus == &pcie_port_bus_type && device->driver) {
> +		service_driver = to_service_driver(device->driver);

Please move the initial assignment to the declaration line to
clean this up a bit:

	struct device **dev = (struct device **)data;

Same thing happens a couple more times in this patch.

> +EXPORT_SYMBOL(pci_find_dpc_service);

EXPORT_SYMBOL_GPL for PCI layer internals again - and ditto for
probably about everything in this series.

>  #if IS_ENABLED(CONFIG_PCIEAER)
> -	/* Use the aer driver of the component firstly */
> -	driver = pci_find_aer_service(udev);
> +	if ((severity == AER_FATAL) ||
> +	    (severity == AER_NONFATAL) ||
> +	    (severity == AER_CORRECTABLE))
> +		driver = pci_find_aer_service(udev);
>  #endif

No need for the inner braces here.

> -	if (severity == AER_FATAL)
> +	if ((severity == AER_FATAL) ||
> +	    (severity == DPC_FATAL))
>  		state = pci_channel_io_frozen;
>  	else
>  		state = pci_channel_io_normal;

Same here and a few more times below.
