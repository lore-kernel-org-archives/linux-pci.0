Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbdJKWIW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Oct 2017 18:08:22 -0400
Date: Wed, 11 Oct 2017 17:08:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] PCI: protect restore with device lock to be
 consistent
Message-ID: <20171011220819.GW25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I think this series makes a lot of sense overall; thanks for doing
this work!  I had a few comments on the individual patches.

(This response would ordinarily be to the cover letter, but there
isn't one, so I'm just responding to the first patch.)

On Sat, Sep 23, 2017 at 08:16:54PM -0400, Sinan Kaya wrote:
> Commit b014e96d1abb ("PCI: Protect pci_error_handlers->reset_notify() usage
> with device_lock()") added protection around pci_dev_restore() function so
> that device specific remove callback does not cause a race condition
> against hotplug.
> 
> pci_dev_lock() usage has been forgotten in two different places in the
> code. Adding locks for pci_slot_restore() and moving pci_dev_restore()
> inside the locks for pci_try_reset_function().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6078dfc..23681f4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4344,9 +4344,9 @@ int pci_try_reset_function(struct pci_dev *dev)
>  
>  	pci_dev_save_and_disable(dev);
>  	rc = __pci_reset_function_locked(dev);
> +	pci_dev_restore(dev);
>  	pci_dev_unlock(dev);
>  
> -	pci_dev_restore(dev);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(pci_try_reset_function);
> @@ -4546,7 +4546,9 @@ static void pci_slot_restore(struct pci_slot *slot)
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
> +		pci_dev_lock(dev);
>  		pci_dev_restore(dev);
> +		pci_dev_unlock(dev);
>  		if (dev->subordinate)
>  			pci_bus_restore(dev->subordinate);
>  	}
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
