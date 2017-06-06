Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbdFFFbo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jun 2017 01:31:44 -0400
Date: Tue, 6 Jun 2017 00:31:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: rakesh@tuxera.com, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] PCI: ensure the PCI device is locked over
 ->reset_notify calls
Message-ID: <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com>
References: <20170601111039.8913-1-hch@lst.de>
 <20170601111039.8913-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170601111039.8913-2-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 01, 2017 at 01:10:37PM +0200, Christoph Hellwig wrote:
> Without this ->notify_reset instance may race with ->remove calls,

s/notify_reset/reset_notify/

> which can be easily triggered in NVMe.

OK, sorry to be dense; it's taking me a long time to work out the
details here.  It feels like there should be a general principle to
help figure out where we need locking, and it would be really awesome
if we could include that in the changelog.  But it's not obvious to me
what that principle would be.

I think the two racing paths are these:

PATH 1 (write to sysfs "reset" file):

  sysfs_kf_write                      # <-- A (sysfs write)
    reset_store
      pci_reset_function
        pci_dev_lock                  # <-- patch moves lock here
          device_lock
        pci_dev_save_and_disable
          pci_reset_notify(dev, true)
            err_handler->reset_notify
              nvme_reset_notify       # nvme_err_handler.reset_notify
                nvme_dev_disable      # prepare == true
                  # shutdown == false
                  nvme_pci_disable
          pci_save_state
        pci_dev_reset
          pci_dev_lock                # <-- lock was originally here
          __pci_dev_reset
            pcie_flr                  # <-- B (issue reset)
          pci_dev_unlock              # <-- unlock was originally here
        pci_dev_restore
          pci_restore_state
          pci_reset_notify(dev, false)
            err_handler->reset_notify
              nvme_reset_notify       # nvme_err_handler.reset_notify
                dev = pci_get_drvdata(pdev)   # <-- F (dev == NULL)
                nvme_reset            # prepare == false
                  queue_work(..., &dev->reset_work)   # nvme_reset_work
        pci_dev_unlock                # <-- patch moves unlock here

  ...
  nvme_reset_work
    nvme_remove_dead_ctrl
      nvme_dev_disable
        if (!schedule_work(&dev->remove_work)) # nvme_remove_dead_ctrl_work
          nvme_put_ctrl

  ...
  nvme_remove_dead_ctrl_work
    if (pci_get_drvdata(pdev))
      device_release_driver(&pdev->dev)
        ...
          __device_release_driver
            drv->remove
              nvme_remove
                pci_set_drvdata(pdev, NULL)

PATH 2 (AER recovery):

  do_recovery                         # <-- C (AER interrupt)
    if (severity == AER_FATAL)
      state = pci_channel_io_frozen
    status = broadcast_error_message(..., report_error_detected)
      pci_walk_bus
        report_error_detected
          err_handler->error_detected
            nvme_error_detected
              return PCI_ERS_RESULT_NEED_RESET        # frozen case
    # status == PCI_ERS_RESULT_NEED_RESET
    if (severity == AER_FATAL)
      reset_link
    if (status == PCI_ERS_RESULT_NEED_RESET)
      broadcast_error_message(..., report_slot_reset)
        pci_walk_bus
          report_slot_reset
            device_lock               # <-- D (acquire device lock)
            err_handler->slot_reset
              nvme_slot_reset
                nvme_reset
                  queue_work(..., &dev->reset_work)   # nvme_reset_work
            device_lock               # <-- unlock

  ...
  nvme_reset_work
    ...
      schedule_work(&dev->remove_work)  # nvme_remove_dead_ctrl_work

  ...
  nvme_remove_dead_ctrl_work
    ...
      drv->remove
        nvme_remove                     # <-- E (driver remove() method)
          pci_set_drvdata(pdev, NULL)

So the critical point is that with the current code, we can have this
sequence:

  A sysfs write occurs
  B sysfs write thread issues FLR to device
  C AER thread takes an interrupt as a result of the FLR
  D AER thread acquires device lock
  E AER thread calls the driver remove() method and clears drvdata
  F sysfs write thread reads drvdata which is now NULL

The AER thread acquires the device lock before calling
err_handler->slot_reset, and this patch makes the sysfs thread hold
the lock until after it has read drvdata, so the patch avoids the NULL
pointer dereference at F by changing the sequence to this:

  A sysfs write occurs
  B sysfs write thread issues FLR to device
  C AER thread takes an interrupt as a result of the FLR
  F sysfs write thread reads drvdata
  D AER thread acquires device lock
  E AER thread calls the driver remove() method and clears drvdata

But I'm still nervous because I think both threads will queue
nvme_reset_work() work items for the same device, and I'm not sure
they're prepared to run concurrently.

I don't really think it should be the driver's responsibility to
understand issues like this and worry about things like
nvme_reset_work() running concurrently.  So I'm thinking maybe the PCI
core needs to be a little stricter here, but I don't know exactly
*how*.

What do you think?

Bjorn

> Reported-by: Rakesh Pandit <rakesh@tuxera.com>
> Tested-by: Rakesh Pandit <rakesh@tuxera.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/pci.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 563901cd9c06..92f7e5ae2e5e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4276,11 +4276,13 @@ int pci_reset_function(struct pci_dev *dev)
>  	if (rc)
>  		return rc;
>  
> +	pci_dev_lock(dev);
>  	pci_dev_save_and_disable(dev);
>  
> -	rc = pci_dev_reset(dev, 0);
> +	rc = __pci_dev_reset(dev, 0);
>  
>  	pci_dev_restore(dev);
> +	pci_dev_unlock(dev);
>  
>  	return rc;
>  }
> @@ -4300,16 +4302,14 @@ int pci_try_reset_function(struct pci_dev *dev)
>  	if (rc)
>  		return rc;
>  
> -	pci_dev_save_and_disable(dev);
> +	if (pci_dev_trylock(dev))
> +		return -EAGAIN;
>  
> -	if (pci_dev_trylock(dev)) {
> -		rc = __pci_dev_reset(dev, 0);
> -		pci_dev_unlock(dev);
> -	} else
> -		rc = -EAGAIN;
> +	pci_dev_save_and_disable(dev);
> +	rc = __pci_dev_reset(dev, 0);
> +	pci_dev_unlock(dev);
>  
>  	pci_dev_restore(dev);
> -
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(pci_try_reset_function);
> @@ -4459,7 +4459,9 @@ static void pci_bus_save_and_disable(struct pci_bus *bus)
>  	struct pci_dev *dev;
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		pci_dev_lock(dev);
>  		pci_dev_save_and_disable(dev);
> +		pci_dev_unlock(dev);
>  		if (dev->subordinate)
>  			pci_bus_save_and_disable(dev->subordinate);
>  	}
> @@ -4474,7 +4476,9 @@ static void pci_bus_restore(struct pci_bus *bus)
>  	struct pci_dev *dev;
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		pci_dev_lock(dev);
>  		pci_dev_restore(dev);
> +		pci_dev_unlock(dev);
>  		if (dev->subordinate)
>  			pci_bus_restore(dev->subordinate);
>  	}
> -- 
> 2.11.0
> 
