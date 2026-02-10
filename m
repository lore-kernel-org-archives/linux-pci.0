Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1399311979
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770767190; cv=none; b=QBfvZ/PKwQQRu0xXZ75zhStLe1INxm5wEQqvBk0/R5bTfPbrtnAF4wO3r5SJ6Cyxquk8Iitnikrn5MMADDIWcrwQfEcnkLYbEjv6sLJR5CWChvGfNs7hy5BTAXF2TTS5AZb0fEdRm/cO5MmxDLy2JVDGCbGxe56zQTZdObUKR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770767190; c=relaxed/simple;
	bh=46bIQ6MbazcTEK0MAkNqJUYRYK2tCdki+hk15BvBdEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9wYCAl1CLRRkAwe5gMcmzZQ7KgQPGk5ecb7M9kZ8sot5sGLk/5DN40pxQOnmJ5vwT9zB8k+6Si92ekjfS2JWqLrlsG59prQOnLN5FNwlMNHHg4sgX2jppiBzatCqoy4WqYGsP9/Eicj2uZytC308ivNJDS25j24xUcJ/OW1NaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=nTQH3v6g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZLqgJlym; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="nTQH3v6g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZLqgJlym"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B361F14000FF;
	Tue, 10 Feb 2026 18:46:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 10 Feb 2026 18:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770767186;
	 x=1770853586; bh=XF2d7y5x3j6eZ3osPgzXA6lROxI5/v5TepW8rlaR/Xo=; b=
	nTQH3v6g+9Z7MTDXoKZV5cki9y2hbyr01SFVmarGoHo8itEZByYRvJs3eOWarRMU
	g2mKG8Er0ci3AqWbTLLheq2Lr3HWI36frBHiN5TMu4W3a+FyNCivFBYwsRwh2g7d
	+EGlvDZtSKi172Qoq+w6VSe581Ka7UanGyePRcIBw3y1/Jq91XLk//IhTaQ3cwDb
	AGZMB6eVDyGNhgMW2zJ9+er/mZw5bPDa4pzAE+mt+JQulpuXozWyJCYz5BUbjuBq
	mxu0DBGCEoLcOhfEZEh0zxSjP5HlqWE+gBjAFrUo/Eal5MKT3zVRSfledyFdyXWy
	fj6qdR9XzJrgxSVQ3cUj3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770767186; x=
	1770853586; bh=XF2d7y5x3j6eZ3osPgzXA6lROxI5/v5TepW8rlaR/Xo=; b=Z
	LqgJlym0TW80Rdk7kQMVB2ue/JNBNDnyvDBGEY0r+xzxJWO5VlosxR0Iltc5pBlr
	RzYJ747GXMldpBLCa9/cVB3junQoA+JOuO3zNeQpRzJIkEWKBwWSiHyN9NMbWsCq
	ydUNtE6FDLkPa/2roraHFM/48kzqAUxhflLvOZ5u8kttfyZoLlHL9LMtd6a2UvnS
	SEMatDPoPIsq6KSYpZMjM44PPxFkl2VYSkYXRIrkZPP5xlbn/FAqLyqdwbNOPTJ9
	QEGd2qBCbSAYB+TyuDVx8HYVf+jo05RWk/ssfNd9AsBm94Ilz1sM0RW7TtJmG1oP
	d73ZorWDHkC6ABa+B0Lqw==
X-ME-Sender: <xms:UcOLaWFZ60huilQbxQwC2hYObIxxka4o0SrFFbCefURiHIy-Mi7FeA>
    <xme:UcOLaRVS13bLUYmTEzlBtn2NFIdd1QStIalGQliM0I9vrGEycSOUwyX6Q_BKlZ_kP
    KC7mvISxLcEOCahEJ6VBNPVdbi6mlzqMmw4Zmj57Srs_TbH6vOq>
X-ME-Received: <xmr:UcOLaWxfBxeCFM03Hj2V3iAbPYhCTPMXsbDcED7ZD_fL9m8mv4oefX9tZqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgsuhhstghhsehmvghtrgdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshesfihunh
    hnvghrrdguvgdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdr
    tghomhdprhgtphhtthhopehguhhojhhinhhhuhhirdhlihgrmhessgihthgvuggrnhgtvg
    drtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhht
    vghlrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UcOLaeSmJu6e6-G4RO5tDvKcbKWqgUJ9pDfFl56huAu6VyF67oHloA>
    <xmx:UcOLaag3WTXnyiUoyIqw9tGwCdVEcd_MZWm5VfkKbIQNIzjVjVj9-Q>
    <xmx:UcOLadmCkRD5dwV_5a3E4fUEAvNpQOkpHhv9lfjdZMp4mdFR-7MimA>
    <xmx:UcOLaVuBrR4RacHARae3f-ycyE7cwzWAYc2a9GmUql3qcpTLbrNNtw>
    <xmx:UsOLaTFCkfL57YugJBY-WSdWbmPl6suOqOKrRWoSYJN_Vfw_hu5l-fl8>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 18:46:24 -0500 (EST)
Date: Tue, 10 Feb 2026 16:46:23 -0700
From: Alex Williamson <alex@shazbot.org>
To: Keith Busch <kbusch@meta.com>
Cc: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>, <lukas@wunner.de>,
 <dan.j.williams@intel.com>, <guojinhui.liam@bytedance.com>,
 <ilpo.jarvinen@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 3/4] pci: remove slot specific lock/unlock and
 save/restore
Message-ID: <20260210164623.74d38699@shazbot.org>
In-Reply-To: <20260205212533.1512153-4-kbusch@meta.com>
References: <20260205212533.1512153-1-kbusch@meta.com>
	<20260205212533.1512153-4-kbusch@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Feb 2026 13:25:32 -0800
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> The Linux pci driver resolves a "slot" to the "D" in the B:D.f (see
> PCI_SLOT()). A pcie "slot reset" is a secondary bus reset, which affects
> every function on every "D", not just the ones with a matching "slot".
> The slot lock/unlock and save/restore functions, however, are only
> handling a subset of the functions, breaking the rest.

So are we deprecating conventional PCI hotplug slots?  I've always
understood these to be a subset of the bus, where we find the devices
sharing the same physical PCI slot by comparing the pci_dev.slot across
the bus, as done in all the code removed here.  pci_create_slot()
certainly is not simply a reflection of PCI_SLOT().  Is the error below
really a reflection that pci_dev.slot isn't carried over to the full
set of functions?  Thanks,

Alex

 
> ARI devices with more than 8 functions fail because their state is not
> properly handled, nor is the attached driver notified of the reset. In
> the best case, the device will appear unresponsive to the driver,
> resulting in unexpected errors. A worse possibility may panic the kernel
> if in flight transactions trigger hardware reported errors like this
> real observation:
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
>  drivers/pci/pci.c | 147 ++++------------------------------------------
>  1 file changed, 11 insertions(+), 136 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e00af20ea7376..df9ed73dad416 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5287,96 +5287,6 @@ static int pci_bus_trylock(struct pci_bus *bus)
>  	return 0;
>  }
>  
> -/* Do any devices on or below this slot prevent a bus reset? */
> -static bool pci_slot_resettable(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	if (bridge && (bridge->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
> -		return false;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
> -		    (dev->subordinate && !pci_bus_resettable(dev->subordinate)))
> -			return false;
> -	}
> -
> -	return true;
> -}
> -
> -/* Lock devices from the top of the tree down */
> -static void pci_slot_lock(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	if (bridge)
> -		pci_dev_lock(bridge);
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
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate)
> -			pci_bus_unlock(dev->subordinate);
> -		else
> -			pci_dev_unlock(dev);
> -	}
> -
> -	if (bridge)
> -		pci_dev_unlock(bridge);
> -}
> -
> -/* Return 1 on successful lock, 0 on contention */
> -static int pci_slot_trylock(struct pci_slot *slot)
> -{
> -	struct pci_dev *dev, *bridge = slot->bus->self;
> -
> -	if (bridge && !pci_dev_trylock(bridge))
> -		return 0;
> -
> -	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> -		if (!dev->slot || dev->slot != slot)
> -			continue;
> -		if (dev->subordinate) {
> -			if (!pci_bus_trylock(dev->subordinate))
> -				goto unlock;
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
> -
> -	if (bridge)
> -		pci_dev_unlock(bridge);
> -	return 0;
> -}
> -
>  /*
>   * Save and disable devices from the top of the tree down while holding
>   * the @dev mutex lock for the entire tree.
> @@ -5410,59 +5320,23 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
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
> +	struct pci_bus *bus = slot ? slot->bus : NULL;
>  	int rc;
>  
> -	if (!slot || !pci_slot_resettable(slot))
> +	if (!slot || !bus || !pci_bus_resettable(bus))
>  		return -ENOTTY;
>  
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
> @@ -5489,25 +5363,26 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
>   * wrap the bus reset to avoid spurious slot related events such as hotplug.
>   * Generally a slot reset should be attempted before a bus reset.  All of the
>   * function of the slot and any subordinate buses behind the slot are reset
> - * through this function.  PCI config space of all devices in the slot and
> - * behind the slot is saved before and restored after reset.
> + * through this function.  PCI config space of all devices below the slot bus
> + * are saved before and restored after reset.
>   *
>   * Same as above except return -EAGAIN if the slot cannot be locked
>   */
>  static int pci_try_reset_slot(struct pci_slot *slot)
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

