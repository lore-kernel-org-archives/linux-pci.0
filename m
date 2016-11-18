Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752824AbcKROD2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Nov 2016 09:03:28 -0500
Date: Fri, 18 Nov 2016 08:03:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v2 0/9] PCIe port PM: high gloss polish & hotplug support
Message-ID: <20161118140319.GD25762@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1477611126.git.lukas@wunner.de>
 <20161118011515.GB25762@bhelgaas-glaptop.roam.corp.google.com>
 <20161118091057.GA12168@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161118091057.GA12168@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2016 at 10:10:57AM +0100, Lukas Wunner wrote:
> On Thu, Nov 17, 2016 at 07:15:15PM -0600, Bjorn Helgaas wrote:
> > On Fri, Oct 28, 2016 at 10:52:06AM +0200, Lukas Wunner wrote:
> > > Respin of this series to polish the runtime PM support for PCIe ports
> > > that was added with v4.8, and extend it to native hotplug ports:
> [snip]
> > I applied these to pci/pm for v4.10, thanks!
> > 
> > I did make two changes to the changelog of the last patch: you
> > mentioned the "subordinate" bus, and I changed it to "secondary".  We
> > have often used "subordinate" to refer to the immediately-downstream
> > bus, but that's slightly confusing because in the bridge spec,
> > "subordinate" means the highest bus number downstream from the bridge,
> > while "secondary" refers to the immediately-downstream bridge.  Am I
> > making sense or confusing things more?
> 
> Indeed the secondary bus was meant here and I used "subordinate" only
> because the attribute in struct pci_dev is named like this. :-)

Yeah, I wish it weren't named that way, but I guess we're stuck with
that one.
