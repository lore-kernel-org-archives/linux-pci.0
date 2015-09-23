Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60352 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbIWIVq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 04:21:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: David Daney <ddaney.cavm@gmail.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3 3/6] PCI: generic: Quit clobbering our pci_ops.
Date: Wed, 23 Sep 2015 10:21:10 +0200
Message-ID: <1729894.341fjYUAKl@wuerfel>
In-Reply-To: <1442965757-12925-4-git-send-email-ddaney.cavm@gmail.com>
References: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com> <1442965757-12925-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 22 September 2015 16:49:14 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The pci-host-generic driver keeps a global struct pci_ops which it
> then patches with the .map_bus method appropriate for the bus device.
> A problem arises when the driver is used for two different types of
> bus devices, the .map_bus method for the last device probed clobbers
> the method for all previous devices.  The result, only the last bus
> device probed has the proper .map_bus, and the others fail.
> 
> Move the struct pci_ops into the bus specific structure, and
> initialize it when the bus device is probed.  Keep a copy of the
> gen_pci_cfg_bus_ops structure, instead of a pointer to a global copy,

This is a very useful change.

> to future proof against the addition of bus specific elements to
> struct pci_ops.

but I don't like this part. We should just not have bus specific
elements in pci_ops. We don't really have that here either, except
that the gen_pci driver had a hack for reusing the same operations
for things that are actually different.

It's an established practice that anything named '*_operations' is
meant to be constant and ideally defined as 'static const ... *_ops;'
in the driver. We could try to enforce this better by marking
bus->ops as 'const' and changing all the instances of this structure
accordingly.

> @@ -65,7 +65,11 @@ static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_bus *bus,
>  
>  static struct gen_pci_cfg_bus_ops gen_pci_cfg_cam_bus_ops = {
>  	.bus_shift	= 16,
> -	.map_bus	= gen_pci_map_cfg_bus_cam,
> +	.ops		= {
> +		.map_bus	= gen_pci_map_cfg_bus_cam,
> +		.read		= pci_generic_config_read,
> +		.write		= pci_generic_config_write,
> +	}
>  };

So this is good. We could in theory unify the map_bus functions
like this now:

static void __iomem *gen_pci_map_cfg_bus(struct pci_bus *bus,
                                         unsigned int devfn,
                                         int where)
{
        struct gen_pci *pci = bus->sysdata;
	struct gen_pci_cfg_bus_ops *ops;
        resource_size_t idx;

	ops = container_of(bus->ops, struct gen_pci_cfg_bus_ops, ops);
	idx = bus->number - pci->cfg.bus_range->start;

        return pci->cfg.win[idx] + ((devfn << ops->dev_shift) | where);
}

Not sure if that improves clarity or not, up to Will.

> @@ -234,8 +237,7 @@ static int gen_pci_probe(struct platform_device *pdev)
>  	}
>  
>  	of_id = of_match_node(gen_pci_of_match, np);
> -	pci->cfg.ops = of_id->data;
> +	pci->cfg.ops = *(struct gen_pci_cfg_bus_ops *)of_id->data;

This is the part that grabbed my attention, we should not do it like this.

	Arnd
