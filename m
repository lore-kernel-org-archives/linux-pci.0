Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934553AbcIFTXt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 15:23:49 -0400
Date: Tue, 6 Sep 2016 14:23:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] pci/aer: Add bus flag to skip source id matching
Message-ID: <20160906192344.GD7554@localhost>
References: <1472167571-11123-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472167571-11123-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 25, 2016 at 05:26:10PM -0600, Jon Derrick wrote:
> Allow root port buses to choose to skip source id matching when finding
> the faulting device. Certain root port devices may return an incorrect
> source id and recommend to scan child device registers for aer
> notifications.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Applied both of these to pci/host-vmd for v4.9, thanks!

I think I might even go farther and remove the "nosourceid" module
parameter.  Per Documentation/PCI/pcieaer-howto.txt, it's to work
around broken hardware, but it's not otherwise documented.  With the
flag you're adding, we could add quirks for that broken hardware,
which would be far better.  I doubt anybody's actually using that
module parameter.

> ---
>  drivers/pci/pcie/aer/aerdrv_core.c | 7 +++++--
>  include/linux/pci.h                | 5 +++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 521e39c..3a0d839 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -132,7 +132,9 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>  	 * When bus id is equal to 0, it might be a bad id
>  	 * reported by root port.
>  	 */
> -	if (!nosourceid && (PCI_BUS_NUM(e_info->id) != 0)) {
> +	if (!nosourceid &&
> +	    (PCI_BUS_NUM(e_info->id) != 0) &&
> +	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
>  		/* Device ID match? */
>  		if (e_info->id == ((dev->bus->number << 8) | dev->devfn))
>  			return true;
> @@ -147,7 +149,8 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>  	 *      1) nosourceid==y;
>  	 *      2) bus id is equal to 0. Some ports might lose the bus
>  	 *              id of error source id;
> -	 *      3) There are multiple errors and prior id comparing fails;
> +	 *      3) bus flag PCI_BUS_FLAGS_NO_AERSID is set
> +	 *      4) There are multiple errors and prior id comparing fails;
>  	 * We check AER status registers to find possible reporter.
>  	 */
>  	if (atomic_read(&dev->enable_cnt) == 0)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b7d3aa2..5c08137 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -183,8 +183,9 @@ enum pci_irq_reroute_variant {
>  
>  typedef unsigned short __bitwise pci_bus_flags_t;
>  enum pci_bus_flags {
> -	PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
> -	PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
> +	PCI_BUS_FLAGS_NO_MSI	= (__force pci_bus_flags_t) 1,
> +	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
> +	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
>  };
>  
>  /* These values come from the PCI Express Spec */
> -- 
> 1.8.3.1
> 
