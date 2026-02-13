Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC42D7DD3
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967674; cv=none; b=Oxv9m/Atky5GR061LBcByc78huZmz9lDzTaPILOXswOuXyp8qArIQETvFRCAOrDo8nkLNu7ZR076RaffB6a/aOWHD+hZOZDiIUl2m5ZZz+77AsHoB+prwXFJPf1gCbNayZQkVmImKZ24T2jBVpf39zEhMfonoeONZ3IpHu5Q65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967674; c=relaxed/simple;
	bh=QJ8TOiAEjN256w2RBaruk3g4ykUw8kK3diSVxqQMGXM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kwSG3zzu/BVfuB072B+0IB0J43Rl+w6yeYK8K/wkqy9LX5Oh/x5HZ0YRnZoN2tEMJNENIcTmcAS/NqrDFTifc/2RLtICxf0jzS/rqyXcTFpppVZY2UDYvf7trkol+FlSZggjMQVKi7mm18jnC8mGMSVGsIaLGojR4Dk+j+oLpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLcNtBN5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLcNtBN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770967673; x=1802503673;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QJ8TOiAEjN256w2RBaruk3g4ykUw8kK3diSVxqQMGXM=;
  b=XLcNtBN5x6hsqcmoWkxcyrn9e0PW+58jeS/gTfgUNm1uFtUPwCizrnEO
   LD7NIQyhhu/uYc2dXS1CK1dEzpaXT31CLupc+yiUUquNQcIKcZ1DgRMJn
   i6zbTtm0EWnvR4+2Rgbfb0HyOFkVbt32fvcUg+c2tysEelS/KbK01/XSs
   lfGXljgkIjKP48gl3qOf3D6UVQljDwKuIih/XD/Vo6YRBseCiFq3P7m1F
   kExu9gU2rfSosnoHNE2zZbn2JIqbTKJCSjXtCN+wUR+MYF6V13KXUuuUt
   bs9H02fqJKbWAtwics1fk8yUEaGmCyJe6/J5uSab840Rukhe43kreE+CF
   Q==;
X-CSE-ConnectionGUID: KCl1YiRMTI+SS4RmmzaHVg==
X-CSE-MsgGUID: uiqr+ZJDTcOOtYJHqDmgvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72053002"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="72053002"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 23:27:52 -0800
X-CSE-ConnectionGUID: OE2e9scVSv2mM717prhilQ==
X-CSE-MsgGUID: N//0/fZQRaeiphkw46OTJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="212948055"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.12])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 23:27:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 13 Feb 2026 09:27:45 +0200 (EET)
To: Keith Busch <kbusch@meta.com>
cc: linux-pci@vger.kernel.org, helgaas@kernel.org, alex@shazbot.org, 
    dan.j.williams@intel.com, Lukas Wunner <lukas@wunner.de>, 
    Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 2/3] pci: allow all bus devices to use the same slot
In-Reply-To: <20260212224112.1913980-3-kbusch@meta.com>
Message-ID: <8338f25a-eba8-b8a9-4e5a-b18fa5192047@linux.intel.com>
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

Capitalize pci: in the subject.

-- 
 i.

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
