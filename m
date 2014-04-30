Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56506 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbaD3Wqn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Apr 2014 18:46:43 -0400
Received: by mail-ie0-f181.google.com with SMTP id y20so2701551ier.40
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2014 15:46:39 -0700 (PDT)
Date: Wed, 30 Apr 2014 16:46:37 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: Device driver function reset notification
Message-ID: <20140430224637.GA31315@google.com>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397000541-1085-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 08, 2014 at 05:42:20PM -0600, Keith Busch wrote:
> A user can issue a pci function level reset to a device using sysfs entry
> /sys/bus/pci/devices/.../reset. A kernel driver handling the pci device
> might like to know this reset is about to occur and when the reset attempt
> completes. This is so the driver has a chance to take appropriate device
> specific actions; for example, it may need to quiesce before the reset,
> and reinitialize the device after.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pci.c   |   13 +++++++++++++
>  include/linux/pci.h |    3 +++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fdbc294..cb24bbe 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3320,6 +3320,15 @@ static int pci_dev_reset(struct pci_dev *dev, int probe)
>  
>  	return rc;
>  }
> +
> +static void pci_reset_notify(struct pci_dev *dev, bool prepare)
> +{
> +	const struct pci_error_handlers *err_handler =
> +			dev->driver ? dev->driver->err_handler : NULL;
> +	if (err_handler && err_handler->reset_notify)
> +		err_handler->reset_notify(dev, prepare);
> +}
> +
>  /**
>   * __pci_reset_function - reset a PCI device function
>   * @dev: PCI device to reset
> @@ -3408,11 +3417,13 @@ int pci_reset_function(struct pci_dev *dev)
>  	if (rc)
>  		return rc;
>  
> +	pci_reset_notify(dev, true);
>  	pci_dev_save_and_disable(dev);
>  
>  	rc = pci_dev_reset(dev, 0);
>  
>  	pci_dev_restore(dev);
> +	pci_reset_notify(dev, false);
>  
>  	return rc;
>  }
> @@ -3432,6 +3443,7 @@ int pci_try_reset_function(struct pci_dev *dev)
>  	if (rc)
>  		return rc;
>  
> +	pci_reset_notify(dev, true);
>  	pci_dev_save_and_disable(dev);
>  
>  	if (pci_dev_trylock(dev)) {
> @@ -3441,6 +3453,7 @@ int pci_try_reset_function(struct pci_dev *dev)
>  		rc = -EAGAIN;
>  
>  	pci_dev_restore(dev);
> +	pci_reset_notify(dev, false);

You put the notify in these functions:

  pci_reset_function()
  pci_try_reset_function()

but what about these:

  pci_reset_slot()
  pci_try_reset_slot()
  pci_reset_bus()
  pci_try_reset_bus()

It seems like this ought to work the same way over all kinds of reset.

>  	return rc;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 33aa2ca..d82dd3f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -603,6 +603,9 @@ struct pci_error_handlers {
>  	/* PCI slot has been reset */
>  	pci_ers_result_t (*slot_reset)(struct pci_dev *dev);
>  
> +	/* PCI function reset prepare or completed */
> +	void (*reset_notify)(struct pci_dev *dev, bool prepare);
> +
>  	/* Device driver may resume normal operations */
>  	void (*resume)(struct pci_dev *dev);
>  };
> -- 
> 1.7.10.4
> 
