Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31990 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbcHMAMV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 12 Aug 2016 20:12:21 -0400
Date: Fri, 12 Aug 2016 17:03:58 -0700
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] pci: add option to ignore slot capabilities
Message-ID: <20160813000358.GA20474@sean.stalley.intel.com>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Mon, Aug 08, 2016 at 02:19:01PM -0600, Keith Busch wrote:
> This adds flags to struct pci_dev that can be set to request ignoring
> attention and power indicators. This is in prepration for devices that
> advertise these capabilities, but do not support it.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 6 ++++++
>  include/linux/pci.h              | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 08e84d6..3e6646c 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -804,6 +804,12 @@ struct controller *pcie_init(struct pcie_device *dev)
>  	}
>  	ctrl->pcie = dev;
>  	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
> +
> +	if (pdev->ignore_aip)
> +		slot_cap &= ~PCI_EXP_SLTCAP_AIP;
> +	if (pdev->ignore_pip)
> +		slot_cap &= ~PCI_EXP_SLTCAP_PIP;
> +

I think we should clear these bits after the ctrl_info() below.
If we clear it immediately, the ctrl_info() will report these bits as cleared,
even though they may be set in hardware.

I don't think we want to put a value into the log that differs from what hardware reports.

>  	ctrl->slot_cap = slot_cap;
>  	mutex_init(&ctrl->ctrl_lock);
>  	init_waitqueue_head(&ctrl->queue);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9890906..d8bc530 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -308,6 +308,8 @@ struct pci_dev {
>  						   powered on/off by the
>  						   corresponding bridge */
>  	unsigned int	ignore_hotplug:1;	/* Ignore hotplug events */
> +	unsigned int	ignore_aip:1;		/* Ignore attention indicator */
> +	unsigned int	ignore_pip:1;		/* Ignore power indicator */
>  	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
>  
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
