Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbeIFDCs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 23:02:48 -0400
Date: Wed, 5 Sep 2018 17:30:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 4/9] PCI: pciehp: Unify controller and slot structs
Message-ID: <20180905223016.GA214747@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1534686484.git.lukas@wunner.de>
 <2d4b1ed51a1c90fb6e1ef6282ab0c28f6c62cab1.1534686485.git.lukas@wunner.de>
 <c8e76de1-a2c3-b725-2e86-733dd0267d55@kernel.org>
 <20180820090953.sbvgxc2ednxaq73s@wunner.de>
 <05c7fadf-82ef-5ee0-601d-850583eefb0f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <05c7fadf-82ef-5ee0-601d-850583eefb0f@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2018 at 01:34:48PM -0400, Sinan Kaya wrote:
> On 8/20/2018 5:09 AM, Lukas Wunner wrote:
> > On Sun, Aug 19, 2018 at 05:59:33PM -0400, Sinan Kaya wrote:
> > > On 8/19/2018 10:29 AM, Lukas Wunner wrote:
> > > > Simplify the driver by merging struct slot into struct controller.
> > > > Merge the slot constructor pcie_init_slot() and the destructor
> > > > pcie_cleanup_slot() into the controller counterparts.  Rename the slot
> > > > struct's "lock" member to "state_lock" and rename "work" to "button_work"
> > > > for clarity.
> > > 
> > > please split this into multiple pieces.
> > 
> > Hm, you mean split out the renaming of the "lock" and "work" members?
> > 
> > The unification of the two structs needs to happen in a single commit
> > to avoid breaking the build for people doing a git bisect.
> 
> I was thinking of the rename.

Could the rename be done in a separate patch before the unification?
If so, that would be nice.

Bjorn
