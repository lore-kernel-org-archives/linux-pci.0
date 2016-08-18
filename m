Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755142AbcHSB4O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:56:14 -0400
Date: Thu, 18 Aug 2016 18:29:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 2/3] pci/msix: Skip disabling removed devices
Message-ID: <20160818232941.GT27353@localhost>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <1470683667-28418-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470683667-28418-3-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 08, 2016 at 01:14:26PM -0600, Keith Busch wrote:
> There is no need to disable MSIx interrupts on a device that doesn't
> exist.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/msi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index a02981e..b60ee25 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -999,6 +999,11 @@ void pci_msix_shutdown(struct pci_dev *dev)
>  	if (!pci_msi_enable || !dev || !dev->msix_enabled)
>  		return;
>  
> +	if (!pci_device_is_present(dev)) {

It doesn't really make sense to me to use pci_device_is_present()
(which calls pci_bus_read_dev_vendor_id()) for this purpose.

Adding a new config read and checking for failure seems like just
narrowing the window -- a device that stops responding between this
point and the next required config read could still cause a problem.

Is this fixing a performance problem?  What's the specific motivation
for this?

I see "completion synthesis" in your cover letter.  I don't know what
that is; maybe the capabilities cover letter would have made more
sense to me if I did.

And you also mention "instability with hardware" -- what exactly is
that?  I understand some slowdown if we do config accesses to
non-existent devices, but I don't understand hardware instability.

> +		dev->msix_enabled = 0;
> +		return;
> +	}
> +
>  	/* Return the device with MSI-X masked as initial states */
>  	for_each_pci_msi_entry(entry, dev) {
>  		/* Keep cached states to be restored */
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
