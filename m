Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932185AbcI2Vtx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Sep 2016 17:49:53 -0400
Date: Thu, 29 Sep 2016 16:49:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, alex.williamson@redhat.com,
        vikrams@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/5] PCI: save and restore bus on parent bus reset
Message-ID: <20160929214942.GD20897@localhost>
References: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
 <1474056395-21843-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474056395-21843-4-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Fri, Sep 16, 2016 at 04:06:32PM -0400, Sinan Kaya wrote:
> Device states on the bus are saved and restored for all bus resets except
> the one initiated through pci_dev_reset. Filling the hole.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aab9d51..8aecab1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -51,6 +51,10 @@ static void pci_pme_list_scan(struct work_struct *work);
>  static LIST_HEAD(pci_pme_list);
>  static DEFINE_MUTEX(pci_pme_list_mutex);
>  static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
> +static void pci_dev_lock(struct pci_dev *dev);
> +static void pci_dev_unlock(struct pci_dev *dev);
> +static void pci_bus_save_and_disable(struct pci_bus *bus);
> +static void pci_bus_restore(struct pci_bus *bus);
>  
>  struct pci_pme_device {
>  	struct list_head list;
> @@ -3888,8 +3892,18 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
>  	if (probe)
>  		return 0;
>  
> +	if (!probe) {
> +		pci_dev_unlock(dev);
> +		pci_bus_save_and_disable(dev->bus);
> +	}
> +
>  	pci_reset_bridge_secondary_bus(dev->bus->self);
>  
> +	if (!probe) {
> +		pci_bus_restore(dev->bus);
> +		pci_dev_lock(dev);
> +	}

This pattern of "unlock, do something, relock" needs some
justification.  In general it's unsafe because the lock is protecting
*something*, and you have to assume that something can change as soon
as you unlock.  Maybe you know it's safe in this situation, and if so,
the explanation of why it's safe is what I'm looking for.

Also, you're now calling pci_reset_bridge_secondary_bus() with the dev
unlocked, where we called it with the dev locked before.  Some (but
worryingly, not all) of the other pci_reset_bridge_secondary_bus()
callers also have the dev locked.  I didn't look long enough to figure
out if there is a strategy there or if these inconsistencies are
latent bugs.

> +
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
