Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE2350A36
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769718472; cv=none; b=hPa/8gAME+H4NrxPr0dWWluUOI5v/J9g/RhpfDxft1TSk0mDm/WpU+E/zZ2J6pJnVw4a74M5lSZb3f0BB1uaxcCFxn9B8VqoNmymwFBeJLMdrsmU6NbmaxrGsF+6XBTd3fduiMxNOLl898PJtwNm65sXHIRT1YJID0Z8wy35Pj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769718472; c=relaxed/simple;
	bh=cz3lFyl/BD6cnXb/+f7G+94V83386fYF2sRNDtvGm6E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mHBCOGhOBDT6pDk9Pe3iBsxb85VVNXl8PSyAfTzdWSCGiiYlLFhAsSSoKPyDQOP5iBZeLfQ+QGTXhdL9UQD3KGg1PnTh10CNJyY03ilxZ6qLrzvZd/2XLFu8w/g+YYHgRGVP18ooEtb5hZ2jk/WyIVH7qmaUUV3hGzRapgxSJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH6RZLHV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH6RZLHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36D5C4CEF7;
	Thu, 29 Jan 2026 20:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769718471;
	bh=cz3lFyl/BD6cnXb/+f7G+94V83386fYF2sRNDtvGm6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pH6RZLHVvsdkDICe8Gax+Z6OAUORzdZ0ftC+BmuTC1IhGfxLLnWLp0gyRtRDDQaxb
	 e1KLGnQ5SyYyILwtPwSaKf+Jdiu0JKH7+IW/Qu6SFKQxbrBeO+pKadvJqT7sXBmZr1
	 xxL8p3c0lIE8Ue+yR0+xGD1hXtc9Yn//zMxI8x9JIzd4rnnAeIcn4Q3jd7VXC74myG
	 gtWr15zLx6CW0Yy7JSILFMxHWE4SXOIoyCOK3fH0EeEZwFrgj6ee7R+ktW4OuxZsp1
	 NYBocV/yELkzelUOZ1E6nWFS1DV2myG0Mk+3MjqFyxEezSU72f2+1DhaGyiwPGyzXT
	 BPi/S/5UV9EXQ==
Date: Thu, 29 Jan 2026 14:27:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, alex@shazbot.org, lukas@wunner.de,
	dan.j.williams@intel.com, guojinhui.liam@bytedance.com,
	ilpo.jarvinen@linux.intel.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] pci: remove slot specific lock/unlock and save/restore
Message-ID: <20260129202750.GA476192@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129160955.2637158-1-kbusch@meta.com>

On Thu, Jan 29, 2026 at 08:09:55AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The Linux pci driver resolves a "slot" to the "D" in the B:D.f (see
> PCI_SLOT()). A pcie "slot reset" is a secondary bus reset, which affects
> every function on every "D", not just the ones with a matching "slot".
> The slot lock/unlock and save/restore functions, however, are only
> handling a subset of the functions, breaking the rest.
> 
> ARI devices with more than 8 functions fail because their state is not
> properly handled, nor is the attached driver notified of the reset. In
> the best case, the device will appear unresponsive to the driver,
> resulting in unexpected errors. A worse possiblility may panic the
> kernel if in flight transactions trigger hardware reported errors like
> this real observation:
> 
>   vfio-pci 0000:01:00.0: resetting
>   vfio-pci 0000:01:00.0: reset done
>   {1}[Hardware Error]:  Error 1, type: fatal
>   {1}[Hardware Error]:   section_type: PCIe error
>   {1}[Hardware Error]:   port_type: 0, PCIe end point
>   {1}[Hardware Error]:   version: 0.2
>   {1}[Hardware Error]:   command: 0x0140, status: 0x0010
>   {1}[Hardware Error]:   device_id: 0000:01:01.0
>   {1}[Hardware Error]:   slot: 0
>   {1}[Hardware Error]:   secondary_bus: 0x00
>   {1}[Hardware Error]:   vendor_id: 0x1d9b, device_id: 0x0207
>   {1}[Hardware Error]:   class_code: 020000
>   {1}[Hardware Error]:   bridge: secondary_status: 0x0000, control: 0x0000
>   {1}[Hardware Error]:   aer_cor_status: 0x00008000, aer_cor_mask: 0x00002000
>   {1}[Hardware Error]:   aer_uncor_status: 0x00010000, aer_uncor_mask: 0x00100000
>   {1}[Hardware Error]:   aer_uncor_severity: 0x006f6030
>   {1}[Hardware Error]:   TLP Header: 0a412800 00192080 60000004 00000004
>   GHES: Fatal hardware error but panic disabled
>   Kernel panic - not syncing: GHES: Fatal hardware error
> 
> Fix this by properly locking and notifying the entire affected bus
> topology, not just specific matching slots. For architectures that
> support "slot" specific resets, this patch potentially introduces an
> insignificant amount of overhead, but is otherwise harmless.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---

This seems reasonable, but is a much larger change than just fixing
the slot locking, so it would really be nice to get some review
besides just me.

> This patch is based on v6.19-rc1 as requested. Note, there will be a
> minor merge conflict if this other patch fixing the "trylock" handling
> is already included:
> 
>   https://lore.kernel.org/linux-pci/20260128225344.GA422463@bhelgaas/

The patch below removes pci_slot_trylock() completely, which renders
Jinhui's fix to that function moot, so if we apply this one, there
would be no reason to keep Jinhui's patch.

An alternate path would be to:

  - keep Jinhui's patch that fixes the pci_slot_trylock() error path
    (same as your 1/1 patch)

  - apply your 2/2 patch [1] to fix pci_slot_lock(),
    pci_slot_unlock(), and pci_slot_trylock() to lock the bridge
    (after accounting for the mistaken merge)

  - finally, rebase *this* patch on top to remove the pci_slot_lock(),
    pci_slot_unlock(), and pci_slot_trylock() that have just been
    fixed

The advantage would be that if there's any issue or objection to
completely removing pci_slot_lock() et al, we could drop or defer that
while still fixing the locking issues.

[1] https://lore.kernel.org/r/20260116184150.3013258-2-kbusch@meta.com

> But I don't see it applied in any the pci git tree.
> 
>  drivers/pci/pci.c | 113 ++++------------------------------------------
>  1 file changed, 9 insertions(+), 104 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31f..8c19939d633a0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5307,67 +5307,6 @@ static bool pci_slot_resettable(struct pci_slot *slot)
>  	return true;
>  }
>  
> -/* Lock devices from the top of the tree down */
> -static void pci_slot_lock(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate)
> -			pci_bus_lock(dev->subordinate);
> -		else
> -			pci_dev_lock(dev);
> -	}
> -}
> -
> -/* Unlock devices from the bottom of the tree up */
> -static void pci_slot_unlock(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate)
> -			pci_bus_unlock(dev->subordinate);
> -		else
> -			pci_dev_unlock(dev);
> -	}
> -}
> -
> -/* Return 1 on successful lock, 0 on contention */
> -static int pci_slot_trylock(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate) {
> -			if (!pci_bus_trylock(dev->subordinate)) {
> -				pci_dev_unlock(dev);
> -				goto unlock;
> -			}
> -		} else if (!pci_dev_trylock(dev))
> -			goto unlock;
> -	}
> -	return 1;
> -
> -unlock:
> -	list_for_each_entry_continue_reverse(dev,
> -					     &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate)
> -			pci_bus_unlock(dev->subordinate);
> -		else
> -			pci_dev_unlock(dev);
> -	}
> -	return 0;
> -}
> -
>  /*
>   * Save and disable devices from the top of the tree down while holding
>   * the @dev mutex lock for the entire tree.
> @@ -5401,59 +5340,24 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
>  	}
>  }
>  
> -/*
> - * Save and disable devices from the top of the tree down while holding
> - * the @dev mutex lock for the entire tree.
> - */
> -static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		pci_dev_save_and_disable(dev);
> -		if (dev->subordinate)
> -			pci_bus_save_and_disable_locked(dev->subordinate);
> -	}
> -}
> -
> -/*
> - * Restore devices from top of the tree down while holding @dev mutex lock
> - * for the entire tree.  Parent bridges need to be restored before we can
> - * get to subordinate devices.
> - */
> -static void pci_slot_restore_locked(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		pci_dev_restore(dev);
> -		if (dev->subordinate) {
> -			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
> -			pci_bus_restore_locked(dev->subordinate);
> -		}
> -	}
> -}
> -
>  static int pci_slot_reset(struct pci_slot *slot, bool probe)
>  {
> +	struct pci_bus *bus;
>  	int rc;
>  
>  	if (!slot || !pci_slot_resettable(slot))
>  		return -ENOTTY;
>  
> +	bus = slot->bus;
>  	if (!probe)
> -		pci_slot_lock(slot);
> +		pci_bus_lock(bus);
>  
>  	might_sleep();
>  
>  	rc = pci_reset_hotplug_slot(slot->hotplug, probe);
>  
>  	if (!probe)
> -		pci_slot_unlock(slot);
> +		pci_bus_unlock(bus);
>  
>  	return rc;
>  }
> @@ -5487,18 +5391,19 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
>   */
>  static int __pci_reset_slot(struct pci_slot *slot)
>  {
> +	struct pci_bus *bus = slot->bus;
>  	int rc;
>  
>  	rc = pci_slot_reset(slot, PCI_RESET_PROBE);
>  	if (rc)
>  		return rc;
>  
> -	if (pci_slot_trylock(slot)) {
> -		pci_slot_save_and_disable_locked(slot);
> +	if (pci_bus_trylock(bus)) {
> +		pci_bus_save_and_disable_locked(bus);
>  		might_sleep();
>  		rc = pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
> -		pci_slot_restore_locked(slot);
> -		pci_slot_unlock(slot);
> +		pci_bus_restore_locked(bus);
> +		pci_bus_unlock(bus);
>  	} else
>  		rc = -EAGAIN;
>  
> -- 
> 2.47.3
> 
