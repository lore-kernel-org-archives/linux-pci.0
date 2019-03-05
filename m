Return-Path: <SRS0=Jbu+=RI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77AFC43381
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 21:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4570820652
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 21:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551822286;
	bh=k/UxhkjfL8M4bhECI5GbVAFTerk1jG9pwIxCOMlGNkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ne64eMLZROSVg8bB7NPrG95DTgrCFmuaUaS/F2PIy1o5sH2yl/PTU6QtywmhQL7id
	 NUpS/IIiVP3yt9bPvH2CIMRmYkBSWYLGbyVYIwlkCMn3oElai7rPmrdI0bBDwvdmkQ
	 rPLhW/JQUSyIENA6s7ToQc5SdLM8qN0TujgGV/JE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfCEVop (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfCEVop (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Mar 2019 16:44:45 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8756A20652;
        Tue,  5 Mar 2019 21:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551822283;
        bh=k/UxhkjfL8M4bhECI5GbVAFTerk1jG9pwIxCOMlGNkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpwAYZJBbM7vymnVQ0+20hrruM9l1QlZbDy7w+H/lxEGE/dpGN9x9zVdyX7BRPNcw
         54xiyKxoChTldMfayHgF47yVVQwqoO/VAeXBa+R/dfm5LZ5bGi+HLfXy8H8po9n/eH
         TGsHhzkKb4ObHi0dE4aOzrYT99KsgGyZ8td3xKXU=
Date:   Tue, 5 Mar 2019 15:44:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, okaya@kernel.org, myron.stowe@redhat.com
Subject: Re: [PATCH v2] PCI: Fix "try" semantics of bus and slot reset
Message-ID: <20190305214442.GA215617@google.com>
References: <155051908423.10656.10601490787034368635.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155051908423.10656.10601490787034368635.stgit@gimli.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 18, 2019 at 12:46:46PM -0700, Alex Williamson wrote:
> The commit referenced below introduced device locking around save and
> restore of state for each device during a PCI bus "try" reset, making
> it decidely non-"try" and prone to deadlock in the event that a device
> is already locked.  Restore __pci_reset_bus() and __pci_reset_slot()
> to their advertised locking semantics by pushing the save and restore
> functions into the branch where the entire tree is already locked.
> Extend the helper function names with "_locked" and update the comment
> to reflect this calling requirement.
> 
> Fixes: b014e96d1abb ("PCI: Protect pci_error_handlers->reset_notify() usage with device_lock()")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied with Sinan's reviewed-by to pci/misc for v5.1, thanks, Alex!

> ---
>  drivers/pci/pci.c |   54 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> v2: White space only fix suggested by Myron Stowe, removing an additional
>     empty line from __pci_reset_slot() after the restore call is moved.
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c25acace7d91..2fb149216cde 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5058,39 +5058,42 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  	return 0;
>  }
>  
> -/* Save and disable devices from the top of the tree down */
> -static void pci_bus_save_and_disable(struct pci_bus *bus)
> +/*
> + * Save and disable devices from the top of the tree down while holding
> + * the @dev mutex lock for the entire tree.
> + */
> +static void pci_bus_save_and_disable_locked(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		pci_dev_lock(dev);
>  		pci_dev_save_and_disable(dev);
> -		pci_dev_unlock(dev);
>  		if (dev->subordinate)
> -			pci_bus_save_and_disable(dev->subordinate);
> +			pci_bus_save_and_disable_locked(dev->subordinate);
>  	}
>  }
>  
>  /*
> - * Restore devices from top of the tree down - parent bridges need to be
> - * restored before we can get to subordinate devices.
> + * Restore devices from top of the tree down while holding @dev mutex lock
> + * for the entire tree.  Parent bridges need to be restored before we can
> + * get to subordinate devices.
>   */
> -static void pci_bus_restore(struct pci_bus *bus)
> +static void pci_bus_restore_locked(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		pci_dev_lock(dev);
>  		pci_dev_restore(dev);
> -		pci_dev_unlock(dev);
>  		if (dev->subordinate)
> -			pci_bus_restore(dev->subordinate);
> +			pci_bus_restore_locked(dev->subordinate);
>  	}
>  }
>  
> -/* Save and disable devices from the top of the tree down */
> -static void pci_slot_save_and_disable(struct pci_slot *slot)
> +/*
> + * Save and disable devices from the top of the tree down while holding
> + * the @dev mutex lock for the entire tree.
> + */
> +static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
>  {
>  	struct pci_dev *dev;
>  
> @@ -5099,26 +5102,25 @@ static void pci_slot_save_and_disable(struct pci_slot *slot)
>  			continue;
>  		pci_dev_save_and_disable(dev);
>  		if (dev->subordinate)
> -			pci_bus_save_and_disable(dev->subordinate);
> +			pci_bus_save_and_disable_locked(dev->subordinate);
>  	}
>  }
>  
>  /*
> - * Restore devices from top of the tree down - parent bridges need to be
> - * restored before we can get to subordinate devices.
> + * Restore devices from top of the tree down while holding @dev mutex lock
> + * for the entire tree.  Parent bridges need to be restored before we can
> + * get to subordinate devices.
>   */
> -static void pci_slot_restore(struct pci_slot *slot)
> +static void pci_slot_restore_locked(struct pci_slot *slot)
>  {
>  	struct pci_dev *dev;
>  
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
> -		pci_dev_lock(dev);
>  		pci_dev_restore(dev);
> -		pci_dev_unlock(dev);
>  		if (dev->subordinate)
> -			pci_bus_restore(dev->subordinate);
> +			pci_bus_restore_locked(dev->subordinate);
>  	}
>  }
>  
> @@ -5177,17 +5179,15 @@ static int __pci_reset_slot(struct pci_slot *slot)
>  	if (rc)
>  		return rc;
>  
> -	pci_slot_save_and_disable(slot);
> -
>  	if (pci_slot_trylock(slot)) {
> +		pci_slot_save_and_disable_locked(slot);
>  		might_sleep();
>  		rc = pci_reset_hotplug_slot(slot->hotplug, 0);
> +		pci_slot_restore_locked(slot);
>  		pci_slot_unlock(slot);
>  	} else
>  		rc = -EAGAIN;
>  
> -	pci_slot_restore(slot);
> -
>  	return rc;
>  }
>  
> @@ -5273,17 +5273,15 @@ static int __pci_reset_bus(struct pci_bus *bus)
>  	if (rc)
>  		return rc;
>  
> -	pci_bus_save_and_disable(bus);
> -
>  	if (pci_bus_trylock(bus)) {
> +		pci_bus_save_and_disable_locked(bus);
>  		might_sleep();
>  		rc = pci_bridge_secondary_bus_reset(bus->self);
> +		pci_bus_restore_locked(bus);
>  		pci_bus_unlock(bus);
>  	} else
>  		rc = -EAGAIN;
>  
> -	pci_bus_restore(bus);
> -
>  	return rc;
>  }
>  
> 
