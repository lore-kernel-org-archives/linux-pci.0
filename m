Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41114 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063AbaIWMK5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 08:10:57 -0400
Date: Tue, 23 Sep 2014 13:10:50 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Simon Horman <horms@verge.net.au>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] Add PCI domain support to R-Car drivers
Message-ID: <20140923121050.GR1994@e106497-lin.cambridge.arm.com>
References: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
 <20140922210038.GJ1880@google.com>
 <84672882bcaa4730aae409f092bcbcfb@HKXPR06MB168.apcprd06.prod.outlook.com>
 <20140923103224.GO1994@e106497-lin.cambridge.arm.com>
 <99f5c020d74b465384e42ef2c883a479@HKXPR06MB168.apcprd06.prod.outlook.com>
 <20140923111000.GQ1994@e106497-lin.cambridge.arm.com>
 <028b0606cca84f619d1007bbde9693fd@HKXPR06MB168.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <028b0606cca84f619d1007bbde9693fd@HKXPR06MB168.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 23, 2014 at 12:38:28PM +0100, Phil Edworthy wrote:
> Hi Liviu,
> 
> On 23 September 2014 12:10, Liviu wrote:
> > On Tue, Sep 23, 2014 at 12:00:41PM +0100, Phil Edworthy wrote:
> > > Hi Liviu,
> > >
> > > On 23 September 2014 11:32, Liviu wrote:
> > > > On Tue, Sep 23, 2014 at 11:10:29AM +0100, Phil Edworthy wrote:
> > > > > Hi Bjorn,
> > > > >
> > > > > On 22 September 2014 22:01, Bjorn wrote:
> > > > > > On Mon, Sep 22, 2014 at 10:51:07AM +0100, Phil Edworthy wrote:
> > > > > > > The Renesas R-Car devices (r8a7790 and r8a7791) use two PCI controller
> > > > > > drivers,
> > > > > > > one for an external PCIe slot, the other for an internal PCI bridge to USB
> > > > > > > controllers.
> > > > > > >
> > > > > > > However, they currently do not work at the same time as they use the
> > > > > > same PCI
> > > > > > > domain and use the same root bus number. We can't use different root
> > > > > > bus numbers
> > > > > > > due to the way root bus numbers are assigned in pcibios_init_hw() in
> > > > > > > arch/arm/kernel/bios32.c.
> > > > > > >
> > > > > > > Since the two PCI controllers are completely independent, I think it makes
> > > > > > sense
> > > > > > > to use different PCI domains for them.
> > > > > > >
> > > > > > > I've marked the third patch as RFC as I am not sure of the impact of
> > > > > > enabling
> > > > > > > PCI domains for all ARM devices. In the march to 'one kernel to rule them
> > > > > > all',
> > > > > > > I steered clear of mach specific changes.
> > > > > > >
> > > > > > > These patches require the following patch from Liviu Dudau:
> > > > > > >   [PATCH v11 07/10] OF: Introduce helper function for getting PCI
> > > > > > domain_nr
> > > > > > > Based on comments on this patch from Jason Gunthorpe, there is still the
> > > > > > issue
> > > > > > > that the domain numbers may change depending on the ordering at probe
> > > > > > time.
> > > > > > > However, this can be fixed later on by adding the entries in the DT files.
> > > > > > >
> > > > > > >
> > > > > > > Phil Edworthy (3):
> > > > > > >   PCI: rcar-pcie: Add call to get domain nr
> > > > > > >   PCI: rcar-internal-pci: Add call to get domain nr
> > > > > > >   ARM: Enable PCI domains
> > > > > >
> > > > > > I'm deferring these for now because they depend on Liviu's work, which I
> > > > > > haven't merged yet, and I suspect some minor adaptation will be required
> > > > > > here.
> > > > > >
> > > > > > For what it's worth, I agree with Rob's hesitation about mixing lookup with
> > > > > > domain number allocation in of_pci_get_domain_nr().  That seems
> > > > > > unnecessarily complicated.
> > > > > I could create patches to add an optional "pci-domain" property for the R-Car
> > > > > PCI drivers, and just attempt to get the property in the drivers. If not found,
> > > > > the drivers will assume the domain is 0.
> > > > >
> > > > > We would then have fixed PCI domain numbering and I don't have to worry about
> > > > > Liviu's work.
> > > >
> > > > I will split the current of_pci_get_domain_nr() even further and replace it with
> > > > two functions: pci_get_domain_nr() which will do just the allocation (still based
> > > > on the boolean flag passed as parameter) and of_get_pci_domain_nr() that will
> > > > retrieve a "linux,pci-domain" value from a property belonging to a given device
> > > > node.
> > > This doesn't solve the problem of different domain numbers based on different
> > > probe ordering. If you have multiple domains then I think you must have the
> > > "linux,pci-domain" property for each controller.
> > 
> > Correct, but I've said I'm going to leave for the moment the check to the host
> > controller(s).
> > So if you care about ordering or mandating the presence of "linux,pci-
> > domain" in the DT, please add the check in your driver.
> >
> > >
> > > If we assume the above, of_get_pci_domain_nr() can just return a bus number of
> > > 0 if the "linux,pci-domain" property doesn't exist.
> > 
> > You mean *domain* number of 0. But that is still a valid value and you won't
> > be able to distinguish between DT providing a "linux,pci-domain" value of zero and
> > the property not being present.
> Yes, I meant domain.
> If a device only has a single PCI domain, no "linux,pci-domain" prop is needed
> and a default domain number of 0 is ok.

Agree, except it is not a "device" choice but a platform choice. In other words,
having a host bridge capable of running on multi-host-bridge setups, then
your HB driver will have to mandate "linux,pci-domain" presence. But the decision
to have more than one HB will be present in the device tree, not in the driver.

> If there is more than one domain, userspace needs to have consistent domain
> numbering over kernel versions, so we have to specify the domain in the DT.

Agree, and the DT will pin down the domain numbers.

> 
> I am probably missing something, it wouldn't be the first time, but I don't see
> why of_get_pci_domain_nr() needs to allocate domain numbers.

Maybe because I have confused you. Let's try again:
  - of_pci_get_domain_nr(): function present in v11, parses "pci-domain" alias,
    allocates a new domain number if "pci-domain" info is missing. Will be
    removed in v12.
  - of_get_pci_domain_nr(): subtle change of name to flag the change of behaviour
    from the previous function. Only parses "linux,pci-domain" property of the
    host bridge node, returns the property value as an integer between 0 and 255,
    or a negative value if the property is missing.
  - pci_get_new_domain_nr(): this function is only present in v12 and allocates
    a new domain number each time it is called.

Hope this helps,

Liviu

>  
> > >
> > > I suppose you could have a temporary solution that allocates the domain numbers
> > > until the necessary drivers have been updated.
> > 
> > And that is what pci_get_domain_nr() will do. If you don't care about ordering, one
> > will use that one. If you care about ordering then "linux,pci-domain" is required
> > and one can use of_get_pci_domain_nr() to retrieve it and fail if the information
> > is missing.
> > 
> > Does that look like a workable solution?
> > 
> > Best regards,
> > Liviu
> > 
> > >
> > > > I plan to leave for the moment the check for mandatory presence of
> > > > "linux,pci-domain"
> > > > to the host bridge driver so that everyone can implement their own
> > policies.
> > > >
> > > > How does that sound?
> > >
> 
> Thanks
> Phil

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

