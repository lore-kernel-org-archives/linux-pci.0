Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54845 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbbIPKcS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Sep 2015 06:32:18 -0400
Date: Wed, 16 Sep 2015 11:32:32 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Will Deacon <Will.Deacon@arm.com>,
	David Daney <ddaney.cavm@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/6] PCI: generic: Only fixup irqs for bus we are
 creating.
Message-ID: <20150916103232.GB17510@red-moon>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
 <1442013719-5001-3-git-send-email-ddaney.cavm@gmail.com>
 <20150915173654.GJ31157@arm.com>
 <55F85A24.2010600@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55F85A24.2010600@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 15, 2015 at 06:49:24PM +0100, David Daney wrote:
> On 09/15/2015 10:36 AM, Will Deacon wrote:
> > Hi David,
> >
> > On Sat, Sep 12, 2015 at 12:21:55AM +0100, David Daney wrote:
> >> From: David Daney <david.daney@cavium.com>
> >>
> >> Use pci_walk_bus() to restrict the fixup irq actions to only the bus
> >> being created.
> >>
> >> If we create multiple buses with pci-host-generic, or there are buses
> >> created by other drivers, we don't want to call pci_fixup_irqs() which
> >> operates on all devices, not just the devices on the bus being added.
> >> The consequence is that either the fixups are done more than once, or
> >> in some cases incorrect fixups could be applied.
> >>
> >> Signed-off-by: David Daney <david.daney@cavium.com>
> >> ---
> >>   drivers/pci/host/pci-host-generic.c | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> >> index 265dd25..a0fb241 100644
> >> --- a/drivers/pci/host/pci-host-generic.c
> >> +++ b/drivers/pci/host/pci-host-generic.c
> >> @@ -205,6 +205,12 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
> >>   	return 0;
> >>   }
> >>
> >> +static int gen_pci_fixup_irq_cb(struct pci_dev *dev, void *arg)
> >> +{
> >> +	pdev_fixup_irq(dev, pci_common_swizzle, of_irq_parse_and_map_pci);
> >> +	return 0;
> >> +}
> >> +
> >>   static int gen_pci_probe(struct platform_device *pdev)
> >>   {
> >>   	int err;
> >> @@ -262,7 +268,7 @@ static int gen_pci_probe(struct platform_device *pdev)
> >>   		return -ENODEV;
> >>   	}
> >>
> >> -	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> >> +	pci_walk_bus(bus, gen_pci_fixup_irq_cb, NULL);
> >
> > Any chance we could put something in the core PCI code for this? I think
> > any host controller wanting to work with arm64 is potentially going to
> > run into the same problem.
> 
> Good idea.
> 
> I will move the walking code into setup-irq.c (the current home of 
> pci_fixup_irqs()), and make it part of patch 1/6.

For arm64 we could even compile out pci_fixup_irqs() since the IRQ mapping
is done in pcibios_add_device() through DT, I agree on CONFIG_ARM this
needs fixing though, so yes, make it common code and patch all host
controllers that make use of pci_fixup_irqs() since that's a common
issue as far as I can see (ARM pcibios works around it by having a
IRQ mapping function per bus and it provides an API to initialize
multiple host controllers at once and fixing up IRQs before devices
are added, still, for host controllers that do not use that
functionality - eg drivers/pci/host/pcie-designware.c - if there are
multiple host controllers instances we run into the same problem).

Side note: do you have any PCI host controller where mapping IRQs through
of_irq_parse_and_map_pci() does not work ? If yes, why ?

Cheers,
Lorenzo
