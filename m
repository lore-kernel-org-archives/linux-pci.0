Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbdHOMXd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Aug 2017 08:23:33 -0400
Date: Tue, 15 Aug 2017 07:23:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: use IDA to manage domain number if not getting
 it from DT
Message-ID: <20170815122330.GA16904@bhelgaas-glaptop.roam.corp.google.com>
References: <1498523473-157373-1-git-send-email-shawn.lin@rock-chips.com>
 <20170811211738.GH17039@bhelgaas-glaptop.roam.corp.google.com>
 <10d14bca-660a-4d0b-1885-c873c4725028@rock-chips.com>
 <20170815114316.GA25758@e107981-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170815114316.GA25758@e107981-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 15, 2017 at 12:43:16PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Aug 15, 2017 at 03:01:48PM +0800, Shawn Lin wrote:
> > Hi Bjorn,
> > 
> > On 2017/8/12 5:17, Bjorn Helgaas wrote:
> > >[+cc Lorenzo, resending because I fat-fingered the cc line and subject]
> > >
> > >On Tue, Jun 27, 2017 at 08:31:13AM +0800, Shawn Lin wrote:
> > >>If not getting domain number from DT, the domain number will
> > >>keep increasing once doing unbind/bind RC drivers. This could
> > >>introduce pointless tree view of lspci as shows below:
> > >>
> > >>-+-[0001:00]---00.0-[01]----00.0
> > >>   \-[0000:00]-
> > >>
> > >>The more test we do, the lengthier it would be. The more serious
> > >>issue is that if attaching two hierarchies for two different domains
> > >>belonging to two root bridges, so when doing unbind/bind test for one
> > >>of them and keep the other, then the domain number would finally
> > >>overflow and make the two hierarchies of devices share the some domain
> > >>number but actually they shouldn't. So it looks like we need to invent
> > >>a new indexing ID mechanism to manage domain number. This patch
> > >>introduces idr to achieve our purpose.
> > >>
> > >>Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > >
> > >The "use_dt_domains" logic in of_pci_bus_find_domain_nr() is fairly
> > >obtuse.  I *think*, now that we have pci_scan_root_bus_bridge() due to
> > >Lorenzo's excellent work, the time is ripe for moving the domain
> > >number from arch-specific places into struct pci_host_bridge.
> > >
> > >I suspect that will end up simplifying the CONFIG_PCI_DOMAINS vs
> > >CONFIG_PCI_DOMAINS_GENERIC situation, and I wonder whether it might
> > >enable some simplification of of_pci_bus_find_domain_nr() as well,
> > >which in turn, might make *this* patch simpler.
> > >
> > >This isn't that big a patch to begin with, so I could apply it as-is
> > >and we could do more domain cleanup later.  It's just that it's
> > >intertwined with the PCI_DOMAINS #ifdefs and maybe there's an
> > >opportunity to make this story more readable if those are out of the
> > >way.  Any thoughts?
> > 
> > That sounds good to me that aftering add IDA domain, we could start
> > considering moving domain number from arch-specific places into the
> > bridge code and may be could also finally remove the macro
> > CONFIG_PCI_DOMAIN* both?
> 
> I need to see how this can be implemented (another hook in
> pci_host_bridge ?) but I suspect we can't get away with arch
> specific bits - or maybe you are referring to having one single
> place where the domain is _assigned_ using an arch specific hook
> (in pci_host_bridge) ? I have to have a look into this, certainly
> this patch should be considered because that atomic counter deserved
> more thought, yes.

What I was hoping (and I haven't thought this all through) was that we
could: 

  - add "domain" to struct pci_host_bridge

  - have callers of pci_scan_root_bus_bridge() assign bridge->domain
    alongside their existing bridge->busnr, bridge->ops, etc.
    assignments.  This would pull a little of the messiness of
    pci_bus_find_domain_nr() into the bridge drivers, but they would
    know a priori whether to use ACPI or DT, so we wouldn't need quite
    as much guesswork.

  - replace the pci_bus_find_domain_nr() call in
    pci_register_host_bridge() with "bus->domain_nr = bridge->domain"

  - replace the arch-specific pci_domain_nr() implementations with a
    generic one

  - add IDA alloc to the DT domain number alloc path

Bjorn
