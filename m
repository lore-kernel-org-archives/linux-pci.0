Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590D403138
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189613; cv=none; b=B5JUQgNfZ+tgCg1GWNDuUoAULTYi0wz1rWchv4/RAGgBfauGrqCwhdu7LTPvieH27IqtSHB909CrHw/gxS+vOWSHkS5+NSARthUmAqeqSJ+CVn1D3f6+jFb4IYLuuDcSKA+d/JUtKRiiQb4Tga00IU0b+oRCLNGSgiLSaOVUhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189613; c=relaxed/simple;
	bh=/4JyXmJp5XbHU3LYpvNBld08XtWbsEKJAIer+p6IHRU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u81fiopTg6LyjsNA/JcxXfke017c/rj9Kz0p1BQ72Au5lGb6w5sTPhK9TPgubVFi7fFOLz/0sF9kr+bYTD+NlX3FQE9XyZkZLIThmSw0UCIyJcIXBxuj9ByKum6GQ8A8hxA6i5ZoLFiLt9gKkl0CPLDyph+dCwJjNZOd8nGchEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUXAkrQv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUXAkrQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791189605; x=1822725605;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/4JyXmJp5XbHU3LYpvNBld08XtWbsEKJAIer+p6IHRU=;
  b=WUXAkrQvEHD1Sa/qOtTUvy1VqlXrRzpJQfHvg5A9FBDPnILnpDr/iFMX
   UZEkJ2bPqnjJszbDHCnxSz+y9EZzDF0g0jnfxEz+ZcaLBSBuqJdSxCFvU
   raRP9Bp9v9u2DD7gd+o7sRwdRSUWMassBeJwg9WLeHS+7F+DQ8iciHBRC
   6K5I9FFyYiwNhg0N1I18R9x0Tc7neooUokbVJiGyyWrySuT/HMyxvkhzK
   Jm83y5Fi8Ahr/Hy3PGbGRDYaAyek7Yl7urpLQbEdAwtWcLmwlan9lgw0W
   DXjlead/7hzw9ZYX7SdaeacxSwtqtwzID2IuhRPnbITU/Jlsuq2edsPS8
   A==;
X-CSE-ConnectionGUID: GptRret1TESMaWxaOJ9pNQ==
X-CSE-MsgGUID: DyFRVg1xTWmw9XPkdCLNhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="103226064"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="103226064"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 01:40:01 -0700
X-CSE-ConnectionGUID: gFndz9htSp+R/juTz0XpNA==
X-CSE-MsgGUID: c89japQuRhmqWYJBa025bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="274568941"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 01:39:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Oct 2026 11:39:53 +0300 (EEST)
To: Maciej Grochowski <maciej.grochowski@sony.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH 1/2] PCI: Add pci=hpreserve= to reserve memory windows
 for a hotplug bridge
In-Reply-To: <20261002193111.51637-2-maciej.grochowski@sony.com>
Message-ID: <8b41ee8a-8138-cfe7-8e58-19de2f1baee9@linux.intel.com>
References: <20261002193111.51637-1-maciej.grochowski@sony.com> <20261002193111.51637-2-maciej.grochowski@sony.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 Oct 2026, Maciej Grochowski wrote:

> A hotplug bridge is sized for the devices that are present when its
> windows are sized, plus the optional hpmmiosize/hpmmioprefsize space.
> Some topologies have devices that are known to appear later.  After a
> reset of a two-level PCIe switch hierarchy, for example, pciehp
> re-enumerates the upstream switch before the link to the nested switch
> is back up, so the downstream port leading to the nested switch is
> sized with nothing below it.  When the nested switch appears, its BARs
> do not fit.
> 
> On a two-level Microchip PM50052 (Switchtec PFX) hierarchy whose nested
> switch has an NTB function with a 1 GiB prefetchable BAR, a hard reset
> of the top-level switch on v7.3-rc2 leaves downstream port 82:03.0
> with a 206 MiB prefetchable window, an equal share of its
> parent's window.  The nested switch returns about 0.6 s later and
> fails:
> 
>   pci 0000:8c:00.1: BAR 2 [mem size 0x40000000 64bit pref]: can't assign; no space
>   switchtec 0000:8c:00.1: probe with driver switchtec failed with error -16
> 
> The global hpmmioprefsize cannot express this.  It applies to every
> hotplug bridge, it is optional space that is dropped when it does not
> fit, and it has no alignment.  Here the root port window is 1036 MiB:
> exactly the 1 GiB + 4 MiB + 4 MiB of the nested switch plus the 4 MiB
> BAR of the top switch's management function.  Only one port may get
> the space, and it has to be 1 GiB aligned.
> 
> Add "pci=hpreserve=<reservation>@<pci_dev>[; ...]" to request a minimum

Hi,

Why is this a new parameter instead of adding the per device functionality 
into hpmmio{,pref}size=x ?

> size and alignment for the memory windows of specific hotplug bridges,
> using the usual device specification.  A full path is more robust than
> a bare BDF when downstream bus numbers change.  pbus_size_mem() folds
> the reservation into the required size and alignment of the window,
> so it is assigned like the resources of a device already present below
> the bridge.  The runtime distribution of spare space can shrink only
> the optional part, leaving the required reservation intact.
> 
> Without the parameter nothing changes.
> 
> Tested-by: Maciej Grochowski <maciej.grochowski@sony.com>

The usual assumption the patch submitter has actually tested the patch so 
normal custom is to not include self tested-bys.

-- 
 i.

> Signed-off-by: Maciej Grochowski <maciej.grochowski@sony.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  34 ++++++
>  drivers/pci/pci.c                             | 106 ++++++++++++++++++
>  drivers/pci/pci.h                             |  19 ++++
>  drivers/pci/setup-bus.c                       |  33 ++++++
>  4 files changed, 192 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 33cd30996e47..19b98e22b10e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5232,6 +5232,40 @@ Kernel parameters
>  		hpbussize=nn	The minimum amount of additional bus numbers
>  				reserved for buses below a hotplug bridge.
>  				Default is 1.
> +		hpreserve=
> +				Format:
> +				<reservation>@<pci_dev>[; ...]
> +				where <reservation> is one or more of
> +				<key>=<value> separated by colons.
> +				Reserve resources for the hotplug bridges
> +				specified (in the format described above)
> +				for devices that are not present yet, e.g.
> +				a switch that is expected behind the bridge
> +				but whose link comes up only after the
> +				bridge windows have been sized.  Unlike
> +				hpmmiosize and hpmmioprefsize, which add
> +				optional space that is dropped if it does
> +				not fit, the reservation is required space:
> +				the bridge window is sized to include it,
> +				like the resources of devices already
> +				present below the bridge.
> +				Only hotplug bridges are affected.
> +				Keys:
> +				  mmio=nn[KMG]	Minimum size of the
> +					non-prefetchable memory window.
> +				  mmioalign=nn[KMG]  Minimum alignment of
> +					the non-prefetchable memory window.
> +				  mmiopref=nn[KMG]  Minimum size of the
> +					prefetchable memory window.
> +				  mmioprefalign=nn[KMG]  Minimum alignment
> +					of the prefetchable memory window.
> +				Alignments must be powers of two.  For
> +				example,
> +				  pci=hpreserve=mmiopref=1032M:mmioprefalign=1G@0000:80:01.1/00.0/03.0
> +				reserves a 1 GiB-aligned 1032 MiB
> +				prefetchable window below the downstream
> +				port at devfn 03.0 of the switch behind root
> +				port 0000:80:01.1.
>  		realloc=	Enable/disable reallocating PCI bridge resources
>  				if allocations done by BIOS are too small to
>  				accommodate resources required by all child
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..f6922cf0d96e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -412,6 +412,109 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>  	return 1;
>  }
>  
> +/*
> + * "pci=hpreserve=<reservation>@<pci_dev>[; ...]", set in pci_setup() and
> + * copied in pci_realloc_setup_params().
> + */
> +static const char *hotplug_reserve_param;
> +
> +static bool pci_hotplug_reserve_key(const char *p, size_t len, const char *key)
> +{
> +	return strlen(key) == len && !strncmp(p, key, len);
> +}
> +
> +/*
> + * Parse one "<key>=<value>[:<key>=<value>]*@" reservation into @res.
> + * Returns a pointer to the device specification following the '@', or
> + * NULL if the reservation cannot be parsed.
> + */
> +static const char *pci_parse_hotplug_reserve(const char *p,
> +					     struct pci_hotplug_reserve *res)
> +{
> +	unsigned long long val;
> +	size_t len;
> +	char *end;
> +
> +	memset(res, 0, sizeof(*res));
> +
> +	for (;;) {
> +		len = strcspn(p, "=:@;");
> +		if (p[len] != '=')
> +			return NULL;
> +
> +		val = memparse(p + len + 1, &end);
> +		if (end == p + len + 1)
> +			return NULL;
> +
> +		if (pci_hotplug_reserve_key(p, len, "mmio"))
> +			res->mmio_size = val;
> +		else if (pci_hotplug_reserve_key(p, len, "mmioalign"))
> +			res->mmio_align = val;
> +		else if (pci_hotplug_reserve_key(p, len, "mmiopref"))
> +			res->mmio_pref_size = val;
> +		else if (pci_hotplug_reserve_key(p, len, "mmioprefalign"))
> +			res->mmio_pref_align = val;
> +		else
> +			return NULL;
> +
> +		p = end + 1;
> +		if (*end == '@')
> +			break;
> +		if (*end != ':')
> +			return NULL;
> +	}
> +
> +	if ((res->mmio_align && !is_power_of_2(res->mmio_align)) ||
> +	    (res->mmio_pref_align && !is_power_of_2(res->mmio_pref_align)))
> +		return NULL;
> +
> +	return p;
> +}
> +
> +/**
> + * pci_get_hotplug_reserve - get the resources reserved for a hotplug bridge
> + * @bridge: the bridge
> + * @res: filled in with the reservation for @bridge
> + *
> + * Look up @bridge in the "pci=hpreserve=" kernel parameter.  Only hotplug
> + * bridges are considered.
> + *
> + * Return: true if a reservation was requested for @bridge.
> + */
> +bool pci_get_hotplug_reserve(struct pci_dev *bridge,
> +			     struct pci_hotplug_reserve *res)
> +{
> +	const char *p = hotplug_reserve_param;
> +	int ret;
> +
> +	if (!p || !bridge->is_hotplug_bridge)
> +		return false;
> +
> +	while (*p) {
> +		p = pci_parse_hotplug_reserve(p, res);
> +		if (!p) {
> +			pr_err_once("PCI: Can't parse hpreserve parameter\n");
> +			return false;
> +		}
> +
> +		ret = pci_dev_str_match(bridge, p, &p);
> +		if (ret == 1)
> +			return true;
> +		if (ret < 0) {
> +			pr_err_once("PCI: Can't parse hpreserve parameter\n");
> +			return false;
> +		}
> +
> +		if (*p != ';' && *p != ',') {
> +			/* End of param or invalid format */
> +			break;
> +		}
> +		p++;
> +	}
> +
> +	return false;
> +}
> +
>  static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
>  			      u8 pos, int cap)
>  {
> @@ -6840,6 +6943,8 @@ static int __init pci_setup(char *str)
>  					simple_strtoul(str + 10, &str, 0);
>  				if (pci_hotplug_bus_size > 0xff)
>  					pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> +			} else if (!strncmp(str, "hpreserve=", 10)) {
> +				hotplug_reserve_param = str + 10;
>  			} else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
>  				pcie_bus_config = PCIE_BUS_TUNE_OFF;
>  			} else if (!strncmp(str, "pcie_bus_safe", 13)) {
> @@ -6879,6 +6984,7 @@ static int __init pci_realloc_setup_params(void)
>  					   GFP_KERNEL);
>  	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
>  	config_acs_param = kstrdup(config_acs_param, GFP_KERNEL);
> +	hotplug_reserve_param = kstrdup(hotplug_reserve_param, GFP_KERNEL);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..5003d2c71200 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -410,6 +410,25 @@ extern unsigned long pci_hotplug_mmio_size;
>  extern unsigned long pci_hotplug_mmio_pref_size;
>  extern unsigned long pci_hotplug_bus_size;
>  
> +/**
> + * struct pci_hotplug_reserve - resources reserved for a hotplug bridge
> + * @mmio_size: minimum size of the non-prefetchable memory window
> + * @mmio_align: minimum alignment of the non-prefetchable memory window
> + * @mmio_pref_size: minimum size of the prefetchable memory window
> + * @mmio_pref_align: minimum alignment of the prefetchable memory window
> + *
> + * Requested with "pci=hpreserve=".  A value of zero means no reservation.
> + */
> +struct pci_hotplug_reserve {
> +	resource_size_t mmio_size;
> +	resource_size_t mmio_align;
> +	resource_size_t mmio_pref_size;
> +	resource_size_t mmio_pref_align;
> +};
> +
> +bool pci_get_hotplug_reserve(struct pci_dev *bridge,
> +			     struct pci_hotplug_reserve *res);
> +
>  static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
>  {
>  	return dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d3c1..105bf8694cdc 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1258,6 +1258,38 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
>  	return true;
>  }
>  
> +/*
> + * Apply a "pci=hpreserve=" reservation to the memory window @b_res of the
> + * bridge leading to @bus.  Unlike the hpmmiosize/hpmmioprefsize space, the
> + * reservation is sized as required space, so it is in place before the
> + * devices that need it appear behind the bridge.
> + */
> +static void pbus_size_mem_reserve(struct pci_bus *bus, struct resource *b_res,
> +				  resource_size_t *size,
> +				  resource_size_t *min_align)
> +{
> +	bool pref = b_res->flags & IORESOURCE_PREFETCH;
> +	struct pci_hotplug_reserve res;
> +	resource_size_t rsize, ralign;
> +
> +	if (!bus->self || !pci_get_hotplug_reserve(bus->self, &res))
> +		return;
> +
> +	rsize = pref ? res.mmio_pref_size : res.mmio_size;
> +	ralign = pref ? res.mmio_pref_align : res.mmio_align;
> +	if (rsize <= *size && ralign <= *min_align)
> +		return;
> +
> +	*size = max(*size, rsize);
> +	if (!*size)
> +		return;
> +	*min_align = max(*min_align, ralign);
> +
> +	pci_info(bus->self, "bridge window to %pR: reserving %s size %#llx align %#llx\n",
> +		 &bus->busn_res, pref ? "prefetchable" : "non-prefetchable",
> +		 (unsigned long long)*size, (unsigned long long)*min_align);
> +}
> +
>  /**
>   * pbus_size_mem() - Size the memory window of a given bus
>   *
> @@ -1349,6 +1381,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
>  	win_align = pci_min_window_alignment(bus, b_res->flags);
>  	min_align = calculate_head_align(aligns, max_order);
>  	min_align = max(min_align, win_align);
> +	pbus_size_mem_reserve(bus, b_res, &size, &min_align);
>  	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
>  				  0, win_align);
>  
> 
