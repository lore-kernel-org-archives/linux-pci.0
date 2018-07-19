Return-Path: <SRS0=TL/u=KD=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=TL/u=KD=h08.hostsharing.net=foo00@kernel.org>
Date: Thu, 19 Jul 2018 11:43:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
	linux-pci@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mayurkumar Patel <mayurkumar.patel@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Stefan Roese <sr@denx.de>, Rajat Jain <rajatja@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 00/32] Rework pciehp event handling & add runtime PM
Message-ID: <20180719094315.GA19033@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
 <20180716142053.GA12391@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180716142053.GA12391@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 16, 2018 at 09:20:54AM -0500, Bjorn Helgaas wrote:
> On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> > Rework pciehp to use modern, threaded IRQ handling.  The slot is powered
> > on and off synchronously in the IRQ thread, no indirection via a work
> > queue anymore.
> > 
> > When the slot is enabled/disabled by the user via sysfs or an Attention
> > Button press, a request is sent to the IRQ thread.  The IRQ thread is
> > thus the sole entity enabling/disabling the slot.
> > 
> > The IRQ thread can cope with missed events, e.g. if a card is inserted
> > and immediately pulled out before the IRQ thread had a chance to react.
> > It also tolerates an initially unstable link as observed in the wild by
> > Stefan Roese.
> > 
> > Finally, runtime PM support is added.  This was the original motivation
> > of the series because runtime suspending hotplug ports is needed to power
> > down Thunderbolt controllers on idle, which saves ~1.5W per controller.
> > Runtime resuming ports takes tenths of milliseconds during which events
> > may be missed, this in turn necessitated the event handling rework.
> > 
> > I've pushed the series to GitHub to ease reviewing/fetching:
> > https://github.com/l1k/linux/commits/pciehp_runpm_v2
> 
> My current test branch:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/06-16-lukas-pciehp
> 
> has this series with these changes:
> 
>   - Drop the genirq patch (already merged via tip)
> 
>   - Add one blank line (pcie_cleanup_slot())
> 
>   - A few trivial changelog updates (mostly to use lkml.kernel.org
>     links to reduce dependency on 3rd party archives)

I've reviewed the branch and diffed every commit with the original patch
and this all LGTM.  I'll try to adhere more closely to the desired style
in the future, i.e. use kernel.org links and order the Cc: to the bottom.


> Do you plan any other updates?  The open questions I see are:
> 
>   - You mentioned withdrawing "03/32 PCI: pciehp: Fix deadlock on
>     unplug".  I tried simply dropping that, but that caused a conflict
>     that I didn't try to resolve.

Yes, a single patch succeeding it won't apply cleanly if patch 03/32 is
omitted, namely "06/32 PCI: pciehp: Declare pciehp_unconfigure_device()
void".  However resolving the conflict is straightforward, I'm including
a replacement patch below.


>   - Mika had a few questions/comments that are still dangling.

I could resolve those with two further replacement patches:

- "17/32 PCI: pciehp: Enable/disable exclusively from IRQ thread"
  => Deduplicate code to detect a change in slot occupancy
     by introducing a small helper.

- "23/32 PCI: pciehp: Avoid slot access during reset"
  => Amend commit message to justify usage of rw_semaphore.

However ISTR that you dislike replacement patches because they're
more complicated for you to handle.  Would you prefer me to repost
the full series instead?

Further open points:

- Mika suggested adding a few breaks to switch/case statements to avoid
  unintentional fall-throughs if the code is later extended.  I think
  it might be good to do that in a separate commit that is applied on
  top of this series, and at the same time mark all intentional
  fall-throughs as such for -Wimplicit-fallthrough.
  BTW, you may see a merge conflict between the pci/06-16-lukas-pciehp
  and the pci/misc branch because you've already applied Gustavo's patch
  to the latter and it touches pciehp_ctrl.c.

- The commit message of "27/32 PCI: pciehp: Support interrupts sent from
  D3hot" could optionally be extended by your comment that the "Downstream
  Port" term includes both Root Ports and Switch Downstream Ports.

- Mika voiced a concern that "32/32 PCI: Whitelist Thunderbolt ports for
  runtime D3" should probably be constrained to Apple systems, this is
  pending a reply to the mail I sent yesterday evening.


>   - Whether to include "02/32 PCI: pciehp: Fix UAF on unplug" in the
>     v4.19 merge window or in v4.18.

Personally I think submitting the fix during the 4.19 merge window is
sufficient, considering that it'll already open in two to three weeks
and the bug has been present for years.

Thanks,

Lukas

-- >8 --
Subject: [PATCH] PCI: pciehp: Declare pciehp_unconfigure_device() void

Since commit 0f4bd8014db5 ("PCI: hotplug: Drop checking of PCI_BRIDGE_
CONTROL in *_unconfigure_device()"), pciehp_unconfigure_device() can no
longer fail, so declare it and its sole caller remove_board() void, in
keeping with the usual kernel pattern that enablement can fail, but
disablement cannot.  No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp.h      |  2 +-
 drivers/pci/hotplug/pciehp_ctrl.c | 11 ++++-------
 drivers/pci/hotplug/pciehp_pci.c  |  4 +---
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 79b9b5f..9bb9931 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -129,7 +129,7 @@ struct controller {
 int pciehp_sysfs_disable_slot(struct slot *slot);
 void pciehp_queue_interrupt_event(struct slot *slot, u32 event_type);
 int pciehp_configure_device(struct slot *p_slot);
-int pciehp_unconfigure_device(struct slot *p_slot);
+void pciehp_unconfigure_device(struct slot *p_slot);
 void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 5bbd28d..163947b 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -133,14 +133,11 @@ static int board_added(struct slot *p_slot)
  * remove_board - Turns off slot and LEDs
  * @p_slot: slot where board is being removed
  */
-static int remove_board(struct slot *p_slot)
+static void remove_board(struct slot *p_slot)
 {
-	int retval;
 	struct controller *ctrl = p_slot->ctrl;
 
-	retval = pciehp_unconfigure_device(p_slot);
-	if (retval)
-		return retval;
+	pciehp_unconfigure_device(p_slot);
 
 	if (POWER_CTRL(ctrl)) {
 		pciehp_power_off_slot(p_slot);
@@ -155,7 +152,6 @@ static int remove_board(struct slot *p_slot)
 
 	/* turn off Green LED */
 	pciehp_green_led_off(p_slot);
-	return 0;
 }
 
 struct power_work_info {
@@ -435,7 +431,8 @@ int pciehp_disable_slot(struct slot *p_slot)
 		}
 	}
 
-	return remove_board(p_slot);
+	remove_board(p_slot);
+	return 0;
 }
 
 int pciehp_sysfs_enable_slot(struct slot *p_slot)
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index acc360d..ec3f065 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -76,9 +76,8 @@ int pciehp_configure_device(struct slot *p_slot)
 	return ret;
 }
 
-int pciehp_unconfigure_device(struct slot *p_slot)
+void pciehp_unconfigure_device(struct slot *p_slot)
 {
-	int rc = 0;
 	u8 presence = 0;
 	struct pci_dev *dev, *temp;
 	struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
@@ -121,5 +120,4 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 	}
 
 	pci_unlock_rescan_remove();
-	return rc;
 }
-- 
2.17.1
