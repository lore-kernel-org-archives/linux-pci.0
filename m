Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91276C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5918A218AF
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548876576;
	bh=sv3PaANrTz1S6M7IM3Mxm5xrvuoDM0MnOEuWc2CNErA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BQqusDekmbizCETv4kJi9rxQ13BDqFSenYE9P376yYAKcPgd11B+2MXEb0I54A1qL
	 U6fFSfpdqTr3kB8uVs7EqqtdoJFXVTA3EMiE8XEQXZJzy3nb7syoYJL0isIOg9Jh0n
	 qDHdBi9sL5WSARhwPf43rSaaVqDppe02Tx2trMdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbfA3T3f (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:29:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfA3T3f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 14:29:35 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659402087F;
        Wed, 30 Jan 2019 19:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548876573;
        bh=sv3PaANrTz1S6M7IM3Mxm5xrvuoDM0MnOEuWc2CNErA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XFijlE9Aw2f97w94QASfSJbpaqTp/Z6i7lxzzcgBljuwLtGYjQK0ibaBvGrVHak0s
         OZr6ZwMKIqT3sZlGTaAug5MrO/xQ/62jKyZjxYIYGGcQ7lpksdxYNFQn3SCl6jls1R
         CJab/1h3KdFlKMb8kE/HHeyh0GEu/4/G2zezSjao=
Date:   Wed, 30 Jan 2019 13:29:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: switch remaining pci_printk(KERN_DEBUG users to
 pci_dbg
Message-ID: <20190130192931.GJ229773@google.com>
References: <44473b8c-c9d3-733c-a4b1-18904f4d62b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44473b8c-c9d3-733c-a4b1-18904f4d62b2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 21, 2018 at 05:20:05PM +0200, Heiner Kallweit wrote:
> pci_printk messages with level KERN_DEBUG are written to the syslog
> even if CONFIG_DEBUG isn't defined. This may confuse users, e.g. if
> the debug messages include "not supported" or "failed to". To avoid
> this switch the remaining pci_printk(KERN_DEBUG users to pci_dbg.

Yeah...

I always find the dev_dbg() stuff confusing because it depends on DEBUG,
CONFIG_DYNAMIC_DEBUG, and possibly some dynamic stuff that I always have to
look up, so you can't tell from the source whether to expect the message in
a dmesg log, and I personally never use it.

When we get bug reports, they often already contain a dmesg log, and it's
super nice when that has everything we need.  If they don't, it's a lot
easier to just ask for a dmesg log than to figure out how to enable debug
output.

Some of these, e.g., the device ID, BAR and bridge window info, "PME#
supported from", etc., probably should be converted to pci_info() because
I think we really do always want them.

That said, some of the messages *are* potentially confusing.  I would
rather change the text of the message to make them more useful.

Bjorn

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/bus.c       |  3 +--
>  drivers/pci/pci.c       | 39 +++++++++++++++++++--------------------
>  drivers/pci/probe.c     | 17 ++++++++---------
>  drivers/pci/setup-bus.c | 26 +++++++++++++-------------
>  4 files changed, 41 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 5cb40b251..ddee5f461 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -288,8 +288,7 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
>  		res->end = end;
>  		res->flags &= ~IORESOURCE_UNSET;
>  		orig_res.flags &= ~IORESOURCE_UNSET;
> -		pci_printk(KERN_DEBUG, dev, "%pR clipped to %pR\n",
> -				 &orig_res, res);
> +		pci_dbg(dev, "%pR clipped to %pR\n", &orig_res, res);
>  
>  		return true;
>  	}
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fb63b3d89..e60fd652d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2711,19 +2711,19 @@ void pci_pm_init(struct pci_dev *dev)
>  			dev->d2_support = true;
>  
>  		if (dev->d1_support || dev->d2_support)
> -			pci_printk(KERN_DEBUG, dev, "supports%s%s\n",
> -				   dev->d1_support ? " D1" : "",
> -				   dev->d2_support ? " D2" : "");
> +			pci_dbg(dev, "supports%s%s\n",
> +				dev->d1_support ? " D1" : "",
> +				dev->d2_support ? " D2" : "");
>  	}
>  
>  	pmc &= PCI_PM_CAP_PME_MASK;
>  	if (pmc) {
> -		pci_printk(KERN_DEBUG, dev, "PME# supported from%s%s%s%s%s\n",
> -			 (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
> -			 (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
> -			 (pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
> -			 (pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
> -			 (pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" : "");
> +		pci_dbg(dev, "PME# supported from%s%s%s%s%s\n",
> +			(pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
> +			(pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
> +			(pmc & PCI_PM_CAP_PME_D2) ? " D2" : "",
> +			(pmc & PCI_PM_CAP_PME_D3) ? " D3hot" : "",
> +			(pmc & PCI_PM_CAP_PME_D3cold) ? " D3cold" : "");
>  		dev->pme_support = pmc >> PCI_PM_CAP_PME_SHIFT;
>  		dev->pme_poll = true;
>  		/*
> @@ -2886,18 +2886,17 @@ static int pci_ea_read(struct pci_dev *dev, int offset)
>  	res->flags = flags;
>  
>  	if (bei <= PCI_EA_BEI_BAR5)
> -		pci_printk(KERN_DEBUG, dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
> -			   bei, res, prop);
> +		pci_dbg(dev, "BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
> +			bei, res, prop);
>  	else if (bei == PCI_EA_BEI_ROM)
> -		pci_printk(KERN_DEBUG, dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
> -			   res, prop);
> +		pci_dbg(dev, "ROM: %pR (from Enhanced Allocation, properties %#02x)\n",
> +			res, prop);
>  	else if (bei >= PCI_EA_BEI_VF_BAR0 && bei <= PCI_EA_BEI_VF_BAR5)
> -		pci_printk(KERN_DEBUG, dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
> -			   bei - PCI_EA_BEI_VF_BAR0, res, prop);
> +		pci_dbg(dev, "VF BAR %d: %pR (from Enhanced Allocation, properties %#02x)\n",
> +			bei - PCI_EA_BEI_VF_BAR0, res, prop);
>  	else
> -		pci_printk(KERN_DEBUG, dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
> -			   bei, res, prop);
> -
> +		pci_dbg(dev, "BEI %d res: %pR (from Enhanced Allocation, properties %#02x)\n",
> +			bei, res, prop);
>  out:
>  	return offset + ent_size;
>  }
> @@ -4114,8 +4113,8 @@ int pci_set_cacheline_size(struct pci_dev *dev)
>  	if (cacheline_size == pci_cache_line_size)
>  		return 0;
>  
> -	pci_printk(KERN_DEBUG, dev, "cache line size of %d is not supported\n",
> -		   pci_cache_line_size << 2);
> +	pci_dbg(dev, "cache line size of %d is not supported\n",
> +		pci_cache_line_size << 2);
>  
>  	return -EINVAL;
>  }
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b1c05b505..bd986a1c1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -317,7 +317,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  	res->flags = 0;
>  out:
>  	if (res->flags)
> -		pci_printk(KERN_DEBUG, dev, "reg 0x%x: %pR\n", pos, res);
> +		pci_dbg(dev, "reg 0x%x: %pR\n", pos, res);
>  
>  	return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
>  }
> @@ -384,7 +384,7 @@ static void pci_read_bridge_io(struct pci_bus *child)
>  		region.start = base;
>  		region.end = limit + io_granularity - 1;
>  		pcibios_bus_to_resource(dev->bus, res, &region);
> -		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
> +		pci_dbg(dev, "  bridge window %pR\n", res);
>  	}
>  }
>  
> @@ -406,7 +406,7 @@ static void pci_read_bridge_mmio(struct pci_bus *child)
>  		region.start = base;
>  		region.end = limit + 0xfffff;
>  		pcibios_bus_to_resource(dev->bus, res, &region);
> -		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
> +		pci_dbg(dev, "  bridge window %pR\n", res);
>  	}
>  }
>  
> @@ -459,7 +459,7 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
>  		region.start = base;
>  		region.end = limit + 0xfffff;
>  		pcibios_bus_to_resource(dev->bus, res, &region);
> -		pci_printk(KERN_DEBUG, dev, "  bridge window %pR\n", res);
> +		pci_dbg(dev, "  bridge window %pR\n", res);
>  	}
>  }
>  
> @@ -489,9 +489,8 @@ void pci_read_bridge_bases(struct pci_bus *child)
>  			if (res && res->flags) {
>  				pci_bus_add_resource(child, res,
>  						     PCI_SUBTRACTIVE_DECODE);
> -				pci_printk(KERN_DEBUG, dev,
> -					   "  bridge window %pR (subtractive decode)\n",
> -					   res);
> +				pci_dbg(dev, "  bridge window %pR (subtractive decode)\n",
> +					res);
>  			}
>  		}
>  	}
> @@ -1626,8 +1625,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	dev->revision = class & 0xff;
>  	dev->class = class >> 8;		    /* upper 3 bytes */
>  
> -	pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
> -		   dev->vendor, dev->device, dev->hdr_type, dev->class);
> +	pci_dbg(dev, "[%04x:%04x] type %02x class %#08x\n",
> +		dev->vendor, dev->device, dev->hdr_type, dev->class);
>  
>  	if (pci_early_dump)
>  		early_dump_pci_device(dev);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed960436d..34c1d0e84 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -255,10 +255,10 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
>  				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
>  			if (pci_reassign_resource(add_res->dev, idx,
>  						  add_size, align))
> -				pci_printk(KERN_DEBUG, add_res->dev,
> -					   "failed to add %llx res[%d]=%pR\n",
> -					   (unsigned long long)add_size,
> -					   idx, res);
> +				pci_dbg(add_res->dev,
> +					"failed to add %llx res[%d]=%pR\n",
> +					(unsigned long long)add_size,
> +					idx, res);
>  		}
>  out:
>  		list_del(&add_res->list);
> @@ -955,9 +955,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  	if (size1 > size0 && realloc_head) {
>  		add_to_list(realloc_head, bus->self, b_res, size1-size0,
>  			    min_align);
> -		pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx\n",
> -			   b_res, &bus->busn_res,
> -			   (unsigned long long)size1-size0);
> +		pci_dbg(bus->self, "bridge window %pR to %pR add_size %llx\n",
> +			b_res, &bus->busn_res,
> +			(unsigned long long)size1-size0);
>  	}
>  }
>  
> @@ -1100,10 +1100,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	b_res->flags |= IORESOURCE_STARTALIGN;
>  	if (size1 > size0 && realloc_head) {
>  		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
> -		pci_printk(KERN_DEBUG, bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
> -			   b_res, &bus->busn_res,
> -			   (unsigned long long) (size1 - size0),
> -			   (unsigned long long) add_align);
> +		pci_dbg(bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
> +			b_res, &bus->busn_res,
> +			(unsigned long long) (size1 - size0),
> +			(unsigned long long) add_align);
>  	}
>  	return 0;
>  }
> @@ -1568,8 +1568,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
>  	release_child_resources(r);
>  	if (!release_resource(r)) {
>  		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
> -		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
> -					PCI_BRIDGE_RESOURCES + idx, r);
> +		pci_dbg(dev, "resource %d %pR released\n",
> +			PCI_BRIDGE_RESOURCES + idx, r);
>  		/* keep the old size */
>  		r->end = resource_size(r) - 1;
>  		r->start = 0;
> -- 
> 2.19.1
> 
> 
