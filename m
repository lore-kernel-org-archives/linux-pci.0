Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:37555 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755270AbaIWKKe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Sep 2014 06:10:34 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Simon Horman <horms@verge.net.au>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: RE: [PATCH 0/3] Add PCI domain support to R-Car drivers
Date: Tue, 23 Sep 2014 10:10:29 +0000
Message-ID: <84672882bcaa4730aae409f092bcbcfb@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
 <20140922210038.GJ1880@google.com>
In-Reply-To: <20140922210038.GJ1880@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 22 September 2014 22:01, Bjorn wrote:
> On Mon, Sep 22, 2014 at 10:51:07AM +0100, Phil Edworthy wrote:
> > The Renesas R-Car devices (r8a7790 and r8a7791) use two PCI controller
> drivers,
> > one for an external PCIe slot, the other for an internal PCI bridge to USB
> > controllers.
> >
> > However, they currently do not work at the same time as they use the
> same PCI
> > domain and use the same root bus number. We can't use different root
> bus numbers
> > due to the way root bus numbers are assigned in pcibios_init_hw() in
> > arch/arm/kernel/bios32.c.
> >
> > Since the two PCI controllers are completely independent, I think it makes
> sense
> > to use different PCI domains for them.
> >
> > I've marked the third patch as RFC as I am not sure of the impact of
> enabling
> > PCI domains for all ARM devices. In the march to 'one kernel to rule them
> all',
> > I steered clear of mach specific changes.
> >
> > These patches require the following patch from Liviu Dudau:
> >   [PATCH v11 07/10] OF: Introduce helper function for getting PCI
> domain_nr
> > Based on comments on this patch from Jason Gunthorpe, there is still the
> issue
> > that the domain numbers may change depending on the ordering at probe
> time.
> > However, this can be fixed later on by adding the entries in the DT files.
> >
> >
> > Phil Edworthy (3):
> >   PCI: rcar-pcie: Add call to get domain nr
> >   PCI: rcar-internal-pci: Add call to get domain nr
> >   ARM: Enable PCI domains
> 
> I'm deferring these for now because they depend on Liviu's work, which I
> haven't merged yet, and I suspect some minor adaptation will be required
> here.
> 
> For what it's worth, I agree with Rob's hesitation about mixing lookup with
> domain number allocation in of_pci_get_domain_nr().  That seems
> unnecessarily complicated.
I could create patches to add an optional "pci-domain" property for the R-Car
PCI drivers, and just attempt to get the property in the drivers. If not found,
the drivers will assume the domain is 0.

We would then have fixed PCI domain numbering and I don't have to worry about
Liviu's work.

Would that be ok?
 
Thanks
Phil
