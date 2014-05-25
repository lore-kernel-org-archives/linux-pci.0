Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:57153 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751342AbaEYKsr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 25 May 2014 06:48:47 -0400
Date: Sun, 25 May 2014 11:48:15 +0100
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
	"sthokal@xilinx.com" <sthokal@xilinx.com>
Subject: Re: [PATCH v7 4/4] PCI: Generic Configuration Access Mechanism
 support
Message-ID: <20140525104815.GB2343@arm.com>
References: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
 <1400863915-24135-5-git-send-email-will.deacon@arm.com>
 <201405232122.18995.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405232122.18995.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 23, 2014 at 08:22:18PM +0100, Arnd Bergmann wrote:
> On Friday 23 May 2014, Will Deacon wrote:
> > +static void __iomem *pci_cfg_map_bus_ecam(struct pci_bus *bus,
> > +                                         unsigned int devfn,
> > +                                         int where)
> > +{
> > +       struct pci_sys_data *sys = bus->sysdata;
> > +       struct pci_cfg_windows *cfg = sys->private_data;
> > +       resource_size_t idx = bus->number - cfg->bus_range.start;
> > +
> > +       return cfg->win[idx] + ((devfn << PCI_CFG_ECAM_DEV_NUM) | where);
> > +}
> 
> I just noticed that this function makes the code rather non-generic, because
> struct pci_sys_data is the ARM specific structure that doesn't exist elsewhere,
> and sys->private_data wouldn't typically point to struct pci_cfg_windows on
> anything other than your generic PCI host.

Indeed. That's what I was refering to initially when I suggested some
potential alignment on the private_data across host controller drivers
trying to use this.

> I'd say let's drop this for now. I know it was my idea to do it like this,
> but it seems it's more complex than I had hoped to get this right, and
> I'd really prefer to merge the other three patches for 3.16 if possible.
> We can factor it out later if we get more users.

Sure, I think we all had good intentions. I'll send a pull for the first
three patches -- should it go via arm-soc or Bjorn's PCI tree?

Cheers,

Will
