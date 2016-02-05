Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Vineet.Gupta1@synopsys.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, CARLOS.PALMINHA@synopsys.com,
	Alexey.Brodkin@synopsys.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Subject: Re: [PATCH v8 2/2] add new platform driver for PCI RC
Date: Fri, 05 Feb 2016 15:39:05 +0100
Message-ID: <4427983.0G6mVNKP5W@wuerfel>
In-Reply-To: <56B47D0D.5030204@synopsys.com>
References: <cover.1454600622.git.jpinto@synopsys.com> <20160204234334.GH7031@localhost> <56B47D0D.5030204@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 05 February 2016 10:44:29 Joao Pinto wrote:
> Hi,
> 
> On 2/4/2016 11:43 PM, Bjorn Helgaas wrote:
> >> What do you think?
> > 
> > I don't think the "dw" part is relevant (none of the other
> > DesignWare-based drivers includes it in the driver or file name).
> > 
> > How do people typically refer to this board?
> > 
> > I really like "synopsys" because it fits the pattern of being
> > recognizable and pronounceable like "altera", "designware", "qcom",
> > "keystone", "layerscape", "tegra", etc.  But I can't tell whether it's
> > too generic.
> > 
> > "ipk" or "haps" would be fine with me.  I think it's OK if it doesn't
> > cover 100% of the possible systems.
> 
> I think we should follow the iproc example: pcie-iproc-platform.c
> In this case we would have pcie-designware-platform.c
> I think this would be the best name because the driver is a non soc specific
> designware platform driver.
> 
> Arnd and Bjorn agree on this name?

Sorry, I did not realize that your submission was for the generic dw-pcie
implementation rather than a particular product integrating it.

I think in this case, we should do this completely differently:

How about putting all the new code into drivers/pci/host/pcie-designware.c
as functions that can be used by the other drivers in absence of a chip
specific handler?

Instead of providing a new instance of struct pcie_host_ops, maybe add
it as a default implementation in dw_pcie_link_up() and dw_pcie_host_init()
for drivers that don't provide their own. "hisi_pcie_host_ops" currently
provides no host_init() callback function, so you will have to change
the hisi frontend to a provide nop-function.

For all other drivers, check if they can be changed to use your generic
implementation and remove their private callbacks if possible.

I think the MSI implementation should be split out into a separate file
though, as not everyone uses this.

	Arnd
