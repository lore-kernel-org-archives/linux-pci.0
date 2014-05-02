Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:57849 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbaEBRX2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 2 May 2014 13:23:28 -0400
Date: Fri, 2 May 2014 11:23:18 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [RESEND PATCH 2/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140502172317.GC3179@obsidianresearch.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com>
 <1399048876-11862-3-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399048876-11862-3-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 02, 2014 at 05:41:15PM +0100, Will Deacon wrote:

> +       bus_range = &pci->cfg.bus_range;
> +       for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
> +               u32 idx = busn - bus_range->start;
> +               u32 sz = 1 << pci->cfg.ops->bus_shift;
> +
> +               pci->cfg.win[idx] = devm_ioremap(dev,
> +                                                pci->cfg.res.start + busn * sz,
> +                                                sz);

Why map each bus individually? Both CAM and ECAM define consecutive
busses consecutively in the address space, and I though ioremap was OK
with unaligned stuff?

> +out_unmap_cfg:
> +	while (busn-- > bus_range->start)
> +		devm_iounmap(dev, pci->cfg.win[busn - bus_range->start]);

Is there a reason to explicitly clean up devm resources? I guess it is
because this is in setup not probe?

It seems strange to me for a driver to do this sort of work in a setup
function, typically probe acquires as much stuff as it can, that way
defered probe can work properly.

Looking at pci-mvebu, 'setup' is only populating the resource list, I
would suggest the same split for this driver.

> +out_release_res:
> +	release_child_resources(&iomem_resource);
> +	release_child_resources(&ioport_resource);

This looks really off to me, doesn't this free all resources in the
system?

This isn't enough?:

> +	list_for_each_entry(win, &sys->resources, list)
> +		devm_kfree(dev, win->res);
> +	pci_free_resource_list(&sys->resources);


At worst, I would guess 'release_child_resources(win->res);' in the
loop. But since no bus scan has been done, is there any chance of
child resources at this point?

Regards,
Jason
