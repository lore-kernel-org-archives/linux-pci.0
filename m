Return-Path: <SRS0=xK5x=LD=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=xK5x=LD=h08.hostsharing.net=foo00@kernel.org>
Date: Mon, 20 Aug 2018 11:09:53 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 4/9] PCI: pciehp: Unify controller and slot structs
Message-ID: <20180820090953.sbvgxc2ednxaq73s@wunner.de>
References: <cover.1534686484.git.lukas@wunner.de>
 <2d4b1ed51a1c90fb6e1ef6282ab0c28f6c62cab1.1534686485.git.lukas@wunner.de>
 <c8e76de1-a2c3-b725-2e86-733dd0267d55@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c8e76de1-a2c3-b725-2e86-733dd0267d55@kernel.org>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 19, 2018 at 05:59:33PM -0400, Sinan Kaya wrote:
> On 8/19/2018 10:29 AM, Lukas Wunner wrote:
> > Simplify the driver by merging struct slot into struct controller.
> > Merge the slot constructor pcie_init_slot() and the destructor
> > pcie_cleanup_slot() into the controller counterparts.  Rename the slot
> > struct's "lock" member to "state_lock" and rename "work" to "button_work"
> > for clarity.
> 
> please split this into multiple pieces.

Hm, you mean split out the renaming of the "lock" and "work" members?

The unification of the two structs needs to happen in a single commit
to avoid breaking the build for people doing a git bisect.

Thanks,

Lukas
