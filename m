Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC432773FF
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967609; cv=none; b=q8mqo5TH/zkxkph7txBvYCMDkdF7d67yOFxL6KI65OIE1y6TWx8ad7kfHZVSbUTE4+Lh3aLxbbv28z0+xYymuLEsrS3uxVZ/24ZKDpBuyW7wcF54omiCDqmrydf3t5cdLrOj5RVGoMZsL+ZmpP8OBoyEtMbEX/2XncTsDGrO5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967609; c=relaxed/simple;
	bh=sHz5TBdJhDYsAqcjkvtRxqCFsxaJH45rBNaL6k6+mxo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aX4BwwXPGCZLPTUFwOqr+cYXAChin/zTb6tnZbvW43PQd9Kp7hETCCgSNlXf3EgrYTQ7cQ8lL32dRZbG95GJbhE75U+NPrAm6mj/BlFpenSXxfauK3Y3Sk1cCTMjD3ucg1l1hQh/0c69pHaYG4gtBnUKNxmiQcgE4omOjxE54mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8Uc88IK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8Uc88IK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770967608; x=1802503608;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sHz5TBdJhDYsAqcjkvtRxqCFsxaJH45rBNaL6k6+mxo=;
  b=e8Uc88IKk6pbTQ9gLYxdHM6sk1K/imHIGCdIvrO/fUu3r0VuLAvrCCkA
   GkLytUhtsem6jTUpwqP4+2nBrz16aUPW6EGDAyrh87o3J0PDjcoap4Jba
   P/8jNToI83A7HENYEsgjb6gsV5pXf2Z4RBnW6uNjloTH0IKovIQT0IvkH
   O3XCkPgwu5iJyjtiKNLkRoyfy5zOh9WjNR/dZUe/aGmtQUQYSyU5pk4hB
   gvL8vwABYQ5rg6sz8JpY6uR5ARqb7xwstuanGkcz3QS7a+cG0pbxsUy5o
   78Pz3iZrCHWWNdjwu+whszLRTM+9lqLtE4QHlSlgpOQKD8isN8lzG1OmX
   A==;
X-CSE-ConnectionGUID: WYK9lCHhQ3yGINfXW/M4CA==
X-CSE-MsgGUID: Lwr6ItZhR1ag3X7FYpxxcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83249508"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="83249508"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 23:26:46 -0800
X-CSE-ConnectionGUID: s1Rtr137TlmZUeMGzU4q5g==
X-CSE-MsgGUID: lE0u2vtrSEyH89GzqlkpLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="217393295"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.12])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 23:26:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 13 Feb 2026 09:26:35 +0200 (EET)
To: Keith Busch <kbusch@meta.com>
cc: linux-pci@vger.kernel.org, helgaas@kernel.org, alex@shazbot.org, 
    dan.j.williams@intel.com, Lukas Wunner <lukas@wunner.de>, 
    Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 2/3] pci: allow all bus devices to use the same slot
In-Reply-To: <20260212224112.1913980-3-kbusch@meta.com>
Message-ID: <da0a460b-2098-c9ce-a884-d4a8118638f9@linux.intel.com>
References: <20260212224112.1913980-1-kbusch@meta.com> <20260212224112.1913980-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Feb 2026, Keith Busch wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> A pcie hotplug slot applies to the entire subordinate bus. Thus, pciehp
> only allocates a single hotplug_slot for the bridge to that bus. The pci
> slot, though, would only match to functions on device 0, meaning all
> device beyond that are not matched to any slot even though they share
> it. A slot reset will break all the missing devices because the handling
> skips them.
> 
> Allow a slot to be created to claim all devices on a bus, not just a
> matching device. This is done by introducing a sentinel value, named
> PCI_SLOT_ALL_DEVICES, which then has the pci slot match to any device on
> the bus. This fixes slot resets for pciehp.
> 
> Since 0xff already has special meaning, the chosen value for this new
> feature is 0xfe. This will not clash with any actual slot number since
> they are limited to 5 bits.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/hotplug/pciehp_core.c |  3 ++-
>  drivers/pci/slot.c                | 27 +++++++++++++++++++++++----
>  include/linux/pci.h               |  8 +++++++-
>  3 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index f59baa9129709..d80346d567049 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -79,7 +79,8 @@ static int init_slot(struct controller *ctrl)
>  	snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
>  
>  	retval = pci_hp_initialize(&ctrl->hotplug_slot,
> -				   ctrl->pcie->port->subordinate, 0, name);
> +				   ctrl->pcie->port->subordinate,
> +				   PCI_SLOT_ALL_DEVICES, name);
>  	if (retval) {
>  		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
>  		kfree(ops);
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 50fb3eb595fe6..bf6f265454a84 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -42,6 +42,15 @@ static ssize_t address_read_file(struct pci_slot *slot, char *buf)
>  				  pci_domain_nr(slot->bus),
>  				  slot->bus->number);
>  
> +	/*
> +	 * Preserve legacy ABI expectations that hotplug drivers that manage
> +	 * multiple devices per slot emit 0 for the device number.
> +	 */
> +	if (slot->number == PCI_SLOT_ALL_DEVICES)
> +		return sysfs_emit(buf, "%04x:%02x:00\n",
> +				  pci_domain_nr(slot->bus),
> +				  slot->bus->number);

This fits to two lines.

Add braces as it's a multi-line block.

-- 
 i.

> +
>  	return sysfs_emit(buf, "%04x:%02x:%02x\n",
>  			  pci_domain_nr(slot->bus),
>  			  slot->bus->number,
> @@ -73,7 +82,8 @@ static void pci_slot_release(struct kobject *kobj)
>  
>  	down_read(&pci_bus_sem);
>  	list_for_each_entry(dev, &slot->bus->devices, bus_list)
> -		if (PCI_SLOT(dev->devfn) == slot->number)
> +		if (slot->number == PCI_SLOT_ALL_DEVICES ||
> +		    PCI_SLOT(dev->devfn) == slot->number)
>  			dev->slot = NULL;
>  	up_read(&pci_bus_sem);
>  
> @@ -166,7 +176,8 @@ void pci_dev_assign_slot(struct pci_dev *dev)
>  
>  	mutex_lock(&pci_slot_mutex);
>  	list_for_each_entry(slot, &dev->bus->slots, list)
> -		if (PCI_SLOT(dev->devfn) == slot->number)
> +		if (slot->number == PCI_SLOT_ALL_DEVICES ||
> +		    PCI_SLOT(dev->devfn) == slot->number)
>  			dev->slot = slot;
>  	mutex_unlock(&pci_slot_mutex);
>  }
> @@ -188,7 +199,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
>  /**
>   * pci_create_slot - create or increment refcount for physical PCI slot
>   * @parent: struct pci_bus of parent bridge
> - * @slot_nr: PCI_SLOT(pci_dev->devfn) or -1 for placeholder
> + * @slot_nr: PCI_SLOT(pci_dev->devfn), -1 for placeholder, or PCI_SLOT_ALL_DEVICES
>   * @name: user visible string presented in /sys/bus/pci/slots/<name>
>   * @hotplug: set if caller is hotplug driver, NULL otherwise
>   *
> @@ -222,6 +233,13 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
>   * consist solely of a dddd:bb tuple, where dddd is the PCI domain of the
>   * %struct pci_bus and bb is the bus number. In other words, the devfn of
>   * the 'placeholder' slot will not be displayed.
> + *
> + * Bus-wide slots:
> + * For PCIe hotplug, the physical slot encompasses the entire subordinate
> + * bus, not just a single device number. Pass @slot_nr == PCI_SLOT_ALL_DEVICES
> + * to create a slot that matches all devices on the bus. Unlike placeholder
> + * slots, bus-wide slots go through normal slot lookup and reuse existing
> + * slots if present.
>   */
>  struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  				 const char *name,
> @@ -285,7 +303,8 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  
>  	down_read(&pci_bus_sem);
>  	list_for_each_entry(dev, &parent->devices, bus_list)
> -		if (PCI_SLOT(dev->devfn) == slot_nr)
> +		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
> +		    PCI_SLOT(dev->devfn) == slot_nr)
>  			dev->slot = slot;
>  	up_read(&pci_bus_sem);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index edf792a79193f..7073519bcc1ad 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -72,12 +72,18 @@
>  /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
>  #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
>  
> +/*
> + * PCI_SLOT_ALL_DEVICES indicates a slot that covers all devices on the bus.
> + * Used for PCIe hotplug where the physical slot is the entire subordinate bus.
> + */
> +#define PCI_SLOT_ALL_DEVICES	0xfe
> +
>  /* pci_slot represents a physical slot */
>  struct pci_slot {
>  	struct pci_bus		*bus;		/* Bus this slot is on */
>  	struct list_head	list;		/* Node in list of slots */
>  	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
> -	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
> +	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
>  	struct kobject		kobj;
>  };
>  
> 

