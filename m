Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 5 Feb 2016 17:32:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Vineet.Gupta1@synopsys.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v8 2/2] add new platform driver for PCI RC
Message-ID: <20160205233248.GC11780@localhost>
References: <cover.1454600622.git.jpinto@synopsys.com>
 <20160204234334.GH7031@localhost>
 <56B47D0D.5030204@synopsys.com>
 <4427983.0G6mVNKP5W@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4427983.0G6mVNKP5W@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 05, 2016 at 03:39:05PM +0100, Arnd Bergmann wrote:
> On Friday 05 February 2016 10:44:29 Joao Pinto wrote:
> > Hi,
> > 
> > On 2/4/2016 11:43 PM, Bjorn Helgaas wrote:
> > >> What do you think?
> > > 
> > > I don't think the "dw" part is relevant (none of the other
> > > DesignWare-based drivers includes it in the driver or file name).
> > > 
> > > How do people typically refer to this board?
> > > 
> > > I really like "synopsys" because it fits the pattern of being
> > > recognizable and pronounceable like "altera", "designware", "qcom",
> > > "keystone", "layerscape", "tegra", etc.  But I can't tell whether it's
> > > too generic.
> > > 
> > > "ipk" or "haps" would be fine with me.  I think it's OK if it doesn't
> > > cover 100% of the possible systems.
> > 
> > I think we should follow the iproc example: pcie-iproc-platform.c
> > In this case we would have pcie-designware-platform.c
> > I think this would be the best name because the driver is a non soc specific
> > designware platform driver.
> > 
> > Arnd and Bjorn agree on this name?
> 
> Sorry, I did not realize that your submission was for the generic dw-pcie
> implementation rather than a particular product integrating it.
> 
> I think in this case, we should do this completely differently:
> 
> How about putting all the new code into drivers/pci/host/pcie-designware.c
> as functions that can be used by the other drivers in absence of a chip
> specific handler?
> 
> Instead of providing a new instance of struct pcie_host_ops, maybe add
> it as a default implementation in dw_pcie_link_up() and dw_pcie_host_init()
> for drivers that don't provide their own. "hisi_pcie_host_ops" currently
> provides no host_init() callback function, so you will have to change
> the hisi frontend to a provide nop-function.
> 
> For all other drivers, check if they can be changed to use your generic
> implementation and remove their private callbacks if possible.
> 
> I think the MSI implementation should be split out into a separate file
> though, as not everyone uses this.

I'm not sure I understand what you're proposing, Arnd, so let me
ramble and you can direct me back on course.

Currently drivers/pci/host/pcie-designware.c is not usable by itself;
it doesn't register a platform_driver.

There's hardly any code in Joao's patches; it looks like they add a
minimal wrapper around the functionality in pcie-designware.c and
register it as a platform_driver.

Are you suggesting that we should just add that functionality directly
in pcie-designware.c so that file could both be a minimal driver with
the functionality of Joao's patches, *and* continue to provide the
shared code used by all the existing DesignWare-based drivers?  Maybe
the platform_driver registration part could be controlled by its own
separate Kconfig option.

For example, he could make dw_pcie_link_up() look like:

  int dw_pcie_link_up(struct pcie_port *pp)
  {
    u32 val;

    if (pp->ops->link_up)
      return pp->ops->link_up(pp);

    val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
    return val & PCIE_PHY_DEBUG_R1_LINK_UP;
  }

That seems like it would make sense to me.  It would resolve the
filename question, since there wouldn't be a new file.  And if this is
merely a driver for the generic DesignWare core without any
extensions, I'm happy with some sort of "dw"-based driver name and
compatibility string.

Bjorn
