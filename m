Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:51153 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbcBHMcT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2016 07:32:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Vineet.Gupta1@synopsys.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v8 2/2] add new platform driver for PCI RC
Date: Mon, 08 Feb 2016 13:31:38 +0100
Message-ID: <2803103.hQZUPM7HZf@wuerfel>
In-Reply-To: <20160205233248.GC11780@localhost>
References: <cover.1454600622.git.jpinto@synopsys.com> <4427983.0G6mVNKP5W@wuerfel> <20160205233248.GC11780@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 05 February 2016 17:32:48 Bjorn Helgaas wrote:
> On Fri, Feb 05, 2016 at 03:39:05PM +0100, Arnd Bergmann wrote:
> > On Friday 05 February 2016 10:44:29 Joao Pinto wrote:

> > I think in this case, we should do this completely differently:
> > 
> > How about putting all the new code into drivers/pci/host/pcie-designware.c
> > as functions that can be used by the other drivers in absence of a chip
> > specific handler?
> > 
> > Instead of providing a new instance of struct pcie_host_ops, maybe add
> > it as a default implementation in dw_pcie_link_up() and dw_pcie_host_init()
> > for drivers that don't provide their own. "hisi_pcie_host_ops" currently
> > provides no host_init() callback function, so you will have to change
> > the hisi frontend to a provide nop-function.
> > 
> > For all other drivers, check if they can be changed to use your generic
> > implementation and remove their private callbacks if possible.
> > 
> > I think the MSI implementation should be split out into a separate file
> > though, as not everyone uses this.
> 
> I'm not sure I understand what you're proposing, Arnd, so let me
> ramble and you can direct me back on course.
> 
> Currently drivers/pci/host/pcie-designware.c is not usable by itself;
> it doesn't register a platform_driver.
> 
> There's hardly any code in Joao's patches; it looks like they add a
> minimal wrapper around the functionality in pcie-designware.c and
> register it as a platform_driver.
> 
> Are you suggesting that we should just add that functionality directly
> in pcie-designware.c so that file could both be a minimal driver with
> the functionality of Joao's patches, *and* continue to provide the
> shared code used by all the existing DesignWare-based drivers?  Maybe
> the platform_driver registration part could be controlled by its own
> separate Kconfig option.

Either way is fine, we just have to be a little careful about the
initialization ordering.

> For example, he could make dw_pcie_link_up() look like:
> 
>   int dw_pcie_link_up(struct pcie_port *pp)
>   {
>     u32 val;
> 
>     if (pp->ops->link_up)
>       return pp->ops->link_up(pp);
> 
>     val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
>     return val & PCIE_PHY_DEBUG_R1_LINK_UP;
>   }

This is definitely good (after checking that all existing drivers
either work with the generic version, or provide their own callbacks
already).

> That seems like it would make sense to me.  It would resolve the
> filename question, since there wouldn't be a new file.  And if this is
> merely a driver for the generic DesignWare core without any
> extensions, I'm happy with some sort of "dw"-based driver name and
> compatibility string.

The important part I think is that the new driver should not require
and code that is seen as soc-specific: If it works with any implementation
of pci-dw rather than a specific system, the driver should know how
to do the right thing.

It may be helpful to move the actual matching on the compatible string
and calling of the generic probe function into another module, if we
are going forward with loadable PCI host drivers as posted by 
Paul Gortmaker today. Otherwise we end up with a device being bound
to the generic driver when a more specific one exists and both
are loadable modules, because the generic driver is always loaded
first.  As long as both drivers are built-in, it works fine because
we first look for a driver matching the most specific compatible string.

	Arnd
