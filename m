Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:57453 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935217AbcJaK7w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2016 06:59:52 -0400
Date: Mon, 31 Oct 2016 12:00:40 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 3/3] pci/msix: Skip disabling removed devices
Message-ID: <20161031110040.GA9693@wunner.de>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <1477695497-6207-4-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477695497-6207-4-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 28, 2016 at 06:58:17PM -0400, Keith Busch wrote:
> There is no need to disable MSIx interrupts or write message data on a
> device that isn't present. This patch checks the device removed state
> prior to executing device shutdown operations so that tear down on
> removed devices completes quicker.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/msi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index bfdd074..9249ec1 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -317,7 +317,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  {
>  	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
>  
> -	if (dev->current_state != PCI_D0) {
> +	if (dev->current_state != PCI_D0 || dev->is_removed) {
>  		/* Don't touch the hardware now */
>  	} else if (entry->msi_attrib.is_msix) {
>  		void __iomem *base = pci_msix_desc_addr(entry);

Hm, I don't see __pci_write_msi_msg() being called anywhere on device
removal.  Am I missing something?  Rest of the patch LGTM.

Thanks,

Lukas

> @@ -1017,6 +1017,11 @@ void pci_msix_shutdown(struct pci_dev *dev)
>  	if (!pci_msi_enable || !dev || !dev->msix_enabled)
>  		return;
>  
> +	if (dev->is_removed) {
> +		dev->msix_enabled = 0;
> +		return;
> +	}
> +
>  	/* Return the device with MSI-X masked as initial states */
>  	for_each_pci_msi_entry(entry, dev) {
>  		/* Keep cached states to be restored */
> -- 
> 2.7.2
