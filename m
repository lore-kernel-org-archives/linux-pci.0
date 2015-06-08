Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35475 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbbFHM6w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2015 08:58:52 -0400
Received: by iesa3 with SMTP id a3so97229864ies.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2015 05:58:51 -0700 (PDT)
Date: Mon, 8 Jun 2015 07:58:46 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Michal Simek <monstr@monstr.eu>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/7] microblaze/PCI: Remove unused declarations
Message-ID: <20150608125846.GV3631@google.com>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150604214929.2399.85988.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <55714AA3.1070407@monstr.eu>
 <CAErSpo6pMzOUwwxD0snOpcpdoCH5mBQhH2eXO74SVRnXvazX=A@mail.gmail.com>
 <55754D06.9050201@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55754D06.9050201@monstr.eu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 08, 2015 at 10:06:30AM +0200, Michal Simek wrote:
> On 06/05/2015 05:11 PM, Bjorn Helgaas wrote:
> > On Fri, Jun 5, 2015 at 2:07 AM, Michal Simek <monstr@monstr.eu> wrote:
> >> On 06/04/2015 11:49 PM, Bjorn Helgaas wrote:
> >>> The following declarations were copied from powerpc but are unused on
> >>> microblaze:
> >>>
> >>>   struct pci_controller *init_phb_dynamic(struct device_node *dn)
> >>>   int remove_phb_dynamic(struct pci_controller *phb)
> >>>   struct pci_dev *of_create_pci_dev(struct device_node *node, ...)
> >>>   void of_scan_pci_bridge(struct device_node *node, ...)
> >>>   void of_scan_bus(struct device_node *node, struct pci_bus *bus)
> >>>   void of_rescan_bus(struct device_node *node, struct pci_bus *bus)
> >>>
> >>> Remove them.
> >>>
> >>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >>> CC: Michal Simek <monstr@monstr.eu>
> >>> ---
> >>>  arch/microblaze/include/asm/pci.h |   12 ------------
> >>>  1 file changed, 12 deletions(-)
> >>
> >> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
> >>
> >> Bjorn: Do you want me to take this via Microblaze tree?
> > 
> > Sure, it'd be great if you take all the Microblaze-specific patches.
> > There aren't any dependencies on them, so there shouldn't be any
> > problem.
> 
> Ok. Added these 3 patches to microblaze next branch - it will be in
> linux-next tmr.

Great, thanks!  I dropped them from my branch.

> > I do have a Microblaze hunk in "PCI: Remove unused
> > pci_dma_burst_advice()" and if you agree, I'll merge that one through
> > my tree since the change for each arch is essentially identical.
> 
> No problem at all. Feel free to add there my acked-by line for microblaze.

Done, thanks again!

Bjorn
