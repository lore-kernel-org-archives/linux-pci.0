Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Tue, 13 Sep 2016 23:13:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI: Fix bridge_d3 update on device removal
Message-ID: <20160913211307.GA1521@wunner.de>
References: <9bc855a01d0f29cc8425cf50dce9812062309cfb.1473135221.git.lukas@wunner.de>
 <20160913210231.GG4138@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160913210231.GG4138@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 04:02:31PM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 06, 2016 at 06:20:46AM +0200, Lukas Wunner wrote:
> > Starting with v4.8, we allow a PCIe port to runtime suspend to D3hot if
> > the port itself and its children satisfy a number of conditions.  Once a
> > child is removed, we recheck those conditions in case the removed device
> > was blocking the port from suspending.
> > 
> > The rechecking needs to happen *after* the device has been removed from
> > the bus it resides on.  Otherwise when walking the port's subordinate
> > bus in pci_bridge_d3_update(), the device being removed would
> > erroneously still be taken into account.
> > 
> > However the device is removed from the bus_list in pci_destroy_dev() and
> > we currently recheck *before* that.  Fix it.
> > 
> > Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> 9d26d3a8f1b0 appeared in v4.8-rc1, so I assume this fix should be merged
> before v4.8, right?

Yes, it's a bug in the new runtime PM code for PCIe ports,
albeit a relatively harmless one:  I think the worst that
can happen is that a port which should suspend doesn't.

But it's still a bug, so if this could still go into 4.8
it would be ideal.

> I applied it to for-linus with Mika's reviewed-by and Rafael's acked-by on
> that assumption.

Perfect, thanks!

Lukas
