Return-Path: <SRS0=V+wt=LU=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=V+wt=LU=h08.hostsharing.net=foo00@kernel.org>
Date: Thu, 6 Sep 2018 09:38:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 4/9] PCI: pciehp: Unify controller and slot structs
Message-ID: <20180906073826.43xonlbyoahji7hr@wunner.de>
References: <cover.1534686484.git.lukas@wunner.de>
 <2d4b1ed51a1c90fb6e1ef6282ab0c28f6c62cab1.1534686485.git.lukas@wunner.de>
 <c8e76de1-a2c3-b725-2e86-733dd0267d55@kernel.org>
 <20180820090953.sbvgxc2ednxaq73s@wunner.de>
 <05c7fadf-82ef-5ee0-601d-850583eefb0f@kernel.org>
 <20180905223016.GA214747@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905223016.GA214747@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 05:30:16PM -0500, Bjorn Helgaas wrote:
> > > > On 8/19/2018 10:29 AM, Lukas Wunner wrote:
> > > > > Simplify the driver by merging struct slot into struct controller.
> > > > > Merge the slot constructor pcie_init_slot() and the destructor
> > > > > pcie_cleanup_slot() into the controller counterparts.
> > > > > Rename the slot struct's "lock" member to "state_lock" and rename
> > > > > "work" to "button_work" for clarity.
> 
> Could the rename be done in a separate patch before the unification?
> If so, that would be nice.

Okay, I've already reworked my internal development branch to do the
unification first, then the rename, but can easily turn the order around,
no problem at all.

The preceding patches 1 to 3 of this series could be merged independently,
or would you prefer me to resend them?  The first one is also included in
Keith's error handling rework series (posted yesterday):

[1/9] PCI: Simplify disconnected marking
      https://patchwork.ozlabs.org/patch/959373/
[2/9] PCI: pciehp: Drop unnecessary includes
      https://patchwork.ozlabs.org/patch/959376/
[3/9] [3/9] PCI: pciehp: Drop hotplug_slot_ops wrappers
      https://patchwork.ozlabs.org/patch/959377/

Important side note:  Keith's series includes a pciehp fix which should
probably go into 4.19:

[PATCHv2,15/20] PCI/pciehp: Fix powerfault detection order
https://patchwork.ozlabs.org/patch/966678/

Now, if that patch goes into, say, 4.19-rc3, the pci/hotplug branch would
have to be rebased on top of 4.19-rc3 to avoid conflicts during the 4.20
merge window.

The problem with unification of the controller and slot structs in pciehp
is that it's a fairly intrusive patch.  Any pciehp patches that are pending
now would need to be rebased on top of it.  Right now the only pending
pciehp patches are Keith's series posted yesterday and this patch from me
(which would be 4.20 material):

PCI: pciehp: Tolerate Presence Detect hardwired to zero diffmboxseries
https://patchwork.ozlabs.org/patch/961860/

I can rebase all the patches as often as necessary, no problem.
Just let me know when it is most convenient for you to merge what
and I'll accommodate.  I'm sorry for the somewhat complicated
merging situation.

Thanks,

Lukas
