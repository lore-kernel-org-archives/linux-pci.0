Return-Path: <SRS0=sOCM=IR=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=sOCM=IR=h08.hostsharing.net=foo00@kernel.org>
Date: Wed, 30 May 2018 12:40:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 3/9] PCI: pciehp: Clear Presence Detect and Data Link
 Layer Status Changed on resume
Message-ID: <20180530104050.GA3954@wunner.de>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-4-mika.westerberg@linux.intel.com>
 <20180501215211.GD11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180502115509.GF2355@lahna.fi.intel.com>
 <20180502134148.GF11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180503104250.GJ2355@lahna.fi.intel.com>
 <20180503230108.GD15790@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503230108.GD15790@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 06:01:08PM -0500, Bjorn Helgaas wrote:
> On Thu, May 03, 2018 at 01:42:50PM +0300, Mika Westerberg wrote:
> > On Wed, May 02, 2018 at 08:41:48AM -0500, Bjorn Helgaas wrote:
> > > On Wed, May 02, 2018 at 02:55:09PM +0300, Mika Westerberg wrote:
> > > > On Tue, May 01, 2018 at 04:52:11PM -0500, Bjorn Helgaas wrote:
> > > > > On Mon, Apr 16, 2018 at 01:34:47PM +0300, Mika Westerberg wrote:
> > > > > > After suspend/resume cycle the Presence Detect or Data Link Layer Status
> > > > > > Changed bits might be set and if we don't clear them those events will
> > > > > > not fire anymore and nothing happens for instance when a device is now
> > > > > > hot-unplugged.
> > > > > > 
> > > > > > Fix this by clearing those bits in a newly introduced function
> > > > > > pcie_reenable_notification(). This should be fine because immediately
> > > > > > after we check if the adapter is still present by reading directly from
> > > > > > the status register.
> > > > > 
> > > > > I want to understand why we need to handle this differently between
> > > > > the boot-time probe path and the resume path.
> > > > > 
> > > > > This patch clears PCI_EXP_SLTSTA_PDC and PCI_EXP_SLTSTA_DLLSC in the
> > > > > resume path:
> > > > > 
> > > > >   pciehp_resume
> > > > >     pcie_reenable_notification
> > > > >       # clear PDC DLLSC
> > > > >       pcie_enable_notification
> > > > >         # set DLLSCE ABPE/PDCE HPIE CCIE
> > > > >     pciehp_get_adapter_status
> > > > >       # read PCI_EXP_SLTSTA
> > > > > 
> > > > > We used to clear PCI_EXP_SLTSTA_PDC and PCI_EXP_SLTSTA_DLLSC in the
> > > > > probe path:
> > > > > 
> > > > >   pciehp_probe
> > > > >     pcie_init
> > > > >       # clear PDC ABP PFD MRLSC CC DLSCC
> > > > >     pcie_init_notification
> > > > >       pciehp_request_irq
> > > > >       pcie_enable_notification
> > > > >         # set DLLSCE ABPE/PDCE HPIE CCIE
> > > > >     pciehp_get_adapter_status
> > > > >       # read PCI_EXP_SLTSTA
> > > > >     pciehp_get_power_status
> > > > > 
> > > > > db63d40017a5 ("PCI: pciehp: Do not clear Presence Detect Changed
> > > > > during initialization") changed the probe path so we don't clear
> > > > > PCI_EXP_SLTSTA_PDC there anymore.  This was so we wouldn't miss a PDC
> > > > > interrupt that happened before probe.
> > > > > 
> > > > > Why can't we handle probe and resume the same way?  They look quite
> > > > > similar.
> > > > > 
> > > > > You say this patch should be fine because we read SLTSTA immediately
> > > > > after clearing PDC and DLLSC.  But we also read SLTSTA in the probe
> > > > > path, so I'm not sure why we need to clear PDC and DLLSC for resume
> > > > > but not for probe.
> > > > 
> > > > On probe path we read status but here is what it does:
> > > > 
> > > > 	pcie_init_notification()
> > > > 	...
> > > >         pciehp_get_adapter_status(slot, &occupied);
> > > > 	...
> > > >         if (occupied && pciehp_force) {
> > > >                 mutex_lock(&slot->hotplug_lock);
> > > >                 pciehp_enable_slot(slot);
> > > >                 mutex_unlock(&slot->hotplug_lock);
> > > >         }
> > > > 
> > > > If you don't have "pciehp.pciehp_force=1" in your kernel command line
> > > > you miss the fact that the card is already there. Obviously you can't
> > > > expect ordinary users to pass random command line options to get their
> > > > already connected device detected by Linux.
> > > 
> > > Yeah, definitely not, that's really ugly.
> > > 
> > > > So the reason why in probe we don't clear PDC is that once the interrupt
> > > > is unmasked, you get an interrupt and the card gets detected properly.
> > > > 
> > > > On resume path we already check whether the card is there or not and
> > > > handle it accordingly. However, if we don't clear PDC and DLLSC bits we
> > > > will never get hotplug interrupt again.
> > > > 
> > > > Now, you ask why can't we handle probe and resume the same way? I think
> > > > we can if we could get rid of that pciehp_force thing but it seems to
> > > > fix an issue on some HP hardware. See 9e5858244926 ("pciehp: don't
> > > > enable slot unless forced").
> > > 
> > > Ugh.  That's really ancient history.  I would *love* to get rid of
> > > pciehp.pciehp_force.  There's not much detail in 9e5858244926, but
> > > maybe with some digging we can figure out something.
> > > 
> > > I'd rather do the digging now and try to simplify this area instead of
> > > adding another tweak.
> > 
> > I did some digging but unfortunately it is still not clear what issue
> > 9e5858244926 is fixing. There is no bugzilla link and I was not able to
> > find any discussion around this either.
> > 
> > However, I think currently pciehp_force=1 does not actually do what it
> > was intended to do. Reason is that portdrv core already asks BIOS
> > whether native PCIe is allowed and if not, it does not set
> > PCIE_PORT_SERVICE_HP and that prevents the whole device to be created.
> > So even if you specify pciehp_force=1 in the command line, it does not
> > bypass the BIOS setting.
> > 
> > Furthermore we have had similar check in pciehp_resume() but it was
> > removed with 87683e22c646 ("PCI: pciehp: Always implement resume,
> > regardless of pciehp_force param") because it broke resume.
> > 
> > If I understand correctly you want me to change the driver so that I
> > remove pciehp_force check from probe. Then I can revert db63d40017a5
> > ("PCI: pciehp: Do not clear Presence Detect Changed during
> > initialization") and that makes both probe path and resume path similar
> > (when this patch is included). Is that correct? I can do that in the
> > next version of the patch series.
> 
> If you think we can remove pciehp_force, that would be awesome.  This
> should be a separate patch all by itself, of course, and include your
> reasoning above.
> 
> I would also love to revert db63d40017a5 ("PCI: pciehp: Do not clear
> Presence Detect Changed during initialization") because I'm not
> convinced that trying to handle interrupts that happened before
> binding the driver makes sense.  It *would* make sense to me to enable
> interrupts, clear the "changed" status bits so future changes will
> cause interrupts, and check the "state" status bits and act on them.

JFYI, I've added the below patch to my upcoming series which reworks
pciehp event handling and adds runtime PM support:
https://github.com/l1k/linux/commits/pciehp_runpm_v2

The patch removes pciehp_force and reverts db63d40017a5 as requested.
I needed this for the series to work flawlessly.  Note, the patch
depends on the preceding patches in the series.  It cannot be applied
as is to pci.git branches.

The series has been in development for months but is now converging,
I hope to post it sometime during or after the merge window.
Comments/testing welcome.

Thanks,

Lukas

-- >8 --
Subject: [PATCH] PCI: pciehp: Always enable occupied slot on probe

Per PCIe r4.0, sec 6.7.3.4, a "port may optionally send an MSI when
there are hot-plug events that occur while interrupt generation is
disabled, and interrupt generation is subsequently enabled."

On probe, we currently clear all event bits in the Slot Status register
with the notable exception of the Presence Detect Changed bit.  Thereby
we seek to receive an interrupt for an already occupied slot once event
notification is enabled.

But because the interrupt is optional, users may have to specify the
pciehp_force parameter on the command line, which is inconvenient.

Moreover, now that pciehp's event handling has become resilient to
missed events, a Presence Detect Changed interrupt for a slot which is
powered on is interpreted as removal of the card.  If the slot has
already been brought up by the BIOS, receiving such an interrupt on
probe causes the slot to be powered off and immediately back on, which
is likewise undesirable.

Avoid both issues by making the behavior of pciehp_force the default and
clearing the Presence Detect Changed bit on probe.

Note that the stated purpose of pciehp_force per the MODULE_PARM_DESC
("Force pciehp, even if OSHP is missing") seems nonsensical because the
OSHP control method is only relevant for SHCP slots according to the
PCI Firmware specification r3.0, sec 4.8.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_core.c | 12 ++++--------
 drivers/pci/hotplug/pciehp_hpc.c  |  9 ++-------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 6c77b6d7445f..64903f6fc8ef 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -30,7 +30,6 @@
 bool pciehp_debug;
 bool pciehp_poll_mode;
 int pciehp_poll_time;
-static bool pciehp_force;
 
 /*
  * not really modular, but the easiest way to keep compat with existing
@@ -39,11 +38,9 @@ static bool pciehp_force;
 module_param(pciehp_debug, bool, 0644);
 module_param(pciehp_poll_mode, bool, 0644);
 module_param(pciehp_poll_time, int, 0644);
-module_param(pciehp_force, bool, 0644);
 MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
-MODULE_PARM_DESC(pciehp_force, "Force pciehp, even if OSHP is missing");
 
 #define PCIE_MODULE_NAME "pciehp"
 
@@ -243,11 +240,10 @@ static int pciehp_probe(struct pcie_device *dev)
 	mutex_lock(&slot->lock);
 	pciehp_get_adapter_status(slot, &occupied);
 	pciehp_get_power_status(slot, &poweron);
-	if (pciehp_force &&
-	    ((occupied && (slot->state == OFF_STATE ||
-			   slot->state == BLINKINGON_STATE)) ||
-	     (!occupied && (slot->state == ON_STATE ||
-			    slot->state == BLINKINGOFF_STATE)))) {
+	if ((occupied && (slot->state == OFF_STATE ||
+			  slot->state == BLINKINGON_STATE)) ||
+	    (!occupied && (slot->state == ON_STATE ||
+			   slot->state == BLINKINGOFF_STATE))) {
 		atomic_or(PCI_EXP_SLTSTA_PDC, &ctrl->pending_events);
 		irq_wake_thread(ctrl->pcie->irq, ctrl);
 	}
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 3d402bd998df..8cde5c14f4e6 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -835,16 +835,11 @@ struct controller *pcie_init(struct pcie_device *dev)
 	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
 		ctrl->link_active_reporting = 1;
 
-	/*
-	 * Clear all remaining event bits in Slot Status register except
-	 * Presence Detect Changed. We want to make sure possible
-	 * hotplug event is triggered when the interrupt is unmasked so
-	 * that we don't lose that event.
-	 */
+	/* Clear all remaining event bits in Slot Status register. */
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 		PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
-		PCI_EXP_SLTSTA_DLLSC);
+		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
 
 	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c\n",
 		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
-- 
2.17.1
