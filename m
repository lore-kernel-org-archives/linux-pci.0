Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbeIFXbh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 19:31:37 -0400
Date: Thu, 6 Sep 2018 13:54:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 4/9] PCI: pciehp: Unify controller and slot structs
Message-ID: <20180906185447.GD214747@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1534686484.git.lukas@wunner.de>
 <2d4b1ed51a1c90fb6e1ef6282ab0c28f6c62cab1.1534686485.git.lukas@wunner.de>
 <c8e76de1-a2c3-b725-2e86-733dd0267d55@kernel.org>
 <20180820090953.sbvgxc2ednxaq73s@wunner.de>
 <05c7fadf-82ef-5ee0-601d-850583eefb0f@kernel.org>
 <20180905223016.GA214747@bhelgaas-glaptop.roam.corp.google.com>
 <20180906073826.43xonlbyoahji7hr@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906073826.43xonlbyoahji7hr@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 06, 2018 at 09:38:26AM +0200, Lukas Wunner wrote:
> On Wed, Sep 05, 2018 at 05:30:16PM -0500, Bjorn Helgaas wrote:
> > > > > On 8/19/2018 10:29 AM, Lukas Wunner wrote:
> > > > > > Simplify the driver by merging struct slot into struct controller.
> > > > > > Merge the slot constructor pcie_init_slot() and the destructor
> > > > > > pcie_cleanup_slot() into the controller counterparts.
> > > > > > Rename the slot struct's "lock" member to "state_lock" and rename
> > > > > > "work" to "button_work" for clarity.
> > 
> > Could the rename be done in a separate patch before the unification?
> > If so, that would be nice.
> 
> Okay, I've already reworked my internal development branch to do the
> unification first, then the rename, but can easily turn the order around,
> no problem at all.

I don't care which order they're in.  I just wasn't sure if the
unification was possible without the renaming.

> The preceding patches 1 to 3 of this series could be merged independently,
> or would you prefer me to resend them?  The first one is also included in
> Keith's error handling rework series (posted yesterday):
> 
> [1/9] PCI: Simplify disconnected marking
>       https://patchwork.ozlabs.org/patch/959373/
> [2/9] PCI: pciehp: Drop unnecessary includes
>       https://patchwork.ozlabs.org/patch/959376/
> [3/9] [3/9] PCI: pciehp: Drop hotplug_slot_ops wrappers
>       https://patchwork.ozlabs.org/patch/959377/

I applied patches 1-3 to pci/hotplug.  If you could rebase what's left
on top of that, it would be great.

> Important side note:  Keith's series includes a pciehp fix which should
> probably go into 4.19:
> 
> [PATCHv2,15/20] PCI/pciehp: Fix powerfault detection order
> https://patchwork.ozlabs.org/patch/966678/

Thanks for the heads-up; I probably wouldn't have picked that out.

> Now, if that patch goes into, say, 4.19-rc3, the pci/hotplug branch would
> have to be rebased on top of 4.19-rc3 to avoid conflicts during the 4.20
> merge window.

I'll try to remember to do this.  I have no problem rebasing my branches to
-rc3.

Bjorn
