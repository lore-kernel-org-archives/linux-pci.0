Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9051494C3
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967960; cv=none; b=KLJVOuJB95O9XU/xISAJ3jCl62NNvatumLto0zOMfRiVxEWsYWDax/7MsnCOh/yswz9Kdv7x3pDS3zYNW3BhFI4Lx4vJE3bMTuOP4iVafJf5ksEzCtcEEa3aGIrha4cUbUrR7FbemjsAbAPqYCepbHIZC5LxxOMszNmXQ4z7r2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967960; c=relaxed/simple;
	bh=xRnRql6Ozi8FjXcLArLEFT3N941bxk8FgUMw3YWMCdk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q+wcBMOFAXedJAlRy2Y6o/O+yoFGX2xvdDUrW1GMaae5kHlDyuYyJTeAlUScRoIYgfZRz7YQ19urNfnlhqO+IcvlWTUKY8lQi00rN7J2/e8S90oQKKL8MGe8xKmQGIRrIxe1T42FYLU9rYY/iFAPJSkPG6to3p3DWqUf0R79uVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkaTK54+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkaTK54+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770967959; x=1802503959;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xRnRql6Ozi8FjXcLArLEFT3N941bxk8FgUMw3YWMCdk=;
  b=FkaTK54+v7Y0hCjPw+JwLrVf1bSfVezwx3tWGMmQwf4zxNNdfWh2yEPk
   kAYm0E6tko0h3YH5x779AFK5yFT2VFf/Lgx+pd0S2WYW5bqmlvSsbw0a3
   ZDgByg+LJkGhBbbFTHIslNge4BWUmbFbzFX02UthBgMlH8NC1A+//6DN0
   41zUD7Ej+C5AhMkwuhVXZ/C84D5eHrAj1P0A0c/wFxnbIPuPdR0LzaXOZ
   m7vEbEvGFpHTPkIkWgbDZNo6omFu5MB65WIXpbPn5+H0+DpjJb9zp7RBe
   OMIXz7hfdniiskOKX55SFsJcuAXQpkLxFNV2iguBSwM/LVHDpjqbClVFS
   g==;
X-CSE-ConnectionGUID: XyDJhxACQcGi3ZnJZMNhUA==
X-CSE-MsgGUID: 1+nuUfGiSOWuxTKvyLtgmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72053189"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="72053189"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 23:32:39 -0800
X-CSE-ConnectionGUID: Z1cNsMluQ/WtSFDzPlhGvA==
X-CSE-MsgGUID: ymH1fgAFQBuVoC4wXop47w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="212949454"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.12])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 23:32:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 13 Feb 2026 09:32:32 +0200 (EET)
To: Keith Busch <kbusch@meta.com>
cc: linux-pci@vger.kernel.org, helgaas@kernel.org, alex@shazbot.org, 
    dan.j.williams@intel.com, Lukas Wunner <lukas@wunner.de>, 
    Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 3/3] pci: make reset_subordinate hotplug safe
In-Reply-To: <20260212224112.1913980-4-kbusch@meta.com>
Message-ID: <04516225-9967-fd1e-c756-6963719aa08d@linux.intel.com>
References: <20260212224112.1913980-1-kbusch@meta.com> <20260212224112.1913980-4-kbusch@meta.com>
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
> Use the slot reset method when resetting the bridge if the bus contains
> hot plug slots. This fixes spurious hot plug events that are triggered
> by the secondary bus reset that bypasses the slot's detection disabling.
> 
> Resetting a bridge's subordinate bus can be done like this:
> 
>   # echo 1 > /sys/bus/pci/devices/0000:50:01.0/reset_subordinate
> 
> Prior to this patch, an example kernel message may show something like:
> 
>   pcieport 0000:50:01.0: pciehp: Slot(40): Link Down
> 
> With this change, the pciehp driver ignores the link event during the
> reset, so may show this message instead:
> 
>   pcieport 0000:50:01.0: pciehp: Slot(40): Link Down/Up ignored
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c |  3 +-
>  drivers/pci/pci.c       | 86 +++++++++++++++++++++++++++--------------
>  drivers/pci/pci.h       |  2 +-
>  3 files changed, 60 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b44e884fd5372..6187b0f3e2833 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -553,7 +553,6 @@ static ssize_t reset_subordinate_store(struct device *dev,
>  				const char *buf, size_t count)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct pci_bus *bus = pdev->subordinate;
>  	unsigned long val;
>  
>  	if (!capable(CAP_SYS_ADMIN))
> @@ -563,7 +562,7 @@ static ssize_t reset_subordinate_store(struct device *dev,
>  		return -EINVAL;
>  
>  	if (val) {
> -		int ret = pci_try_reset_bus(bus);
> +		int ret = pci_try_reset_bridge(pdev);
>  
>  		if (ret)
>  			return ret;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5ab0b22dc7274..c535cd7f45013 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -54,6 +54,10 @@ unsigned int pci_pm_d3hot_delay;
>  
>  static void pci_pme_list_scan(struct work_struct *work);
>  
> +#define PCI_RESET_RESTORE true
> +#define PCI_RESET_NO_RESTORE false
> +static int pci_reset_bridge(struct pci_dev *bridge, bool restore);

As this forward declaration is unnecessary after the suggestion below, 
there should be comment before defines to indicate they relate to 
pci_reset_bridge()'s restore parameter.

> +
>  static LIST_HEAD(pci_pme_list);
>  static DEFINE_MUTEX(pci_pme_list_mutex);
>  static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
> @@ -5600,36 +5604,10 @@ static int pci_bus_reset(struct pci_bus *bus, bool probe)
>  /**
>   * pci_bus_error_reset - reset the bridge's subordinate bus
>   * @bridge: The parent device that connects to the bus to reset
> - *
> - * This function will first try to reset the slots on this bus if the method is
> - * available. If slot reset fails or is not available, this will fall back to a
> - * secondary bus reset.
>   */
>  int pci_bus_error_reset(struct pci_dev *bridge)
>  {
> -	struct pci_bus *bus = bridge->subordinate;
> -	struct pci_slot *slot;
> -
> -	if (!bus)
> -		return -ENOTTY;
> -
> -	mutex_lock(&pci_slot_mutex);
> -	if (list_empty(&bus->slots))
> -		goto bus_reset;
> -
> -	list_for_each_entry(slot, &bus->slots, list)
> -		if (pci_probe_reset_slot(slot))
> -			goto bus_reset;
> -
> -	list_for_each_entry(slot, &bus->slots, list)
> -		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
> -			goto bus_reset;
> -
> -	mutex_unlock(&pci_slot_mutex);
> -	return 0;
> -bus_reset:
> -	mutex_unlock(&pci_slot_mutex);
> -	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
> +	return pci_reset_bridge(bridge, PCI_RESET_NO_RESTORE);
>  }

I think this should be moved down below pci_reset_bridge() and the forward 
declaration of pci_reset_bridge() removed.
  
>  /**
> @@ -5650,7 +5628,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
>   *
>   * Same as above except return -EAGAIN if the bus cannot be locked
>   */
> -int pci_try_reset_bus(struct pci_bus *bus)
> +static int pci_try_reset_bus(struct pci_bus *bus)
>  {
>  	int rc;
>  
> @@ -5670,6 +5648,58 @@ int pci_try_reset_bus(struct pci_bus *bus)
>  	return rc;
>  }
>  
> +/**
> + * pci_reset_bridge - reset a bridge's subordinate bus
> + * @bridge: bridge that connects to the bus to reset
> + * @restore: true if affected device states need to be restored after the reset
> + *
> + * This function will first try to reset the slots on this bus if the method is
> + * available. If slot reset fails or is not available, this will fall back to a
> + * secondary bus reset.
> + */
> +static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
> +{
> +	struct pci_bus *bus = bridge->subordinate;
> +	struct pci_slot *slot;
> +
> +	if (!bus)
> +		return -ENOTTY;
> +
> +	mutex_lock(&pci_slot_mutex);
> +	if (list_empty(&bus->slots))
> +		goto bus_reset;
> +
> +	list_for_each_entry(slot, &bus->slots, list)
> +		if (pci_probe_reset_slot(slot))
> +			goto bus_reset;
> +
> +	list_for_each_entry(slot, &bus->slots, list) {
> +		int ret;
> +
> +		if (restore)
> +			ret = pci_try_reset_slot(slot);
> +		else
> +			ret = pci_slot_reset(slot, PCI_RESET_DO_RESET);
> +
> +		if (ret)
> +			goto bus_reset;
> +	}
> +
> +	mutex_unlock(&pci_slot_mutex);
> +	return 0;
> +bus_reset:
> +	mutex_unlock(&pci_slot_mutex);
> +
> +	if (restore)
> +		return pci_try_reset_bus(bus);
> +	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
> +}
> +
> +int pci_try_reset_bridge(struct pci_dev *bridge)
> +{
> +	return pci_reset_bridge(bridge, PCI_RESET_RESTORE);
> +}
> +
>  /**
>   * pci_reset_bus - Try to reset a PCI bus
>   * @pdev: top level PCI device to reset via slot/bus
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d1350d54b932d..9e363ad22e161 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -231,7 +231,7 @@ bool pci_reset_supported(struct pci_dev *dev);
>  void pci_init_reset_methods(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
> -int pci_try_reset_bus(struct pci_bus *bus);
> +int pci_try_reset_bridge(struct pci_dev *bridge);
>  
>  struct pci_cap_saved_data {
>  	u16		cap_nr;
> 

-- 
 i.

