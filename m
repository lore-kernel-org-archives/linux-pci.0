Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B882EEE7D;
	Mon,  6 Jul 2026 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357575; cv=none; b=SB8UwwO6zGptZQBnibS8nZO/BAOiUE6lLSo5TMbKpUPwVmOFiEDmCn9mxyjWE0v5AtPg3aIyru22HzHEipxKKYRhJ0B02FemJ3988cSUUfyDWKRw8jAa9o4P3NUsuzXq/DNeN/dibVqrIzKgCCLRPXtwAM0TCxZ1dpbSjzEA4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357575; c=relaxed/simple;
	bh=sUlm6dTulXxUMAPmlfnEEjPCgDlohgGBMLsj8JKVv1s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ssLDfuJQx4PTwFqGPgFL+F+UL8zIHqAvEIgatFAFuwZ3br9sw1D6jC1PAWm9N+/iqyHe9MWlYCHxy6TnLQMfRJLE+QFj4rfd+KlFZGcZYrqNrqjSnFbHjxNGmYDrtOM6nFxgrmwRU/gzhloYFTcS7uzd1R0bkQaykFKlxRiN/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4/6ecxC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4/6ecxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783357573; x=1814893573;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sUlm6dTulXxUMAPmlfnEEjPCgDlohgGBMLsj8JKVv1s=;
  b=j4/6ecxCMd1hK4HTaqagbVCIA3502PijtvFXEqj/VflIw3JleQAGZ0QY
   klDf+sjMJ2sH/CVEYecLZOW8aSFoONn+i4Sk24RW2aeI+hXNrl6UEL+BR
   n6FIIEz5membmbesTjfw+yalaUTZ8M5pYzI1OUjCsXnSagfM/uh/vy1nw
   kWvOIbZtkQheq/30gRttTsJu47hJwes/dzj8BB/WuYCa7Hvwhawr/KZBo
   w+7GOdpc7xyomH7BGnaPuuMpkPh1I6+LC9SKk6+j7CDOj+nf3z/2Xh/Q7
   YQwYrmW3nw2je+rbZXeSrmSNgawkCu1zUpT/bhCxO85+9BTVMs/+DaJGX
   Q==;
X-CSE-ConnectionGUID: psBYbZORTFWLbQjT40eCiw==
X-CSE-MsgGUID: sAGcxzmbQmytjh6572CJ9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="84049465"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="84049465"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:06:13 -0700
X-CSE-ConnectionGUID: u0JEVkYYQyut1zPNZjiTJg==
X-CSE-MsgGUID: 5b1Yww1NRg6ZEFGVLEfv/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="254411846"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.95])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 10:06:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 Jul 2026 20:06:02 +0300 (EEST)
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
cc: bhelgaas@google.com, robh@kernel.org, krzk+dt@kernel.org, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    qiang.yu@oss.qualcomm.com
Subject: Re: [RFC PATCH] PCI: Get the hotplug bridge window sizes from DT
In-Reply-To: <20260706123133.545104-1-manivannan.sadhasivam@oss.qualcomm.com>
Message-ID: <5cfa59b1-079c-f192-9c77-14054af3a012@linux.intel.com>
References: <20260706123133.545104-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 6 Jul 2026, Manivannan Sadhasivam wrote:

> Most of the PCI hotplug bridges used in Devicetree platforms do not have
> their bridge windows populated by firmware. So the PCI core allocates the
> bridge windows based on the requirements below:
> 
> 1. Total size needed by the downstream devices
> 2. Default size (2MiB for MMIO, 256 bytes for IO) if no devices are
>    available during the initial bus scan
> 3. Command line params like hpmemsize etc...
> 
> If no devices are available during the initial bus scan, then the PCI core
> allocates the default conservative 2MiB MMIO bridge windows. But this size
> sometimes becomes insufficient when a BAR hungry device like a GPU gets
> plugged in later. So users have to resort to command line params to
> increase the window sizes. But this is very inconvenient and causes a lot
> of pain in distro integration.
> 
> To address this issue, parse the 'ranges' property from the bridge DT node
> (if available) and use the sizes for each bridge window. This works well
> because the 'ranges' property is already allowed by the DT binding for PCI
> bridges and it lets system designers pre-define the hotplug bridge window
> size requirements in firmware.
> 
> The DT derived sizes are applied as the additional (hotplug) reservation for
> each window. Command line parameters (hpmemsize etc...) continue to take
> precedence over DT.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> 
> Sending this patch as RFC because I'm not 100% sure if 'ranges' if the correct
> property here. I chose this property as it is already allowed for PCI bridges
> and allows specifying the window sizes. But for this usecase, bridge start
> addresses specified with this property are ignored.
> 
> Other option would be to introduce a new property to specify the bridge window
> size.
> 
> But nevertheless, having a DT property for specifying the window sizes will help
> with usecases like USB4 PCIe Tunnelling, multi-Root Port setups where firmware
> doesn't pre-allocate the bridge windows.
> 
>  drivers/pci/pci.c       |  3 --
>  drivers/pci/pci.h       |  4 +++
>  drivers/pci/setup-bus.c | 75 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d34266651ad0..5b6474a18b51 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -102,9 +102,6 @@ bool pci_reset_supported(struct pci_dev *dev)
>  int pci_domains_supported = 1;
>  #endif
>  
> -#define DEFAULT_HOTPLUG_IO_SIZE		(256)
> -#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
> -#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
>  /* hpiosize=nn can override this */
>  unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
>  /*
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4a14f88e543a..055c9b8c052b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -414,6 +414,10 @@ extern unsigned long pci_hotplug_mmio_size;
>  extern unsigned long pci_hotplug_mmio_pref_size;
>  extern unsigned long pci_hotplug_bus_size;
>  
> +#define DEFAULT_HOTPLUG_IO_SIZE		(256)
> +#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
> +#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)

It would be nice to convert these to SZ_* as we're touching them now.

Consider moving defines + variables into setup-bus.c as they're more 
relevant there.

> +
>  static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
>  {
>  	return dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4cf120ebe5ad..3dc82e3d3fd5 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -29,6 +29,8 @@
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>  #include "pci.h"
>  
>  #define PCI_RES_TYPE_MASK \
> @@ -1385,6 +1387,54 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
>  	}
>  }
>  
> +/*
> + * pci_bridge_of_get_window - Get bridge window from DT.
> + *
> + * If the bridge's DT node has a "ranges" property, then parse the property and
> + * return the bridge window sizes. This allows per-bridge resource allocation
> + * from DT.
> + *
> + * Return: 'true' if a valid 'ranges' property was found in DT node, with bridge
> + * window resources populated in @io, @mmio, @mmio_pref arguments. 'false'
> + * otherwise.
> + */
> +static bool pci_bridge_of_get_window(struct pci_dev *dev,
> +				     struct resource *io,
> +				     struct resource *mmio,
> +				     struct resource *mmio_pref)
> +{
> +	struct device_node *np = dev->dev.of_node;
> +	struct of_pci_range_parser parser;
> +	struct of_pci_range range;
> +	bool found = false;
> +
> +	if (!np || !of_property_present(np, "ranges"))
> +		return false;
> +
> +	if (of_pci_range_parser_init(&parser, np))
> +		return false;
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		struct resource *res;
> +
> +		if (range.flags & IORESOURCE_IO)
> +			res = io;
> +		else if (range.flags & IORESOURCE_PREFETCH)
> +			res = mmio_pref;
> +		else if (range.flags & IORESOURCE_MEM)
> +			res = mmio;

I wonder what should this do with the recent PCIe spec change that allows 
64-bit non-prefetchable resources. Does/will DT keep using the prefetch 
flagas the differentiator for 32-bit vs 64-bit window?

There was discussion some months (or perhaps a year by now) back about 
this on general level and it seemed Bjorn was leaning towards PCI core 
allowing 64-bit non-pref resources into the "prefetchable" window in 
cases where things are pure PCIe.

I readily admit I'm pretty unfamiliar when it comes to DT (and have had to 
look at them only while looking into some PCI resource regressions) so 
please take that into account while considering this feedback, I may miss 
some critical understanding about DT,

> +		else
> +			continue;
> +
> +		res->flags = range.flags;
> +		res->start = range.cpu_addr;
> +		res->end = range.cpu_addr + range.size - 1;

resource_set_range()

> +		found = true;
> +	}
> +
> +	return found;
> +}
> +
>  void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
> @@ -1430,9 +1480,34 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  	case PCI_HEADER_TYPE_BRIDGE:
>  		pci_bridge_check_ranges(bus);
>  		if (bus->self->is_hotplug_bridge) {
> +			struct resource dt_io = {}, dt_mmio = {}, dt_mmio_pref = {};
> +
>  			additional_io_size  = pci_hotplug_io_size;
>  			additional_mmio_size = pci_hotplug_mmio_size;
>  			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
> +
> +			/*
> +			 * If the bridge has a DT ranges property, use that to
> +			 * override the default window sizes. Command line
> +			 * parameters (hpmemsize etc...) take precedence over
> +			 * DT.
> +			 */
> +			if (pci_bridge_of_get_window(bus->self,
> +						     &dt_io, &dt_mmio,
> +						     &dt_mmio_pref)) {

Fits to 2 lines.

> +				if (dt_io.flags &&
> +				    pci_hotplug_io_size == DEFAULT_HOTPLUG_IO_SIZE)
> +					additional_io_size =
> +						resource_size(&dt_io);
> +				if (dt_mmio.flags &&
> +				    pci_hotplug_mmio_size == DEFAULT_HOTPLUG_MMIO_SIZE)
> +					additional_mmio_size =
> +						resource_size(&dt_mmio);
> +				if (dt_mmio_pref.flags &&
> +				    pci_hotplug_mmio_pref_size == DEFAULT_HOTPLUG_MMIO_PREF_SIZE)
> +					additional_mmio_pref_size =
> +						resource_size(&dt_mmio_pref);

As noted also by sashiko, giving a cmdline argument with the default value 
would be overriden.

> +			}
>  		}
>  		fallthrough;
>  	default:
> 

-- 
 i.

