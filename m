Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35449 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbcDHPHY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2016 11:07:24 -0400
Date: Fri, 8 Apr 2016 08:07:23 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI: Move PCIe ports to D3 during suspend
Message-ID: <20160408150723.GA29919@kroah.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
 <1460111790-92836-3-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460111790-92836-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 08, 2016 at 01:36:28PM +0300, Mika Westerberg wrote:
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index f0640b7a1c42..aafc1b093bc8 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -379,7 +379,7 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
>  	 * need to have the registers polled during D3, so avoid D3cold.
>  	 */
>  	if (xhci->quirks & XHCI_COMP_MODE_QUIRK)
> -		pdev->no_d3cold = true;
> +		pci_enable_d3cold(pdev, false);
>  
>  	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
>  		xhci_pme_quirk(hcd);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 004b8133417d..d8801587b4ca 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -296,6 +296,7 @@ struct pci_dev {
>  	unsigned int	d2_support:1;	/* Low power state D2 is supported */
>  	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>  	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
> +	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
>  	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
>  	unsigned int	mmio_always_on:1;	/* disallow turning off io/mem
>  						   decoding during bar sizing */
> @@ -1085,6 +1086,7 @@ int pci_back_from_sleep(struct pci_dev *dev);
>  bool pci_dev_run_wake(struct pci_dev *dev);
>  bool pci_check_pme_status(struct pci_dev *dev);
>  void pci_pme_wakeup_bus(struct pci_bus *bus);
> +void pci_enable_d3cold(struct pci_dev *dev, bool enable);

That's an ackward api, as is seen in the above use in the xhci driver
(enable false?)

Why not just make 2 functions:
	pci_dc3cold_enable(struct pci_dev *dev)
	pci_dc3cold_disable(struct pci_dev *dev)
which makes it obvious what is going on.

Whenever you add a bool to a function, it requires the developer to go
look up the implementation to see what it means and how to use it, to
check if the usage is correct.  Just make it obvious in the name itself
so everyone knows exactly what is going on.

Same thing goes for pci_bridge_pm_update(), even with the documentation
I'm not quite sure what the bool flag is for.  Please split this into
two calls as well.

thanks,

greg k-h
